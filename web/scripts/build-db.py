#!/usr/bin/env python3
"""
Parses the addon's Lua sources into JSON for the website:

  Database.lua  -> web/data/database.json
  Core.lua      -> web/data/stat-caps.json + web/data/meta.json

Run from anywhere; paths are resolved relative to the repo root.
"""
import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent.parent
ADDON = REPO / "TBCBisTracker"
OUT = REPO / "web" / "data"

DB_FILE = ADDON / "Database.lua"
CORE_FILE = ADDON / "Core.lua"


def strip_comments(text: str) -> str:
    """Strip Lua single-line comments, respecting double-quoted strings."""
    out = []
    for line in text.split("\n"):
        in_str = False
        i = 0
        while i < len(line):
            c = line[i]
            if c == '"':
                # honour backslash escapes
                if i > 0 and line[i - 1] == "\\":
                    pass
                else:
                    in_str = not in_str
            elif (
                c == "-"
                and not in_str
                and i + 1 < len(line)
                and line[i + 1] == "-"
            ):
                line = line[:i]
                break
            i += 1
        out.append(line)
    return "\n".join(out)


def find_matching_brace(text: str, open_pos: int) -> int:
    """Given the index of an opening '{', return the index of its matching '}'.

    Tracks Lua double-quoted strings (with backslash escapes) to ignore braces
    that appear inside string literals.
    """
    assert text[open_pos] == "{"
    depth = 0
    i = open_pos
    n = len(text)
    in_str = False
    while i < n:
        c = text[i]
        if in_str:
            if c == "\\":
                i += 2
                continue
            if c == '"':
                in_str = False
        else:
            if c == '"':
                in_str = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    return i
        i += 1
    raise ValueError(f"unbalanced braces starting at {open_pos}")


# Match item(id, "source", "sourceType" [, "note"|nil [, questId|nil]])
ITEM_RE = re.compile(
    r"""item\(\s*
        (?P<id>\d+)\s*,\s*
        "(?P<source>(?:[^"\\]|\\.)*)"\s*,\s*
        "(?P<sourceType>(?:[^"\\]|\\.)*)"
        (?:\s*,\s*(?P<note>"(?:[^"\\]|\\.)*"|nil))?
        (?:\s*,\s*(?P<questId>\d+|nil))?
        \s*\)""",
    re.VERBOSE,
)

SPEC_HEADER_RE = re.compile(
    r'^DB\["(?P<class>[A-Z]+)"\]\["(?P<spec>[^"]+)"\]\s*=\s*\{',
    re.MULTILINE,
)
# Phase entry: at start of an indented line: prebis = { ... }
PHASE_HEADER_RE = re.compile(
    r"(?m)^[ \t]+(?P<phase>prebis|phase\d|pvp)\s*=\s*\{"
)
# Slot entry: at start of an indented line — either single item(...) or list { ... }
SLOT_LIST_RE = re.compile(r"(?m)^[ \t]+(?P<slot>[a-z]+\d?)\s*=\s*\{")
SLOT_SINGLE_RE = re.compile(
    r"(?m)^[ \t]+(?P<slot>[a-z]+\d?)\s*=\s*item\("
)


def _unescape(s: str) -> str:
    return s.replace('\\"', '"').replace("\\\\", "\\")


def _read_item(m: re.Match) -> dict:
    note = m.group("note")
    note_v = None if note in (None, "nil") else _unescape(note[1:-1])
    qid = m.group("questId")
    qid_v = int(qid) if qid and qid != "nil" else None
    return {
        "id": int(m.group("id")),
        "source": _unescape(m.group("source")),
        "sourceType": m.group("sourceType"),
        "note": note_v,
        "questId": qid_v,
    }


def parse_phase_body(body: str) -> dict:
    """Inside a `prebis = { ... }` body, collect slot lists.

    A slot is either `slot = { item(...), item(...) }` or `slot = item(...)`.
    """
    out: dict = {}
    # Walk text top-down, alternating between SLOT_LIST and SLOT_SINGLE.
    pos = 0
    while pos < len(body):
        list_m = SLOT_LIST_RE.search(body, pos)
        single_m = SLOT_SINGLE_RE.search(body, pos)
        next_m = None
        kind = None
        if list_m and (not single_m or list_m.start() <= single_m.start()):
            next_m = list_m
            kind = "list"
        elif single_m:
            next_m = single_m
            kind = "single"
        else:
            break
        slot = next_m.group("slot")
        if kind == "list":
            brace_pos = body.index("{", next_m.start())
            close = find_matching_brace(body, brace_pos)
            inner = body[brace_pos + 1 : close]
            items = [_read_item(im) for im in ITEM_RE.finditer(inner)]
            out[slot] = items
            pos = close + 1
        else:
            # single item — find the call's closing paren
            paren = body.index("(", next_m.start())
            depth = 0
            i = paren
            n = len(body)
            in_str = False
            close = None
            while i < n:
                c = body[i]
                if in_str:
                    if c == "\\":
                        i += 2
                        continue
                    if c == '"':
                        in_str = False
                else:
                    if c == '"':
                        in_str = True
                    elif c == "(":
                        depth += 1
                    elif c == ")":
                        depth -= 1
                        if depth == 0:
                            close = i
                            break
                i += 1
            if close is None:
                raise ValueError("unterminated item() at single slot")
            seg = body[next_m.start() : close + 1]
            im = ITEM_RE.search(seg)
            out[slot] = [_read_item(im)] if im else []
            pos = close + 1
    return out


