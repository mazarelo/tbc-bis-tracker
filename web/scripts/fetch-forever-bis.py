#!/usr/bin/env python3
"""
Refreshes the curated WoW Forever pre-raid gear list (level 60) from
classicwowforever.com:

  https://classicwowforever.com/bis-list/<spec>-<class>/  ->  web/scripts/forever-lvl60.json

Then run build-forever-db.py to regenerate the add-on and website data.

  python3 web/scripts/fetch-forever-bis.py            # download the pages
  python3 web/scripts/fetch-forever-bis.py --cache D  # read/keep the pages in D

Each page carries its lists as JSON in its server-rendered payload: one object
per level bracket ({"id":"level-60", "slots":{...}, "setups":[...]}), each slot
a list of items, first pick first. The script fails loudly when that changes.

The site's guides and data are CC BY 4.0: keep the credit (README, the
generated files' headers, the website's credit line).
"""
import argparse
import datetime
import json
import re
import sys
import time
import urllib.request
from collections import OrderedDict
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent.parent
OUT = REPO / "web" / "scripts" / "forever-lvl60.json"
BASE = "https://classicwowforever.com"
BRACKET = "level-60"

# (page, class, add-on spec names fed by it)
PAGES = [
    ("fury-warrior", "WARRIOR", ["Fury"]),
    ("arms-warrior", "WARRIOR", ["Arms"]),
    ("protection-warrior", "WARRIOR", ["Protection"]),
    ("holy-paladin", "PALADIN", ["Holy"]),
    ("protection-paladin", "PALADIN", ["Protection"]),
    ("retribution-paladin", "PALADIN", ["Retribution"]),
    ("marksmanship-hunter", "HUNTER", ["Marksmanship"]),
    ("survival-hunter", "HUNTER", ["Survival"]),
    ("beast-mastery-hunter", "HUNTER", ["Beast Mastery"]),
    ("combat-rogue", "ROGUE", ["Combat"]),
    ("assassination-rogue", "ROGUE", ["Assassination"]),
    ("subtlety-rogue", "ROGUE", ["Subtlety"]),
    ("holy-priest", "PRIEST", ["Holy"]),
    ("discipline-priest", "PRIEST", ["Discipline"]),
    ("shadow-priest", "PRIEST", ["Shadow"]),
    ("restoration-shaman", "SHAMAN", ["Restoration"]),
    ("elemental-shaman", "SHAMAN", ["Elemental"]),
    ("enhancement-shaman", "SHAMAN", ["Enhancement"]),
    ("arcane-mage", "MAGE", ["Arcane"]),
    ("fire-mage", "MAGE", ["Fire"]),
    ("frost-mage", "MAGE", ["Frost"]),
    ("destruction-warlock", "WARLOCK", ["Destruction"]),
    ("affliction-warlock", "WARLOCK", ["Affliction"]),
    ("demonology-warlock", "WARLOCK", ["Demonology"]),
    ("balance-druid", "DRUID", ["Balance"]),
    ("restoration-druid", "DRUID", ["Restoration"]),
    # One Feral page: cat gear first, bear swaps marked in the notes.
    ("feral-druid", "DRUID", ["Feral - Tank", "Feral - DPS"]),
]

# site slot -> add-on slot
SLOTS = OrderedDict([
    ("head", "head"), ("neck", "neck"), ("shoulder", "shoulder"), ("back", "back"), ("chest", "chest"),
    ("wrist", "wrist"), ("hands", "hands"), ("waist", "waist"), ("legs", "legs"), ("feet", "feet"),
    ("finger-1", "ring1"), ("finger-2", "ring2"), ("trinket-1", "trinket1"), ("trinket-2", "trinket2"),
    ("main-hand", "mainhand"), ("off-hand", "offhand"), ("ranged", "ranged"),
])

# A drop whose place is one of these is an open-world drop, not a dungeon boss.
ZONES = {
    "Alterac Mountains", "Arathi Highlands", "Ashenvale", "Azshara", "Badlands", "Blasted Lands",
    "Burning Steppes", "Darkshore", "Deadwind Pass", "Desolace", "Dun Morogh", "Durotar", "Duskwood",
    "Dustwallow Marsh", "Eastern Plaguelands", "Elwynn Forest", "Felwood", "Feralas", "Hillsbrad Foothills",
    "Loch Modan", "Moonglade", "Mount Hyjal", "Mulgore", "Redridge Mountains", "Riverglades", "Searing Gorge",
    "Silithus", "Silverpine Forest", "Stonetalon Mountains", "Stranglethorn Vale", "Swamp of Sorrows",
    "Tanaris", "Teldrassil", "The Barrens", "The Hinterlands", "Thousand Needles", "Tirisfal Glades",
    "Un'Goro Crater", "Western Plaguelands", "Westfall", "Wetlands", "Winterspring", "Zephras Isle",
}
RAIDS = {"Molten Core", "Onyxia's Lair", "The Barrow Deeps", "Barrow Deeps", "Hyjal Summit", "Blackwing Lair",
         "Zul'Gurub", "Ruins of Ahn'Qiraj", "Temple of Ahn'Qiraj", "Naxxramas"}
STANDINGS = ("Friendly", "Honored", "Revered", "Exalted")


def fetch(page, cache):
    name = page + ".html"
    if cache and (cache / name).exists():
        return (cache / name).read_text(encoding="utf-8")
    req = urllib.request.Request("%s/bis-list/%s/" % (BASE, page), headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=60) as r:
        doc = r.read().decode("utf-8")
    if cache:
        cache.mkdir(parents=True, exist_ok=True)
        (cache / name).write_text(doc, encoding="utf-8")
    time.sleep(1)
    return doc


