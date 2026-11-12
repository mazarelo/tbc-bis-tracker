#!/usr/bin/env python3
"""
Builds the WoW Forever pre-raid (level 60) gear lists from three sources,
most trusted first, and writes web/scripts/forever-lvl60.json. Then run
build-forever-db.py to regenerate the add-on and website data.

  1. sim   The WoW Forever simulator (github.com/wowsims/forever, MIT): the
           pre-raid gear sets its spec maintainers ship, plus its item database
           (stats, sources), which every item below is checked against.
  2. kami  kami-labs.fr: one pick per slot for every spec, computed from the
           simulator's stat weights over items with a known source.
  3. cwf   classicwowforever.com (CC BY 4.0): hand-made lists with alternatives.
           Used for alternatives only, and only items whose stats fit the role
           (it listed healing plate for Fury Warrior).

Per slot: the sim pick first (when the spec has a set), then kami's, then the
cwf items. There is no official list: Wowhead's Forever BiS guides are still
empty templates (checked 2026-11-12).

  python3 web/scripts/fetch-forever-bis.py            # download everything
  python3 web/scripts/fetch-forever-bis.py --cache D  # read/keep downloads in D
"""
import argparse
import datetime
import html
import json
import re
import sys
import time
import urllib.request
from collections import OrderedDict
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent.parent
OUT = REPO / "web" / "scripts" / "forever-lvl60.json"

SIM_RAW = "https://raw.githubusercontent.com/wowsims/forever/master/"
KAMI_URL = "https://kami-labs.fr/en/bis-list-wow-forever/"
CWF_BASE = "https://classicwowforever.com"
CWF_BRACKET = "level-60"

SLOTS = ["head", "neck", "shoulder", "back", "chest", "wrist", "hands", "waist", "legs", "feet",
         "ring1", "ring2", "trinket1", "trinket2", "mainhand", "offhand", "ranged"]

# class, add-on spec, simulator gear set (ui/specs/...), kami spec name, cwf page, role
SPECS = [
    ("WARRIOR", "Fury", "warrior/dps/gear_sets/prebis_fury.gear.json", "Warrior Fury", "fury-warrior", "phys"),
    ("WARRIOR", "Arms", "warrior/dps/gear_sets/prebis_arms.gear.json", "Warrior Arms", "arms-warrior", "phys"),
    ("WARRIOR", "Protection", "warrior/protection/gear_sets/prebis.gear.json", "Warrior Protection", "protection-warrior", "tank"),
    ("PALADIN", "Holy", "paladin/holy/gear_sets/default.gear.json", "Paladin Holy", "holy-paladin", "caster"),
    ("PALADIN", "Protection", "paladin/protection/gear_sets/default.gear.siml", "Paladin Protection", "protection-paladin", "tank"),
    ("PALADIN", "Retribution", "paladin/retribution/gear_sets/default.gear.siml", "Paladin Retribution", "retribution-paladin", "phys"),
    ("HUNTER", "Marksmanship", "hunter/dps/gear_sets/p1.gear.siml", "Hunter Marksmanship", "marksmanship-hunter", "phys"),
    ("HUNTER", "Survival", "hunter/dps/gear_sets/p1.gear.siml", "Hunter Survival", "survival-hunter", "phys"),
    ("HUNTER", "Beast Mastery", "hunter/dps/gear_sets/p1.gear.siml", "Hunter Beast Mastery", "beast-mastery-hunter", "phys"),
    ("ROGUE", "Combat", "rogue/dps/gear_sets/p1_bscombat.gear.json", "Rogue Combat", "combat-rogue", "phys"),
    ("ROGUE", "Assassination", "rogue/dps/gear_sets/p1_muti.gear.json", "Rogue Assassination", "assassination-rogue", "phys"),
    ("ROGUE", "Subtlety", "rogue/dps/gear_sets/p1_bssub.gear.json", "Rogue Subtlety", "subtlety-rogue", "phys"),
    ("PRIEST", "Holy", "priest/healer/gear_sets/preraid.gear.json", "Priest Holy", "holy-priest", "caster"),
    ("PRIEST", "Discipline", "priest/healer/gear_sets/preraid.gear.json", "Priest Discipline", "discipline-priest", "caster"),
    ("PRIEST", "Shadow", None, "Priest Shadow", "shadow-priest", "caster"),
    ("SHAMAN", "Restoration", None, "Shaman Restoration", "restoration-shaman", "caster"),
    ("SHAMAN", "Elemental", None, "Shaman Elemental", "elemental-shaman", "caster"),
    ("SHAMAN", "Enhancement", None, "Shaman Enhancement", "enhancement-shaman", "phys"),
    ("MAGE", "Arcane", "mage/dps/gear_sets/p1Arcane.gear.json", "Mage Arcane", "arcane-mage", "caster"),
    ("MAGE", "Fire", None, "Mage Fire", "fire-mage", "caster"),
    ("MAGE", "Frost", None, "Mage Frost", "frost-mage", "caster"),
    ("WARLOCK", "Destruction", "warlock/dps/gear_sets/preraid.gear.json", "Warlock Destruction", "destruction-warlock", "caster"),
    ("WARLOCK", "Affliction", "warlock/dps/gear_sets/preraid.gear.json", "Warlock Affliction", "affliction-warlock", "caster"),
    ("WARLOCK", "Demonology", "warlock/dps/gear_sets/preraid.gear.json", "Warlock Demonology", "demonology-warlock", "caster"),
    ("DRUID", "Balance", "druid/balance/gear_sets/prebis.gear.json", "Druid Balance", "balance-druid", "caster"),
    ("DRUID", "Restoration", None, "Druid Restoration", "restoration-druid", "caster"),
    ("DRUID", "Feral - Tank", "druid/feralbear/gear_sets/default.gear.json", "Druid Guardian (bear)", "feral-druid", "tank"),
    ("DRUID", "Feral - DPS", "druid/feralcat/gear_sets/pre_raid.gear.json", "Druid Feral (cat)", "feral-druid", "phys"),
]

