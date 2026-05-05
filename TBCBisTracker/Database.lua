-- TBCBisTracker Database
-- Best-in-Slot gear for all classes and specs across all TBC phases.
-- Item IDs match Wowhead TBC Classic (https://www.wowhead.com/tbc/item=<id>).
-- Source types: "crafted","heroic","raid","reputation","pvp","world","quest","dungeon"
--
-- STATUS: Only PRIEST Shadow has real Wowhead-sourced data. All other specs
-- are empty placeholders to be filled in one-by-one from Wowhead BiS guides.

TBCBisTracker = TBCBisTracker or {}
TBCBisTracker.DB = {}

local DB = TBCBisTracker.DB

local function item(id, source, sourceType, note)
    return { id = id, source = source, sourceType = sourceType or "raid", note = note }
end

local function EMPTY_PHASES()
    return { prebis = {}, phase1 = {}, phase2 = {}, phase3 = {}, phase4 = {}, phase5 = {} }
end

-- =================================================================
-- WARRIOR -- TODO: Wowhead-source per spec
-- =================================================================
DB["WARRIOR"] = {}
DB["WARRIOR"]["Fury"]       = EMPTY_PHASES()
DB["WARRIOR"]["Protection"] = EMPTY_PHASES()

-- =================================================================
-- PALADIN -- TODO
-- =================================================================
DB["PALADIN"] = {}
DB["PALADIN"]["Holy"]        = EMPTY_PHASES()
DB["PALADIN"]["Protection"]  = EMPTY_PHASES()
DB["PALADIN"]["Retribution"] = EMPTY_PHASES()

-- =================================================================
-- HUNTER -- TODO
-- =================================================================
DB["HUNTER"] = {}
DB["HUNTER"]["Marksmanship"]  = EMPTY_PHASES()
DB["HUNTER"]["Survival"]      = EMPTY_PHASES()
DB["HUNTER"]["Beast Mastery"] = EMPTY_PHASES()

-- =================================================================
-- ROGUE -- TODO
-- =================================================================
DB["ROGUE"] = {}
DB["ROGUE"]["Combat"]        = EMPTY_PHASES()
DB["ROGUE"]["Assassination"] = EMPTY_PHASES()

-- =================================================================
-- PRIEST
-- =================================================================
DB["PRIEST"] = {}
DB["PRIEST"]["Holy"]       = EMPTY_PHASES()   -- TODO
DB["PRIEST"]["Discipline"] = EMPTY_PHASES()   -- TODO

-- Shadow Priest BIS — sourced from Wowhead TBC Classic guides
DB["PRIEST"]["Shadow"] = {
    prebis = {
        head     = item(24266, "Tailoring (Spellstrike Hood)", "crafted"),
        neck     = item(28245, "PvP — Honor (Pendant of Dominance)", "pvp"),
        shoulder = item(21869, "Tailoring/Shadoweave (Frozen Shadoweave Shoulders)", "crafted"),
        back     = item(31201, "Chief Engineer Lorthander, Netherstorm (Illidari Cloak of Shadow Wrath)", "world"),
        chest    = item(21871, "Tailoring/Shadoweave (Frozen Shadoweave Robe)", "crafted"),
        wrist    = item(31225, "Ambassador Jerrikar, Shadowmoon Valley (Illidari Bindings of Shadow Wrath)", "world"),
        hands    = item(31166, "Speaker Mar'grom, Blade's Edge (Nethersteel-Lined Handwraps of Shadow Wrath)", "world"),
        waist    = item(31199, "Voidhunter Yar, Nagrand (Voidweave Cilice of Shadow Wrath)", "world"),
        legs     = item(24262, "Tailoring (Spellstrike Pants)", "crafted"),
        feet     = item(21870, "Tailoring/Shadoweave (Frozen Shadoweave Boots)", "crafted"),
        ring1    = item(21709, "AQ40 - C'Thun (Ring of the Fallen God)", "raid"),
        ring2    = item(23031, "Naxx40 - Noth the Plaguebringer (Band of the Inevitable)", "raid"),
        trinket1 = item(29370, "Vendor - Badges of Justice (Icon of the Silver Crescent)", "raid"),
        trinket2 = item(27683, "H Slave Pens - Quagmirran (Quagmirran's Eye)", "heroic"),
        mainhand = item(30832, "Lower City Exalted (Gavel of Unearthed Secrets)", "reputation"),
        offhand  = item(29272, "Vendor - Badges of Justice (Orb of the Soul-Eater)", "raid"),
        ranged   = item(25295, "World Drop (Flawless Wand of Shadow Wrath)", "world"),
    },
    -- Phase 1 (Karazhan) — Wowhead-sourced BiS + alternatives
    phase1 = {
        head = {
            item(24266, "Tailoring (Spellstrike Hood)", "crafted"),
            item(28804, "Gruul - Gruul (Collar of Cho'gall)", "raid"),
            item(29058, "Karazhan - Prince Malchezaar (Soul-Collar of the Incarnate)", "raid"),
            item(31104, "Quest: Teron Gorefiend, I am... (Evoker's Helmet of Second Sight)", "quest"),
        },
        shoulder = {
            item(21869, "Tailoring/Shadoweave (Frozen Shadoweave Shoulders)", "crafted"),
            item(29060, "Gruul - High King Maulgar (Soul-Mantle of the Incarnate)", "raid"),
            item(27778, "H Shadow Labyrinth - Murmur (Spaulders of Oblivion)", "heroic"),
        },
        back = {
            item(31201, "Chief Engineer Lorthander, Netherstorm (Illidari Cloak of Shadow Wrath)", "world"),
            item(25043, "World Drop (Amber Cape of Shadow Wrath)", "world"),
            item(31254, "Marticar, Zangarmarsh (Striderhide Cloak of Shadow Wrath)", "world"),
            item(28570, "Karazhan - Moroes (Shadow-Cloak of Dalaran)", "raid"),
            item(28766, "Karazhan - Prince Malchezaar (Ruby Drape of the Mysticant)", "raid"),
            item(28797, "Gruul - High King Maulgar (Brute Cloak of the Ogre-Magi)", "raid"),
        },
        chest = {
            item(21871, "Tailoring/Shadoweave (Frozen Shadoweave Robe)", "crafted"),
            item(29056, "Magtheridon (Shroud of the Incarnate)", "raid"),
            item(28232, "Shadow Labyrinth - Murmur (Robe of Oblivion)", "heroic"),
            item(31297, "World Drop (Robe of the Crimson Order)", "world"),
        },
        wrist = {
            item(30684, "Karazhan - Rokad the Ravager (Ravager's Cuffs of Shadow Wrath)", "raid"),
            item(31225, "Ambassador Jerrikar, Shadowmoon Valley (Illidari Bindings of Shadow Wrath)", "world"),
            item(24692, "World Drop (Elementalist Bracelets of Shadow Wrath)", "world"),
            item(31192, "Goretooth, Nagrand (Crocolisk Hide Bindings of Shadow Wrath)", "world"),
            item(24250, "Tailoring (Bracers of Havok)", "crafted"),
            item(28515, "Karazhan - Maiden of Virtue (Bands of Nefarious Deeds)", "raid"),
            item(28477, "Karazhan - Attumen the Huntsman (Harbinger Bands)", "raid"),
        },
        hands = {
            item(31166, "Speaker Mar'grom, Blade's Edge (Nethersteel-Lined Handwraps of Shadow Wrath)", "world"),
            item(28507, "Karazhan - Attumen the Huntsman (Handwraps of Flowing Thought)", "raid"),
            item(28780, "Magtheridon (Soul-Eater's Handwraps)", "raid"),
            item(24688, "World Drop (Elementalist Gloves of Shadow Wrath)", "world"),
            item(30725, "Doomwalker (Anger-Spark Gloves)", "raid"),
        },
        waist = {
            item(30675, "Karazhan - Hyakiss the Lurker (Lurker's Cord of Shadow Wrath)", "raid"),
            item(28799, "Gruul - High King Maulgar (Belt of Divine Inspiration)", "raid"),
            item(24256, "Tailoring (Girdle of Ruination)", "crafted"),
        },
        legs = {
            item(24262, "Tailoring (Spellstrike Pants)", "crafted"),
            item(30734, "Doom Lord Kazzak (Leggings of the Seventh Circle)", "raid"),
            item(28594, "Karazhan - Opera Event (Trial-Fire Trousers)", "raid"),
            item(30531, "H Black Morass - Aeonus (Breeches of the Occultist)", "heroic"),
            item(30532, "H Shadow Labyrinth - Murmur (Kirin Tor Master's Trousers)", "heroic"),
        },
        feet = {
            item(30680, "Karazhan - Shadikith the Glider (Glider's Foot-Wraps of Shadow Wrath)", "raid"),
            item(21870, "Tailoring/Shadoweave (Frozen Shadoweave Boots)", "crafted"),
            item(28517, "Karazhan - Maiden of Virtue (Boots of Foretelling)", "raid"),
            item(28585, "Karazhan - The Crone (Ruby Slippers)", "raid"),
            item(28179, "Quest: Into the Heart of the Labyrinth (Shattrath Jumpers)", "quest"),
        },
        neck = {
            item(30666, "Karazhan - Trash (Ritssyn's Lost Pendant)", "raid"),
            item(24121, "Jewelcrafting (Chain of the Twilight Owl)", "crafted"),
            item(24116, "Jewelcrafting (Eye of the Night)", "crafted"),
            item(20966, "Jewelcrafting (Jade Pendant of Blasting)", "crafted"),
            item(28245, "PvP - Honor (Pendant of Dominance)", "pvp"),
            item(18814, "MC - Ragnaros (Choker of the Fire Lord)", "raid"),
            item(31693, "Quest: The Hound-Master (Natasha's Arcane Filament)", "quest"),
        },
        ring1 = {
            item(21709, "AQ40 - C'Thun (Ring of the Fallen God)", "raid"),
            item(23031, "Naxx40 - Noth the Plaguebringer (Band of the Inevitable)", "raid"),
            item(28753, "Karazhan - Dust Covered Chest (Ring of Recurrence)", "raid"),
            item(29352, "H Mana-Tombs - Nexus-Prince Shaffar (Cobalt Band of Tyrigosa)", "heroic"),
            item(28793, "Magtheridon (Band of Crimson Fury)", "raid"),
            item(28555, "Spirit Shards (Seal of the Exorcist)", "reputation"),
            item(29287, "Quest - Violet Eye Exalted (Violet Signet of the Archmage)", "reputation"),
            item(19434, "BWL - Death Talon (Band of Dark Dominion)", "raid"),
            item(19147, "MC (Ring of Spell Power)", "raid"),
            item(29126, "Scryers Exalted (Seer's Signet)", "reputation"),
            item(29172, "Cenarion Expedition Exalted (Ashyen's Gift)", "reputation"),
        },
        ring2 = {
            item(23031, "Naxx40 - Noth the Plaguebringer (Band of the Inevitable)", "raid"),
            item(21709, "AQ40 - C'Thun (Ring of the Fallen God)", "raid"),
            item(28753, "Karazhan - Dust Covered Chest (Ring of Recurrence)", "raid"),
            item(29352, "H Mana-Tombs - Nexus-Prince Shaffar (Cobalt Band of Tyrigosa)", "heroic"),
            item(28793, "Magtheridon (Band of Crimson Fury)", "raid"),
            item(28555, "Spirit Shards (Seal of the Exorcist)", "reputation"),
            item(29287, "Quest - Violet Eye Exalted (Violet Signet of the Archmage)", "reputation"),
            item(19434, "BWL - Death Talon (Band of Dark Dominion)", "raid"),
            item(19147, "MC (Ring of Spell Power)", "raid"),
            item(29126, "Scryers Exalted (Seer's Signet)", "reputation"),
            item(29172, "Cenarion Expedition Exalted (Ashyen's Gift)", "reputation"),
        },
        trinket1 = {
            item(29370, "Vendor - Badges of Justice (Icon of the Silver Crescent)", "raid"),
            item(27683, "H Slave Pens - Quagmirran (Quagmirran's Eye)", "heroic"),
            item(28789, "Magtheridon (Eye of Magtheridon)", "raid"),
            item(23207, "Quest: Phylactery of Kel'Thuzad (Mark of the Champion)", "quest"),
            item(23046, "Naxx40 - Sapphiron (The Restrained Essence of Sapphiron)", "raid"),
            item(19379, "BWL - Nefarian (Neltharion's Tear)", "raid"),
            item(29132, "Scryers Revered (Scryer's Bloodgem)", "reputation"),
        },
        trinket2 = {
            item(27683, "H Slave Pens - Quagmirran (Quagmirran's Eye)", "heroic"),
            item(29370, "Vendor - Badges of Justice (Icon of the Silver Crescent)", "raid"),
            item(28789, "Magtheridon (Eye of Magtheridon)", "raid"),
            item(23207, "Quest: Phylactery of Kel'Thuzad (Mark of the Champion)", "quest"),
            item(23046, "Naxx40 - Sapphiron (The Restrained Essence of Sapphiron)", "raid"),
            item(19379, "BWL - Nefarian (Neltharion's Tear)", "raid"),
            item(29132, "Scryers Revered (Scryer's Bloodgem)", "reputation"),
        },
        mainhand = {
            item(28770, "Karazhan - Prince Malchezaar (Nathrezim Mindblade)", "raid"),
            item(30723, "Doomwalker (Talon of the Tempest)", "raid"),
            item(28297, "Arena Points - Season 1 (Gladiator's Spellblade)", "pvp"),
            item(30832, "Lower City Exalted (Gavel of Unearthed Secrets)", "reputation"),
            item(23554, "Blacksmithing (Eternium Runed Blade)", "crafted"),
        },
        offhand = {
            item(29272, "Vendor - Badges of Justice (Orb of the Soul-Eater)", "raid"),
            item(29273, "Vendor - Badges of Justice (Khadgar's Knapsack)", "raid"),
        },
        ranged = {
            item(25295, "World Drop (Flawless Wand of Shadow Wrath)", "world"),
            item(29350, "H Underbog - The Black Stalker (The Black Stalk)", "heroic"),
            item(25294, "World Drop (Dragonscale Wand of Shadow Wrath)", "world"),
            item(28673, "Karazhan - Shade of Aran (Tirisfal Wand of Ascendancy)", "raid"),
        },
    },
    -- Phase 2 (SSC + The Eye)
    phase2 = {
        head     = item(30161, "SSC - Lady Vashj (Hood of the Avatar)", "raid"),
        neck     = item(30666, "Karazhan - Trash (Ritssyn's Lost Pendant)", "raid"),
        shoulder = item(30163, "TK - Void Reaver (Wings of the Avatar)", "raid"),
        back     = item(31201, "Chief Engineer Lorthander, Netherstorm (Illidari Cloak)", "world"),
        chest    = item(30107, "SSC - Lady Vashj (Vestments of the Sea-Witch)", "raid"),
        wrist    = item(31225, "Ambassador Jerrikar, Shadowmoon Valley (Illidari Bindings)", "world"),
        hands    = item(31166, "Speaker Mar'grom, Blade's Edge (Nethersteel-Lined Handwraps)", "world"),
        waist    = item(30038, "Tailoring (Belt of Blasting)", "crafted"),
        legs     = item(29972, "TK - High Astromancer Solarian (Trousers of the Astromancer)", "raid"),
        feet     = item(30050, "SSC - Hydross the Unstable (Boots of the Shifting Nightmare)", "raid"),
        ring1    = item(30109, "SSC - Lady Vashj (Ring of Endless Coils)", "raid"),
        ring2    = item(29922, "TK - Al'ar (Band of Al'ar)", "raid"),
        trinket1 = item(29370, "Vendor - Badges of Justice (Icon of the Silver Crescent)", "raid"),
        trinket2 = item(23207, "Naxx40 - Kel'Thuzad (Mark of the Champion)", "raid"),
        mainhand = item(28770, "Karazhan - Prince Malchezaar (Nathrezim Mindblade)", "raid"),
        offhand  = item(29272, "Vendor - Badges of Justice (Orb of the Soul-Eater)", "raid"),
        ranged   = item(29982, "TK - High Astromancer Solarian (Wand of the Forgotten Star)", "raid"),
    },
    -- Phase 3 (Black Temple + Hyjal)
    phase3 = {
        head     = item(31064, "Hyjal - Archimonde (Hood of Absolution)", "raid"),
        neck     = item(32349, "BT - Essence of Anger (Translucent Spellthread Necklace)", "raid"),
        shoulder = item(31070, "BT - Mother Shahraz (Shoulderpads of Absolution)", "raid"),
        back     = item(32590, "BT - Trash (Nethervoid Cloak)", "raid"),
        chest    = item(31065, "BT - Illidan Stormrage (Shroud of Absolution)", "raid"),
        wrist    = item(32586, "Tailoring (Bracers of Nimble Thought)", "crafted"),
        hands    = item(31061, "Hyjal - Azgalor (Handguards of Absolution)", "raid"),
        waist    = item(32256, "BT - Supremus (Waistwrap of Infinity)", "raid"),
        legs     = item(30916, "Hyjal - Kaz'rogal (Leggings of Channeled Elements)", "raid"),
        feet     = item(32239, "BT - High Warlord Naj'entus (Slippers of the Seacaller)", "raid"),
        ring1    = item(32527, "BT - Trash (Ring of Ancient Knowledge)", "raid"),
        ring2    = item(32528, "BT (Blessed Band of Karabor)", "raid"),
        trinket1 = item(32483, "BT - Illidan Stormrage (The Skull of Gul'dan)", "raid"),
        trinket2 = item(31856, "Quest - Darkmoon Blessings Deck (Darkmoon Card: Crusade)", "quest"),
        mainhand = item(32374, "BT - Illidan Stormrage (Zhar'doom, Greatstaff of the Devourer)", "raid"),
        offhand  = nil,  -- Zhar'doom is 2H
        ranged   = item(29982, "TK - High Astromancer Solarian (Wand of the Forgotten Star)", "raid"),
    },
    -- Phase 4 (Zul'Aman)
    phase4 = {
        head     = item(31064, "Hyjal - Archimonde (Hood of Absolution)", "raid"),
        neck     = item(33466, "ZA - Zul'jin (Loop of Cursed Bones)", "raid"),
        shoulder = item(31070, "BT - Mother Shahraz (Shoulderpads of Absolution)", "raid"),
        back     = item(32590, "BT - Trash (Nethervoid Cloak)", "raid"),
        chest    = item(31065, "BT - Illidan Stormrage (Shroud of Absolution)", "raid"),
        wrist    = item(32586, "Tailoring (Bracers of Nimble Thought)", "crafted"),
        hands    = item(31061, "Hyjal - Azgalor (Handguards of Absolution)", "raid"),
        waist    = item(32256, "BT - Supremus (Waistwrap of Infinity)", "raid"),
        legs     = item(30916, "Hyjal - Kaz'rogal (Leggings of Channeled Elements)", "raid"),
        feet     = item(32239, "BT - High Warlord Naj'entus (Slippers of the Seacaller)", "raid"),
        ring1    = item(32527, "BT - Trash (Ring of Ancient Knowledge)", "raid"),
        ring2    = item(30109, "SSC - Lady Vashj (Ring of Endless Coils)", "raid"),
        trinket1 = item(33829, "ZA - Hex Lord Malacrass (Hex Shrunken Head)", "raid"),
        trinket2 = item(32483, "BT - Illidan Stormrage (The Skull of Gul'dan)", "raid"),
        mainhand = item(32374, "BT - Illidan Stormrage (Zhar'doom, Greatstaff of the Devourer)", "raid"),
        offhand  = item(33334, "Vendor - Badges of Justice (Fetish of the Primal Gods)", "raid"),
        ranged   = item(33192, "Vendor - Badges of Justice (Carved Witch Doctor's Stick)", "raid"),
    },
    -- Phase 5 (Sunwell Plateau)
    phase5 = {
        head     = item(34340, "SWP - Kil'jaeden (Dark Conjuror's Collar)", "raid"),
        neck     = item(34204, "SWP - Eredar Twins (Amulet of Unfettered Magics)", "raid"),
        shoulder = item(34210, "SWP - Eredar Twins (Amice of the Convoker)", "raid"),
        back     = item(34242, "SWP - Kil'jaeden (Tattered Cape of Antonidas)", "raid"),
        chest    = item(34232, "SWP - M'uru (Fel Conquerer Raiments)", "raid"),
        wrist    = item(34434, "SWP - Kalecgos (Bracers of Absolution) — set bonus", "raid"),
        hands    = item(34344, "SWP - Kil'jaeden (Handguards of Defiled Worlds)", "raid"),
        waist    = item(34528, "SWP - Brutallus (Cord of Absolution)", "raid"),
        legs     = item(34181, "SWP - Brutallus (Leggings of Calamity)", "raid"),
        feet     = item(34563, "SWP - Felmyst (Treads of Absolution)", "raid"),
        ring1    = item(34230, "SWP - M'uru (Ring of Omnipotence)", "raid"),
        ring2    = item(32527, "BT - Trash (Ring of Ancient Knowledge)", "raid"),
        trinket1 = item(34429, "SWP - M'uru (Shifting Naaru Sliver)", "raid"),
        trinket2 = item(33829, "ZA - Hex Lord Malacrass (Hex Shrunken Head)", "raid"),
        mainhand = item(34336, "SWP (Sunflare)", "raid"),
        offhand  = item(34179, "SWP - Brutallus (Heart of the Pit)", "raid"),
        ranged   = item(34347, "SWP - Trash (Wand of the Demonsoul)", "raid"),
    },
}

-- =================================================================
-- MAGE -- TODO
-- =================================================================
DB["MAGE"] = {}
DB["MAGE"]["Fire"]   = EMPTY_PHASES()
DB["MAGE"]["Arcane"] = EMPTY_PHASES()
DB["MAGE"]["Frost"]  = EMPTY_PHASES()

-- =================================================================
-- WARLOCK -- TODO
-- =================================================================
DB["WARLOCK"] = {}
DB["WARLOCK"]["Destruction"] = EMPTY_PHASES()
DB["WARLOCK"]["Affliction"]  = EMPTY_PHASES()
DB["WARLOCK"]["Demonology"]  = EMPTY_PHASES()

-- =================================================================
-- DRUID -- TODO
-- =================================================================
DB["DRUID"] = {}
DB["DRUID"]["Balance"]     = EMPTY_PHASES()
DB["DRUID"]["Restoration"] = EMPTY_PHASES()
DB["DRUID"]["Feral"]       = EMPTY_PHASES()

-- =================================================================
-- SHAMAN -- TODO
-- =================================================================
DB["SHAMAN"] = {}
DB["SHAMAN"]["Restoration"] = EMPTY_PHASES()
DB["SHAMAN"]["Elemental"]   = EMPTY_PHASES()
DB["SHAMAN"]["Enhancement"] = EMPTY_PHASES()

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