def bracket(doc, page):
    """The level-60 list object out of the page's payload."""
    try:
        payload = "".join(json.loads(s) for s in re.findall(r'\.rsc\.push\((".*?")\)</script>', doc, flags=re.S))
    except ValueError:
        payload = ""
    at = payload.find('{"id":"%s"' % BRACKET)
    if at < 0:
        raise SystemExit("%s: no %s list in the page (layout changed?)" % (page, BRACKET))
    obj, _ = json.JSONDecoder().raw_decode(payload[at:])
    if not isinstance(obj.get("slots"), dict) or not obj["slots"].get("head"):
        raise SystemExit("%s: the %s list has no slots (layout changed?)" % (page, BRACKET))
    return obj


def standing(detail):
    """'Revered with Barkskin Burrow' / 'Gadgetzan - Honored' -> ('Barkskin Burrow', 'Revered')."""
    for st in STANDINGS:
        if st in (detail or ""):
            who = re.sub(r"\b%s\b" % st, "", detail)
            who = re.sub(r"\bwith\b", "", who).strip(" ,-–")
            if who:
                return who, st
    return None


def entry(item):
    src = item.get("source") or {}
    kind, place, name, detail = src.get("kind"), src.get("place"), src.get("name"), src.get("detail")
    notes = []
    if kind == "crafted":
        source, stype = place or "Crafted", "crafted"
    elif kind == "quest":
        source, stype = "Quest: " + (name or place or "?"), "quest"
        if name and place:
            notes.append(place)
        if detail:
            notes.append(detail)
    elif kind == "vendor":
        rep = standing(detail)
        seller = ", ".join(x for x in (name, place) if x)
        if rep:
            source, stype = "%s - %s" % rep, "reputation"
            notes.append("Sold by " + seller)
        else:
            source, stype = "Sold by " + seller, "world"
            if detail:
                notes.append(detail)
    elif kind == "drop":
        source = ", ".join(x for x in (name, place) if x) or "Unknown source"
        stype = "world" if place in ZONES else ("raid" if place in RAIDS else "dungeon")
        if detail:
            notes.append(detail)
    else:
        raise SystemExit("unknown source kind %r for %s" % (kind, item.get("name")))
    if item.get("note"):
        notes.append(item["note"])
    e = OrderedDict(id=int(item["id"]), name=item["name"], source=source, sourceType=stype,
                    sourceUrl="https://www.wowhead.com/forever/item=%d" % int(item["id"]))
    if notes:
        e["note"] = ". ".join(n.rstrip(".") for n in notes)
    side = re.match(r"^(Alliance|Horde)\b(?: only)?[.;,]", item.get("note") or "")
    if side:
        e["faction"] = side.group(1)
    return e


def to_slots(obj):
    lists = dict(obj["slots"])
    setups = obj.get("setups") or []
    hide = set(obj.get("hide") or [])
    setup = None
    if setups:
        # The first setup is the one the page shows.
        setup = setups[0]
        lists.update(setup.get("slots") or {})
        hide |= set(setup.get("hide") or [])
    unknown = set(lists) - set(SLOTS)
    if unknown:
        raise SystemExit("unknown slots: %s" % ", ".join(sorted(unknown)))
    out = OrderedDict()
    for site, ours in SLOTS.items():
        out[ours] = [] if site in hide else [entry(i) for i in lists.get(site) or []]
    others = [s.get("label") for s in setups[1:]]
    return out, setup and setup.get("label"), others


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cache", type=Path, help="directory to read/keep the downloaded pages in")
    args = ap.parse_args()

    data, basis, builds, dates = OrderedDict(), OrderedDict(), set(), set()
    for page, cls, specs in PAGES:
        obj = bracket(fetch(page, args.cache), page)
        slots, setup, others = to_slots(obj)
        builds.add(obj.get("build") or "?")
        dates.add(obj.get("updated") or "?")
        for spec in specs:
            data.setdefault(cls, OrderedDict())[spec] = slots
            basis["%s/%s" % (cls, spec)] = (
                "classicwowforever.com/bis-list/%s (checked %s)%s%s; order = the site's, first pick first"
                % (page, obj.get("updated"),
                   "; weapons: %s setup" % setup if setup else "",
                   " (not used: %s)" % ", ".join(others) if others else ""))
        print("%-22s %-8s %-12s %3d items" % (page, cls, setup or "-", sum(len(v) for v in slots.values())))

    doc = OrderedDict(
        meta=OrderedDict(
            generated=datetime.date.today().isoformat(),
            sources=["%s/bis-list/%s/" % (BASE, p[0]) for p in PAGES],
            credit="Lists: Classic WoW Forever (classicwowforever.com), CC BY 4.0",
            siteStatus=["Level 60 pre-raid lists checked %s against build %s"
                        % (", ".join(sorted(dates)), ", ".join(sorted(builds)))],
            notes=("Level 60 pre-raid (Pre-BIS) WoW Forever lists read from classicwowforever.com by "
                   "web/scripts/fetch-forever-bis.py. Item IDs are the site's (Wowhead Forever IDs). Entries with "
                   "a \"faction\" field are Alliance- or Horde-only. Weapons use each page's first setup; "
                   "a slot the setup hides (off hand with a two-hander) is empty. The site calls its lists "
                   "unranked first picks with alternatives, and says drop sources are not all checked in game."),
        ),
        data=data,
        specBasis=basis,
    )
    OUT.write_text(json.dumps(doc, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    print("wrote %s" % OUT.relative_to(REPO))
    return 0


if __name__ == "__main__":
    sys.exit(main())