# ── simulator codes (proto/common.proto) ──
PROFESSIONS = {1: "Alchemy", 2: "Blacksmithing", 3: "Enchanting", 4: "Engineering", 8: "Leatherworking", 11: "Tailoring"}
STANDINGS = {5: "Friendly", 6: "Honored", 7: "Revered", 8: "Exalted"}
FACTIONS = {1: "Alliance", 2: "Horde"}
TYPE_SLOT = {1: "head", 2: "neck", 3: "shoulder", 4: "back", 5: "chest", 6: "wrist", 7: "hands", 8: "waist",
             9: "legs", 10: "feet"}
SIML_SLOT = {"head": "head", "neck": "neck", "shoulder": "shoulder", "back": "back", "chest": "chest",
             "wrist": "wrist", "hands": "hands", "waist": "waist", "legs": "legs", "feet": "feet",
             "finger1": "ring1", "finger2": "ring2", "trinket1": "trinket1", "trinket2": "trinket2",
             "main_hand": "mainhand", "off_hand": "offhand", "ranged": "ranged"}
STAT_PHYS = {0, 1, 14, 15, 16, 20, 21}          # strength, agility, attack power, armor pen, expertise
STAT_SPELL = {4, 5, 6, 7, 8, 9, 10, 11, 12}     # healing and spell damage
STAT_CASTER = STAT_SPELL | {3, 13}              # + intellect, spirit
STAT_TANK = {22, 23, 24, 25, 26, 28}
HAND_TWO = 4

RAIDS = {"Molten Core", "Onyxia's Lair", "Blackwing Lair", "Zul'Gurub", "Ruins of Ahn'Qiraj", "Ahn'Qiraj",
         "Temple of Ahn'Qiraj", "Naxxramas", "Hyjal Summit", "The Barrow Deeps", "Barrow Deeps"}
