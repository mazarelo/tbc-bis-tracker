# TBC BIS Tracker

A **World of Warcraft TBC Anniversary** add-on that lets you select gear for every phase of Burning Crusade Classic (Pre-BIS through Sunwell Plateau) and tracks your progress toward completing your Best-in-Slot list — inspired by the "Attuned" add-on but focused entirely on gear.

---

## Features

| Feature | Details |
|---------|---------|
| **All 9 classes** | Warrior, Paladin, Hunter, Rogue, Priest, Shaman, Mage, Warlock, Druid |
| **Multiple specs** | 2–3 specialisations per class |
| **5 phases** | Pre-BIS · Phase 1 (KZ/Gruul/Mag) · Phase 2 (SSC/TK) · Phase 3 (BT/Hyjal) · Phase 4 (Sunwell) |
| **17 gear slots** | Head · Neck · Shoulders · Back · Chest · Wrist · Hands · Waist · Legs · Feet · Ring ×2 · Trinket ×2 · Main Hand · Off Hand · Ranged |
| **Item tooltips** | Hover a row to see the full Wowhead-linked tooltip |
| **Wowhead links** | Item ID and Wowhead URL shown in tooltip |
| **Source info** | Shows where to get each item (heroic, crafted, reputation, raid, etc.) |
| **Per-character tracking** | Each character stores its own check-list |
| **Progress bar** | Visual progress indicator per phase |
| **Missing filter** | Toggle to show only items you still need |
| **Minimap button** | Quick toggle; draggable around the minimap |
| **Slash commands** | `/tbcbis` to open/close, `/tbcbis reset` to wipe data |

---

## Installation

1. Download or clone this repository.
2. Copy the **`TBCBisTracker`** folder into:
   ```
   World of Warcraft/_classic_/Interface/AddOns/TBCBisTracker/
   ```
3. Launch (or reload) the game: `/reload`
4. Enable the add-on in the **AddOns** list on the character-selection screen.

---

## Usage

| Action | How |
|--------|-----|
| Open / Close | Click the **minimap button** or type `/tbcbis` |
| Select class | Click a class icon at the top of the window |
| Select spec | Click a spec tab below the class icons |
| Select phase | Click a phase tab (Pre-BIS, Phase 1 – 4) |
| Mark obtained | Tick the checkbox on the right of any row |
| Filter missing | Enable **"Show missing only"** checkbox |
| View item info | Hover a row for the full in-game tooltip + Wowhead URL |
| Reset tracking | `/tbcbis reset` |
| Hide minimap button | `/tbcbis hide` |
| Show minimap button | `/tbcbis show` |

---

## Gear data source

All item lists were curated from **[Wowhead TBC Classic](https://www.wowhead.com/tbc/)**.  
Item tooltips in-game are powered by the game's own item cache — the same data Wowhead uses.

Because WoW addons cannot make live HTTP requests, the database is pre-populated with known item IDs. You can verify or update any entry in `TBCBisTracker/Database.lua`.

---

## Extending the database

`Database.lua` is structured so that adding or updating entries is straightforward:

```lua
-- Example entry
DB["WARRIOR"]["Fury"].prebis.head = {
    id         = 23274,             -- Wowhead item ID
    source     = "Crafted (Blacksmithing 350)",
    sourceType = "crafted",         -- heroic | raid | crafted | reputation | pvp | world | quest
    note       = "Optional note",   -- shown in tooltip
}
```

---

## File structure

```
TBCBisTracker/
├── TBCBisTracker.toc    — Addon manifest (interface 2.5.4)
├── Localization.lua     — All display strings
├── Core.lua             — Initialisation, events, saved-variables, slash commands, minimap button
├── Database.lua         — Complete Pre-BIS + Phase 1-4 BIS data (all classes/specs)
└── UI.lua               — Full graphical interface
```

---

## Contributing

Pull requests with improved item data, new specs or UI enhancements are welcome.  
Please keep one item per PR for easy review.

---

## License

MIT — see `LICENSE` file.
