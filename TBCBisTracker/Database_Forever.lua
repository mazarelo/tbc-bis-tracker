-- TBCBisTracker WoW Forever database (GENERATED — do not edit by hand)
-- Source: web/scripts/forever-lvl60.json via web/scripts/build-forever-db.py
-- Generated: 2026-11-12
-- Level 60 pre-raid lists; refresh with web/scripts/fetch-forever-bis.py.
-- Lists: WoW Forever simulator gear sets (wowsims/forever, MIT), kami-labs.fr, Classic WoW Forever (classicwowforever.com, CC BY 4.0)
-- Simulator sets and item data read 2026-11-12; kami-labs computed November 9, 2026; classicwowforever checked 2026-11-08

TBCBisTracker = TBCBisTracker or {}
TBCBisTracker.FOREVER_DB = {}

local DB = TBCBisTracker.FOREVER_DB

local function item(id, source, sourceType, note, faction, questId)
    return { id = id, source = source, sourceType = sourceType or "dungeon", note = note,
             faction = faction, questId = questId }
end

-- ============================================================
-- WARRIOR
-- ============================================================
DB["WARRIOR"] = {}
-- Fury: first picks: wowsims/forever warrior/dps/gear_sets/prebis_fury.gear.json; then kami-labs (Warrior Fury); alternatives: classicwowforever.com/bis-list/fury-warrior
DB["WARRIOR"]["Fury"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", nil),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
    },
    neck = {
        item(19491, "Quest: 1200 Tickets - Amulet of the Darkmoon", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(10263, "World drop, sold at the auction house (Adventurer's Shoulders of the Tiger)", "world", nil),
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", nil),
        item(6314, "Wolf Master Nandos, Shadowfang Keep (Wolfmaster Cape)", "dungeon", nil),
    },
    chest = {
        item(252483, "Leatherworking (Dawn Armor)", "crafted", nil),
        item(252484, "Leatherworking (Timbermaw Tunic)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", nil),
    },
    wrist = {
        item(10147, "World drop, sold at the auction house (Mighty Armsplints of the Tiger)", "world", nil),
        item(12936, "Warchief Rend Blackhand, Blackrock Spire (Battleborn Armbraces)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor. Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(16735, "Trash mobs, Blackrock Spire (Bracers of Valor)", "dungeon", nil),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(11745, "Phalanx, Blackrock Depths (Fists of Phalanx)", "dungeon", nil),
        item(271948, "Theramore Expeditionary Force - Exalted (Theramore Gloves)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
    },
    waist = {
        item(20216, "Quest: A Collection of Heads (Belt of Preserved Heads)", "quest", nil),
        item(272403, "Sold by Pix Xizzix, Stranglethorn Vale (Valiant's Waistguard)", "world", nil),
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(10798, "Atal'alarion, The Temple of Atal'Hakkar (Atal'alarion's Tusk Ring)", "dungeon", nil),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", nil),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(21316, "Quest: Deadwood of the North (Leggings of the Ursa)", "quest", "Blackmaw Hold"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
    },
    feet = {
        item(13070, "World drop, sold at the auction house (Sapphiron's Scale Boots)", "world", nil),
        item(13967, "Kirtonos the Herald, Scholomance (Windreaver Greaves)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(272408, "Sold by Pix Xizzix, Stranglethorn Vale (Cutthroat's Signet)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(272409, "Sold by Pix Xizzix, Stranglethorn Vale (Ring of Awareness)", "world", nil),
        item(13098, "General Drakkisath, Blackrock Spire (Painweaver Band)", "dungeon", nil),
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(249469, "Enchanting (Frozen Heart of the Mountain)", "crafted", nil),
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(11815, "Emperor Dagran Thaurissan, Blackrock Depths (Hand of Justice)", "dungeon", nil),
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(22384, "Blacksmithing (Persuader)", "crafted", nil),
        item(12774, "Blacksmithing (Dawn's Edge)", "crafted", nil),
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(250618, "Blacksmithing (Bagh Nakh)", "crafted", "Needs Blacksmithing; the plans need Timbermaw Hold at Revered"),
    },
    offhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(18323, "Zevrim Thornhoof, Dire Maul (Satyr's Bow)", "dungeon", nil),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Arms: first picks: wowsims/forever warrior/dps/gear_sets/prebis_arms.gear.json; then kami-labs (Warrior Arms); alternatives: classicwowforever.com/bis-list/arms-warrior
DB["WARRIOR"]["Arms"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", nil),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
    },
    neck = {
        item(19491, "Quest: 1200 Tickets - Amulet of the Darkmoon", "quest", nil),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Enchant: Enchant Necklace - Strength"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(10263, "World drop, sold at the auction house (Adventurer's Shoulders of the Tiger)", "world", nil),
        item(20057, "The League of Arathor - Exalted (Highlander's Plate Spaulders)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", nil),
    },
    back = {
        item(10249, "World drop, sold at the auction house (Master's Cloak of the Tiger)", "world", nil),
        item(272414, "Sold by Pix Xizzix, Stranglethorn Vale (Howler's Furs)", "world", "Enchant: Enchant Cloak - Minor Agility"),
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", nil),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(6314, "Wolf Master Nandos, Shadowfang Keep (Wolfmaster Cape)", "dungeon", nil),
    },
    chest = {
        item(252483, "Leatherworking (Dawn Armor)", "crafted", nil),
        item(11726, "Gorosh the Dervish, Blackrock Depths (Savage Gladiator Chain)", "dungeon", "Enchant: Enchant Chest - Greater Stats"),
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", nil),
    },
    wrist = {
        item(10147, "World drop, sold at the auction house (Mighty Armsplints of the Tiger)", "world", nil),
        item(16710, "Instructor Malicia, Scholomance (Shadowcraft Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Strength"),
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor. Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(16735, "Trash mobs, Blackrock Spire (Bracers of Valor)", "dungeon", nil),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(11745, "Phalanx, Blackrock Depths (Fists of Phalanx)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Enchant: Enchant Gloves - Superior Strength"),
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
    },
    waist = {
        item(272403, "Sold by Pix Xizzix, Stranglethorn Vale (Valiant's Waistguard)", "world", nil),
        item(20041, "The League of Arathor - Honored (Highlander's Plate Girdle)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(10798, "Atal'alarion, The Temple of Atal'Hakkar (Atal'alarion's Tusk Ring)", "dungeon", nil),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", nil),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(21316, "Quest: Deadwood of the North (Leggings of the Ursa)", "quest", "Blackmaw Hold"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
    },
    feet = {
        item(13070, "World drop, sold at the auction house (Sapphiron's Scale Boots)", "world", nil),
        item(20048, "The League of Arathor - Revered (Highlander's Plate Greaves)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant Boots - Greater Agility", "Alliance"),
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(272408, "Sold by Pix Xizzix, Stranglethorn Vale (Cutthroat's Signet)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(272409, "Sold by Pix Xizzix, Stranglethorn Vale (Ring of Awareness)", "world", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(249469, "Enchanting (Frozen Heart of the Mountain)", "crafted", nil),
        item(11815, "Emperor Dagran Thaurissan, Blackrock Depths (Hand of Justice)", "dungeon", nil),
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(272604, "PvP reward (Premier High Warlord's Greatsword)", "pvp", nil),
        item(2801, "Ezra Grimm, Stratholme (Blade of Hanna)", "dungeon", "Drop chance 0.02%. Enchant: Enchant 2H Weapon - Superior Impact"),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", nil),
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(12782, "Blacksmithing (Corruption)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
    },
    ranged = {
        item(15289, "World drop, sold at the auction house (Archstrike Bow of the Tiger)", "world", nil),
        item(18323, "Zevrim Thornhoof, Dire Maul (Satyr's Bow)", "dungeon", nil),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Protection: first picks: wowsims/forever warrior/protection/gear_sets/prebis.gear.json; then kami-labs (Warrior Protection); alternatives: classicwowforever.com/bis-list/protection-warrior
DB["WARRIOR"]["Protection"] = { lvl60 = {
    head = {
        item(10388, "World drop, sold at the auction house (Hyperion Helm of Defense)", "world", nil),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", "We don't know where the plans drop"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", nil),
        item(18381, "Immol'thar, Dire Maul (Evil Eye Pendant)", "dungeon", "Enchant: Enchant Necklace - Deflection"),
        item(274749, "Booty Bay - Honored (Souvenir Sea Shell)", "reputation", "Sold by Gezzy Gunkgear. Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    shoulder = {
        item(275737, "World drop, sold at the auction house (Hermit's Pauldron)", "world", nil),
        item(20057, "The League of Arathor - Exalted (Highlander's Plate Spaulders)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(250577, "Blacksmithing (Sentinel's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
    },
    back = {
        item(18413, "Tailoring (Cloak of Warding)", "crafted", nil),
        item(13397, "Stonespine, Stratholme (Stoneskin Gargoyle Cape)", "dungeon", "Enchant: Enchant Cloak - Superior Defense"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(11311, "Galgann Firehammer, Uldaman (Emberscale Cape)", "dungeon", nil),
    },
    chest = {
        item(252483, "Leatherworking (Dawn Armor)", "crafted", nil),
        item(18503, "Captain Kromcrush, Dire Maul (Kromcrush's Chestplate)", "dungeon", "Enchant: Enchant Chest - Greater Stats"),
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together. Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(12618, "Blacksmithing (Enchanted Thorium Breastplate)", "crafted", nil),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
    },
    wrist = {
        item(10147, "World drop, sold at the auction house (Mighty Armsplints of the Tiger)", "world", nil),
        item(16735, "Trash mobs, Blackrock Spire (Bracers of Valor)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor. Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(250582, "Blacksmithing (Sentinel's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    hands = {
        item(250552, "Blacksmithing (Sentinel's Gloves)", "crafted", nil),
        item(271940, "Theramore Expeditionary Force - Exalted (Theramore Gauntlets)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(12639, "Blacksmithing (Stronghold Gauntlets)", "crafted", "We don't know where the plans drop"),
    },
    waist = {
        item(13077, "World drop, sold at the auction house (Girdle of Uther)", "world", nil),
        item(272403, "Sold by Pix Xizzix, Stranglethorn Vale (Valiant's Waistguard)", "world", nil),
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together. Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(250572, "Blacksmithing (Sentinel's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(10798, "Atal'alarion, The Temple of Atal'Hakkar (Atal'alarion's Tusk Ring)", "dungeon", nil),
    },
    legs = {
        item(10389, "World drop, sold at the auction house (Hyperion Legplates of Defense)", "world", nil),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", "We don't know where the plans drop"),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
    },
    feet = {
        item(10376, "World drop, sold at the auction house (Commander's Boots of Defense)", "world", nil),
        item(20048, "The League of Arathor - Revered (Highlander's Plate Greaves)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant Boots - Greater Agility", "Alliance"),
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together. Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250562, "Blacksmithing (Sentinel's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(272409, "Sold by Pix Xizzix, Stranglethorn Vale (Ring of Awareness)", "world", nil),
        item(13373, "Ramstein the Gorger, Stratholme (Band of Flesh)", "dungeon", nil),
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
    },
    ring2 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", nil),
        item(18522, "King Gordok, Dire Maul (Band of the Ogre King)", "dungeon", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
    },
    trinket1 = {
        item(272440, "Sold by Pix Xizzix, Stranglethorn Vale (Defender's Grip Stabilizer)", "world", nil),
        item(13164, "Overlord Wyrmthalak, Blackrock Spire (Heart of the Scale)", "dungeon", nil),
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", nil),
        item(13966, "Quest: For The Horde! (Mark of Tyranny)", "quest", "Also: General Drakkisath's Demise"),
    },
    mainhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(22384, "Blacksmithing (Persuader)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(12774, "Blacksmithing (Dawn's Edge)", "crafted", nil),
        item(12797, "Blacksmithing (Frostguard)", "crafted", nil),
    },
    offhand = {
        item(16998, "Quest: The Scarlet Oracle, Demetria (Sacred Protector)", "quest", "Also: Order Must Be Restored"),
        item(12602, "General Drakkisath, Blackrock Spire (Draconian Deflector)", "dungeon", "Enchant: Enchant Shield - Greater Stamina"),
        item(7726, "Scarlet Commander Mograine, Scarlet Monastery (Aegis of the Scarlet Commander)", "dungeon", nil),
        item(18168, "Engineering (Force Reactive Disk)", "crafted", "Needs Engineering. We don't know where the schematic drops"),
        item(9643, "Quest: Rescue OOX-17/TN! (Optomatic Deflector)", "quest", "Tanaris"),
        item(274418, "Barkskin Burrow - Revered (Burrow Barricade)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal. Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(15289, "World drop, sold at the auction house (Archstrike Bow of Defense)", "world", nil),
        item(13023, "Gizrul the Slavener, Blackrock Spire (Eaglehorn Long Bow)", "dungeon", "Drop chance 0.01%"),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }

-- ============================================================
-- PALADIN
-- ============================================================
DB["PALADIN"] = {}
-- Holy: first picks: wowsims/forever paladin/holy/gear_sets/default.gear.json; then kami-labs (Paladin Holy); alternatives: classicwowforever.com/bis-list/holy-paladin
DB["PALADIN"]["Holy"] = { lvl60 = {
    head = {
        item(12633, "Blacksmithing (Whitesoul Helm)", "crafted", nil),
        item(252561, "Leatherworking (Living Crown)", "crafted", nil),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    neck = {
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", nil),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", "Enchant: Enchant Necklace - Healing Power"),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
    },
    shoulder = {
        item(12625, "Blacksmithing (Dawnbringer Shoulders)", "crafted", nil),
        item(16718, "Gizrul the Slavener, Blackrock Spire (Wildheart Spaulders)", "dungeon", nil),
        item(15061, "Leatherworking (Living Shoulders)", "crafted", "Needs Leatherworking"),
        item(250579, "Blacksmithing (Prefect's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
    },
    back = {
        item(272413, "Sold by Pix Xizzix, Stranglethorn Vale (Drape of Recovery)", "world", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(275046, "Quest: Bring Me His Head (Twilight Overlord Drape)", "quest", "Riverglades. Alliance only. Choose this or another reward. Riverglades. Alliance only. Choose this or another reward", "Alliance"),
        item(275050, "Quest: Bring Me His Head (Cloak of the Cult)", "quest", "Riverglades. Horde only. Choose this or another reward. Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    chest = {
        item(16726, "General Drakkisath, Blackrock Spire (Lightforge Breastplate)", "dungeon", nil),
        item(15047, "Leatherworking (Red Dragonscale Breastplate)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(18486, "Tailoring (Mooncloth Robe)", "crafted", "Needs Tailoring"),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    wrist = {
        item(16722, "Lord Alexei Barov, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(250584, "Blacksmithing (Prefect's Wristguards)", "crafted", "Enchant: Enchant Bracer - Healing Power"),
        item(252573, "Leatherworking (Mender's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring; pattern costs 60 Merchant's Favor"),
    },
    hands = {
        item(250554, "Blacksmithing (Prefect's Gloves)", "crafted", nil),
        item(20296, "Leatherworking (Green Dragonscale Gauntlets)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", "Needs Tailoring"),
    },
    waist = {
        item(250574, "Blacksmithing (Prefect's Waistguard)", "crafted", nil),
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(252591, "Leatherworking (Mender's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring; pattern costs 60 Merchant's Favor"),
    },
    legs = {
        item(16728, "Baron Rivendare, Stratholme (Lightforge Legplates)", "dungeon", nil),
        item(250600, "Blacksmithing (Martyr's Legplates)", "crafted", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(15060, "Leatherworking (Living Leggings)", "crafted", "Needs Leatherworking"),
    },
    feet = {
        item(16725, "Balnazzar, Stratholme (Lightforge Boots)", "dungeon", nil),
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", "Enchant: Enchant Boots - Spirit"),
        item(252579, "Leatherworking (Mender's Mail Sabatons)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(250564, "Blacksmithing (Prefect's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(22681, "Quest: Superior Armaments of Battle - Friend of the Dawn (Band of Piety)", "quest", "Also: Superior Armaments of Battle - Honored Amongst the Dawn; Superior Armaments of Battle - Revered Amongst the Dawn"),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. The quest wants 20 donated books. Choose this or another reward"),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale. Sold by Gezzy Gunkgear, Stranglethorn Vale"),
        item(275043, "Quest: Bloodmaster's Ring", "quest", "Riverglades. Horde only. Choose this or another reward. Riverglades. Horde only. Choose this or another reward", "Horde"),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
    },
    ring2 = {
        item(272406, "Sold by Pix Xizzix, Stranglethorn Vale (Channeler's Ring)", "world", nil),
        item(12543, "Quest: The Princess's Surprise (Songstone of Ironforge)", "quest", nil, "Alliance"),
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
    },
    trinket1 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
    },
    trinket2 = {
        item(11811, "Enchanting (Smoking Heart of the Mountain)", "crafted", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(20648, "Quest: Hero of the Stormpike (Cold Forged Hammer)", "quest", "Also: Hero of the Frostwolf"),
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", "Enchant: Enchant Weapon - Healing Power"),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
    },
    offhand = {
        item(276754, "World drop, sold at the auction house (Sunderbark Vigil)", "world", nil),
        item(11262, "Quest: In the Name of the Light (Orb of Lorica)", "quest", nil, "Alliance"),
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
        item(277258, "Quest: Greater Friend of the Library (Crest of Elucidation)", "quest", "Stormwind City or Undercity. A shield, so it adds armor. The quest wants 25 donated books. Stormwind City or Undercity. A shield, so it adds armor. The quest wants 25 donated books"),
    },
    ranged = {
        item(272436, "Sold by Pix Xizzix, Stranglethorn Vale (Libram of Economy)", "world", nil),
        item(23201, "Instructor Malicia, Scholomance (Libram of Divinity)", "dungeon", nil),
        item(228175, "Enchanting (Libram of Holy Alacrity)", "crafted", "Needs Enchanting; formula costs 240 Merchant's Favor"),
    },
} }
-- Protection: first picks: wowsims/forever paladin/protection/gear_sets/default.gear.siml; then kami-labs (Paladin Protection); alternatives: classicwowforever.com/bis-list/protection-paladin
DB["PALADIN"]["Protection"] = { lvl60 = {
    head = {
        item(250599, "Blacksmithing (Stalwart Helm)", "crafted", nil),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
        item(250597, "Blacksmithing (Enriched Thorium Helm)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", "Needs Blacksmithing"),
    },
    neck = {
        item(18381, "Immol'thar, Dire Maul (Evil Eye Pendant)", "dungeon", "Enchant: Enchant Necklace - Deflection"),
    },
    shoulder = {
        item(272745, "PvP reward (Premier Chevalier Shoulders)", "pvp", nil),
        item(20057, "The League of Arathor - Exalted (Highlander's Plate Spaulders)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(250578, "Blacksmithing (Warder's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(250580, "Blacksmithing (Justicar's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(22093, "Quest: Anthion's Parting Words (Soulforge Spaulders)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    back = {
        item(18413, "Tailoring (Cloak of Warding)", "crafted", nil),
        item(13397, "Stonespine, Stratholme (Stoneskin Gargoyle Cape)", "dungeon", "Enchant: Enchant Cloak - Superior Defense"),
        item(11311, "Galgann Firehammer, Uldaman (Emberscale Cape)", "dungeon", nil),
    },
    chest = {
        item(250595, "Blacksmithing (Enriched Thorium Breastplate)", "crafted", nil),
        item(18503, "Captain Kromcrush, Dire Maul (Kromcrush's Chestplate)", "dungeon", "Enchant: Enchant Chest - Greater Stats"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    wrist = {
        item(16722, "Lord Alexei Barov, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(13951, "Darkmaster Gandling, Scholomance (Vigorsteel Vambraces)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(250583, "Blacksmithing (Warder's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250582, "Blacksmithing (Sentinel's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250585, "Blacksmithing (Justicar's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22088, "Quest: An Earnest Proposition (Soulforge Bracers)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples. Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples", "Alliance"),
    },
    hands = {
        item(279264, "Blacksmithing (Heavy Thorium Gauntlets)", "crafted", nil),
        item(271940, "Theramore Expeditionary Force - Exalted (Theramore Gauntlets)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(22090, "Quest: Just Compensation (Soulforge Gauntlets)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets. Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
    },
    waist = {
        item(250572, "Blacksmithing (Sentinel's Waistguard)", "crafted", nil),
        item(16736, "Trash mobs, Blackrock Spire (Belt of Valor)", "dungeon", nil),
        item(250573, "Blacksmithing (Warder's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250575, "Blacksmithing (Justicar's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22086, "Quest: Just Compensation (Soulforge Belt)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets. Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
    },
    legs = {
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
        item(250596, "Blacksmithing (Enriched Thorium Leggings)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(22092, "Quest: Anthion's Parting Words (Soulforge Legplates)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    feet = {
        item(279263, "Blacksmithing (Depleted Thorium Sabatons)", "crafted", nil),
        item(20048, "The League of Arathor - Revered (Highlander's Plate Greaves)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant Boots - Greater Agility", "Alliance"),
        item(250563, "Blacksmithing (Warder's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250562, "Blacksmithing (Sentinel's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22087, "Quest: Anthion's Parting Words (Soulforge Boots)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    ring1 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", nil),
        item(13373, "Ramstein the Gorger, Stratholme (Band of Flesh)", "dungeon", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
        item(275045, "Quest: Bloodmaster's Ring (Ogre Horn Ring)", "quest", "Riverglades. Horde only. Choose this or another reward. Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    ring2 = {
        item(272409, "Sold by Pix Xizzix, Stranglethorn Vale (Ring of Awareness)", "world", nil),
        item(18522, "King Gordok, Dire Maul (Band of the Ogre King)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or another reward"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
    },
    trinket1 = {
        item(19024, "Quest: Arena Grandmaster (Arena Grand Master)", "quest", nil),
        item(272440, "Sold by Pix Xizzix, Stranglethorn Vale (Defender's Grip Stabilizer)", "world", nil),
        item(11811, "Enchanting (Smoking Heart of the Mountain)", "crafted", "Needs Enchanting"),
    },
    trinket2 = {
        item(272440, "Sold by Pix Xizzix, Stranglethorn Vale (Defender's Grip Stabilizer)", "world", nil),
        item(13966, "Quest: For The Horde! (Mark of Tyranny)", "quest", "Also: General Drakkisath's Demise"),
    },
    mainhand = {
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(22384, "Blacksmithing (Persuader)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Needs Blacksmithing"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Needs Blacksmithing"),
    },
    offhand = {
        item(18168, "Engineering (Force Reactive Disk)", "crafted", nil),
        item(12602, "General Drakkisath, Blackrock Spire (Draconian Deflector)", "dungeon", "Enchant: Enchant Shield - Greater Stamina"),
        item(7726, "Scarlet Commander Mograine, Scarlet Monastery (Aegis of the Scarlet Commander)", "dungeon", nil),
        item(274418, "Barkskin Burrow - Revered (Burrow Barricade)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal. Sold by Dala Fairmaw, Mount Hyjal"),
        item(11915, "Quest: Shizzle's Flyer (Shizzle's Drizzle Blocker)", "quest", "Un'Goro Crater. Choose this or another reward"),
    },
    ranged = {
        item(23203, "World drop, sold at the auction house (Libram of Fervor)", "world", nil),
        item(272434, "Sold by Pix Xizzix, Stranglethorn Vale (Sentinel's Libram)", "world", nil),
        item(249442, "Enchanting (Libram of Invocation)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
    },
} }
-- Retribution: first picks: wowsims/forever paladin/retribution/gear_sets/default.gear.siml; then kami-labs (Paladin Retribution); alternatives: classicwowforever.com/bis-list/retribution-paladin
DB["PALADIN"]["Retribution"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", nil),
        item(16727, "Darkmaster Gandling, Scholomance (Lightforge Helm)", "dungeon", nil),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Strength"),
    },
    shoulder = {
        item(14503, "Ras Frostwhisper, Scholomance (Death's Clutch)", "dungeon", nil),
        item(20058, "The League of Arathor - Exalted (Highlander's Lamellar Spaulders)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(16729, "The Beast, Blackrock Spire (Lightforge Spaulders)", "dungeon", nil),
        item(250580, "Blacksmithing (Justicar's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(22093, "Quest: Anthion's Parting Words (Soulforge Spaulders)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    back = {
        item(279269, "Tailoring (Fel Cape)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Needs Leatherworking"),
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", "Needs Leatherworking"),
    },
    chest = {
        item(252484, "Leatherworking (Timbermaw Tunic)", "crafted", nil),
        item(16726, "General Drakkisath, Blackrock Spire (Lightforge Breastplate)", "dungeon", nil),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate. Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Needs Leatherworking"),
    },
    wrist = {
        item(21184, "Quest: Stalwart's Battlegear (Deeprock Bracers)", "quest", nil),
        item(250590, "Blacksmithing (Blessed Plate Bracers)", "crafted", "Enchant: Enchant Bracer - Superior Strength"),
        item(16722, "Lord Alexei Barov, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(250585, "Blacksmithing (Justicar's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22088, "Quest: An Earnest Proposition (Soulforge Bracers)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples. Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples", "Alliance"),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", nil),
        item(271940, "Theramore Expeditionary Force - Exalted (Theramore Gauntlets)", "reputation", "Enchant: Enchant Gloves - Superior Strength", "Alliance"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(22090, "Quest: Just Compensation (Soulforge Gauntlets)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets. Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Needs Leatherworking"),
        item(19057, "Blacksmithing (Gloves of the Dawn)", "crafted", "Needs Blacksmithing. The plans need Argent Dawn reputation"),
    },
    waist = {
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", nil),
        item(250592, "Blacksmithing (Blessed Plate Belt)", "crafted", nil),
        item(250575, "Blacksmithing (Justicar's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22086, "Quest: Just Compensation (Soulforge Belt)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets. Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
        item(10798, "Atal'alarion, The Temple of Atal'Hakkar (Atal'alarion's Tusk Ring)", "dungeon", nil),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", nil),
        item(16728, "Baron Rivendare, Stratholme (Lightforge Legplates)", "dungeon", nil),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
        item(22092, "Quest: Anthion's Parting Words (Soulforge Legplates)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
        item(17711, "Princess Theradras, Maraudon (Elemental Rockridge Leggings)", "dungeon", nil),
    },
    feet = {
        item(275618, "Leatherworking (Scalegut Treaders)", "crafted", nil),
        item(250587, "Blacksmithing (Blessed Plate Boots)", "crafted", "Enchant: Enchant Boots - Greater Agility"),
        item(250565, "Blacksmithing (Justicar's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22087, "Quest: Anthion's Parting Words (Soulforge Boots)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders. Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
    },
    ring1 = {
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only. Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    ring2 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or another reward"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
    },
    trinket1 = {
        item(274759, "Everlook - Honored (Everlook Pathcarver)", "reputation", "Sold by Zippie Fizzbolt"),
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
    },
    trinket2 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
    },
    mainhand = {
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", nil),
        item(19323, "Sold by Gaelden Hammersmith, Alterac Valley (The Unstoppable Force)", "world", "Enchant: Enchant 2H Weapon - Strength"),
        item(7960, "Blacksmithing (Truesilver Champion)", "crafted", "Needs Blacksmithing"),
        item(250617, "Blacksmithing (Stormcarver)", "crafted", "Needs Blacksmithing. The plans need Revered with Timbermaw Hold"),
        item(9418, "Archaedas, Uldaman (Stoneslayer)", "dungeon", nil),
    },
    ranged = {
        item(272435, "Sold by Pix Xizzix, Stranglethorn Vale (Libram of Law)", "world", nil),
        item(249442, "Enchanting (Libram of Invocation)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
    },
} }

-- ============================================================
-- HUNTER
-- ============================================================
DB["HUNTER"] = {}
-- Marksmanship: first picks: wowsims/forever hunter/dps/gear_sets/p1.gear.siml; then kami-labs (Hunter Marksmanship); alternatives: classicwowforever.com/bis-list/marksmanship-hunter
DB["HUNTER"]["Marksmanship"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(252605, "Leatherworking (Black Dragonscale Helm)", "crafted", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(11124, "Quest: Jammal'an the Prophet (Helm of Exile)", "quest", "Sunken Temple"),
    },
    neck = {
        item(19618, "Quest: The Maelstrom's Tendril", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(271956, "Theramore Expeditionary Force - Exalted (Theramore Epaulets)", "reputation", nil, "Alliance"),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(15787, "Quest: High Chief Winterfall (Willow Band Hauberk)", "quest", "Winterspring"),
    },
    wrist = {
        item(16681, "Trash mobs, Blackrock Spire (Beaststalker's Bindings)", "dungeon", nil),
        item(18508, "Leatherworking (Swift Flight Bracers)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for. Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(271948, "Theramore Expeditionary Force - Exalted (Theramore Gloves)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Pattern sold by Nergal in Un'Goro Crater"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Trash mobs, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(22232, "Urok Doomhowl, Blackrock Spire (Marksman's Girdle)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves. Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(15082, "Leatherworking (Heavy Scorpid Belt)", "crafted", "We don't know where the pattern drops"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Pattern drops from mobs in Un'Goro Crater. We don't know where the pattern drops"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(272408, "Sold by Pix Xizzix, Stranglethorn Vale (Cutthroat's Signet)", "world", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(11990, "World drop, sold at the auction house (Selenium Loop)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Powderfuse - Friendly (Disengagement Ring)", "reputation", "Sold by Friz Frazzlespark"),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only. Riverglades. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(18473, "Quest: The Greatest Race of Hunters (Royal Seal of Eldre'Thalas)", "quest", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(13965, "Quest: For The Horde! (Blackhand's Breadth)", "quest", "Also: General Drakkisath's Demise"),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", nil),
        item(274419, "Sold by Dala Fairmaw, Mount Hyjal (Bear Poking Stick)", "world", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(10698, "Quest: Enchanted Azsharite Fel Weaponry (Enchanted Azsharite Felbane Staff)", "quest", "Stranglethorn Vale. Choose this or another Felbane weapon"),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(13023, "Gizrul the Slavener, Blackrock Spire (Eaglehorn Long Bow)", "dungeon", "Drop chance 0.01%"),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", "Schematic drops from Mossflayer Shadowhunter in Eastern Plaguelands"),
        item(16004, "Engineering (Dark Iron Rifle)", "crafted", "Schematic drops from Doomforge Craftsman in Blackrock Depths"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(17753, "Quest: Corruption of Earth and Seed (Verdant Keeper's Aim)", "quest", "Maraudon. Choose this or another Maraudon quest reward"),
    },
} }
-- Survival: first picks: wowsims/forever hunter/dps/gear_sets/p1.gear.siml; then kami-labs (Hunter Survival); alternatives: classicwowforever.com/bis-list/survival-hunter
DB["HUNTER"]["Survival"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(252605, "Leatherworking (Black Dragonscale Helm)", "crafted", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
    },
    neck = {
        item(19618, "Quest: The Maelstrom's Tendril", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(271956, "Theramore Expeditionary Force - Exalted (Theramore Epaulets)", "reputation", nil, "Alliance"),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(21320, "Quest: Winterfall Activity (Vest of the Den Watcher)", "quest", "Blackmaw Hold"),
    },
    wrist = {
        item(16681, "Trash mobs, Blackrock Spire (Beaststalker's Bindings)", "dungeon", nil),
        item(18375, "Prince Tortheldrin, Dire Maul (Bracers of the Eclipse)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for. Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(271948, "Theramore Expeditionary Force - Exalted (Theramore Gloves)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Pattern sold by Nergal in Un'Goro Crater"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Trash mobs, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(22232, "Urok Doomhowl, Blackrock Spire (Marksman's Girdle)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves. Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(13967, "Kirtonos the Herald, Scholomance (Windreaver Greaves)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(272408, "Sold by Pix Xizzix, Stranglethorn Vale (Cutthroat's Signet)", "world", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(11990, "World drop, sold at the auction house (Selenium Loop)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Powderfuse - Friendly (Disengagement Ring)", "reputation", "Sold by Friz Frazzlespark"),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only. Riverglades. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(13965, "Quest: For The Horde! (Blackhand's Breadth)", "quest", "Also: General Drakkisath's Demise"),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", nil),
        item(274419, "Sold by Dala Fairmaw, Mount Hyjal (Bear Poking Stick)", "world", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(9416, "Grimlok, Uldaman (Grimlok's Charge)", "dungeon", nil),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(13023, "Gizrul the Slavener, Blackrock Spire (Eaglehorn Long Bow)", "dungeon", "Drop chance 0.01%"),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", "Schematic drops from Mossflayer Shadowhunter in Eastern Plaguelands"),
        item(16004, "Engineering (Dark Iron Rifle)", "crafted", "Schematic drops from Doomforge Craftsman in Blackrock Depths"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(17753, "Quest: Corruption of Earth and Seed (Verdant Keeper's Aim)", "quest", "Maraudon. Choose this or another Maraudon quest reward"),
    },
} }
-- Beast Mastery: first picks: wowsims/forever hunter/dps/gear_sets/p1.gear.siml; then kami-labs (Hunter Beast Mastery); alternatives: classicwowforever.com/bis-list/beast-mastery-hunter
DB["HUNTER"]["Beast Mastery"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(252605, "Leatherworking (Black Dragonscale Helm)", "crafted", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
    },
    neck = {
        item(19618, "Quest: The Maelstrom's Tendril", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(271956, "Theramore Expeditionary Force - Exalted (Theramore Epaulets)", "reputation", nil, "Alliance"),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic. Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(21320, "Quest: Winterfall Activity (Vest of the Den Watcher)", "quest", "Blackmaw Hold"),
    },
    wrist = {
        item(16681, "Trash mobs, Blackrock Spire (Beaststalker's Bindings)", "dungeon", nil),
        item(18375, "Prince Tortheldrin, Dire Maul (Bracers of the Eclipse)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(18508, "Leatherworking (Swift Flight Bracers)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for. Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Enchant: Enchant Gloves - Superior Agility"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Trash mobs, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(22232, "Urok Doomhowl, Blackrock Spire (Marksman's Girdle)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves. Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(15082, "Leatherworking (Heavy Scorpid Belt)", "crafted", "We don't know where the pattern drops"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(13967, "Kirtonos the Herald, Scholomance (Windreaver Greaves)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle. Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(272408, "Sold by Pix Xizzix, Stranglethorn Vale (Cutthroat's Signet)", "world", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(11990, "World drop, sold at the auction house (Selenium Loop)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Powderfuse - Friendly (Disengagement Ring)", "reputation", "Sold by Friz Frazzlespark"),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only. Riverglades. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(249469, "Enchanting (Frozen Heart of the Mountain)", "crafted", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(13965, "Quest: For The Horde! (Blackhand's Breadth)", "quest", "Also: General Drakkisath's Demise"),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", nil),
        item(274419, "Sold by Dala Fairmaw, Mount Hyjal (Bear Poking Stick)", "world", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(10698, "Quest: Enchanted Azsharite Fel Weaponry (Enchanted Azsharite Felbane Staff)", "quest", "Stranglethorn Vale. Choose this or another Felbane weapon"),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(13023, "Gizrul the Slavener, Blackrock Spire (Eaglehorn Long Bow)", "dungeon", "Drop chance 0.01%"),
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", "Schematic drops from Mossflayer Shadowhunter in Eastern Plaguelands"),
        item(16004, "Engineering (Dark Iron Rifle)", "crafted", "Schematic drops from Doomforge Craftsman in Blackrock Depths"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(17753, "Quest: Corruption of Earth and Seed (Verdant Keeper's Aim)", "quest", "Maraudon. Choose this or another Maraudon quest reward"),
    },
} }

-- ============================================================
-- ROGUE
-- ============================================================
DB["ROGUE"] = {}
-- Combat: first picks: wowsims/forever rogue/dps/gear_sets/p1_bscombat.gear.json; then kami-labs (Rogue Combat); alternatives: classicwowforever.com/bis-list/combat-rogue
DB["ROGUE"]["Combat"] = { lvl60 = {
    head = {
        item(11735, "Guzzler, Blackrock Depths (Ragefury Eyepatch)", "dungeon", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(272105, "Darkspear Raiders - Exalted (Darkspear Pauldrons)", "reputation", "Sold by Creeg Bothunk", "Horde"),
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(13944, "Darkmaster Gandling, Scholomance (Tombstone Breastplate)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22204, "Emperor Dagran Thaurissan, Blackrock Depths (Wristguards of Renown)", "dungeon", nil),
        item(16710, "Instructor Malicia, Scholomance (Shadowcraft Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde). Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Enchant: Enchant Gloves - Superior Agility"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(272395, "Sold by Pix Xizzix, Stranglethorn Vale (Assassin's Waistguard)", "world", nil),
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", nil),
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \\\"The Swift\\\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(21189, "Quest: Stalwart's Battlegear (Might of Cenarius)", "quest", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal. Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(18465, "Quest: Garona: A Study on Stealth and Treachery (Royal Seal of Eldre'Thalas)", "quest", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
    },
    mainhand = {
        item(19324, "Sold by Gaelden Hammersmith, Alterac Valley (The Lobotomizer)", "world", nil),
        item(22384, "Blacksmithing (Persuader)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Blacksmithing 300. The plans drop from Quartermaster Zigris in Blackrock Spire"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Blacksmithing 300. The plans drop from Foreman Marcrid in the Western Plaguelands"),
        item(250618, "Blacksmithing (Bagh Nakh)", "crafted", "Blacksmithing 300. The plans need Revered with Timbermaw Hold"),
        item(18671, "Baron Charr, Un'Goro Crater (Baron Charr's Sceptre)", "world", nil),
    },
    offhand = {
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(18323, "Zevrim Thornhoof, Dire Maul (Satyr's Bow)", "dungeon", nil),
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Assassination: first picks: wowsims/forever rogue/dps/gear_sets/p1_muti.gear.json; then kami-labs (Rogue Assassination); alternatives: classicwowforever.com/bis-list/assassination-rogue
DB["ROGUE"]["Assassination"] = { lvl60 = {
    head = {
        item(11735, "Guzzler, Blackrock Depths (Ragefury Eyepatch)", "dungeon", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(272105, "Darkspear Raiders - Exalted (Darkspear Pauldrons)", "reputation", "Sold by Creeg Bothunk", "Horde"),
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(13944, "Darkmaster Gandling, Scholomance (Tombstone Breastplate)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22204, "Emperor Dagran Thaurissan, Blackrock Depths (Wristguards of Renown)", "dungeon", nil),
        item(16710, "Instructor Malicia, Scholomance (Shadowcraft Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde). Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Enchant: Enchant Gloves - Superior Agility"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(272395, "Sold by Pix Xizzix, Stranglethorn Vale (Assassin's Waistguard)", "world", nil),
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", nil),
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \\\"The Swift\\\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(21189, "Quest: Stalwart's Battlegear (Might of Cenarius)", "quest", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal. Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(18465, "Quest: Garona: A Study on Stealth and Treachery (Royal Seal of Eldre'Thalas)", "quest", nil),
    },
    mainhand = {
        item(19324, "Sold by Gaelden Hammersmith, Alterac Valley (The Lobotomizer)", "world", nil),
        item(12590, "Warchief Rend Blackhand, Blackrock Spire (Felstriker)", "dungeon", "Enchant: Enchant Weapon - Agility"),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
    },
    offhand = {
        item(19166, "Blacksmithing (Black Amnesty)", "crafted", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(15783, "Quest: Shy-Rotam (Beasthunter Dagger)", "quest", "Winterspring. Horde only. Choose this or Beaststalker Blade", "Horde"),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(18323, "Zevrim Thornhoof, Dire Maul (Satyr's Bow)", "dungeon", nil),
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Subtlety: first picks: wowsims/forever rogue/dps/gear_sets/p1_bssub.gear.json; then kami-labs (Rogue Subtlety); alternatives: classicwowforever.com/bis-list/subtlety-rogue
DB["ROGUE"]["Subtlety"] = { lvl60 = {
    head = {
        item(11735, "Guzzler, Blackrock Depths (Ragefury Eyepatch)", "dungeon", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(272105, "Darkspear Raiders - Exalted (Darkspear Pauldrons)", "reputation", "Sold by Creeg Bothunk", "Horde"),
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(13944, "Darkmaster Gandling, Scholomance (Tombstone Breastplate)", "dungeon", nil),
        item(252483, "Leatherworking (Dawn Armor)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire. Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22204, "Emperor Dagran Thaurissan, Blackrock Depths (Wristguards of Renown)", "dungeon", nil),
        item(16710, "Instructor Malicia, Scholomance (Shadowcraft Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde). Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Enchant: Enchant Gloves - Superior Agility"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(272395, "Sold by Pix Xizzix, Stranglethorn Vale (Assassin's Waistguard)", "world", nil),
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first. Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", nil),
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step. Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \\\"The Swift\\\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(21189, "Quest: Stalwart's Battlegear (Might of Cenarius)", "quest", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal. Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(18465, "Quest: Garona: A Study on Stealth and Treachery (Royal Seal of Eldre'Thalas)", "quest", nil),
    },
    mainhand = {
        item(19324, "Sold by Gaelden Hammersmith, Alterac Valley (The Lobotomizer)", "world", nil),
        item(12590, "Warchief Rend Blackhand, Blackrock Spire (Felstriker)", "dungeon", "Enchant: Enchant Weapon - Superior Striking"),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Blacksmithing 300. The plans drop from Quartermaster Zigris in Blackrock Spire"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Blacksmithing 300. The plans drop from Foreman Marcrid in the Western Plaguelands"),
        item(18671, "Baron Charr, Un'Goro Crater (Baron Charr's Sceptre)", "world", nil),
    },
    offhand = {
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(22384, "Blacksmithing (Persuader)", "crafted", "Enchant: Enchant Weapon - Agility"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
    },
    ranged = {
        item(22347, "Quest: The Perfect Poison (Fahrad's Reloading Repeater)", "quest", nil),
        item(18323, "Zevrim Thornhoof, Dire Maul (Satyr's Bow)", "dungeon", nil),
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }

-- ============================================================
-- PRIEST
-- ============================================================
DB["PRIEST"] = {}
-- Holy: first picks: wowsims/forever priest/healer/gear_sets/preraid.gear.json; then kami-labs (Priest Holy); alternatives: classicwowforever.com/bis-list/holy-priest
DB["PRIEST"]["Holy"] = { lvl60 = {
    head = {
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", nil),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(7720, "High Inquisitor Whitemane, Scarlet Monastery (Whitemane's Chapeau)", "dungeon", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", nil),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
        item(254049, "Tailoring (Nethergeld Shoulders)", "crafted", "Needs Tailoring"),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    back = {
        item(19527, "Sold by Kelm Hargunth, The Barrens (Battle Healer's Cloak)", "world", nil, "Horde"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(10020, "Tailoring (Stormcloth Vest)", "crafted", nil),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", "Enchant: Enchant Chest - Major Intellect"),
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(14154, "Tailoring (Truefaith Vestments)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
    },
    wrist = {
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", nil),
        item(16697, "Trash mobs, Stratholme (Devout Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Intellect"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(254095, "Tailoring (Gilded Gloves)", "crafted", nil),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(19116, "Quest: Separation Anxiety (Greenleaf Handwraps)", "quest", "The Hinterlands. Horde only. Choose this or the other Separation Anxiety reward", "Horde"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(16696, "Trash mobs, Blackrock Spire (Devout Belt)", "dungeon", nil),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple. Choose this or the other Jammal'an the Prophet rewards"),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", "Enchant: Enchant Boots - Spirit"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
    },
    ring1 = {
        item(275740, "World drop, sold at the auction house (Ring of Nature's Cycles)", "world", nil),
        item(13345, "Baron Rivendare, Stratholme (Seal of Rivendare)", "dungeon", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale. Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    ring2 = {
        item(275738, "World drop, sold at the auction house (Jereman's Bauble)", "world", nil),
        item(272406, "Sold by Pix Xizzix, Stranglethorn Vale (Channeler's Ring)", "world", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", nil),
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
    },
    trinket2 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(249454, "Enchanting (Dreamstaff)", "crafted", nil),
        item(17743, "Quest: Corruption of Earth and Seed (Resurgence Rod)", "quest", "Maraudon. Choose this or the other Corruption of Earth and Seed rewards"),
        item(279853, "Quest: Eye of Mugg (Stick No Rock)", "quest", "Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards. Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", nil),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Discipline: first picks: wowsims/forever priest/healer/gear_sets/preraid.gear.json; then kami-labs (Priest Discipline); alternatives: classicwowforever.com/bis-list/discipline-priest
DB["PRIEST"]["Discipline"] = { lvl60 = {
    head = {
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", nil),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(7720, "High Inquisitor Whitemane, Scarlet Monastery (Whitemane's Chapeau)", "dungeon", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", nil),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
        item(254049, "Tailoring (Nethergeld Shoulders)", "crafted", "Needs Tailoring"),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    back = {
        item(19527, "Sold by Kelm Hargunth, The Barrens (Battle Healer's Cloak)", "world", nil, "Horde"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(10020, "Tailoring (Stormcloth Vest)", "crafted", nil),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", "Enchant: Enchant Chest - Major Intellect"),
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(14154, "Tailoring (Truefaith Vestments)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
    },
    wrist = {
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", nil),
        item(16697, "Trash mobs, Stratholme (Devout Bracers)", "dungeon", "Enchant: Enchant Bracer - Superior Intellect"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(254095, "Tailoring (Gilded Gloves)", "crafted", nil),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(19116, "Quest: Separation Anxiety (Greenleaf Handwraps)", "quest", "The Hinterlands. Horde only. Choose this or the other Separation Anxiety reward", "Horde"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(16696, "Trash mobs, Blackrock Spire (Devout Belt)", "dungeon", nil),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple. Choose this or the other Jammal'an the Prophet rewards"),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", "Enchant: Enchant Boots - Spirit"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
    },
    ring1 = {
        item(275740, "World drop, sold at the auction house (Ring of Nature's Cycles)", "world", nil),
        item(13345, "Baron Rivendare, Stratholme (Seal of Rivendare)", "dungeon", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale. Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    ring2 = {
        item(275738, "World drop, sold at the auction house (Jereman's Bauble)", "world", nil),
        item(272406, "Sold by Pix Xizzix, Stranglethorn Vale (Channeler's Ring)", "world", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", nil),
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
    },
    trinket2 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(249454, "Enchanting (Dreamstaff)", "crafted", nil),
        item(17743, "Quest: Corruption of Earth and Seed (Resurgence Rod)", "quest", "Maraudon. Choose this or the other Corruption of Earth and Seed rewards"),
        item(279853, "Quest: Eye of Mugg (Stick No Rock)", "quest", "Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards. Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", nil),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Shadow: first picks: kami-labs (no simulator set for this spec); then kami-labs (Priest Shadow); alternatives: classicwowforever.com/bis-list/shadow-priest
DB["PRIEST"]["Shadow"] = { lvl60 = {
    head = {
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(9470, "Shadowpriest Sezz'ziz, Zul'Farrak (Bad Mojo Mask)", "dungeon", nil),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "We don't know where the pattern drops"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
    },
    neck = {
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(14112, "Tailoring (Felcloth Shoulders)", "crafted", "We don't know where the pattern drops"),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring"),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    back = {
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(14106, "Tailoring (Felcloth Robe)", "crafted", "We don't know where the pattern drops"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe. Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
    },
    wrist = {
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Enchant: Enchant Bracer - Healing Power"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Enchant: Enchant Gloves - Shadow Power"),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", nil),
        item(10023, "Tailoring (Shadoweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(254087, "Tailoring (Black Waistcord)", "crafted", "Needs Tailoring"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(14107, "Tailoring (Felcloth Pants)", "crafted", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    feet = {
        item(18735, "Maleki the Pallid, Stratholme (Maleki's Footwraps)", "dungeon", "Enchant: Enchant Boots - Spirit"),
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle. Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Choose this or the other Willix the Importer rewards"),
    },
    ring2 = {
        item(22433, "Darkmaster Gandling, Scholomance (Don Mauricio's Band of Domination)", "dungeon", nil),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
        item(9622, "Quest: Jarl Needs a Blade (Reedknot Ring)", "quest", "Dustwallow Marsh. Choose this or the other Jarl Needs a Blade reward. Dustwallow Marsh. Choose this or the other Jarl Needs a Blade reward"),
    },
    trinket1 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(20069, "The League of Arathor - Exalted (Ironbark Staff)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant 2H Weapon - Mighty Spell Power", "Alliance"),
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(7713, "Arcanist Doan, Scarlet Monastery (Illusionary Rod)", "dungeon", nil),
        item(274420, "Barkskin Burrow - Revered (Wisepaw Totem)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal. Needs Revered with Barkskin Burrow. Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(13396, "Skul, Stratholme (Skul's Ghastly Touch)", "dungeon", nil),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }

-- ============================================================
-- SHAMAN
-- ============================================================
DB["SHAMAN"] = {}
-- Restoration: first picks: kami-labs (no simulator set for this spec); then kami-labs (Shaman Restoration); alternatives: classicwowforever.com/bis-list/restoration-shaman
DB["SHAMAN"]["Restoration"] = { lvl60 = {
    head = {
        item(252561, "Leatherworking (Living Crown)", "crafted", nil),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(16667, "Darkmaster Gandling, Scholomance (Coif of Elements)", "dungeon", nil),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "We don't know where the pattern drops"),
        item(22097, "Quest: Saving the Best for Last (Coif of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Coif. Orgrimmar. Horde only. Turn in the Elements Coif", "Horde"),
    },
    neck = {
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", "Enchant: Enchant Necklace - Healing Power"),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(20685, "Lord Skwol, Silithus (Wavefront Necklace)", "world", "Summoned boss in Silithus; needs a group"),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", nil),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
        item(19507, "High Inquisitor Fairbanks, Scarlet Monastery (Inquisitor's Shawl)", "dungeon", nil),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons. Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(273825, "Bazil Thredd, The Stockade (Red Wool Cloak)", "dungeon", nil),
    },
    chest = {
        item(15047, "Leatherworking (Red Dragonscale Breastplate)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(18486, "Tailoring (Mooncloth Robe)", "crafted", nil),
        item(22102, "Quest: Saving the Best for Last (Vest of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Vest. Orgrimmar. Horde only. Turn in the Elements Vest", "Horde"),
    },
    wrist = {
        item(254131, "Tailoring (Earthenweave Cuffs)", "crafted", "Enchant: Enchant Bracer - Healing Power"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(22095, "Quest: An Earnest Proposition (Bindings of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Bindings. Orgrimmar. Horde only. Turn in the Elements Bindings", "Horde"),
    },
    hands = {
        item(20296, "Leatherworking (Green Dragonscale Gauntlets)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets. Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(10771, "Mordresh Fire Eye, Razorfen Downs (Deathmage Sash)", "dungeon", nil),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord. Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(252486, "Leatherworking (Ironfeather Leggings)", "crafted", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple"),
        item(20295, "Leatherworking (Blue Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", "Enchant: Enchant Boots - Spirit"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots. Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(12543, "Quest: The Princess's Surprise (Songstone of Ironforge)", "quest", nil, "Alliance"),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. Alliance quest: Bring the Light"),
    },
    trinket1 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale. Stranglethorn Vale"),
        item(274761, "Everlook - Honored (Parachute-Priest Pager)", "reputation", "Sold by Zippie Fizzbolt. Sold by Zippie Fizzbolt, Winterspring"),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(17710, "Princess Theradras, Maraudon (Charstone Dirk)", "dungeon", "Enchant: Enchant Weapon - Healing Power"),
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", nil),
    },
    offhand = {
        item(11262, "Quest: In the Name of the Light (Orb of Lorica)", "quest", nil, "Alliance"),
        item(9403, "Olaf, Uldaman (Battered Viking Shield)", "dungeon", nil),
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor and needs Friendly standing"),
        item(17508, "Quest: Compendium of the Fallen (Forcestone Buckler)", "quest", "Scarlet Monastery. Horde only", "Horde"),
    },
    ranged = {
        item(23199, "Pyroguard Emberseer, Blackrock Spire (Totem of the Storm)", "dungeon", "Drop chance 0.01%"),
        item(249398, "Enchanting (Polished Driftwood Icon)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor"),
    },
} }
-- Elemental: first picks: kami-labs (no simulator set for this spec); then kami-labs (Shaman Elemental); alternatives: classicwowforever.com/bis-list/elemental-shaman
DB["SHAMAN"]["Elemental"] = { lvl60 = {
    head = {
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(16667, "Darkmaster Gandling, Scholomance (Coif of Elements)", "dungeon", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(10033, "Tailoring (Red Mageweave Headband)", "crafted", "We don't know where the pattern drops"),
        item(22097, "Quest: Saving the Best for Last (Coif of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Coif. Orgrimmar. Horde only. Turn in the Elements Coif", "Horde"),
    },
    neck = {
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23169, "Scorn, Scarlet Monastery (Scorn's Icy Choker)", "dungeon", nil),
    },
    shoulder = {
        item(15067, "Leatherworking (Ironfeather Shoulders)", "crafted", nil),
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons. Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(8216, "Leatherworking (Big Voodoo Cloak)", "crafted", "We don't know where the pattern drops"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", nil),
    },
    chest = {
        item(15066, "Leatherworking (Ironfeather Breastplate)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(16666, "General Drakkisath, Blackrock Spire (Vest of Elements)", "dungeon", nil),
        item(15048, "Leatherworking (Blue Dragonscale Breastplate)", "crafted", "Dragonscale Leatherworking recipe"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
    },
    wrist = {
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(15092, "Leatherworking (Runic Leather Bracers)", "crafted", nil),
        item(22095, "Quest: An Earnest Proposition (Bindings of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Bindings. Orgrimmar. Horde only. Turn in the Elements Bindings", "Horde"),
    },
    hands = {
        item(17721, "Leatherworking (190) (Gloves of the Greatfather)", "crafted", "Enchant: Enchant Gloves - Natural Power"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(16672, "Pyroguard Emberseer, Blackrock Spire (Gauntlets of Elements)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets. Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord. Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(252486, "Leatherworking (Ironfeather Leggings)", "crafted", nil),
        item(20295, "Leatherworking (Blue Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(15095, "Leatherworking (Runic Leather Pants)", "crafted", "We don't know where the pattern drops"),
        item(16668, "Baron Rivendare, Stratholme (Kilt of Elements)", "dungeon", nil),
    },
    feet = {
        item(18322, "Hydrospawn, Dire Maul (Waterspout Boots)", "dungeon", "Enchant: Enchant Boots - Spirit"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16670, "Highlord Omokk, Blackrock Spire (Boots of Elements)", "dungeon", nil),
        item(20641, "Quest: Southsea Shakedown (Southsea Mojo Boots)", "quest", "Tanaris"),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots. Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. Alliance quest: Bring the Light"),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon"),
        item(270109, "Quest: Facing Negolash (Smotts' Pinky Ring)", "quest", "Stranglethorn Vale. Stranglethorn Vale"),
    },
    trinket1 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale. Stranglethorn Vale"),
        item(274760, "Everlook - Honored (Everlook Delivery Bot)", "reputation", "Sold by Zippie Fizzbolt. Sold by Zippie Fizzbolt, Winterspring"),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(20069, "The League of Arathor - Exalted (Ironbark Staff)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant 2H Weapon - Mighty Spell Power", "Alliance"),
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(9527, "Quest: Tiara of the Deep (Spellshifter Rod)", "quest", "Zul'Farrak"),
        item(10826, "Quest: Gahz'ridian (Staff of Lore)", "quest", "Tanaris"),
        item(249453, "Enchanting (Radiant Staff)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor and needs Friendly standing"),
    },
    ranged = {
        item(228176, "Enchanting (300) (Totem of Thunder)", "crafted", nil),
        item(249398, "Enchanting (Polished Driftwood Icon)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor"),
    },
} }
-- Enhancement: first picks: kami-labs (no simulator set for this spec); then kami-labs (Shaman Enhancement); alternatives: classicwowforever.com/bis-list/enhancement-shaman
DB["SHAMAN"]["Enhancement"] = { lvl60 = {
    head = {
        item(252605, "Leatherworking (Black Dragonscale Helm)", "crafted", nil),
        item(7719, "Herod, Scarlet Monastery (Raging Berserker's Helm)", "dungeon", nil),
        item(274291, "Bloodmage Thalnos, Scarlet Monastery (Polished Skullcap)", "dungeon", nil),
        item(3837, "Blacksmithing (Golden Scale Coif)", "crafted", nil),
    },
    neck = {
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Strength"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(20060, "The League of Arathor - Exalted (Highlander's Lizardhide Shoulders)", "reputation", "Sold by Samuel Hawke", "Alliance"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Dragonscale Leatherworking recipe"),
        item(252568, "Leatherworking (Skirmisher's Mail Shoulders)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor and needs Friendly standing"),
        item(11871, "Quest: Calm Before the Storm (Snarkshaw Spaulders)", "quest", "Darnassus or Orgrimmar"),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons. Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
        item(5257, "Nimar the Slayer, Arathi Highlands (Dark Hooded Cape)", "world", nil),
    },
    chest = {
        item(252484, "Leatherworking (Timbermaw Tunic)", "crafted", "Enchant: Enchant Chest - Greater Stats"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Dragonscale Leatherworking recipe"),
        item(252599, "Leatherworking (Supple Scorpid Vest)", "crafted", nil),
        item(22102, "Quest: Saving the Best for Last (Vest of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Vest. Orgrimmar. Horde only. Turn in the Elements Vest", "Horde"),
    },
    wrist = {
        item(252572, "Leatherworking (Skirmisher's Mail Bracers)", "crafted", "Enchant: Enchant Bracer - Superior Strength"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon"),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", "Enchant: Enchant Gloves - Superior Strength"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Tribal Leatherworking recipe"),
        item(15823, "Quest: Runecloth (Bricksteel Gauntlets)", "quest", "Blackmaw Hold"),
        item(7724, "Scarlet Commander Mograine, Scarlet Monastery (Gauntlets of Divinity)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets. Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", nil),
        item(10768, "Ragglesnout, Razorfen Downs (Boar Champion's Belt)", "dungeon", nil),
        item(21312, "Quest: Timbermaw Ally (Belt of the Den Watcher)", "quest", "Felwood"),
        item(19043, "Leatherworking (Heavy Timbermaw Belt)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord. Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(252606, "Leatherworking (Pristine Scorpid Leggings)", "crafted", nil),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Tribal Leatherworking recipe. The pattern needs Friendly with Timbermaw Hold"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Tribal Leatherworking recipe. We don't know where the pattern drops"),
        item(22100, "Quest: Anthion's Parting Words (Kilt of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Kilt. Orgrimmar. Horde only. Turn in the Elements Kilt", "Horde"),
    },
    feet = {
        item(14616, "Instructor Malicia, Scholomance (Bloodmail Boots)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(252578, "Leatherworking (Skirmisher's Mail Sabatons)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor and needs Honored standing"),
        item(275618, "Leatherworking (Scalegut Treaders)", "crafted", "The pattern needs Honored with Cenarion Circle"),
        item(16984, "Leatherworking (Black Dragonscale Boots)", "crafted", "Dragonscale recipe. The pattern needs Honored with Thorium Brotherhood"),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots. Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick. Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale. Stranglethorn Vale"),
        item(274759, "Everlook - Honored (Everlook Pathcarver)", "reputation", "Sold by Zippie Fizzbolt. Sold by Zippie Fizzbolt, Winterspring"),
    },
    trinket2 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(17774, "Quest: The Pariah's Instructions (Mark of the Chosen)", "quest", "Maraudon"),
        item(274760, "Everlook - Honored (Everlook Delivery Bot)", "reputation", "Sold by Zippie Fizzbolt. Sold by Zippie Fizzbolt, Winterspring"),
    },
    mainhand = {
        item(19323, "Sold by Gaelden Hammersmith, Alterac Valley (The Unstoppable Force)", "world", "Enchant: Enchant 2H Weapon - Mighty Spell Power"),
        item(9449, "Crowd Pummeler 9-60, Gnomeregan (Manual Crowd Pummeler)", "dungeon", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Master Axesmith recipe. The plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Master Hammersmith recipe. The plans drop from Maleki the Pallid in Stratholme"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(9413, "Archaedas, Uldaman (The Rockpounder)", "dungeon", nil),
    },
    ranged = {
        item(228176, "Enchanting (300) (Totem of Thunder)", "crafted", nil),
    },
} }

-- ============================================================
-- MAGE
-- ============================================================
DB["MAGE"] = {}
-- Arcane: first picks: wowsims/forever mage/dps/gear_sets/p1Arcane.gear.json; then kami-labs (Mage Arcane); alternatives: classicwowforever.com/bis-list/arcane-mage
DB["MAGE"]["Arcane"] = { lvl60 = {
    head = {
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
    },
    neck = {
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(22412, "Baron Rivendare, Stratholme (Thuzadin Mantle)", "dungeon", nil),
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254057, "Tailoring (Nethershine Shoulders)", "crafted", "Needs Tailoring"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(21415, "Quest: Drape of Vaulted Secrets", "quest", nil),
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(17775, "Quest: Twisted Evils (Acumen Robes)", "quest", "Maraudon. One of four quest rewards"),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(16683, "Trash mobs, Blackrock Spire (Magister's Bindings)", "dungeon", nil),
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(254069, "Tailoring (Nethershine Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples. Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(16684, "Doctor Theolen Krastinov, Scholomance (Magister's Gloves)", "dungeon", nil),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(13863, "Tailoring (Runecloth Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22062, "Quest: Just Compensation (Sorcerer's Belt)", "quest", "Ironforge or Orgrimmar. Ironforge or Orgrimmar"),
        item(254089, "Tailoring (Golden Waistcord)", "crafted", "Needs Tailoring"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
    },
    feet = {
        item(11822, "Golem Lord Argelmach, Blackrock Depths (Omnicast Boots)", "dungeon", nil),
        item(22231, "War Master Voone, Blackrock Spire (Kayser's Boots of Precision)", "dungeon", nil),
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254115, "Tailoring (Golden Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(275982, "The Watchers - Exalted (Warden's Signet of Brilliance)", "reputation", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(18543, "World drop, sold at the auction house (Ring of Entropy)", "world", nil),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(23451, "Sold by Lieutenant Jackspring (Grand Marshal's Mageblade)", "world", nil),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(7714, "Arcanist Doan, Scarlet Monastery (Hypnotic Blade)", "dungeon", nil),
        item(6691, "Agathelos the Raging, Razorfen Kraul (Swinetusk Shank)", "dungeon", nil),
    },
    offhand = {
        item(19366, "Quest: The Lord of Blackrock (Master Dragonslayer's Orb)", "quest", nil),
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(221344, "Quest: A Lesson in Literacy (Personal Spellbook)", "quest", "Mage class quest. Mage only. Mage class quest. Mage only"),
        item(7515, "Quest: Celestial Power (Celestial Orb)", "quest", "Mage class quest. Mage class quest. Choose this or Celestial Stave"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting"),
        item(7685, "Bloodmage Thalnos, Scarlet Monastery (Orb of the Forgotten Seer)", "dungeon", nil),
    },
    ranged = {
        item(279246, "Enchanting (Torch of Light)", "crafted", nil),
        item(18338, "Trash mobs, Dire Maul (Wand of Arcane Potency)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }
-- Fire: first picks: kami-labs (no simulator set for this spec); then kami-labs (Mage Fire); alternatives: classicwowforever.com/bis-list/fire-mage
DB["MAGE"]["Fire"] = { lvl60 = {
    head = {
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
    },
    neck = {
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(254053, "Tailoring (Netherflame Shoulders)", "crafted", "Needs Tailoring"),
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(10042, "Tailoring (Cindercloth Robe)", "crafted", nil),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(254065, "Tailoring (Netherflame Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples. Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Enchant: Enchant Gloves - Fire Power"),
        item(18408, "Tailoring (Inferno Gloves)", "crafted", "The pattern comes from a chest in Dire Maul"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254085, "Tailoring (Fiery Waistcord)", "crafted", "Needs Tailoring"),
    },
    legs = {
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(14045, "Tailoring (Cindercloth Pants)", "crafted", nil),
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
    },
    feet = {
        item(13369, "Balnazzar, Stratholme (Fire Striders)", "dungeon", nil),
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254111, "Tailoring (Fiery Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(7714, "Arcanist Doan, Scarlet Monastery (Hypnotic Blade)", "dungeon", nil),
        item(6691, "Agathelos the Raging, Razorfen Kraul (Swinetusk Shank)", "dungeon", nil),
    },
    offhand = {
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(221344, "Quest: A Lesson in Literacy (Personal Spellbook)", "quest", "Mage class quest. Mage only. Mage class quest. Mage only"),
        item(7515, "Quest: Celestial Power (Celestial Orb)", "quest", "Mage class quest. Mage class quest. Choose this or Celestial Stave"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting"),
        item(7685, "Bloodmage Thalnos, Scarlet Monastery (Orb of the Forgotten Seer)", "dungeon", nil),
    },
    ranged = {
        item(11748, "Pyromancer Loregrain, Blackrock Depths (Pyric Caduceus)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }
-- Frost: first picks: kami-labs (no simulator set for this spec); then kami-labs (Mage Frost); alternatives: classicwowforever.com/bis-list/frost-mage
DB["MAGE"]["Frost"] = { lvl60 = {
    head = {
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
    },
    neck = {
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(254051, "Tailoring (Netherfroth Shoulders)", "crafted", "Needs Tailoring"),
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", nil),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(254063, "Tailoring (Netherfroth Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples. Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Enchant: Enchant Gloves - Frost Power"),
        item(22066, "Quest: Just Compensation (Sorcerer's Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Belt and Gloves together; you get both. Ironforge or Orgrimmar. Turn in the Magister's Belt and Gloves together; you get both"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22062, "Quest: Just Compensation (Sorcerer's Belt)", "quest", "Ironforge or Orgrimmar. Ironforge or Orgrimmar. Turn in the Magister's Belt and Gloves together; you get both"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254083, "Tailoring (Frothing Waistcord)", "crafted", "Needs Tailoring"),
    },
    legs = {
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
    },
    feet = {
        item(22231, "War Master Voone, Blackrock Spire (Kayser's Boots of Precision)", "dungeon", nil),
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three. Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254109, "Tailoring (Frothing Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards. Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(7714, "Arcanist Doan, Scarlet Monastery (Hypnotic Blade)", "dungeon", nil),
        item(6691, "Agathelos the Raging, Razorfen Kraul (Swinetusk Shank)", "dungeon", nil),
    },
    offhand = {
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(221344, "Quest: A Lesson in Literacy (Personal Spellbook)", "quest", "Mage class quest. Mage only. Mage class quest. Mage only"),
        item(7515, "Quest: Celestial Power (Celestial Orb)", "quest", "Mage class quest. Mage class quest. Choose this or Celestial Stave"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting"),
        item(7685, "Bloodmage Thalnos, Scarlet Monastery (Orb of the Forgotten Seer)", "dungeon", nil),
    },
    ranged = {
        item(13938, "Darkmaster Gandling, Scholomance (Bonecreeper Stylus)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }

-- ============================================================
-- WARLOCK
-- ============================================================
DB["WARLOCK"] = {}
-- Destruction: first picks: wowsims/forever warlock/dps/gear_sets/preraid.gear.json; then kami-labs (Warlock Destruction); alternatives: classicwowforever.com/bis-list/destruction-warlock
DB["WARLOCK"]["Destruction"] = { lvl60 = {
    head = {
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", "Needs Tailoring. Trainer recipe"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(254053, "Tailoring (Netherflame Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(272413, "Sold by Pix Xizzix, Stranglethorn Vale (Drape of Recovery)", "world", nil),
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    chest = {
        item(14153, "Tailoring (Robe of the Void)", "crafted", nil),
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
    },
    wrist = {
        item(16703, "Trash mobs, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold. Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254065, "Tailoring (Netherflame Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(16705, "Lorekeeper Polkelt, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", "Enchant: Enchant Gloves - Shadow Power"),
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
        item(18408, "Tailoring (Inferno Gloves)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    waist = {
        item(16702, "Trash mobs, Scholomance (Dreadmist Belt)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254085, "Tailoring (Fiery Waistcord)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    legs = {
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14045, "Tailoring (Cindercloth Pants)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
    },
    feet = {
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(18735, "Maleki the Pallid, Stratholme (Maleki's Footwraps)", "dungeon", "Enchant: Enchant Boots - Greater Stamina"),
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(254111, "Tailoring (Fiery Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    ring1 = {
        item(275738, "World drop, sold at the auction house (Jereman's Bauble)", "world", nil),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(19518, "Sold by Kelm Hargunth, The Barrens (Advisor's Ring)", "world", nil, "Horde"),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(272438, "Sold by Pix Xizzix, Stranglethorn Vale (Weakness Analyzer)", "world", nil),
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    trinket2 = {
        item(270225, "World drop, sold at the auction house (Jewel of the Guard Captain)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(22379, "Quest: The Perfect Poison (Shivsprocket's Shiv)", "quest", nil),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Also: Superior Armaments of Battle - Honored Amongst the Dawn; Superior Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", nil),
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(15283, "World drop, sold at the auction house (Lunar Wand)", "world", nil),
        item(13396, "Skul, Stratholme (Skul's Ghastly Touch)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Affliction: first picks: wowsims/forever warlock/dps/gear_sets/preraid.gear.json; then kami-labs (Warlock Affliction); alternatives: classicwowforever.com/bis-list/affliction-warlock
DB["WARLOCK"]["Affliction"] = { lvl60 = {
    head = {
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(14112, "Tailoring (Felcloth Shoulders)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(272413, "Sold by Pix Xizzix, Stranglethorn Vale (Drape of Recovery)", "world", nil),
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    chest = {
        item(14153, "Tailoring (Robe of the Void)", "crafted", nil),
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", "Needs Tailoring. Pattern drops from Cobalt Mageweavers in Winterspring"),
        item(14106, "Tailoring (Felcloth Robe)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
    },
    wrist = {
        item(16703, "Trash mobs, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold. Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(16705, "Lorekeeper Polkelt, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", "Enchant: Enchant Gloves - Shadow Power"),
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
    },
    waist = {
        item(16702, "Trash mobs, Scholomance (Dreadmist Belt)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254087, "Tailoring (Black Waistcord)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    legs = {
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(14107, "Tailoring (Felcloth Pants)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", "Needs Tailoring. Pattern drops from Spectral Citizens in Stratholme"),
    },
    feet = {
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(18735, "Maleki the Pallid, Stratholme (Maleki's Footwraps)", "dungeon", "Enchant: Enchant Boots - Greater Stamina"),
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
    },
    ring1 = {
        item(275738, "World drop, sold at the auction house (Jereman's Bauble)", "world", nil),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(19518, "Sold by Kelm Hargunth, The Barrens (Advisor's Ring)", "world", nil, "Horde"),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(272438, "Sold by Pix Xizzix, Stranglethorn Vale (Weakness Analyzer)", "world", nil),
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    trinket2 = {
        item(270225, "World drop, sold at the auction house (Jewel of the Guard Captain)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(22379, "Quest: The Perfect Poison (Shivsprocket's Shiv)", "quest", nil),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Also: Superior Armaments of Battle - Honored Amongst the Dawn; Superior Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", nil),
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(15283, "World drop, sold at the auction house (Lunar Wand)", "world", nil),
        item(13396, "Skul, Stratholme (Skul's Ghastly Touch)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Demonology: first picks: wowsims/forever warlock/dps/gear_sets/preraid.gear.json; then kami-labs (Warlock Demonology); alternatives: classicwowforever.com/bis-list/demonology-warlock
DB["WARLOCK"]["Demonology"] = { lvl60 = {
    head = {
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(272413, "Sold by Pix Xizzix, Stranglethorn Vale (Drape of Recovery)", "world", nil),
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
    },
    chest = {
        item(14153, "Tailoring (Robe of the Void)", "crafted", nil),
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe. Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", "Needs Tailoring. Pattern drops from Cobalt Mageweavers in Winterspring"),
    },
    wrist = {
        item(16703, "Trash mobs, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold. Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(16705, "Lorekeeper Polkelt, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", "Enchant: Enchant Gloves - Shadow Power"),
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    waist = {
        item(16702, "Trash mobs, Scholomance (Dreadmist Belt)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps. Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(13170, "Highlord Omokk, Blackrock Spire (Skyshroud Leggings)", "dungeon", nil),
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", "Needs Tailoring. Pattern drops from Spectral Citizens in Stratholme"),
    },
    feet = {
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(18735, "Maleki the Pallid, Stratholme (Maleki's Footwraps)", "dungeon", "Enchant: Enchant Boots - Greater Stamina"),
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle. Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    ring1 = {
        item(275738, "World drop, sold at the auction house (Jereman's Bauble)", "world", nil),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(19518, "Sold by Kelm Hargunth, The Barrens (Advisor's Ring)", "world", nil, "Horde"),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(272438, "Sold by Pix Xizzix, Stranglethorn Vale (Weakness Analyzer)", "world", nil),
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Also: Epic Armaments of Battle - Honored Amongst the Dawn; Epic Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    trinket2 = {
        item(270225, "World drop, sold at the auction house (Jewel of the Guard Captain)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(22379, "Quest: The Perfect Poison (Shivsprocket's Shiv)", "quest", nil),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Enchant: Enchant Weapon - Spell Power"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Also: Superior Armaments of Battle - Honored Amongst the Dawn; Superior Armaments of Battle - Revered Amongst the Dawn. Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", nil),
        item(22253, "General Drakkisath, Blackrock Spire (Tome of the Lost)", "dungeon", nil),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(15283, "World drop, sold at the auction house (Lunar Wand)", "world", nil),
        item(13396, "Skul, Stratholme (Skul's Ghastly Touch)", "dungeon", nil),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }

-- ============================================================
-- DRUID
-- ============================================================
DB["DRUID"] = {}
-- Balance: first picks: wowsims/forever druid/balance/gear_sets/prebis.gear.json; then kami-labs (Druid Balance); alternatives: classicwowforever.com/bis-list/balance-druid
DB["DRUID"]["Balance"] = { lvl60 = {
    head = {
        item(10250, "World drop, sold at the auction house (Master's Hat of Magic)", "world", nil),
        item(22267, "General Drakkisath, Blackrock Spire (Spellweaver's Turban)", "dungeon", nil),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(270099, "Quest: Divino-matic Rod (Magister Cowl)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Masons Fraternity Ring. Zul'Farrak. Choose this or Engineer's Guild Headpiece or Masons Fraternity Ring"),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", nil),
        item(22403, "Cannon Master Willey, Stratholme (Nacreous Shell Necklace)", "dungeon", "Enchant: Enchant Necklace - Spell Power"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(10210, "World drop, sold at the auction house (Elegant Mantle of Magic)", "world", nil),
        item(15067, "Leatherworking (Ironfeather Shoulders)", "crafted", nil),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(252537, "Leatherworking (Skycaller's Leather Shoulders)", "crafted", "Needs Leatherworking"),
    },
    back = {
        item(272413, "Sold by Pix Xizzix, Stranglethorn Vale (Drape of Recovery)", "world", nil),
        item(272411, "Sold by Pix Xizzix, Stranglethorn Vale (Arcanoweave Cloak)", "world", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. The pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(279855, "Quest: Tome of Twilight (Torn Cultist Cloak)", "quest", "Krol'dok Stronghold. Alliance only. Krol'dok Stronghold. Alliance only", "Alliance"),
    },
    chest = {
        item(10143, "World drop, sold at the auction house (High Councillor's Robe of Magic)", "world", nil),
        item(15066, "Leatherworking (Ironfeather Breastplate)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(8349, "Leatherworking (Feathered Breastplate)", "crafted", nil),
    },
    wrist = {
        item(10248, "World drop, sold at the auction house (Master's Bracers of Magic)", "world", nil),
        item(18497, "Guard Mol'dar, Dire Maul (Sublime Wristguards)", "dungeon", "Enchant: Enchant Bracer - Healing Power"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(252542, "Leatherworking (Skycaller's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(15092, "Leatherworking (Runic Leather Bracers)", "crafted", nil),
    },
    hands = {
        item(10140, "World drop, sold at the auction house (High Councillor's Gloves of Magic)", "world", nil),
        item(13253, "Quartermaster Zigris, Blackrock Spire (Hands of Power)", "dungeon", "Enchant: Enchant Gloves - Healing Power"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(13863, "Tailoring (Runecloth Gloves)", "crafted", nil),
        item(22110, "Quest: Just Compensation (Feralheart Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Gloves. Ironforge or Orgrimmar. Turn in the Wildheart Gloves"),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(19162, "Leatherworking (Corehound Belt)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(252476, "Leatherworking (Skycaller's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(18504, "Leatherworking (Girdle of Insight)", "crafted", nil),
    },
    legs = {
        item(252486, "Leatherworking (Ironfeather Leggings)", "crafted", nil),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
    },
    feet = {
        item(254129, "Tailoring (Ghostweave Boots)", "crafted", nil),
        item(18322, "Hydrospawn, Dire Maul (Waterspout Boots)", "dungeon", nil),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(252471, "Leatherworking (Skycaller's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(22107, "Quest: Anthion's Parting Words (Feralheart Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Boots. Ironforge or Orgrimmar. Turn in the Wildheart Boots"),
    },
    ring1 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Choose one Willix the Importer ring"),
    },
    ring2 = {
        item(272406, "Sold by Pix Xizzix, Stranglethorn Vale (Channeler's Ring)", "world", nil),
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(272438, "Sold by Pix Xizzix, Stranglethorn Vale (Weakness Analyzer)", "world", nil),
        item(22268, "General Drakkisath, Blackrock Spire (Draconic Infused Emblem)", "dungeon", nil),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(274420, "Barkskin Burrow - Revered (Wisepaw Totem)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal. Needs Revered with Barkskin Burrow"),
        item(20069, "The League of Arathor - Exalted (Ironbark Staff)", "reputation", "Sold by Samuel Hawke. Enchant: Enchant 2H Weapon - Mighty Spell Power", "Alliance"),
        item(275648, "Quest: Twisted Tools (Purified Gnarlybark Staff)", "quest", "Mount Hyjal. One of three quest rewards. Mount Hyjal. Choose this or Reforged Spear or Cleansed Ritual Kris"),
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(249453, "Enchanting (Radiant Staff)", "crafted", "Needs Enchanting"),
    },
    ranged = {
        item(272430, "Sold by Pix Xizzix, Stranglethorn Vale (Swarming Idol)", "world", nil),
        item(249441, "Enchanting (Talons of Wrath)", "crafted", "Needs Enchanting"),
        item(249396, "Enchanting (Mystic Mushroom)", "crafted", "Needs Enchanting"),
    },
} }
-- Restoration: first picks: kami-labs (no simulator set for this spec); then kami-labs (Druid Restoration); alternatives: classicwowforever.com/bis-list/restoration-druid
DB["DRUID"]["Restoration"] = { lvl60 = {
    head = {
        item(252561, "Leatherworking (Living Crown)", "crafted", nil),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(16720, "Darkmaster Gandling, Scholomance (Wildheart Cowl)", "dungeon", nil),
        item(9534, "Quest: Divino-matic Rod (Engineer's Guild Headpiece)", "quest", "Zul'Farrak. Choose this or Magister Cowl or Masons Fraternity Ring"),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    neck = {
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", "Enchant: Enchant Necklace - Healing Power"),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", nil),
        item(16718, "Gizrul the Slavener, Blackrock Spire (Wildheart Spaulders)", "dungeon", nil),
        item(15061, "Leatherworking (Living Shoulders)", "crafted", nil),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. The pattern is sold in Moonglade"),
        item(11873, "Quest: Ancient Spirit (Ethereal Mist Cape)", "quest", "Felwood. Alliance only; choose this or Clouddrift Mantle", "Alliance"),
        item(279855, "Quest: Tome of Twilight (Torn Cultist Cloak)", "quest", "Krol'dok Stronghold. Alliance only. Krol'dok Stronghold. Alliance only", "Alliance"),
    },
    chest = {
        item(254121, "Tailoring (Earthenweave Vest)", "crafted", "Enchant: Enchant Chest - Major Intellect"),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(16706, "General Drakkisath, Blackrock Spire (Wildheart Vest)", "dungeon", nil),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
        item(15059, "Leatherworking (Living Breastplate)", "crafted", nil),
    },
    wrist = {
        item(254131, "Tailoring (Earthenweave Cuffs)", "crafted", "Enchant: Enchant Bracer - Healing Power"),
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring"),
        item(252543, "Leatherworking (Mender's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
    },
    hands = {
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", "Enchant: Enchant Gloves - Healing Power"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(252530, "Leatherworking (Mender's Leather Gloves)", "crafted", "Needs Leatherworking"),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(252477, "Leatherworking (Mender's Leather Waistguard)", "crafted", "Needs Leatherworking"),
    },
    legs = {
        item(252486, "Leatherworking (Ironfeather Leggings)", "crafted", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(16719, "Baron Rivendare, Stratholme (Wildheart Kilt)", "dungeon", nil),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
        item(15060, "Leatherworking (Living Leggings)", "crafted", nil),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", "Enchant: Enchant Boots - Spirit"),
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(16715, "Mother Smolderweb, Blackrock Spire (Wildheart Boots)", "dungeon", nil),
    },
    ring1 = {
        item(272407, "Sold by Pix Xizzix, Stranglethorn Vale (Blessed Band of Light)", "world", nil),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale. Sold by Gezzy Gunkgear, Stranglethorn Vale"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings. Razorfen Kraul. Choose one Willix the Importer ring"),
    },
    ring2 = {
        item(12543, "Quest: The Princess's Surprise (Songstone of Ironforge)", "quest", nil, "Alliance"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(272439, "Sold by Pix Xizzix, Stranglethorn Vale (Serenity Field)", "world", nil),
    },
    trinket2 = {
        item(12930, "Jed Runewatcher, Blackrock Spire (Briarwood Reed)", "dungeon", nil),
    },
    mainhand = {
        item(17710, "Princess Theradras, Maraudon (Charstone Dirk)", "dungeon", "Enchant: Enchant Weapon - Healing Power"),
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", nil),
        item(275647, "Quest: Twisted Tools (Cleansed Ritual Kris)", "quest", "Mount Hyjal. Choose this or the other Twisted Tools rewards. Mount Hyjal. Choose this or Reforged Spear or Purified Gnarlybark Staff"),
    },
    offhand = {
        item(11262, "Quest: In the Name of the Light (Orb of Lorica)", "quest", nil, "Alliance"),
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting"),
        item(274417, "Barkskin Burrow - Revered (Barkskin Baubles)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal. Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(23197, "Baroness Anastari, Stratholme (Idol of the Moon)", "dungeon", "Drop chance 0.01%"),
        item(249396, "Enchanting (Mystic Mushroom)", "crafted", "Needs Enchanting"),
    },
} }
-- Feral - Tank: first picks: wowsims/forever druid/feralbear/gear_sets/default.gear.json; then kami-labs (Druid Guardian (bear)); alternatives: classicwowforever.com/bis-list/feral-druid
DB["DRUID"]["Feral - Tank"] = { lvl60 = {
    head = {
        item(252485, "Leatherworking (Warbear Helm)", "crafted", nil),
        item(8345, "Leatherworking (Wolfshead Helm)", "crafted", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", nil),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", nil),
    },
    neck = {
        item(19491, "Quest: 1200 Tickets - Amulet of the Darkmoon", "quest", nil),
        item(12059, "Quest: Operation: Death to Angerforge (Conqueror's Medallion)", "quest", "Blackrock Depths. lvl 58. Enchant: Enchant Necklace - Agility", "Horde"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
        item(270095, "Quest: The Lost Tablets of Will (Medal of Valor)", "quest", "Uldaman. Alliance only. Uldaman. Alliance only", "Alliance"),
    },
    shoulder = {
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(20194, "The Defilers - Exalted (Defiler's Leather Shoulders)", "reputation", "Sold by Rutherford Twing", "Horde"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking"),
        item(11874, "Quest: Ancient Spirit (Clouddrift Mantle)", "quest", "Felwood. Alliance only; choose this or Ethereal Mist Cape", "Alliance"),
        item(19058, "Leatherworking (Golden Mantle of the Dawn)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(18689, "Jandice Barov, Scholomance (Phantasmal Cloak)", "dungeon", "Enchant: Enchant Cloak - Superior Defense"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(252483, "Leatherworking (Dawn Armor)", "crafted", nil),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Enchant: Enchant Chest - Major Stamina"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", nil),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", nil),
    },
    wrist = {
        item(272754, "PvP reward (Premier Knight-Captain's Beasthide Bracers)", "pvp", nil),
        item(18375, "Prince Tortheldrin, Dire Maul (Bracers of the Eclipse)", "dungeon", "Enchant: Enchant Bracer - Superior Stamina"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", nil),
        item(13258, "Urok Doomhowl, Blackrock Spire (Slaghide Gauntlets)", "dungeon", "Enchant: Enchant Gloves - Superior Agility"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", nil),
    },
    waist = {
        item(272396, "Sold by Pix Xizzix, Stranglethorn Vale (Shifter's Belt)", "world", nil),
        item(13252, "Quartermaster Zigris, Blackrock Spire (Cloudrunner Girdle)", "dungeon", nil),
        item(9636, "Quest: Deliver to MacKinley (Swashbuckler Sash)", "quest", "Tanaris. Choose this or Shinkicker Boots"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(252473, "Leatherworking (Prowler's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(252475, "Leatherworking (Warden's Leather Waistguard)", "crafted", "Needs Leatherworking; Bear option"),
    },
    legs = {
        item(22749, "Sold by Illiyana Moonblaze, Ashenvale (Sentinel's Leather Pants)", "world", nil),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", nil),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "The pattern needs Friendly with Timbermaw Hold; also a Bear option"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(22111, "Quest: Anthion's Parting Words (Feralheart Kilt)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Kilt. Ironforge or Orgrimmar. Turn in the Wildheart Kilt"),
    },
    feet = {
        item(20715, "Quest: Armaments of War (Dunestalker's Boots)", "quest", nil),
        item(20186, "The Defilers - Revered (Defiler's Leather Boots)", "reputation", "Sold by Rutherford Twing. Enchant: Enchant Boots - Greater Stamina", "Horde"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(252469, "Leatherworking (Skulker's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(252470, "Leatherworking (Warden's Leather Boots)", "crafted", "Needs Leatherworking; Bear option"),
    },
    ring1 = {
        item(21202, "Brood of Nozdormu - Friendly (Signet Ring of the Bronze Dragonflight)", "reputation", nil),
        item(12544, "Quest: The Princess Saved? (Thrall's Resolve)", "quest", nil, "Horde"),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(11669, "Golem Lord Argelmach, Blackrock Depths (Naglering)", "dungeon", nil),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
    },
    trinket1 = {
        item(17904, "Quest: The Eye of Command (Stormpike Insignia Rank 6)", "quest", nil),
        item(13966, "Quest: For The Horde! (Mark of Tyranny)", "quest", "Also: General Drakkisath's Demise"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(272060, "Darkspear Raiders - Friendly (Relentless Raider's Seal)", "reputation", "Sold by Creeg Bothunk", "Horde"),
    },
    mainhand = {
        item(272848, "PvP reward (Premier Grand Marshal's Battle Hammer)", "pvp", nil),
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Made by a Blacksmith; the plans drop in Stratholme"),
    },
    ranged = {
        item(272428, "Sold by Pix Xizzix, Stranglethorn Vale (Enraged Idol)", "world", nil),
        item(220606, "Enchanting (Idol of the Dream)", "crafted", "Needs Enchanting"),
    },
} }
-- Feral - DPS: first picks: wowsims/forever druid/feralcat/gear_sets/pre_raid.gear.json; then kami-labs (Druid Feral (cat)); alternatives: classicwowforever.com/bis-list/feral-druid
DB["DRUID"]["Feral - DPS"] = { lvl60 = {
    head = {
        item(8345, "Leatherworking (Wolfshead Helm)", "crafted", nil),
        item(12587, "Warchief Rend Blackhand, Blackrock Spire (Eye of Rend)", "dungeon", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", nil),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", nil),
    },
    neck = {
        item(19491, "Quest: 1200 Tickets - Amulet of the Darkmoon", "quest", nil),
        item(15411, "Quest: In Dreams (Mark of Fordring)", "quest", "Enchant: Enchant Necklace - Agility"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
        item(270095, "Quest: The Lost Tablets of Will (Medal of Valor)", "quest", "Uldaman. Alliance only. Uldaman. Alliance only", "Alliance"),
    },
    shoulder = {
        item(271955, "Theramore Expeditionary Force - Exalted (Theramore Pauldrons)", "reputation", nil, "Alliance"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking"),
        item(11874, "Quest: Ancient Spirit (Clouddrift Mantle)", "quest", "Felwood. Alliance only; choose this or Ethereal Mist Cape", "Alliance"),
        item(19058, "Leatherworking (Golden Mantle of the Dawn)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(13340, "Baron Rivendare, Stratholme (Cape of the Black Baron)", "dungeon", "Enchant: Enchant Cloak - Minor Agility"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(252484, "Leatherworking (Timbermaw Tunic)", "crafted", nil),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", nil),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", nil),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Bear option; the pattern needs Friendly with Timbermaw Hold. We don't know where the pattern drops"),
    },
    wrist = {
        item(19587, "Sold by Illiyana Moonblaze, Ashenvale (Forest Stalker's Bracers)", "world", nil),
        item(18375, "Prince Tortheldrin, Dire Maul (Bracers of the Eclipse)", "dungeon", "Enchant: Enchant Bracer - Superior Agility"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace. Maraudon"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", nil),
        item(271948, "Theramore Expeditionary Force - Exalted (Theramore Gloves)", "reputation", "Enchant: Enchant Gloves - Superior Agility", "Alliance"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", nil),
    },
    waist = {
        item(272396, "Sold by Pix Xizzix, Stranglethorn Vale (Shifter's Belt)", "world", nil),
        item(9636, "Quest: Deliver to MacKinley (Swashbuckler Sash)", "quest", "Tanaris. Choose this or Shinkicker Boots"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(252473, "Leatherworking (Prowler's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(252475, "Leatherworking (Warden's Leather Waistguard)", "crafted", "Needs Leatherworking; Bear option"),
    },
    legs = {
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", nil),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", nil),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(22111, "Quest: Anthion's Parting Words (Feralheart Kilt)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Kilt. Ironforge or Orgrimmar. Turn in the Wildheart Kilt"),
    },
    feet = {
        item(20715, "Quest: Armaments of War (Dunestalker's Boots)", "quest", nil),
        item(12553, "Princess Moira Bronzebeard , Blackrock Depths (Swiftwalker Boots)", "dungeon", "Enchant: Enchant Boots - Greater Agility"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(252469, "Leatherworking (Skulker's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(252470, "Leatherworking (Warden's Leather Boots)", "crafted", "Needs Leatherworking; Bear option"),
    },
    ring1 = {
        item(19325, "Sold by Gaelden Hammersmith, Alterac Valley (Don Julio's Band)", "world", nil),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(275981, "The Watchers - Exalted (Warden's Signet of Ferocity)", "reputation", nil),
        item(18500, "Tribute, Dire Maul (Tarnished Elven Ring)", "dungeon", nil),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
    },
    trinket1 = {
        item(19120, "Quest: Job Opening: Guard Captain of Revantusk Village (Rune of the Guard Captain)", "quest", nil, "Horde"),
        item(272437, "Sold by Pix Xizzix, Stranglethorn Vale (Adaptive Combat Assistant)", "world", nil),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(270275, "World drop, sold at the auction house (Cleansed Vilebranch Medallion)", "world", nil),
        item(11815, "Emperor Dagran Thaurissan, Blackrock Depths (Hand of Justice)", "dungeon", nil),
    },
    mainhand = {
        item(19323, "Sold by Gaelden Hammersmith, Alterac Valley (The Unstoppable Force)", "world", nil),
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Made by a Blacksmith; the plans drop in Stratholme"),
    },
    ranged = {
        item(272427, "Sold by Pix Xizzix, Stranglethorn Vale (Howling Idol)", "world", nil),
        item(220606, "Enchanting (Idol of the Dream)", "crafted", "Needs Enchanting"),
    },
} }