DUNGEONS = {"Ragefire Chasm", "Wailing Caverns", "The Deadmines", "Shadowfang Keep", "Blackfathom Deeps",
            "The Stockade", "Gnomeregan", "Razorfen Kraul", "Scarlet Monastery", "Razorfen Downs", "Uldaman",
            "Zul'Farrak", "Maraudon", "The Temple of Atal'Hakkar", "Sunken Temple", "Blackrock Depths",
            "Blackrock Spire", "Dire Maul", "Stratholme", "Scholomance", "Hall of Thanes", "Ruins of Lordaeron",
            "Excavation Site: Wetlands", "City of Dalaran", "The Drowned City", "Alcaz Prison", "Blackmaw Hold",
            "Shaper's Terrace", "Krol'dok Stronghold"}

KAMI_SLOT = {"Head": "head", "Neck": "neck", "Shoulders": "shoulder", "Back": "back", "Chest": "chest",
             "Wrists": "wrist", "Hands": "hands", "Waist": "waist", "Legs": "legs", "Feet": "feet",
             "Finger 1": "ring1", "Finger 2": "ring2", "Trinket 1": "trinket1", "Trinket 2": "trinket2",
             "Main hand": "mainhand", "Off hand": "offhand", "Ranged": "ranged"}
CWF_SLOT = {"head": "head", "neck": "neck", "shoulder": "shoulder", "back": "back", "chest": "chest",
            "wrist": "wrist", "hands": "hands", "waist": "waist", "legs": "legs", "feet": "feet",
            "finger-1": "ring1", "finger-2": "ring2", "trinket-1": "trinket1", "trinket-2": "trinket2",
            "main-hand": "mainhand", "off-hand": "offhand", "ranged": "ranged"}
ZONES_OPEN = {"Silithus", "Un'Goro Crater", "Arathi Highlands", "Winterspring", "Felwood", "Tanaris",
              "Eastern Plaguelands", "Western Plaguelands", "Burning Steppes", "Azshara", "Feralas",
              "The Hinterlands", "Searing Gorge", "Blasted Lands", "Stranglethorn Vale", "Mount Hyjal",
              "Riverglades", "Moonglade", "Dustwallow Marsh", "Hillsbrad Foothills"}


def text(fragment):
    return re.sub(r"\s+", " ", html.unescape(re.sub(r"<[^>]+>", "", fragment))).replace("’", "'").strip()


def fetch(url, name, cache):
    if cache and (cache / name).exists():
        return (cache / name).read_text(encoding="utf-8")
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=120) as r:
        doc = r.read().decode("utf-8")
    if cache:
        cache.mkdir(parents=True, exist_ok=True)
        (cache / name).write_text(doc, encoding="utf-8")
    time.sleep(0.5)
    return doc


# ─────────────────────────────────────────────
# Simulator: item database and gear sets
# ─────────────────────────────────────────────

