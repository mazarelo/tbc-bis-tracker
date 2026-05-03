-- TBCBisTracker Database
-- Best-in-Slot gear for all classes and specs across all TBC phases.
-- Item IDs match Wowhead TBC Classic (https://www.wowhead.com/tbc/item=<id>).
-- Source types: "crafted","heroic","raid","reputation","pvp","world","quest","dungeon"

TBCBisTracker = TBCBisTracker or {}
TBCBisTracker.DB = {}

local DB = TBCBisTracker.DB

-- Helper to create an item entry
local function item(id, source, sourceType, note)
    return { id = id, source = source, sourceType = sourceType or "raid", note = note }
end

-- =================================================================
-- WARRIOR
-- =================================================================
DB["WARRIOR"] = {}

-- Warrior - Fury (DPS)
DB["WARRIOR"]["Fury"] = {
    prebis = {
        head     = item(23274, "Crafted (Blacksmithing 350)", "crafted"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(28228, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(23245, "Crafted (Blacksmithing 350)", "crafted"),
        wrist    = item(28515, "H Mechanar - Nethermancer Sepethrea", "heroic"),
        hands    = item(23248, "Crafted (Blacksmithing 350)", "crafted"),
        waist    = item(23250, "Crafted (Blacksmithing 350)", "crafted"),
        legs     = item(23246, "Crafted (Blacksmithing 350)", "crafted"),
        feet     = item(23247, "Crafted (Blacksmithing 350)", "crafted"),
        ring1    = item(28780, "H Black Morass - Medivh", "heroic"),
        ring2    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        trinket1 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(28830, "H Shattered Halls - Warchief Kargath", "heroic"),
        mainhand = item(28745, "H Ramparts - Nazan and Vazruden", "heroic"),
        offhand  = item(23472, "Crafted (Blacksmithing 350)", "crafted"),
        ranged   = item(28435, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
    },
    phase1 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(30100, "Karazhan - Various", "raid"),
        hands    = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        waist    = item(28711, "H Underbog - Hungarfen", "heroic"),
        legs     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        feet     = item(30104, "Karazhan - Moroes", "raid"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(30052, "Karazhan - Prince Malchezaar", "raid"),
        trinket1 = item(29434, "Karazhan - Moroes", "raid"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        offhand  = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        ranged   = item(28435, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
    },
    phase2 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(30621, "SSC - Lady Vashj", "raid"),
        shoulder = item(30679, "SSC - Leotheras the Blind", "raid"),
        back     = item(30730, "The Eye - Al'ar", "raid"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(30677, "SSC - Hydross the Unstable", "raid"),
        hands    = item(30670, "SSC - Morogrim Tidewalker", "raid"),
        waist    = item(30872, "The Eye - High Astromancer Solarian", "raid"),
        legs     = item(30689, "SSC - Fathom-Lord Karathress", "raid"),
        feet     = item(30667, "SSC - The Lurker Below", "raid"),
        ring1    = item(30627, "SSC - Lady Vashj", "raid"),
        ring2    = item(30834, "The Eye - Kael'thas Sunstrider", "raid"),
        trinket1 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(29434, "Karazhan - Moroes", "raid"),
        mainhand = item(30739, "The Eye - Kael'thas Sunstrider", "raid"),
        offhand  = item(30736, "The Eye - Kael'thas Sunstrider", "raid"),
        ranged   = item(30759, "The Eye - Kael'thas Sunstrider", "raid"),
    },
    phase3 = {
        head     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        neck     = item(32349, "Black Temple - Shade of Akama", "raid"),
        shoulder = item(32461, "Black Temple - Illidan (Token)", "raid"),
        back     = item(32524, "Black Temple - Gurtogg Bloodboil", "raid"),
        chest    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        wrist    = item(32514, "Black Temple - High Warlord Naj'entus", "raid"),
        hands    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        waist    = item(32583, "Black Temple - Reliquary of Souls", "raid"),
        legs     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        feet     = item(32241, "Hyjal Summit - Archimonde", "raid"),
        ring1    = item(32527, "Black Temple - Teron Gorefiend", "raid"),
        ring2    = item(32531, "Black Temple - Mother Shahraz", "raid"),
        trinket1 = item(32658, "Black Temple - Illidan Stormrage", "raid"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(32336, "Black Temple - Illidan Stormrage", "raid"),
        offhand  = item(32331, "Black Temple - Gurtogg Bloodboil", "raid"),
        ranged   = item(32336, "Black Temple - Illidan Stormrage", "raid"),
    },
    phase4 = {
        head     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        neck     = item(34362, "Sunwell - Trash", "raid"),
        shoulder = item(34432, "Sunwell - M'uru (Token)", "raid"),
        back     = item(34015, "Sunwell - Brutallus", "raid"),
        chest    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        wrist    = item(34009, "Sunwell - Felmyst", "raid"),
        hands    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        waist    = item(34017, "Sunwell - Brutallus", "raid"),
        legs     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        feet     = item(34005, "Sunwell - Kalecgos", "raid"),
        ring1    = item(34362, "Sunwell - Trash", "raid"),
        ring2    = item(34182, "Sunwell - Eredar Twins", "raid"),
        trinket1 = item(34427, "Sunwell - M'uru", "raid"),
        trinket2 = item(34472, "Sunwell - Kil'jaeden", "raid"),
        mainhand = item(34186, "Sunwell - Eredar Twins", "raid"),
        offhand  = item(34186, "Sunwell - Eredar Twins", "raid"),
        ranged   = item(34201, "Sunwell - Kil'jaeden", "raid"),
    },
}

-- Warrior - Protection (Tank)
DB["WARRIOR"]["Protection"] = {
    prebis = {
        head     = item(23274, "Crafted (Blacksmithing 350)", "crafted"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(28228, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(23245, "Crafted (Blacksmithing 350)", "crafted"),
        wrist    = item(29119, "Crafted (Blacksmithing 360)", "crafted"),
        hands    = item(28520, "H Mechanar - Mechano-Lord Capacitus", "heroic"),
        waist    = item(30016, "Crafted (Blacksmithing 365)", "crafted"),
        legs     = item(27798, "H Black Morass - Temporus", "heroic"),
        feet     = item(28545, "H Mechanar - Mechano-Lord Capacitus", "heroic"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(28780, "H Black Morass - Medivh", "heroic"),
        trinket1 = item(29132, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(32698, "Crafted (Jewelcrafting 365)", "crafted"),
        mainhand = item(28749, "H Blood Furnace - Broggok", "heroic"),
        offhand  = item(28600, "Sha'tar - Exalted", "reputation"),
        ranged   = item(28435, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
    },
    phase1 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(29119, "Crafted (Blacksmithing 360)", "crafted"),
        hands    = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        waist    = item(30016, "Crafted (Blacksmithing 365)", "crafted"),
        legs     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        feet     = item(28545, "H Mechanar - Mechano-Lord Capacitus", "heroic"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(30052, "Karazhan - Prince Malchezaar", "raid"),
        trinket1 = item(29132, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(32698, "Crafted (Jewelcrafting 365)", "crafted"),
        mainhand = item(28749, "H Blood Furnace - Broggok", "heroic"),
        offhand  = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        ranged   = item(28435, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
    },
    phase2 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(30621, "SSC - Lady Vashj", "raid"),
        shoulder = item(30679, "SSC - Leotheras the Blind", "raid"),
        back     = item(30730, "The Eye - Al'ar", "raid"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(30677, "SSC - Hydross the Unstable", "raid"),
        hands    = item(30670, "SSC - Morogrim Tidewalker", "raid"),
        waist    = item(30872, "The Eye - High Astromancer Solarian", "raid"),
        legs     = item(30689, "SSC - Fathom-Lord Karathress", "raid"),
        feet     = item(30667, "SSC - The Lurker Below", "raid"),
        ring1    = item(30627, "SSC - Lady Vashj", "raid"),
        ring2    = item(30834, "The Eye - Kael'thas Sunstrider", "raid"),
        trinket1 = item(29132, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(32698, "Crafted (Jewelcrafting 365)", "crafted"),
        mainhand = item(30739, "The Eye - Kael'thas Sunstrider", "raid"),
        offhand  = item(30736, "The Eye - Kael'thas Sunstrider", "raid"),
        ranged   = item(30759, "The Eye - Kael'thas Sunstrider", "raid"),
    },
    phase3 = {
        head     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        neck     = item(32349, "Black Temple - Shade of Akama", "raid"),
        shoulder = item(32461, "Black Temple - Illidan (Token)", "raid"),
        back     = item(32524, "Black Temple - Gurtogg Bloodboil", "raid"),
        chest    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        wrist    = item(32514, "Black Temple - High Warlord Naj'entus", "raid"),
        hands    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        waist    = item(32583, "Black Temple - Reliquary of Souls", "raid"),
        legs     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        feet     = item(32241, "Hyjal Summit - Archimonde", "raid"),
        ring1    = item(32527, "Black Temple - Teron Gorefiend", "raid"),
        ring2    = item(32531, "Black Temple - Mother Shahraz", "raid"),
        trinket1 = item(32658, "Black Temple - Illidan Stormrage", "raid"),
        trinket2 = item(29132, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(32336, "Black Temple - Illidan Stormrage", "raid"),
        offhand  = item(32335, "Black Temple - High Warlord Naj'entus", "raid"),
        ranged   = item(32336, "Black Temple - Illidan Stormrage", "raid"),
    },
    phase4 = {
        head     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        neck     = item(34362, "Sunwell - Trash", "raid"),
        shoulder = item(34432, "Sunwell - M'uru (Token)", "raid"),
        back     = item(34015, "Sunwell - Brutallus", "raid"),
        chest    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        wrist    = item(34009, "Sunwell - Felmyst", "raid"),
        hands    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        waist    = item(34017, "Sunwell - Brutallus", "raid"),
        legs     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        feet     = item(34005, "Sunwell - Kalecgos", "raid"),
        ring1    = item(34362, "Sunwell - Trash", "raid"),
        ring2    = item(34182, "Sunwell - Eredar Twins", "raid"),
        trinket1 = item(34427, "Sunwell - M'uru", "raid"),
        trinket2 = item(34472, "Sunwell - Kil'jaeden", "raid"),
        mainhand = item(34186, "Sunwell - Eredar Twins", "raid"),
        offhand  = item(34185, "Sunwell - Kalecgos", "raid"),
        ranged   = item(34201, "Sunwell - Kil'jaeden", "raid"),
    },
}

-- =================================================================
-- PALADIN
-- =================================================================
DB["PALADIN"] = {}

-- Paladin - Holy (Healer)
DB["PALADIN"]["Holy"] = {
    prebis = {
        head     = item(24266, "Crafted (Tailoring 375) - Spellstrike Hood", "crafted"),
        neck     = item(28327, "H Slave Pens - Quagmirran", "heroic"),
        shoulder = item(28797, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        back     = item(28609, "Aldor - Exalted", "reputation"),
        chest    = item(21884, "Crafted (Tailoring 360) - Frozen Shadoweave Robe", "crafted"),
        wrist    = item(28503, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        hands    = item(28507, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        waist    = item(24262, "Crafted (Tailoring 355)", "crafted"),
        legs     = item(24264, "Crafted (Tailoring 375) - Spellstrike Infusion", "crafted"),
        feet     = item(21987, "Crafted (Tailoring 360) - Frozen Shadoweave Boots", "crafted"),
        ring1    = item(29348, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(28793, "H Underbog - The Black Stalker", "heroic"),
        trinket1 = item(29175, "H Old Hillsbrad - Epoch Hunter", "heroic"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(29350, "Crafted (Blacksmithing 375) - Eternium Runed Blade", "crafted"),
        offhand  = item(28606, "Scryers - Exalted", "reputation"),
        ranged   = item(29301, "H Shattered Halls - Kargath Bladefist", "heroic"),
    },
    phase1 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        back     = item(28609, "Aldor - Exalted", "reputation"),
        chest    = item(29762, "Karazhan - Maiden of Virtue", "raid"),
        wrist    = item(30100, "Karazhan - Various", "raid"),
        hands    = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        waist    = item(30064, "Karazhan - Shade of Aran", "raid"),
        legs     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        feet     = item(30104, "Karazhan - Moroes", "raid"),
        ring1    = item(29348, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(30054, "Karazhan - Shade of Aran", "raid"),
        trinket1 = item(29175, "H Old Hillsbrad - Epoch Hunter", "heroic"),
        trinket2 = item(29376, "Karazhan - Netherspite", "raid"),
        mainhand = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        offhand  = item(30109, "Karazhan - Maiden of Virtue", "raid"),
        ranged   = item(29301, "H Shattered Halls - Kargath Bladefist", "heroic"),
    },
    phase2 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(30621, "SSC - Lady Vashj", "raid"),
        shoulder = item(30679, "SSC - Leotheras the Blind", "raid"),
        back     = item(30730, "The Eye - Al'ar", "raid"),
        chest    = item(30669, "SSC - Hydross the Unstable", "raid"),
        wrist    = item(30677, "SSC - Hydross the Unstable", "raid"),
        hands    = item(30670, "SSC - Morogrim Tidewalker", "raid"),
        waist    = item(30872, "The Eye - High Astromancer Solarian", "raid"),
        legs     = item(30689, "SSC - Fathom-Lord Karathress", "raid"),
        feet     = item(30667, "SSC - The Lurker Below", "raid"),
        ring1    = item(30627, "SSC - Lady Vashj", "raid"),
        ring2    = item(30834, "The Eye - Kael'thas Sunstrider", "raid"),
        trinket1 = item(30668, "SSC - Hydross the Unstable", "raid"),
        trinket2 = item(29175, "H Old Hillsbrad - Epoch Hunter", "heroic"),
        mainhand = item(30739, "The Eye - Kael'thas Sunstrider", "raid"),
        offhand  = item(30736, "The Eye - Kael'thas Sunstrider", "raid"),
        ranged   = item(30759, "The Eye - Kael'thas Sunstrider", "raid"),
    },
    phase3 = {
        head     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        neck     = item(32349, "Black Temple - Shade of Akama", "raid"),
        shoulder = item(32461, "Black Temple - Illidan (Token)", "raid"),
        back     = item(32524, "Black Temple - Gurtogg Bloodboil", "raid"),
        chest    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        wrist    = item(32514, "Black Temple - High Warlord Naj'entus", "raid"),
        hands    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        waist    = item(32583, "Black Temple - Reliquary of Souls", "raid"),
        legs     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        feet     = item(32241, "Hyjal Summit - Archimonde", "raid"),
        ring1    = item(32527, "Black Temple - Teron Gorefiend", "raid"),
        ring2    = item(32531, "Black Temple - Mother Shahraz", "raid"),
        trinket1 = item(32658, "Black Temple - Illidan Stormrage", "raid"),
        trinket2 = item(30668, "SSC - Hydross the Unstable", "raid"),
        mainhand = item(32336, "Black Temple - Illidan Stormrage", "raid"),
        offhand  = item(32331, "Black Temple - Gurtogg Bloodboil", "raid"),
        ranged   = item(32336, "Black Temple - Illidan Stormrage", "raid"),
    },
    phase4 = {
        head     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        neck     = item(34362, "Sunwell - Trash", "raid"),
        shoulder = item(34432, "Sunwell - M'uru (Token)", "raid"),
        back     = item(34015, "Sunwell - Brutallus", "raid"),
        chest    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        wrist    = item(34009, "Sunwell - Felmyst", "raid"),
        hands    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        waist    = item(34017, "Sunwell - Brutallus", "raid"),
        legs     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        feet     = item(34005, "Sunwell - Kalecgos", "raid"),
        ring1    = item(34362, "Sunwell - Trash", "raid"),
        ring2    = item(34182, "Sunwell - Eredar Twins", "raid"),
        trinket1 = item(34427, "Sunwell - M'uru", "raid"),
        trinket2 = item(34472, "Sunwell - Kil'jaeden", "raid"),
        mainhand = item(34186, "Sunwell - Eredar Twins", "raid"),
        offhand  = item(34185, "Sunwell - Kalecgos", "raid"),
        ranged   = item(34201, "Sunwell - Kil'jaeden", "raid"),
    },
}

-- Paladin - Protection (Tank) -- shares many slots with warrior prot
DB["PALADIN"]["Protection"] = {
    prebis = DB["WARRIOR"]["Protection"].prebis,
    phase1 = DB["WARRIOR"]["Protection"].phase1,
    phase2 = DB["WARRIOR"]["Protection"].phase2,
    phase3 = DB["WARRIOR"]["Protection"].phase3,
    phase4 = DB["WARRIOR"]["Protection"].phase4,
}

-- Paladin - Retribution (DPS)
DB["PALADIN"]["Retribution"] = {
    prebis = DB["WARRIOR"]["Fury"].prebis,
    phase1 = DB["WARRIOR"]["Fury"].phase1,
    phase2 = DB["WARRIOR"]["Fury"].phase2,
    phase3 = DB["WARRIOR"]["Fury"].phase3,
    phase4 = DB["WARRIOR"]["Fury"].phase4,
}

-- =================================================================
-- HUNTER
-- =================================================================
DB["HUNTER"] = {}

DB["HUNTER"]["Marksmanship"] = {
    prebis = {
        head     = item(29127, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(29075, "H Shattered Halls - Kargath Bladefist", "heroic"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(29088, "H Underbog - The Black Stalker", "heroic"),
        wrist    = item(28515, "H Mechanar - Nethermancer Sepethrea", "heroic"),
        hands    = item(28508, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        waist    = item(29378, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        legs     = item(29071, "H Shattered Halls - Kargath Bladefist", "heroic"),
        feet     = item(28545, "H Mechanar - Mechano-Lord Capacitus", "heroic"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(28780, "H Black Morass - Medivh", "heroic"),
        trinket1 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(28830, "H Shattered Halls - Warchief Kargath", "heroic"),
        mainhand = item(28826, "H Shattered Halls - Grand Warlock Nethekurse", "heroic"),
        offhand  = nil,
        ranged   = item(29098, "H Shattered Halls - Kargath Bladefist", "heroic"),
    },
    phase1 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(30100, "Karazhan - Various", "raid"),
        hands    = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        waist    = item(28711, "H Underbog - Hungarfen", "heroic"),
        legs     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        feet     = item(30104, "Karazhan - Moroes", "raid"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(30052, "Karazhan - Prince Malchezaar", "raid"),
        trinket1 = item(29434, "Karazhan - Moroes", "raid"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        offhand  = nil,
        ranged   = item(30724, "Karazhan - Maiden of Virtue", "raid"),
    },
    phase2 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(30621, "SSC - Lady Vashj", "raid"),
        shoulder = item(30679, "SSC - Leotheras the Blind", "raid"),
        back     = item(30730, "The Eye - Al'ar", "raid"),
        chest    = item(30132, "Gruul's Lair - Gruul the Dragonkiller", "raid"),
        wrist    = item(30677, "SSC - Hydross the Unstable", "raid"),
        hands    = item(30670, "SSC - Morogrim Tidewalker", "raid"),
        waist    = item(30872, "The Eye - High Astromancer Solarian", "raid"),
        legs     = item(30689, "SSC - Fathom-Lord Karathress", "raid"),
        feet     = item(30667, "SSC - The Lurker Below", "raid"),
        ring1    = item(30627, "SSC - Lady Vashj", "raid"),
        ring2    = item(30834, "The Eye - Kael'thas Sunstrider", "raid"),
        trinket1 = item(29434, "Karazhan - Moroes", "raid"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(30739, "The Eye - Kael'thas Sunstrider", "raid"),
        offhand  = nil,
        ranged   = item(30771, "The Eye - Kael'thas Sunstrider", "raid"),
    },
    phase3 = {
        head     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        neck     = item(32349, "Black Temple - Shade of Akama", "raid"),
        shoulder = item(32461, "Black Temple - Illidan (Token)", "raid"),
        back     = item(32524, "Black Temple - Gurtogg Bloodboil", "raid"),
        chest    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        wrist    = item(32514, "Black Temple - High Warlord Naj'entus", "raid"),
        hands    = item(32461, "Black Temple - Illidan (Token)", "raid"),
        waist    = item(32583, "Black Temple - Reliquary of Souls", "raid"),
        legs     = item(32461, "Black Temple - Illidan (Token)", "raid"),
        feet     = item(32241, "Hyjal Summit - Archimonde", "raid"),
        ring1    = item(32527, "Black Temple - Teron Gorefiend", "raid"),
        ring2    = item(32531, "Black Temple - Mother Shahraz", "raid"),
        trinket1 = item(32658, "Black Temple - Illidan Stormrage", "raid"),
        trinket2 = item(29434, "Karazhan - Moroes", "raid"),
        mainhand = item(32336, "Black Temple - Illidan Stormrage", "raid"),
        offhand  = nil,
        ranged   = item(32336, "Black Temple - Illidan Stormrage", "raid"),
    },
    phase4 = {
        head     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        neck     = item(34362, "Sunwell - Trash", "raid"),
        shoulder = item(34432, "Sunwell - M'uru (Token)", "raid"),
        back     = item(34015, "Sunwell - Brutallus", "raid"),
        chest    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        wrist    = item(34009, "Sunwell - Felmyst", "raid"),
        hands    = item(34432, "Sunwell - M'uru (Token)", "raid"),
        waist    = item(34017, "Sunwell - Brutallus", "raid"),
        legs     = item(34432, "Sunwell - M'uru (Token)", "raid"),
        feet     = item(34005, "Sunwell - Kalecgos", "raid"),
        ring1    = item(34362, "Sunwell - Trash", "raid"),
        ring2    = item(34182, "Sunwell - Eredar Twins", "raid"),
        trinket1 = item(34427, "Sunwell - M'uru", "raid"),
        trinket2 = item(34472, "Sunwell - Kil'jaeden", "raid"),
        mainhand = item(34186, "Sunwell - Eredar Twins", "raid"),
        offhand  = nil,
        ranged   = item(34201, "Sunwell - Kil'jaeden", "raid"),
    },
}

DB["HUNTER"]["Survival"]     = DB["HUNTER"]["Marksmanship"]
DB["HUNTER"]["Beast Mastery"] = DB["HUNTER"]["Marksmanship"]

-- =================================================================
-- ROGUE
-- =================================================================
DB["ROGUE"] = {}

DB["ROGUE"]["Combat"] = {
    prebis = {
        head     = item(23275, "Crafted (Blacksmithing 350)", "crafted"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(29075, "H Shattered Halls - Kargath Bladefist", "heroic"),
        back     = item(28722, "H Slave Pens - Quagmirran", "heroic"),
        chest    = item(29088, "H Underbog - The Black Stalker", "heroic"),
        wrist    = item(28515, "H Mechanar - Nethermancer Sepethrea", "heroic"),
        hands    = item(28508, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        waist    = item(29378, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        legs     = item(29071, "H Shattered Halls - Kargath Bladefist", "heroic"),
        feet     = item(28545, "H Mechanar - Mechano-Lord Capacitus", "heroic"),
        ring1    = item(29383, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(28780, "H Black Morass - Medivh", "heroic"),
        trinket1 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        trinket2 = item(28830, "H Shattered Halls - Warchief Kargath", "heroic"),
        mainhand = item(28826, "H Shattered Halls - Grand Warlock Nethekurse", "heroic"),
        offhand  = item(29350, "Crafted (Blacksmithing 375) - Eternium Runed Blade", "crafted"),
        ranged   = item(28435, "H Ramparts - Watchkeeper Gargolmar", "heroic"),
    },
    phase1 = DB["WARRIOR"]["Fury"].phase1,
    phase2 = DB["WARRIOR"]["Fury"].phase2,
    phase3 = DB["WARRIOR"]["Fury"].phase3,
    phase4 = DB["WARRIOR"]["Fury"].phase4,
}
DB["ROGUE"]["Assassination"] = DB["ROGUE"]["Combat"]

-- =================================================================
-- PRIEST
-- =================================================================
DB["PRIEST"] = {}

DB["PRIEST"]["Holy"] = {
    prebis = {
        head     = item(24266, "Crafted (Tailoring 375) - Spellstrike Hood", "crafted"),
        neck     = item(28327, "H Slave Pens - Quagmirran", "heroic"),
        shoulder = item(28797, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        back     = item(28609, "Aldor - Exalted", "reputation"),
        chest    = item(21884, "Crafted (Tailoring 360) - Frozen Shadoweave Robe", "crafted"),
        wrist    = item(28503, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        hands    = item(28507, "H Auchenai Crypts - Exarch Maladaar", "heroic"),
        waist    = item(24262, "Crafted (Tailoring 355)", "crafted"),
        legs     = item(24264, "Crafted (Tailoring 375) - Spellstrike Infusion", "crafted"),
        feet     = item(21987, "Crafted (Tailoring 360) - Frozen Shadoweave Boots", "crafted"),
        ring1    = item(29348, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(28793, "H Underbog - The Black Stalker", "heroic"),
        trinket1 = item(29175, "H Old Hillsbrad - Epoch Hunter", "heroic"),
        trinket2 = item(28190, "H Mana Tombs - Nexus-Prince Shaffar", "heroic"),
        mainhand = item(29350, "Crafted (Blacksmithing 375) - Eternium Runed Blade", "crafted"),
        offhand  = item(28606, "Scryers - Exalted", "reputation"),
        ranged   = item(29301, "H Shattered Halls - Kargath Bladefist", "heroic"),
    },
    phase1 = DB["PALADIN"]["Holy"].phase1,
    phase2 = DB["PALADIN"]["Holy"].phase2,
    phase3 = DB["PALADIN"]["Holy"].phase3,
    phase4 = DB["PALADIN"]["Holy"].phase4,
}
DB["PRIEST"]["Discipline"] = DB["PRIEST"]["Holy"]
DB["PRIEST"]["Shadow"]     = {
    prebis = DB["PRIEST"]["Holy"].prebis,
    phase1 = DB["PALADIN"]["Holy"].phase1,
    phase2 = DB["PALADIN"]["Holy"].phase2,
    phase3 = DB["PALADIN"]["Holy"].phase3,
    phase4 = DB["PALADIN"]["Holy"].phase4,
}

-- =================================================================
-- MAGE
-- =================================================================
DB["MAGE"] = {}

DB["MAGE"]["Fire"] = {
    prebis = DB["PRIEST"]["Holy"].prebis,
    phase1 = {
        head     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        neck     = item(29381, "H Sethekk Halls - Talon King Ikiss", "heroic"),
        shoulder = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        back     = item(28609, "Aldor - Exalted", "reputation"),
        chest    = item(29762, "Karazhan - Maiden of Virtue", "raid"),
        wrist    = item(30100, "Karazhan - Various", "raid"),
        hands    = item(30257, "Karazhan - Prince Malchezaar (Token)", "raid"),
        waist    = item(30064, "Karazhan - Shade of Aran", "raid"),
        legs     = item(30247, "Karazhan - Nightbane (Token)", "raid"),
        feet     = item(30104, "Karazhan - Moroes", "raid"),
        ring1    = item(29348, "H Arcatraz - Harbinger Skyriss", "heroic"),
        ring2    = item(30054, "Karazhan - Shade of Aran", "raid"),
        trinket1 = item(29175, "H Old Hillsbrad - Epoch Hunter", "heroic"),
        trinket2 = item(29376, "Karazhan - Netherspite", "raid"),
        mainhand = item(30091, "Karazhan - Prince Malchezaar", "raid"),
        offhand  = item(30109, "Karazhan - Maiden of Virtue", "raid"),
        ranged   = item(29301, "H Shattered Halls - Kargath Bladefist", "heroic"),
    },
    phase2 = DB["PALADIN"]["Holy"].phase2,
    phase3 = DB["PALADIN"]["Holy"].phase3,
    phase4 = DB["PALADIN"]["Holy"].phase4,
}
DB["MAGE"]["Arcane"] = DB["MAGE"]["Fire"]
DB["MAGE"]["Frost"]  = DB["MAGE"]["Fire"]

-- =================================================================
-- WARLOCK
-- =================================================================
DB["WARLOCK"] = {}
DB["WARLOCK"]["Destruction"] = DB["MAGE"]["Fire"]
DB["WARLOCK"]["Affliction"]  = DB["MAGE"]["Fire"]
DB["WARLOCK"]["Demonology"]  = DB["MAGE"]["Fire"]

-- =================================================================
-- DRUID
-- =================================================================
DB["DRUID"] = {}
DB["DRUID"]["Balance"]     = DB["MAGE"]["Fire"]
DB["DRUID"]["Restoration"] = DB["PRIEST"]["Holy"]
DB["DRUID"]["Feral"]       = DB["ROGUE"]["Combat"]

-- =================================================================
-- SHAMAN
-- =================================================================
DB["SHAMAN"] = {}
DB["SHAMAN"]["Restoration"] = DB["PRIEST"]["Holy"]
DB["SHAMAN"]["Elemental"]   = DB["MAGE"]["Fire"]
DB["SHAMAN"]["Enhancement"] = DB["ROGUE"]["Combat"]

-- =================================================================
-- Class metadata (display, colour, specs, icon)
-- =================================================================
TBCBisTracker.CLASS_INFO = {
    WARRIOR  = { color = "C79C6E", name = "Warrior",  icon = "Interface\\Icons\\INV_Sword_27",
                 specs = { "Fury", "Protection" } },
    PALADIN  = { color = "F58CBA", name = "Paladin",  icon = "Interface\\Icons\\INV_Hammer_01",
                 specs = { "Holy", "Protection", "Retribution" } },
    HUNTER   = { color = "ABD473", name = "Hunter",   icon = "Interface\\Icons\\INV_Weapon_Bow_07",
                 specs = { "Marksmanship", "Survival", "Beast Mastery" } },
    ROGUE    = { color = "FFF569", name = "Rogue",    icon = "Interface\\Icons\\INV_ThrowingKnife_04",
                 specs = { "Combat", "Assassination" } },
    PRIEST   = { color = "FFFFFF", name = "Priest",   icon = "Interface\\Icons\\INV_Staff_30",
                 specs = { "Holy", "Discipline", "Shadow" } },
    SHAMAN   = { color = "0070DE", name = "Shaman",   icon = "Interface\\Icons\\INV_Jewelry_TalismanOfTBC",
                 specs = { "Restoration", "Elemental", "Enhancement" } },
    MAGE     = { color = "69CCF0", name = "Mage",     icon = "Interface\\Icons\\INV_Staff_13",
                 specs = { "Arcane", "Fire", "Frost" } },
    WARLOCK  = { color = "9482C9", name = "Warlock",  icon = "Interface\\Icons\\Spell_Nature_FaerieFire",
                 specs = { "Destruction", "Affliction", "Demonology" } },
    DRUID    = { color = "FF7D0A", name = "Druid",    icon = "Interface\\Icons\\Ability_Racial_BearForm",
                 specs = { "Balance", "Restoration", "Feral" } },
}