def parse_spec_body(body: str) -> dict:
    """Inside a spec block body, extract each phase -> {slot: [items]}."""
    out: dict = {}
    pos = 0
    while True:
        m = PHASE_HEADER_RE.search(body, pos)
        if not m:
            break
        brace = body.index("{", m.start())
        close = find_matching_brace(body, brace)
        phase_body = body[brace + 1 : close]
        out[m.group("phase")] = parse_phase_body(phase_body)
        pos = close + 1
    return out


def parse_database(text: str) -> dict:
    text = strip_comments(text)
    db: dict = {}
    pos = 0
    while True:
        m = SPEC_HEADER_RE.search(text, pos)
        if not m:
            break
        cls = m.group("class")
        spec = m.group("spec")
        brace = text.index("{", m.start())
        close = find_matching_brace(text, brace)
        spec_body = text[brace + 1 : close]
        db.setdefault(cls, {})[spec] = parse_spec_body(spec_body)
        pos = close + 1
    return db


# ------- Core.lua: STAT_CAPS + label tables -------

STAT_CAPS_BLOCK_RE = re.compile(
    r"addon\.STAT_CAPS\s*=\s*\{(.*?)^\}", re.DOTALL | re.MULTILINE
)
STAT_CAPS_CLASS_RE = re.compile(
    r"^\s{4}([A-Z]+)\s*=\s*\{(.*?)^\s{4}\},?\s*$", re.DOTALL | re.MULTILINE
)
STAT_CAPS_SPEC_RE = re.compile(
    r'^\s{8}(?:\["([^"]+)"\]|([A-Za-z]+))\s*=\s*\{(.*?)^\s{8}\},?\s*$',
    re.DOTALL | re.MULTILINE,
)
STAT_LINE_RE = re.compile(
    r'\{\s*stat\s*=\s*"([^"]+)"\s*,\s*cap\s*=\s*(\d+)\s*,\s*label\s*=\s*"([^"]+)"\s*(?:,\s*info\s*=\s*(true|false))?\s*\}'
)


def parse_stat_caps(core_text: str) -> dict:
    body_match = STAT_CAPS_BLOCK_RE.search(core_text)
    if not body_match:
        raise SystemExit("STAT_CAPS block not found")
    body = body_match.group(1)
    out: dict = {}
    for cls_m in STAT_CAPS_CLASS_RE.finditer(body):
        cls = cls_m.group(1)
        spec_body = cls_m.group(2)
        out[cls] = {}
        for spec_m in STAT_CAPS_SPEC_RE.finditer(spec_body):
            spec = spec_m.group(1) or spec_m.group(2)
            stats_body = spec_m.group(3)
            stats = []
            for sm in STAT_LINE_RE.finditer(stats_body):
                stats.append(
                    {
                        "stat": sm.group(1),
                        "cap": int(sm.group(2)),
                        "label": sm.group(3),
                        "info": sm.group(4) == "true",
                    }
                )
            out[cls][spec] = stats
    return out


def parse_meta(core_text: str) -> dict:
    """Pull SLOTS, SLOT_LABELS, PHASES, PHASE_LABELS, PHASE_DESCRIPTIONS."""
    meta = {}

    def grab_array(name):
        m = re.search(rf"addon\.{name}\s*=\s*\{{(.*?)\}}", core_text, re.DOTALL)
        if not m:
            return []
        return re.findall(r'"([^"]+)"', m.group(1))

    def grab_map(name):
        m = re.search(
            rf"addon\.{name}\s*=\s*\{{(.*?)^\}}",
            core_text,
            re.DOTALL | re.MULTILINE,
        )
        if not m:
            return {}
        body = m.group(1)
        return {
            mm.group(1): _unescape(mm.group(2))
            for mm in re.finditer(r'(\w+)\s*=\s*"((?:[^"\\]|\\.)*)"', body)
        }

    meta["slots"] = grab_array("SLOTS")
    meta["phases"] = grab_array("PHASES")
    meta["slotLabels"] = grab_map("SLOT_LABELS")
    meta["phaseLabels"] = grab_map("PHASE_LABELS")
    meta["phaseDescriptions"] = grab_map("PHASE_DESCRIPTIONS")
    return meta


def main() -> int:
    if not DB_FILE.is_file():
        print(f"Database.lua not found at {DB_FILE}", file=sys.stderr)
        return 1
    if not CORE_FILE.is_file():
        print(f"Core.lua not found at {CORE_FILE}", file=sys.stderr)
        return 1

    OUT.mkdir(parents=True, exist_ok=True)
    db_text = DB_FILE.read_text(encoding="utf-8", errors="replace")
    core_text = CORE_FILE.read_text(encoding="utf-8", errors="replace")

    db = parse_database(db_text)
    stat_caps = parse_stat_caps(core_text)
    meta = parse_meta(core_text)

    (OUT / "database.json").write_text(
        json.dumps(db, ensure_ascii=False, indent=1), encoding="utf-8"
    )
    (OUT / "stat-caps.json").write_text(
        json.dumps(stat_caps, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (OUT / "meta.json").write_text(
        json.dumps(meta, ensure_ascii=False, indent=2), encoding="utf-8"
    )

    # Combined JS payload — lets the page work over file:// without CORS pain.
    combined = {"database": db, "statCaps": stat_caps, "meta": meta}
    (OUT / "data.js").write_text(
        "window.TBC_DATA = "
        + json.dumps(combined, ensure_ascii=False, separators=(",", ":"))
        + ";\n",
        encoding="utf-8",
    )

    n_specs = sum(len(v) for v in db.values())
    n_items = 0
    for _cls, specs in db.items():
        for _sp, phases in specs.items():
            for _ph, slots in phases.items():
                for _slot, lst in slots.items():
                    n_items += len(lst)
    print(
        f"OK: {len(db)} classes, {n_specs} specs, {n_items} items "
        f"-> {OUT.relative_to(REPO)}"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