class SimDB:
    def __init__(self, doc):
        d = json.loads(doc)
        self.items = {i["id"]: i for i in d["items"]}
        self.zones = {z["id"]: z["name"] for z in d["zones"]}
        self.npcs = {n["id"]: n for n in d["npcs"]}
        self.suffixes = {s["id"]: s["name"] for s in d["randomSuffixes"]}
        self.factions = {f["id"]: f["name"] for f in d["factions"]}
        self.by_slug = {}
        for i in d["items"]:
            self.by_slug.setdefault(self.slug(i["name"]), []).append(i)
        if len(self.items) < 3000:
            raise SystemExit("simulator item database looks wrong (%d items)" % len(self.items))

    @staticmethod
    def slug(name):
        return re.sub(r"[^a-z0-9]+", "_", name.lower().replace("'", "")).strip("_")

    def stats(self, item_id):
        it = self.items.get(item_id)
        if not it:
            return None
        return {int(k) for k, v in ((it.get("scalingOptions") or {}).get("0") or {}).get("stats", {}).items() if v}

    def fits(self, item_id, role):
        """False when the item's stats are for another role. Unknown items pass."""
        s = self.stats(item_id)
        if s is None:
            return True
        if role == "phys":
            return not (s & STAT_SPELL and not s & STAT_PHYS)
        if role == "tank":
            return not (s & STAT_SPELL and not s & (STAT_PHYS | STAT_TANK))
        return not (s & STAT_PHYS and not s & STAT_CASTER)

    def two_handed(self, item_id):
        return (self.items.get(item_id) or {}).get("handType") == HAND_TWO

    def source(self, item_id):
        """(source text, type, faction, note) from the item's sources, or None when it has none."""
        it = self.items.get(item_id)
        srcs = [s for s in (it or {}).get("sources") or []]
        if not srcs:
            return None
        # Anything you can get outside PvP first.
        srcs.sort(key=lambda s: "pvp" in s)
        s = srcs[0]
        sides = set()
        for x in srcs:
            for v in x.values():
                sides.add(v.get("faction") or v.get("factionId"))
        faction = FACTIONS.get(next(iter(sides))) if len(sides) == 1 else None
        note = None
        if "crafted" in s:
            prof = PROFESSIONS.get(s["crafted"].get("profession"))
            return (prof or "Crafted"), "crafted", faction, note
        if "quest" in s:
            names = []
            for x in srcs:
                if "quest" in x and x["quest"].get("name") and x["quest"]["name"] not in names:
                    names.append(x["quest"]["name"])
            if len(names) > 1:
                note = "Also: " + "; ".join(names[1:3])
            return "Quest: " + names[0], "quest", faction, note
        if "rep" in s:
            who = self.factions.get(s["rep"].get("repFactionId"))
            st = STANDINGS.get(s["rep"].get("repLevel"))
            if who and st:
                seller = next((x["soldBy"] for x in srcs if "soldBy" in x), None)
                if seller and seller.get("npcName"):
                    note = "Sold by " + seller["npcName"]
                return "%s - %s" % (who, st), "reputation", faction, note
        if "drop" in s:
            drop = s["drop"]
            zone = self.zones.get(drop.get("zoneId")) or (self.npcs.get(drop.get("npcId")) or {}).get("zoneId")
            zone = self.zones.get(zone, zone) if isinstance(zone, int) else zone
            who = (self.npcs.get(drop.get("npcId")) or {}).get("name") or drop.get("otherName")
            if who == "Trash":
                who = "Trash mobs"
            label = ", ".join(x for x in (who, zone) if x) or "Drop"
            kind = "raid" if zone in RAIDS else ("dungeon" if zone in DUNGEONS else "world")
            return label, kind, faction, note
        if "soldBy" in s:
            v = s["soldBy"]
            zone = self.zones.get(v.get("zoneId"))
            return "Sold by " + ", ".join(x for x in (v.get("npcName"), zone) if x), "world", faction, note
        if "pvp" in s:
            return "PvP reward", "pvp", faction, note
        return None

    def gear_set(self, doc, path):
        """{slot: (item id, suffix id or None)} for one gear set file (.gear.json or .gear.siml)."""
        out = {}
        if path.endswith(".json"):
            weapons = []
            for x in json.loads(doc).get("items") or []:
                it = self.items.get(x.get("id"))
                if not it:
                    continue
                pick = (it["id"], x.get("randomSuffix"))
                t = it.get("type")
                if t in TYPE_SLOT:
                    out[TYPE_SLOT[t]] = pick
                elif t == 11:
                    out["ring2" if "ring1" in out else "ring1"] = pick
                elif t == 12:
                    out["trinket2" if "trinket1" in out else "trinket1"] = pick
                elif t == 13:
                    weapons.append(pick)
                elif t == 14:
                    out["ranged"] = pick
            if weapons:
                out["mainhand"] = weapons[0]
                if len(weapons) > 1 and not self.two_handed(weapons[0][0]):
                    out["offhand"] = weapons[1]
            return out
        for line in doc.splitlines():
            m = re.match(r"^(\w+)\s+([a-z0-9_]+)", line)
            if not m or m.group(1) not in SIML_SLOT:
                continue
            found = sorted(self.by_slug.get(m.group(2)) or [], key=lambda i: -(i.get("reqLvl") or 0))
            if not found:
                # Renamed in the game since the set was written: leave the slot to the other sources.
                print("note: %s names %s, which the simulator database does not have" % (path, m.group(2)))
                continue
            out[SIML_SLOT[m.group(1)]] = (found[0]["id"], None)
        return out


# ─────────────────────────────────────────────
# kami-labs: one computed pick per slot
# ─────────────────────────────────────────────

def kami_source(raw):
    """kami's 'where from' text -> (source, type, note)."""
    t = raw.replace(" — ", ", ").replace("“", "").replace("”", "")
    parts = [p.strip() for p in t.split(" · ")]
    head, rest = parts[0], parts[1:]
    note = ". ".join(rest) or None
    m = re.match(r"^Quest (.*?)(?:, (.*))?$", head)
    if m:
        where = m.group(2)
        return "Quest: " + m.group(1), "quest", ". ".join(x for x in (where, note) if x) or None
    if head in ("Vendor", "PvP vendor") and rest:
        kind = "pvp" if head.startswith("PvP") else "world"
        return ("PvP vendor: " if kind == "pvp" else "Sold by ") + rest[0], kind, ". ".join(rest[1:]) or None
    if any(head.startswith(p) for p in PROFESSIONS.values()):
        return head, "crafted", note
    if head.startswith("Dungeon trash, "):
        return "Trash mobs, " + head[len("Dungeon trash, "):], "dungeon", note
    if rest and re.match(r"^[\d.]+%$", rest[0]):
        note = "Drop chance " + ". ".join(rest)
    place = head.rsplit(", ", 1)[-1]
    kind = "raid" if place in RAIDS else ("world" if place in ZONES_OPEN else "dungeon")
    if ", " not in head:
        kind = "world"
    return head, kind, note


def parse_kami(doc):
    specs = {}
    blocks = re.findall(r'<details class="wowf-bis-spec"><summary>BiS (.*?) <span class="wowf-bis-role[^"]*">.*?'
                        r'</summary><ul class="wowf-bis-list">(.*?)</ul>', doc, re.S)
    if len(blocks) < 25:
        raise SystemExit("kami-labs: only %d spec lists found (page layout changed?)" % len(blocks))
    for name, body in blocks:
        slots = {}
        for row in re.findall(r"<li>(.*?)</li>", body, re.S):
            slot = KAMI_SLOT.get(text(re.search(r'wowf-bis-slot">(.*?)</span>', row, re.S).group(1)))
            item = re.search(r'data-wowf="item_(\d+)".*?wowf-bis-item-n">(.*?)</span>', row, re.S)
            src = re.search(r'<span class="wowf-bis-src">(.*?)</span>\s*(?:<span class="wowf-bis-fa|<span class="wowf-bis-editorial|$)', row, re.S)
            if not slot or not item:
                continue
            e = {"id": int(item.group(1)), "name": text(item.group(2))}
            if src:
                e["src"] = text(src.group(1))
            ench = re.search(r'wowf-bis-ench[^>]*>(.*?)</span>', row, re.S)
            if ench:
                e["enchant"] = text(ench.group(1)).lstrip("+ ").strip()
            side = re.search(r'title="(Alliance|Horde) only"', row)
            if side:
                e["faction"] = side.group(1)
            slots[slot] = e
        specs[text(name)] = slots
    stamp = re.search(r"computed on ([A-Za-z]+ \d+, \d{4})", doc)
    return specs, stamp.group(1) if stamp else "?"


# ─────────────────────────────────────────────
# classicwowforever: alternatives
# ─────────────────────────────────────────────

def cwf_standing(detail):
    for st in STANDINGS.values():
        if st in (detail or ""):
            who = re.sub(r"\bwith\b", "", re.sub(r"\b%s\b" % st, "", detail)).strip(" ,-–")
            if who:
                return who, st
    return None


def cwf_entry(item):
    src = item.get("source") or {}
    kind, place, name, detail = src.get("kind"), src.get("place"), src.get("name"), src.get("detail")
    notes = []
    if kind == "crafted":
        source, stype = place or "Crafted", "crafted"
    elif kind == "quest":
        source, stype = "Quest: " + (name or place or "?"), "quest"
        notes += [x for x in ((place if name else None), detail) if x]
    elif kind == "vendor":
        rep = cwf_standing(detail)
        seller = ", ".join(x for x in (name, place) if x)
        if rep:
            source, stype = "%s - %s" % rep, "reputation"
            notes.append("Sold by " + seller)
        else:
            source, stype = "Sold by " + seller, "world"
            notes += [detail] if detail else []
    else:
        source = ", ".join(x for x in (name, place) if x) or "Unknown source"
        stype = "raid" if place in RAIDS else ("world" if place in ZONES_OPEN else "dungeon")
        notes += [detail] if detail else []
    if item.get("note"):
        notes.append(item["note"])
    e = {"id": int(item["id"]), "name": item["name"], "source": source, "sourceType": stype}
    if notes:
        e["note"] = ". ".join(n.rstrip(".") for n in notes)
    side = re.match(r"^(Alliance|Horde)\b(?: only)?[.;,]", item.get("note") or "")
    if side:
        e["faction"] = side.group(1)
    return e


def parse_cwf(doc, page):
    try:
        payload = "".join(json.loads(s) for s in re.findall(r'\.rsc\.push\((".*?")\)</script>', doc, flags=re.S))
    except ValueError:
        payload = ""
    at = payload.find('{"id":"%s"' % CWF_BRACKET)
    if at < 0:
        raise SystemExit("classicwowforever %s: no %s list in the page (layout changed?)" % (page, CWF_BRACKET))
    obj, _ = json.JSONDecoder().raw_decode(payload[at:])
    lists = dict(obj.get("slots") or {})
    for setup in obj.get("setups") or []:
        for k, v in (setup.get("slots") or {}).items():
            lists[k] = (lists.get(k) or []) + [i for i in v if i not in (lists.get(k) or [])]
    return {CWF_SLOT[k]: [cwf_entry(i) for i in v] for k, v in lists.items() if k in CWF_SLOT}, obj.get("updated")


# ─────────────────────────────────────────────
# Merge
# ─────────────────────────────────────────────

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cache", type=Path, help="directory to read/keep the downloads in")
    args = ap.parse_args()
    cache = args.cache

    db = SimDB(fetch(SIM_RAW + "assets/database/db.json", "sim_db.json", cache))
    kami, kami_date = parse_kami(fetch(KAMI_URL, "kami.html", cache))
    cwf_pages, cwf_dates = {}, set()
    for page in sorted({s[4] for s in SPECS}):
        cwf_pages[page], upd = parse_cwf(fetch("%s/bis-list/%s/" % (CWF_BASE, page), "cwf_%s.html" % page, cache), page)
        cwf_dates.add(upd or "?")

    # What kami and cwf say about where an item comes from, for items the simulator has no source for.
    told = {}
    for slots in cwf_pages.values():
        for lst in slots.values():
            for e in lst:
                told.setdefault(e["id"], (e["source"], e["sourceType"], e.get("note")))
    for slots in kami.values():
        for e in slots.values():
            if e.get("src"):
                told[e["id"]] = kami_source(e["src"])

    def make(item_id, origin, name=None, suffix=None, extra_note=None, faction=None):
        it = db.items.get(item_id)
        label = (it["name"] if it else name) or name or ("Item %d" % item_id)
        if suffix and db.suffixes.get(suffix):
            label += " " + db.suffixes[suffix]
        got = db.source(item_id)
        notes = []
        if got and got[1] != "pvp":
            source, stype, side, note = got
        elif item_id in told:
            source, stype, note = told[item_id]
            side = None
        elif got:
            source, stype, side, note = got
        else:
            source, stype, side, note = "World drop, sold at the auction house", "world", None, None
        if stype == "raid":
            return None  # not pre-raid
        notes += [note] if note else []
        notes += [extra_note] if extra_note else []
        e = OrderedDict(id=item_id, name=label, source=source, sourceType=stype,
                        sourceUrl="https://www.wowhead.com/forever/item=%d" % item_id)
        if notes:
            e["note"] = ". ".join(n.rstrip(".") for n in notes)
        if faction or side:
            e["faction"] = faction or side
        e["from"] = origin
        return e

    data, basis, counts = OrderedDict(), OrderedDict(), {"sim": 0, "kami": 0, "cwf": 0}
    dropped = []
    for cls, spec, sim_path, kami_name, cwf_page, role in SPECS:
        sim_set = {}
        if sim_path:
            sim_set = db.gear_set(fetch(SIM_RAW + "ui/specs/" + sim_path, "sim_" + sim_path.replace("/", "_"), cache), sim_path)
        k = kami.get(kami_name)
        if k is None:
            raise SystemExit("kami-labs: no list named %r" % kami_name)
        c = cwf_pages[cwf_page]
        lead = sim_set or k
        two_hand = bool(lead.get("mainhand")) and db.two_handed((lead["mainhand"][0] if sim_set else lead["mainhand"]["id"]))
        slots = OrderedDict()
        for slot in SLOTS:
            out, seen = [], set()

            def add(e):
                if e and e["id"] not in seen:
                    seen.add(e["id"])
                    out.append(e)
                    counts[e["from"]] += 1

            if slot == "offhand" and (two_hand or "offhand" not in lead):
                slots[slot] = out
                continue
            if slot in sim_set:
                add(make(sim_set[slot][0], "sim", suffix=sim_set[slot][1]))
            if slot in k:
                e = k[slot]
                # kami's picks come from the simulator's weights (hit and crit are shared by melee and
                # spells on Forever), so they are not second-guessed by the cruder role check.
                if not (slot == "mainhand" and db.two_handed(e["id"]) != two_hand and sim_set):
                    add(make(e["id"], "kami", name=e["name"], faction=e.get("faction"),
                             extra_note=("Enchant: " + e["enchant"]) if e.get("enchant") else None))
                else:
                    dropped.append("%s/%s %s: %s (kami, other weapon setup)" % (cls, spec, slot, e["name"]))
            for e in c.get(slot) or []:
                if not db.fits(e["id"], role):
                    dropped.append("%s/%s %s: %s (cwf, wrong stats)" % (cls, spec, slot, e["name"]))
                    continue
                if slot == "mainhand" and e["id"] in db.items and db.two_handed(e["id"]) != two_hand:
                    continue
                add(make(e["id"], "cwf", name=e["name"], extra_note=e.get("note"), faction=e.get("faction")))
            slots[slot] = out
        # Both rings / trinkets must not open with the same unique item.
        for a, b in (("ring1", "ring2"), ("trinket1", "trinket2")):
            if slots[a] and slots[b] and slots[a][0]["id"] == slots[b][0]["id"] and len(slots[b]) > 1:
                slots[b].append(slots[b].pop(0))
        data.setdefault(cls, OrderedDict())[spec] = slots
        basis["%s/%s" % (cls, spec)] = "first picks: %s; then kami-labs (%s); alternatives: classicwowforever.com/bis-list/%s" % (
            ("wowsims/forever " + sim_path) if sim_path else "kami-labs (no simulator set for this spec)", kami_name, cwf_page)
        print("%-8s %-14s %-9s %3d items" % (cls, spec, "sim" if sim_set else "kami", sum(len(v) for v in slots.values())))

    doc = OrderedDict(
        meta=OrderedDict(
            generated=datetime.date.today().isoformat(),
            sources=["https://github.com/wowsims/forever", KAMI_URL, CWF_BASE + "/bis-list/"],
            credit=("Lists: WoW Forever simulator gear sets (wowsims/forever, MIT), kami-labs.fr, "
                    "Classic WoW Forever (classicwowforever.com, CC BY 4.0)"),
            siteStatus=["Simulator sets and item data read %s; kami-labs computed %s; classicwowforever checked %s"
                        % (datetime.date.today().isoformat(), kami_date, ", ".join(sorted(cwf_dates)))],
            notes=("Level 60 pre-raid (Pre-BIS) WoW Forever lists built by web/scripts/fetch-forever-bis.py. "
                   "Each entry's \"from\" says which source listed it: sim (the simulator's gear set, first pick), "
                   "kami (computed from the simulator's stat weights) or cwf (classicwowforever, alternatives). "
                   "Every item is checked against the simulator's item database: wrong-role items and raid drops "
                   "are left out. Random-suffix items keep the suffix in the name and use the base item ID."),
            picks=counts,
            leftOut=dropped,
        ),
        data=data,
        specBasis=basis,
    )
    OUT.write_text(json.dumps(doc, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    print("wrote %s — %s; %d left out" % (OUT.relative_to(REPO), counts, len(dropped)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
