-- TBCBisTracker WoW Forever database (GENERATED — do not edit by hand)
-- Source: web/scripts/forever-lvl60.json via web/scripts/build-forever-db.py
-- Generated: 2026-11-12
-- Level 60 pre-raid lists; refresh with web/scripts/fetch-forever-bis.py.
-- Lists: Classic WoW Forever (classicwowforever.com), CC BY 4.0
-- Level 60 pre-raid lists checked 2026-11-08 against build 1.60.1.70862

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
-- Fury: classicwowforever.com/bis-list/fury-warrior (checked 2026-11-08); weapons: Dual wield setup (not used: Two-hander); order = the site's, first pick first
DB["WARRIOR"]["Fury"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", "We don't know where the plans drop"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(12625, "Blacksmithing (Dawnbringer Shoulders)", "crafted", nil),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", nil),
        item(6314, "Wolf Master Nandos, Shadowfang Keep (Wolfmaster Cape)", "dungeon", nil),
    },
    chest = {
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", nil),
    },
    wrist = {
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(16735, "Several enemies, Blackrock Spire (Bracers of Valor)", "dungeon", nil),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
    },
    waist = {
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(10798, "Atal'alarion, Sunken Temple (Atal'alarion's Tusk Ring)", "dungeon", nil),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", "We don't know where the plans drop"),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(21316, "Quest: Deadwood of the North (Leggings of the Ursa)", "quest", "Blackmaw Hold"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
    },
    feet = {
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(22384, "Blacksmithing (Persuader)", "crafted", "We don't know where the plans drop"),
        item(12774, "Blacksmithing (Dawn's Edge)", "crafted", nil),
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(250618, "Blacksmithing (Bagh Nakh)", "crafted", "Needs Blacksmithing; the plans need Timbermaw Hold at Revered"),
    },
    offhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", nil),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Arms: classicwowforever.com/bis-list/arms-warrior (checked 2026-11-08); order = the site's, first pick first
DB["WARRIOR"]["Arms"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", "We don't know where the plans drop"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(12625, "Blacksmithing (Dawnbringer Shoulders)", "crafted", nil),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", nil),
    },
    back = {
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", nil),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(6314, "Wolf Master Nandos, Shadowfang Keep (Wolfmaster Cape)", "dungeon", nil),
    },
    chest = {
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", nil),
    },
    wrist = {
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(16735, "Several enemies, Blackrock Spire (Bracers of Valor)", "dungeon", nil),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
    },
    waist = {
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(10798, "Atal'alarion, Sunken Temple (Atal'alarion's Tusk Ring)", "dungeon", nil),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", "We don't know where the plans drop"),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(21316, "Quest: Deadwood of the North (Leggings of the Ursa)", "quest", "Blackmaw Hold"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
    },
    feet = {
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", nil),
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(12782, "Blacksmithing (Corruption)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
    },
    ranged = {
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Protection: classicwowforever.com/bis-list/protection-warrior (checked 2026-11-08); order = the site's, first pick first
DB["WARRIOR"]["Protection"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", "We don't know where the plans drop"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", nil),
        item(21999, "Quest: Saving the Best for Last (Helm of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(274749, "Booty Bay - Honored (Souvenir Sea Shell)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    shoulder = {
        item(12625, "Blacksmithing (Dawnbringer Shoulders)", "crafted", nil),
        item(22001, "Quest: Anthion's Parting Words (Spaulders of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(250577, "Blacksmithing (Sentinel's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
    },
    back = {
        item(18413, "Tailoring (Cloak of Warding)", "crafted", nil),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(11311, "Galgann Firehammer, Uldaman (Emberscale Cape)", "dungeon", nil),
    },
    chest = {
        item(21997, "Quest: Saving the Best for Last (Breastplate of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor helm and breastplate together"),
        item(12618, "Blacksmithing (Enchanted Thorium Breastplate)", "crafted", nil),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
    },
    wrist = {
        item(21996, "Quest: An Earnest Proposition (Bracers of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Bracers of Valor"),
        item(16735, "Several enemies, Blackrock Spire (Bracers of Valor)", "dungeon", nil),
        item(250582, "Blacksmithing (Sentinel's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    hands = {
        item(21998, "Quest: Just Compensation (Gauntlets of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(12639, "Blacksmithing (Stronghold Gauntlets)", "crafted", "We don't know where the plans drop"),
    },
    waist = {
        item(21994, "Quest: Just Compensation (Belt of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor gauntlets and belt together"),
        item(250572, "Blacksmithing (Sentinel's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(10798, "Atal'alarion, Sunken Temple (Atal'alarion's Tusk Ring)", "dungeon", nil),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", "We don't know where the plans drop"),
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", nil),
        item(22000, "Quest: Anthion's Parting Words (Legplates of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
    },
    feet = {
        item(21995, "Quest: Anthion's Parting Words (Boots of Heroism)", "quest", "Ironforge or Orgrimmar. Turn in the Valor boots, legplates and spaulders together"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250562, "Blacksmithing (Sentinel's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
    },
    ring2 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade"),
    },
    trinket1 = {
        item(13164, "Several enemies, Blackrock Spire (Heart of the Scale)", "dungeon", nil),
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    trinket2 = {
        item(10779, "Quest: You Are Rakh'likh, Demon (Demon's Blood)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", nil),
        item(12774, "Blacksmithing (Dawn's Edge)", "crafted", nil),
        item(22384, "Blacksmithing (Persuader)", "crafted", "We don't know where the plans drop"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", nil),
    },
    offhand = {
        item(7726, "Scarlet Commander Mograine, Scarlet Monastery (Aegis of the Scarlet Commander)", "dungeon", nil),
        item(18168, "Engineering (Force Reactive Disk)", "crafted", "Needs Engineering. We don't know where the schematic drops"),
        item(9643, "Quest: Rescue OOX-17/TN! (Optomatic Deflector)", "quest", "Tanaris"),
        item(274418, "Barkskin Burrow - Revered (Burrow Barricade)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", nil),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }

-- ============================================================
-- PALADIN
-- ============================================================
DB["PALADIN"] = {}
-- Holy: classicwowforever.com/bis-list/holy-paladin (checked 2026-11-08); order = the site's, first pick first
DB["PALADIN"]["Holy"] = { lvl60 = {
    head = {
        item(12633, "Blacksmithing (Whitesoul Helm)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    neck = {
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
    },
    shoulder = {
        item(12625, "Blacksmithing (Dawnbringer Shoulders)", "crafted", "Needs Blacksmithing. The plans need Argent Dawn reputation"),
        item(16718, "Gizrul the Slavener, Blackrock Spire (Wildheart Spaulders)", "dungeon", nil),
        item(15061, "Leatherworking (Living Shoulders)", "crafted", "Needs Leatherworking"),
        item(250579, "Blacksmithing (Prefect's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking"),
        item(275046, "Quest: Bring Me His Head (Twilight Overlord Drape)", "quest", "Riverglades. Alliance only. Choose this or another reward", "Alliance"),
        item(275050, "Quest: Bring Me His Head (Cloak of the Cult)", "quest", "Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    chest = {
        item(16726, "General Drakkisath, Blackrock Spire (Lightforge Breastplate)", "dungeon", nil),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(15047, "Leatherworking (Red Dragonscale Breastplate)", "crafted", "Needs Leatherworking"),
        item(18486, "Tailoring (Mooncloth Robe)", "crafted", "Needs Tailoring"),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    wrist = {
        item(16722, "Several enemies, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(252573, "Leatherworking (Mender's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(250584, "Blacksmithing (Prefect's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring; pattern costs 60 Merchant's Favor"),
    },
    hands = {
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(20296, "Leatherworking (Green Dragonscale Gauntlets)", "crafted", "Needs Leatherworking"),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", "Needs Tailoring"),
    },
    waist = {
        item(250574, "Blacksmithing (Prefect's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(252591, "Leatherworking (Mender's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring; pattern costs 60 Merchant's Favor"),
    },
    legs = {
        item(16728, "Baron Rivendare, Stratholme (Lightforge Legplates)", "dungeon", nil),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(15060, "Leatherworking (Living Leggings)", "crafted", "Needs Leatherworking"),
    },
    feet = {
        item(16725, "Several enemies, Stratholme (Lightforge Boots)", "dungeon", nil),
        item(252579, "Leatherworking (Mender's Mail Sabatons)", "crafted", "Needs Leatherworking; pattern costs 90 Merchant's Favor"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(250564, "Blacksmithing (Prefect's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. The quest wants 20 donated books. Choose this or another reward"),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale"),
        item(275043, "Quest: Bloodmaster's Ring", "quest", "Riverglades. Horde only. Choose this or another reward", "Horde"),
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
    },
    ring2 = {
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
    },
    mainhand = {
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", nil),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
    },
    offhand = {
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
        item(277258, "Quest: Greater Friend of the Library (Crest of Elucidation)", "quest", "Stormwind City or Undercity. A shield, so it adds armor. The quest wants 25 donated books"),
    },
    ranged = {
        item(228175, "Enchanting (Libram of Holy Alacrity)", "crafted", "Needs Enchanting; formula costs 240 Merchant's Favor"),
    },
} }
-- Protection: classicwowforever.com/bis-list/protection-paladin (checked 2026-11-08); order = the site's, first pick first
DB["PALADIN"]["Protection"] = { lvl60 = {
    head = {
        item(250597, "Blacksmithing (Enriched Thorium Helm)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(12620, "Blacksmithing (Enchanted Thorium Helm)", "crafted", "Needs Blacksmithing"),
    },
    neck = {
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
    },
    shoulder = {
        item(16733, "Warchief Rend Blackhand, Blackrock Spire (Spaulders of Valor)", "dungeon", nil),
        item(250578, "Blacksmithing (Warder's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(250580, "Blacksmithing (Justicar's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(22093, "Quest: Anthion's Parting Words (Soulforge Spaulders)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    back = {
        item(18413, "Tailoring (Cloak of Warding)", "crafted", "Needs Tailoring"),
        item(11311, "Galgann Firehammer, Uldaman (Emberscale Cape)", "dungeon", nil),
    },
    chest = {
        item(250595, "Blacksmithing (Enriched Thorium Breastplate)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(16730, "General Drakkisath, Blackrock Spire (Breastplate of Valor)", "dungeon", nil),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
    },
    wrist = {
        item(16722, "Several enemies, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(250583, "Blacksmithing (Warder's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250582, "Blacksmithing (Sentinel's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250585, "Blacksmithing (Justicar's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22088, "Quest: An Earnest Proposition (Soulforge Bracers)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples", "Alliance"),
    },
    hands = {
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(22090, "Quest: Just Compensation (Soulforge Gauntlets)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
    },
    waist = {
        item(250573, "Blacksmithing (Warder's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250572, "Blacksmithing (Sentinel's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250575, "Blacksmithing (Justicar's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22086, "Quest: Just Compensation (Soulforge Belt)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
    },
    legs = {
        item(12619, "Blacksmithing (Enchanted Thorium Leggings)", "crafted", "Needs Blacksmithing"),
        item(250596, "Blacksmithing (Enriched Thorium Leggings)", "crafted", "Needs Blacksmithing; plans cost 120 Merchant's Favor"),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
        item(22092, "Quest: Anthion's Parting Words (Soulforge Legplates)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    feet = {
        item(250563, "Blacksmithing (Warder's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(16734, "Kirtonos the Herald, Scholomance (Boots of Valor)", "dungeon", nil),
        item(250562, "Blacksmithing (Sentinel's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22087, "Quest: Anthion's Parting Words (Soulforge Boots)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    ring1 = {
        item(15855, "Quest: Hidden Treasures (Ring of Protection)", "quest", "Eastern Plaguelands"),
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
        item(275045, "Quest: Bloodmaster's Ring (Ogre Horn Ring)", "quest", "Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or another reward"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
    },
    trinket1 = {
        item(11811, "Enchanting (Smoking Heart of the Mountain)", "crafted", "Needs Enchanting"),
    },
    mainhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Needs Blacksmithing"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Needs Blacksmithing"),
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
    },
    offhand = {
        item(7726, "Scarlet Commander Mograine, Scarlet Monastery (Aegis of the Scarlet Commander)", "dungeon", nil),
        item(274418, "Barkskin Burrow - Revered (Burrow Barricade)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
        item(18168, "Engineering (Force Reactive Disk)", "crafted", "Needs Engineering. We don't know where the schematic drops"),
        item(11915, "Quest: Shizzle's Flyer (Shizzle's Drizzle Blocker)", "quest", "Un'Goro Crater. Choose this or another reward"),
    },
    ranged = {
        item(249442, "Enchanting (Libram of Invocation)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
    },
} }
-- Retribution: classicwowforever.com/bis-list/retribution-paladin (checked 2026-11-08); order = the site's, first pick first
DB["PALADIN"]["Retribution"] = { lvl60 = {
    head = {
        item(12640, "Blacksmithing (Lionheart Helm)", "crafted", "We don't know where the plans drop"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(16727, "Darkmaster Gandling, Scholomance (Lightforge Helm)", "dungeon", nil),
        item(22091, "Quest: Saving the Best for Last (Soulforge Helm)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(16731, "Darkmaster Gandling, Scholomance (Helm of Valor)", "dungeon", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
    },
    shoulder = {
        item(16729, "The Beast, Blackrock Spire (Lightforge Spaulders)", "dungeon", nil),
        item(250580, "Blacksmithing (Justicar's Pauldrons)", "crafted", "Needs Blacksmithing; plans cost 60 Merchant's Favor"),
        item(22093, "Quest: Anthion's Parting Words (Soulforge Spaulders)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Needs Leatherworking"),
        item(18509, "Leatherworking (Chromatic Cloak)", "crafted", "Needs Leatherworking"),
    },
    chest = {
        item(16666, "General Drakkisath, Blackrock Spire (Vest of Elements)", "dungeon", nil),
        item(16726, "General Drakkisath, Blackrock Spire (Lightforge Breastplate)", "dungeon", nil),
        item(22089, "Quest: Saving the Best for Last (Soulforge Breastplate)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Helm and Breastplate", "Alliance"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Needs Leatherworking"),
    },
    wrist = {
        item(16722, "Several enemies, Scholomance (Lightforge Bracers)", "dungeon", nil),
        item(250585, "Blacksmithing (Justicar's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250581, "Blacksmithing (Officer's Wristguards)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22088, "Quest: An Earnest Proposition (Soulforge Bracers)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Bracers with 15 Winterspring Blood Samples", "Alliance"),
    },
    hands = {
        item(16672, "Pyroguard Emberseer, Blackrock Spire (Gauntlets of Elements)", "dungeon", nil),
        item(16737, "Ramstein the Gorger, Stratholme (Gauntlets of Valor)", "dungeon", nil),
        item(22090, "Quest: Just Compensation (Soulforge Gauntlets)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Needs Leatherworking"),
        item(19057, "Blacksmithing (Gloves of the Dawn)", "crafted", "Needs Blacksmithing. The plans need Argent Dawn reputation"),
    },
    waist = {
        item(250575, "Blacksmithing (Justicar's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250571, "Blacksmithing (Officer's Waistguard)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22086, "Quest: Just Compensation (Soulforge Belt)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Belt and Gauntlets", "Alliance"),
        item(10798, "Atal'alarion, Sunken Temple (Atal'alarion's Tusk Ring)", "dungeon", nil),
    },
    legs = {
        item(22385, "Blacksmithing (Titanic Leggings)", "crafted", "We don't know where the plans drop"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(16728, "Baron Rivendare, Stratholme (Lightforge Legplates)", "dungeon", nil),
        item(16732, "Baron Rivendare, Stratholme (Legplates of Valor)", "dungeon", nil),
        item(22092, "Quest: Anthion's Parting Words (Soulforge Legplates)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
        item(17711, "Princess Theradras, Maraudon (Elemental Rockridge Leggings)", "dungeon", nil),
    },
    feet = {
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(250565, "Blacksmithing (Justicar's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(250561, "Blacksmithing (Officer's Sabatons)", "crafted", "Needs Blacksmithing; plans cost 90 Merchant's Favor"),
        item(22087, "Quest: Anthion's Parting Words (Soulforge Boots)", "quest", "Ironforge. Alliance only. Turn in the Lightforge Boots, Legplates and Spaulders", "Alliance"),
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only. Choose this or another reward", "Horde"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or another reward"),
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. The quest wants 20 donated books. Choose this or another reward"),
    },
    mainhand = {
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Needs Blacksmithing"),
        item(7960, "Blacksmithing (Truesilver Champion)", "crafted", "Needs Blacksmithing"),
        item(250617, "Blacksmithing (Stormcarver)", "crafted", "Needs Blacksmithing. The plans need Revered with Timbermaw Hold"),
        item(9418, "Archaedas, Uldaman (Stoneslayer)", "dungeon", nil),
    },
    ranged = {
        item(249442, "Enchanting (Libram of Invocation)", "crafted", "Needs Enchanting; formula costs 120 Merchant's Favor"),
    },
} }

-- ============================================================
-- HUNTER
-- ============================================================
DB["HUNTER"] = {}
-- Marksmanship: classicwowforever.com/bis-list/marksmanship-hunter (checked 2026-11-08); weapons: Two-hander setup (not used: Dual wield); order = the site's, first pick first
DB["HUNTER"]["Marksmanship"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(11124, "Quest: Jammal'an the Prophet (Helm of Exile)", "quest", "Sunken Temple"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(15787, "Quest: High Chief Winterfall (Willow Band Hauberk)", "quest", "Winterspring"),
    },
    wrist = {
        item(18508, "Leatherworking (Swift Flight Bracers)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Pattern sold by Nergal in Un'Goro Crater"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Several enemies, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(15082, "Leatherworking (Heavy Scorpid Belt)", "crafted", "We don't know where the pattern drops"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Pattern drops from mobs in Un'Goro Crater. We don't know where the pattern drops"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Sold by Friz Frazzlespark, Riverglades (Disengagement Ring)", "world", nil),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only", "Horde"),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing; plans cost Merchant's Favor"),
        item(274419, "Sold by Dala Fairmaw, Mount Hyjal (Bear Poking Stick)", "world", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(10698, "Quest: Enchanted Azsharite Fel Weaponry (Enchanted Azsharite Felbane Staff)", "quest", "Stranglethorn Vale. Choose this or another Felbane weapon"),
    },
    ranged = {
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", "Schematic drops from Mossflayer Shadowhunter in Eastern Plaguelands"),
        item(16004, "Engineering (Dark Iron Rifle)", "crafted", "Schematic drops from Doomforge Craftsman in Blackrock Depths"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(17753, "Quest: Corruption of Earth and Seed (Verdant Keeper's Aim)", "quest", "Maraudon. Choose this or another Maraudon quest reward"),
    },
} }
-- Survival: classicwowforever.com/bis-list/survival-hunter (checked 2026-11-08); weapons: Dual wield setup (not used: Two-hander); order = the site's, first pick first
DB["HUNTER"]["Survival"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(21320, "Quest: Winterfall Activity (Vest of the Den Watcher)", "quest", "Blackmaw Hold"),
    },
    wrist = {
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Pattern sold by Nergal in Un'Goro Crater"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Several enemies, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Pattern drops from mobs in Un'Goro Crater. We don't know where the pattern drops"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Sold by Friz Frazzlespark, Riverglades (Disengagement Ring)", "world", nil),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only", "Horde"),
    },
    mainhand = {
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Plans drop from Quartermaster Zigris in Blackrock Spire"),
        item(250618, "Blacksmithing (Bagh Nakh)", "crafted", "Plans need Revered with Timbermaw Hold"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Plans drop from Foreman Marcrid in Western Plaguelands"),
        item(15814, "Quest: Hameya's Plea (Hameya's Slayer)", "quest", "Eastern Plaguelands"),
    },
    offhand = {
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood"),
        item(10697, "Quest: Enchanted Azsharite Fel Weaponry (Enchanted Azsharite Felbane Dagger)", "quest", "Stranglethorn Vale. Choose this or another Felbane weapon"),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(16007, "Engineering (Flawless Arcanite Rifle)", "crafted", "Schematic drops from Mossflayer Shadowhunter in Eastern Plaguelands"),
        item(16004, "Engineering (Dark Iron Rifle)", "crafted", "Schematic drops from Doomforge Craftsman in Blackrock Depths"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(17753, "Quest: Corruption of Earth and Seed (Verdant Keeper's Aim)", "quest", "Maraudon. Choose this or another Maraudon quest reward"),
    },
} }
-- Beast Mastery: classicwowforever.com/bis-list/beast-mastery-hunter (checked 2026-11-08); weapons: Two-hander setup (not used: Dual wield); order = the site's, first pick first
DB["HUNTER"]["Beast Mastery"] = { lvl60 = {
    head = {
        item(16677, "Darkmaster Gandling, Scholomance (Beaststalker's Cap)", "dungeon", nil),
        item(22013, "Quest: Saving the Best for Last (Beastmaster's Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15080, "Leatherworking (Heavy Scorpid Helm)", "crafted", "Pattern sold by Zannok Hidepiercer in Silithus"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(16679, "Overlord Wyrmthalak, Blackrock Spire (Beaststalker's Mantle)", "dungeon", nil),
        item(22016, "Quest: Anthion's Parting Words (Beastmaster's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Pattern drops from Anvilrage Marshal in Blackrock Depths"),
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16674, "General Drakkisath, Blackrock Spire (Beaststalker's Tunic)", "dungeon", nil),
        item(22060, "Quest: Saving the Best for Last (Beastmaster's Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Cap and Tunic"),
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Pattern sold by Plugger Spazzring in Blackrock Depths"),
        item(21320, "Quest: Winterfall Activity (Vest of the Den Watcher)", "quest", "Blackmaw Hold"),
    },
    wrist = {
        item(18508, "Leatherworking (Swift Flight Bracers)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
        item(22011, "Quest: An Earnest Proposition (Beastmaster's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Bindings plus the samples the quest asks for"),
        item(252570, "Leatherworking (Stalker's Mail Bracers)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(15077, "Leatherworking (Heavy Scorpid Bracers)", "crafted", nil),
    },
    hands = {
        item(16676, "War Master Voone, Blackrock Spire (Beaststalker's Gloves)", "dungeon", nil),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Pattern sold by Nergal in Un'Goro Crater"),
        item(15078, "Leatherworking (Heavy Scorpid Gauntlet)", "crafted", "Pattern drops from Blackrock Soldier in Burning Steppes"),
    },
    waist = {
        item(16680, "Several enemies, Blackrock Spire (Beaststalker's Belt)", "dungeon", nil),
        item(252588, "Leatherworking (Stalker's Mail Belt)", "crafted", "Needs Leatherworking; pattern costs Merchant's Favor"),
        item(22010, "Quest: Just Compensation (Beastmaster's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Belt and Gloves"),
        item(15082, "Leatherworking (Heavy Scorpid Belt)", "crafted", "We don't know where the pattern drops"),
        item(19125, "Quest: Fiery Menace! (Seared Mail Girdle)", "quest", "Searing Gorge"),
    },
    legs = {
        item(16678, "Baron Rivendare, Stratholme (Beaststalker's Pants)", "dungeon", nil),
        item(22017, "Quest: Anthion's Parting Words (Beastmaster's Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Pattern drops from Anvilrage Captain in Blackrock Depths"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Pattern drops from mobs in Un'Goro Crater. We don't know where the pattern drops"),
    },
    feet = {
        item(16675, "Nerub'enkan, Stratholme (Beaststalker's Boots)", "dungeon", nil),
        item(22061, "Quest: Anthion's Parting Words (Beastmaster's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Beaststalker's Boots, Pants and Mantle"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Pattern drops from Knot Thimblejack's Cache in Dire Maul"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(276202, "Sold by Friz Frazzlespark, Riverglades (Disengagement Ring)", "world", nil),
        item(275044, "Quest: Bloodmaster's Ring (Bloodsport Band)", "quest", "Riverglades. Horde only", "Horde"),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing; plans cost Merchant's Favor"),
        item(274419, "Sold by Dala Fairmaw, Mount Hyjal (Bear Poking Stick)", "world", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(10698, "Quest: Enchanted Azsharite Fel Weaponry (Enchanted Azsharite Felbane Staff)", "quest", "Stranglethorn Vale. Choose this or another Felbane weapon"),
    },
    ranged = {
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
-- Combat: classicwowforever.com/bis-list/combat-rogue (checked 2026-11-08); order = the site's, first pick first
DB["ROGUE"]["Combat"] = { lvl60 = {
    head = {
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Bring 25 Ogre Warbeads to Falrin Treeshaper. Choose this or Beads of Ogre Mojo"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", "Silithus. Needs Friendly with the Cenarion Circle. Choose this or Gloves of Earthen Power or Band of Earthen Wrath"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", "We don't know where the pattern drops"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Leatherworking 265. Nergal in Un'Goro Crater sells the pattern"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Leatherworking 290. The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Leatherworking 290. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \"The Swift\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    mainhand = {
        item(22384, "Blacksmithing (Persuader)", "crafted", "We don't know where the plans drop"),
        item(12798, "Blacksmithing (Annihilator)", "crafted", "Blacksmithing 300. The plans drop from Quartermaster Zigris in Blackrock Spire"),
        item(12797, "Blacksmithing (Frostguard)", "crafted", "Blacksmithing 300. The plans drop from Foreman Marcrid in the Western Plaguelands"),
        item(250618, "Blacksmithing (Bagh Nakh)", "crafted", "Blacksmithing 300. The plans need Revered with Timbermaw Hold"),
        item(18671, "Baron Charr, Un'Goro Crater (Baron Charr's Sceptre)", "world", nil),
    },
    offhand = {
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Assassination: classicwowforever.com/bis-list/assassination-rogue (checked 2026-11-08); order = the site's, first pick first
DB["ROGUE"]["Assassination"] = { lvl60 = {
    head = {
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Bring 25 Ogre Warbeads to Falrin Treeshaper. Choose this or Beads of Ogre Mojo"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", "Silithus. Needs Friendly with the Cenarion Circle. Choose this or Gloves of Earthen Power or Band of Earthen Wrath"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", "We don't know where the pattern drops"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Leatherworking 265. Nergal in Un'Goro Crater sells the pattern"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Leatherworking 290. The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Leatherworking 290. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \"The Swift\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    mainhand = {
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
    },
    offhand = {
        item(19166, "Blacksmithing (Black Amnesty)", "crafted", nil),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(15783, "Quest: Shy-Rotam (Beasthunter Dagger)", "quest", "Winterspring. Horde only. Choose this or Beaststalker Blade", "Horde"),
    },
    ranged = {
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }
-- Subtlety: classicwowforever.com/bis-list/subtlety-rogue (checked 2026-11-08); weapons: Dagger setup (not used: Mace, axe or sword); order = the site's, first pick first
DB["ROGUE"]["Subtlety"] = { lvl60 = {
    head = {
        item(22005, "Quest: Saving the Best for Last (Darkmantle Cap)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", "Leatherworking 255. The pattern drops from Jadefire Trickster in Felwood"),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", "Leatherworking 225. A trainer teaches it"),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Bring 25 Ogre Warbeads to Falrin Treeshaper. Choose this or Beads of Ogre Mojo"),
        item(20649, "Quest: Vyral the Vile (Sunprism Pendant)", "quest", "Silithus. Choose this or Desert Wind Gauntlets"),
    },
    shoulder = {
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22008, "Quest: Anthion's Parting Words (Darkmantle Spaulders)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(15822, "Quest: Runecloth (Shadowskin Spaulders)", "quest", "Blackmaw Hold. Bring 30 Runecloth to Meilosh"),
    },
    back = {
        item(21187, "Quest: Volunteer's Battlegear (Earthweave Cloak)", "quest", "Silithus. Needs Friendly with the Cenarion Circle. Choose this or Gloves of Earthen Power or Band of Earthen Wrath"),
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", "Leatherworking 300. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(22009, "Quest: Saving the Best for Last (Darkmantle Tunic)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Cap and Tunic. The chain runs through Lord Valthalak's summon in Blackrock Spire"),
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", "Leatherworking 280. The pattern drops from Spectral Researcher in Scholomance"),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Leatherworking 250. We don't know where the pattern drops"),
    },
    wrist = {
        item(22004, "Quest: An Earnest Proposition (Darkmantle Bracers)", "quest", "Ironforge or Orgrimmar. Turn in Shadowcraft Bracers, 20 gold and 15 Winterspring Blood Samples (Alliance) or Silithus Venom Samples (Horde)"),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon. Bring a Vial of Earth Song Water from Maraudon to Woodwyrd in Desolace"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(15084, "Leatherworking (Wicked Leather Bracers)", "crafted", "Leatherworking 240. The pattern drops from Legashi Rogue in Azshara"),
    },
    hands = {
        item(21278, "Leatherworking (Stormshroud Gloves)", "crafted", "We don't know where the pattern drops"),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22006, "Quest: Just Compensation (Darkmantle Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Leatherworking 265. Nergal in Un'Goro Crater sells the pattern"),
        item(15708, "Quest: A Final Blow (Blight Leather Gloves)", "quest", "Felwood"),
    },
    waist = {
        item(252474, "Leatherworking (Skulker's Leather Waistguard)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor"),
        item(22002, "Quest: Just Compensation (Darkmantle Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Belt and Gloves. A Supernatural Device and a Return to Deliana or Mokvar step come first"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "Leatherworking 265. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
        item(15088, "Leatherworking (Wicked Leather Belt)", "crafted", "Leatherworking 275. The pattern drops from Ghoul Ravener in Stratholme"),
    },
    legs = {
        item(22007, "Quest: Anthion's Parting Words (Darkmantle Pants)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Leatherworking 290. The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Leatherworking 260. Meilosh in Felwood sells the pattern for Timbermaw Hold reputation"),
    },
    feet = {
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", "Leatherworking 290. The pattern comes from Knot Thimblejack's Cache in Dire Maul"),
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", "Shadowcraft set piece. The Darkmantle quest takes it"),
        item(22003, "Quest: Anthion's Parting Words (Darkmantle Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Shadowcraft Boots, Pants and Spaulders. The Anthion chain comes first and includes a Dire Maul step"),
        item(9398, "Eric \"The Swift\", Uldaman (Worn Running Boots)", "dungeon", nil),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(21182, "Quest: Veteran's Battlegear (Band of Earthen Might)", "quest", "Silithus. Needs Honored with the Cenarion Circle"),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
        item(275831, "Quest: Tarnished Treasures (Highfeather Bangle)", "quest", "Mount Hyjal"),
        item(11862, "Quest: Bone-Bladed Weapons (White Bone Band)", "quest", "Orgrimmar. Horde only", "Horde"),
    },
    mainhand = {
        item(12783, "Blacksmithing (Heartseeker)", "crafted", "Blacksmithing 300. The plans drop from Cannon Master Willey in Stratholme"),
        item(15706, "Quest: The Remains of Trey Lightforge (Hunt Tracker Blade)", "quest", "Felwood. Choose this or Tidecrest Blade"),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
    },
    offhand = {
        item(17016, "Blacksmithing (Dark Iron Destroyer)", "crafted", nil),
        item(250616, "Blacksmithing (Bold Dirk)", "crafted", "Blacksmithing 270. Pexmit in Mount Hyjal sells the plans"),
        item(17738, "Celebras the Cursed, Maraudon (Claw of Celebras)", "dungeon", nil),
    },
    ranged = {
        item(20086, "Quest: Junkboxes Needed (Dusksteel Throwing Knife)", "quest", "Hillsbrad Foothills. Fahrad at Ravenholdt Manor wants 5 Heavy Junkboxes, which Rogues pickpocket from mobs of level 52 and up"),
        item(16992, "Quest: When Smokey Sings, I Get Violent (Smokey's Explosive Launcher)", "quest", "Eastern Plaguelands"),
        item(9412, "Galgann Firehammer, Uldaman (Galgann's Fireblaster)", "dungeon", nil),
    },
} }

-- ============================================================
-- PRIEST
-- ============================================================
DB["PRIEST"] = {}
-- Holy: classicwowforever.com/bis-list/holy-priest (checked 2026-11-08); weapons: Staff setup (not used: One-hand and off-hand); order = the site's, first pick first
DB["PRIEST"]["Holy"] = { lvl60 = {
    head = {
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "We don't know where the pattern drops"),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(7720, "High Inquisitor Whitemane, Scarlet Monastery (Whitemane's Chapeau)", "dungeon", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", "We don't know where the pattern drops"),
        item(254049, "Tailoring (Nethergeld Shoulders)", "crafted", "Needs Tailoring"),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(14154, "Tailoring (Truefaith Vestments)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
    },
    wrist = {
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", nil),
        item(19116, "Quest: Separation Anxiety (Greenleaf Handwraps)", "quest", "The Hinterlands. Horde only. Choose this or the other Separation Anxiety reward", "Horde"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple. Choose this or the other Jammal'an the Prophet rewards"),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", nil),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
    },
    ring1 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    ring2 = {
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(249454, "Enchanting (Dreamstaff)", "crafted", "Needs Enchanting"),
        item(17743, "Quest: Corruption of Earth and Seed (Resurgence Rod)", "quest", "Maraudon. Choose this or the other Corruption of Earth and Seed rewards"),
        item(279853, "Quest: Eye of Mugg (Stick No Rock)", "quest", "Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Discipline: classicwowforever.com/bis-list/discipline-priest (checked 2026-11-08); weapons: Staff setup (not used: One-hand and off-hand); order = the site's, first pick first
DB["PRIEST"]["Discipline"] = { lvl60 = {
    head = {
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "We don't know where the pattern drops"),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(7720, "High Inquisitor Whitemane, Scarlet Monastery (Whitemane's Chapeau)", "dungeon", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
    },
    shoulder = {
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", "We don't know where the pattern drops"),
        item(254049, "Tailoring (Nethergeld Shoulders)", "crafted", "Needs Tailoring"),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
    },
    back = {
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
        item(14154, "Tailoring (Truefaith Vestments)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
    },
    wrist = {
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", nil),
        item(19116, "Quest: Separation Anxiety (Greenleaf Handwraps)", "quest", "The Hinterlands. Horde only. Choose this or the other Separation Anxiety reward", "Horde"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", nil),
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple. Choose this or the other Jammal'an the Prophet rewards"),
    },
    feet = {
        item(275609, "Tailoring (Swarmtender's Footpads)", "crafted", nil),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
    },
    ring1 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale"),
    },
    ring2 = {
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273031, "Arcane Anomaly, City of Dalaran (Runemender's Seal)", "dungeon", nil),
    },
    trinket1 = {
        item(10659, "Quest: Heroes of Old (Shard of the Splithooves)", "quest", "Blasted Lands"),
    },
    mainhand = {
        item(249454, "Enchanting (Dreamstaff)", "crafted", "Needs Enchanting"),
        item(17743, "Quest: Corruption of Earth and Seed (Resurgence Rod)", "quest", "Maraudon. Choose this or the other Corruption of Earth and Seed rewards"),
        item(279853, "Quest: Eye of Mugg (Stick No Rock)", "quest", "Krol'dok Stronghold. Choose this or the other Eye of Mugg rewards"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Shadow: classicwowforever.com/bis-list/shadow-priest (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["PRIEST"]["Shadow"] = { lvl60 = {
    head = {
        item(9470, "Shadowpriest Sezz'ziz, Zul'Farrak (Bad Mojo Mask)", "dungeon", nil),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "We don't know where the pattern drops"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(22080, "Quest: Saving the Best for Last (Virtuous Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
    },
    neck = {
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(14112, "Tailoring (Felcloth Shoulders)", "crafted", "We don't know where the pattern drops"),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring"),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(22082, "Quest: Anthion's Parting Words (Virtuous Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(19121, "Quest: Wanted: Vile Priestess Hexx and Her Minions (Deep Woodlands Cloak)", "quest", "The Hinterlands. Horde only. Choose this or the other quest reward", "Horde"),
    },
    chest = {
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", nil),
        item(14106, "Tailoring (Felcloth Robe)", "crafted", "We don't know where the pattern drops"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(22083, "Quest: Saving the Best for Last (Virtuous Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Crown and Robe"),
    },
    wrist = {
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Needs Tailoring"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(9448, "Electrocutioner 6000, Gnomeregan (Spidertank Oilrag)", "dungeon", nil),
    },
    hands = {
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", nil),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "We don't know where the pattern drops"),
        item(10023, "Tailoring (Shadoweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(254087, "Tailoring (Black Waistcord)", "crafted", "Needs Tailoring"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(14107, "Tailoring (Felcloth Pants)", "crafted", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(22085, "Quest: Anthion's Parting Words (Virtuous Skirt)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    feet = {
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(22084, "Quest: Anthion's Parting Words (Virtuous Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Devout Sandals, Skirt and Mantle"),
    },
    ring1 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Choose this or the other Willix the Importer rewards"),
    },
    ring2 = {
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
        item(9622, "Quest: Jarl Needs a Blade (Reedknot Ring)", "quest", "Dustwallow Marsh. Choose this or the other Jarl Needs a Blade reward"),
    },
    mainhand = {
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
        item(15863, "Quest: Return to Tinkee (Grave Scepter)", "quest", "Winterspring. Choose this or Blitzcleaver"),
        item(7714, "Arcanist Doan, Scarlet Monastery (Hypnotic Blade)", "dungeon", nil),
    },
    offhand = {
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
        item(7685, "Bloodmage Thalnos, Scarlet Monastery (Orb of the Forgotten Seer)", "dungeon", nil),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting"),
    },
    ranged = {
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }

-- ============================================================
-- SHAMAN
-- ============================================================
DB["SHAMAN"] = {}
-- Restoration: classicwowforever.com/bis-list/restoration-shaman (checked 2026-11-08); weapons: One-hand and shield setup (not used: Staff); order = the site's, first pick first
DB["SHAMAN"]["Restoration"] = { lvl60 = {
    head = {
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(16667, "Darkmaster Gandling, Scholomance (Coif of Elements)", "dungeon", nil),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "We don't know where the pattern drops"),
        item(22097, "Quest: Saving the Best for Last (Coif of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Coif", "Horde"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(20685, "Lord Skwol, Silithus (Wavefront Necklace)", "world", "Summoned boss in Silithus; needs a group"),
    },
    shoulder = {
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
        item(19507, "High Inquisitor Fairbanks, Scarlet Monastery (Inquisitor's Shawl)", "dungeon", nil),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(273825, "Bazil Thredd, The Stockade (Red Wool Cloak)", "dungeon", nil),
    },
    chest = {
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(18486, "Tailoring (Mooncloth Robe)", "crafted", nil),
        item(15047, "Leatherworking (Red Dragonscale Breastplate)", "crafted", "Dragonscale Leatherworking recipe. The pattern drops from General Drakkisath"),
        item(22102, "Quest: Saving the Best for Last (Vest of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Vest", "Horde"),
    },
    wrist = {
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(22095, "Quest: An Earnest Proposition (Bindings of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Bindings", "Horde"),
    },
    hands = {
        item(20296, "Leatherworking (Green Dragonscale Gauntlets)", "crafted", "Dragonscale Leatherworking recipe"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(10771, "Mordresh Fire Eye, Razorfen Downs (Deathmage Sash)", "dungeon", nil),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(11123, "Quest: Jammal'an the Prophet (Rainstrider Leggings)", "quest", "Sunken Temple"),
        item(20295, "Leatherworking (Blue Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
    },
    feet = {
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon"),
        item(270081, "Quest: Bring the End (Purified Ring)", "quest", "Razorfen Downs. Alliance quest: Bring the Light"),
    },
    trinket1 = {
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale"),
        item(274761, "Everlook - Honored (Parachute-Priest Pager)", "reputation", "Sold by Zippie Fizzbolt, Winterspring"),
    },
    mainhand = {
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", nil),
    },
    offhand = {
        item(9403, "Olaf, Uldaman (Battered Viking Shield)", "dungeon", nil),
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor and needs Friendly standing"),
        item(11262, "Quest: In the Name of the Light (Orb of Lorica)", "quest", "Scarlet Monastery. Alliance only", "Alliance"),
        item(17508, "Quest: Compendium of the Fallen (Forcestone Buckler)", "quest", "Scarlet Monastery. Horde only", "Horde"),
    },
    ranged = {
        item(249398, "Enchanting (Polished Driftwood Icon)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor"),
    },
} }
-- Elemental: classicwowforever.com/bis-list/elemental-shaman (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["SHAMAN"]["Elemental"] = { lvl60 = {
    head = {
        item(16667, "Darkmaster Gandling, Scholomance (Coif of Elements)", "dungeon", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(10033, "Tailoring (Red Mageweave Headband)", "crafted", "We don't know where the pattern drops"),
        item(22097, "Quest: Saving the Best for Last (Coif of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Coif", "Horde"),
    },
    neck = {
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23169, "Scorn, Scarlet Monastery (Scorn's Icy Choker)", "dungeon", nil),
    },
    shoulder = {
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(15067, "Leatherworking (Ironfeather Shoulders)", "crafted", "Tribal Leatherworking recipe"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(8216, "Leatherworking (Big Voodoo Cloak)", "crafted", "We don't know where the pattern drops"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", nil),
    },
    chest = {
        item(16666, "General Drakkisath, Blackrock Spire (Vest of Elements)", "dungeon", nil),
        item(15048, "Leatherworking (Blue Dragonscale Breastplate)", "crafted", "Dragonscale Leatherworking recipe"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
    },
    wrist = {
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(15092, "Leatherworking (Runic Leather Bracers)", "crafted", nil),
        item(22095, "Quest: An Earnest Proposition (Bindings of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Bindings", "Horde"),
    },
    hands = {
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(16672, "Pyroguard Emberseer, Blackrock Spire (Gauntlets of Elements)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(20295, "Leatherworking (Blue Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(15095, "Leatherworking (Runic Leather Pants)", "crafted", "We don't know where the pattern drops"),
        item(16668, "Baron Rivendare, Stratholme (Kilt of Elements)", "dungeon", nil),
    },
    feet = {
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16670, "Highlord Omokk, Blackrock Spire (Boots of Elements)", "dungeon", nil),
        item(20641, "Quest: Southsea Shakedown (Southsea Mojo Boots)", "quest", "Tanaris"),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(270081, "Quest: Bring the End (Purified Ring)", "quest", "Razorfen Downs. Alliance quest: Bring the Light"),
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon"),
        item(270109, "Quest: Facing Negolash (Smotts' Pinky Ring)", "quest", "Stranglethorn Vale"),
    },
    trinket1 = {
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale"),
        item(274760, "Everlook - Honored (Everlook Delivery Bot)", "reputation", "Sold by Zippie Fizzbolt, Winterspring"),
    },
    mainhand = {
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
        item(15863, "Quest: Return to Tinkee (Grave Scepter)", "quest", "Winterspring"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor and needs Friendly standing"),
        item(276204, "Powderfuse - Honored (Thrash's Trash)", "reputation", "Sold by Friz Frazzlespark, Riverglades"),
    },
    ranged = {
        item(249398, "Enchanting (Polished Driftwood Icon)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor"),
        item(228176, "Enchanting (Totem of Thunder)", "crafted", "Needs Enchanting. The formula costs Merchant's Favor and needs Honored standing"),
    },
} }
-- Enhancement: classicwowforever.com/bis-list/enhancement-shaman (checked 2026-11-08); order = the site's, first pick first
DB["SHAMAN"]["Enhancement"] = { lvl60 = {
    head = {
        item(7719, "Herod, Scarlet Monastery (Raging Berserker's Helm)", "dungeon", nil),
        item(274291, "Bloodmage Thalnos, Scarlet Monastery (Polished Skullcap)", "dungeon", nil),
        item(3837, "Blacksmithing (Golden Scale Coif)", "crafted", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul"),
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
    },
    shoulder = {
        item(19050, "Tailoring (Mantle of the Timbermaw)", "crafted", nil),
        item(15051, "Leatherworking (Black Dragonscale Shoulders)", "crafted", "Dragonscale Leatherworking recipe"),
        item(252568, "Leatherworking (Skirmisher's Mail Shoulders)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor and needs Friendly standing"),
        item(11871, "Quest: Calm Before the Storm (Snarkshaw Spaulders)", "quest", "Darnassus or Orgrimmar"),
        item(22101, "Quest: Anthion's Parting Words (Pauldrons of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Pauldrons", "Horde"),
    },
    back = {
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
        item(5257, "Nimar the Slayer, Arathi Highlands (Dark Hooded Cape)", "world", nil),
    },
    chest = {
        item(15050, "Leatherworking (Black Dragonscale Breastplate)", "crafted", "Dragonscale Leatherworking recipe"),
        item(252599, "Leatherworking (Supple Scorpid Vest)", "crafted", nil),
        item(22102, "Quest: Saving the Best for Last (Vest of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Vest", "Horde"),
    },
    wrist = {
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon"),
        item(252572, "Leatherworking (Skirmisher's Mail Bracers)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor and needs Honored standing"),
    },
    hands = {
        item(12632, "Leatherworking (Storm Gauntlets)", "crafted", "We don't know where the pattern drops"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", "Tribal Leatherworking recipe"),
        item(15823, "Quest: Runecloth (Bricksteel Gauntlets)", "quest", "Blackmaw Hold"),
        item(7724, "Scarlet Commander Mograine, Scarlet Monastery (Gauntlets of Divinity)", "dungeon", nil),
        item(22099, "Quest: Just Compensation (Gauntlets of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Gauntlets", "Horde"),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(10768, "Ragglesnout, Razorfen Downs (Boar Champion's Belt)", "dungeon", nil),
        item(21312, "Quest: Timbermaw Ally (Belt of the Den Watcher)", "quest", "Felwood"),
        item(19043, "Leatherworking (Heavy Timbermaw Belt)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(22098, "Quest: Just Compensation (Cord of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Cord", "Horde"),
    },
    legs = {
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "Tribal Leatherworking recipe. The pattern needs Friendly with Timbermaw Hold"),
        item(15052, "Leatherworking (Black Dragonscale Leggings)", "crafted", "Dragonscale Leatherworking recipe"),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "Tribal Leatherworking recipe. We don't know where the pattern drops"),
        item(22100, "Quest: Anthion's Parting Words (Kilt of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Kilt", "Horde"),
    },
    feet = {
        item(252578, "Leatherworking (Skirmisher's Mail Sabatons)", "crafted", "Needs Leatherworking. The pattern costs Merchant's Favor and needs Honored standing"),
        item(275618, "Leatherworking (Scalegut Treaders)", "crafted", "The pattern needs Honored with Cenarion Circle"),
        item(16984, "Leatherworking (Black Dragonscale Boots)", "crafted", "Dragonscale recipe. The pattern needs Honored with Thorium Brotherhood"),
        item(22096, "Quest: Anthion's Parting Words (Boots of The Five Thunders)", "quest", "Orgrimmar. Horde only. Turn in the Elements Boots", "Horde"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak"),
        item(274754, "Gadgetzan - Honored (Suspicious Spare Part)", "reputation", "Sold by Rettrick, Tanaris"),
    },
    trinket1 = {
        item(270226, "Quest: Message in a Bottle (Golden Banana)", "quest", "Stranglethorn Vale"),
        item(274759, "Everlook - Honored (Everlook Pathcarver)", "reputation", "Sold by Zippie Fizzbolt, Winterspring"),
    },
    trinket2 = {
        item(17774, "Quest: The Pariah's Instructions (Mark of the Chosen)", "quest", "Maraudon"),
        item(274760, "Everlook - Honored (Everlook Delivery Bot)", "reputation", "Sold by Zippie Fizzbolt, Winterspring"),
    },
    mainhand = {
        item(9449, "Crowd Pummeler 9-60, Gnomeregan (Manual Crowd Pummeler)", "dungeon", nil),
        item(12784, "Blacksmithing (Arcanite Reaper)", "crafted", "Master Axesmith recipe. The plans drop from Bannok Grimaxe in Blackrock Spire"),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Master Hammersmith recipe. The plans drop from Maleki the Pallid in Stratholme"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(9413, "Archaedas, Uldaman (The Rockpounder)", "dungeon", nil),
    },
} }

-- ============================================================
-- MAGE
-- ============================================================
DB["MAGE"] = {}
-- Arcane: classicwowforever.com/bis-list/arcane-mage (checked 2026-11-08); weapons: Staff setup (not used: One-hand and off-hand); order = the site's, first pick first
DB["MAGE"]["Arcane"] = { lvl60 = {
    head = {
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254057, "Tailoring (Nethershine Shoulders)", "crafted", "Needs Tailoring"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Needs Tailoring"),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(17775, "Quest: Twisted Evils (Acumen Robes)", "quest", "Maraudon. One of four quest rewards"),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(16683, "Several enemies, Blackrock Spire (Magister's Bindings)", "dungeon", nil),
        item(254069, "Tailoring (Nethershine Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(16684, "Several enemies, Scholomance (Magister's Gloves)", "dungeon", nil),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "We don't know where the pattern drops"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(13863, "Tailoring (Runecloth Gloves)", "crafted", nil),
    },
    waist = {
        item(22062, "Quest: Just Compensation (Sorcerer's Belt)", "quest", "Ironforge or Orgrimmar"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "The pattern comes from a chest in Dire Maul"),
        item(254089, "Tailoring (Golden Waistcord)", "crafted", "Needs Tailoring"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
    },
    legs = {
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
    },
    feet = {
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254115, "Tailoring (Golden Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    mainhand = {
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(275648, "Quest: Twisted Tools (Purified Gnarlybark Staff)", "quest", "Mount Hyjal. One of three quest rewards"),
        item(249453, "Enchanting (Radiant Staff)", "crafted", "Needs Enchanting"),
        item(274420, "Barkskin Burrow - Revered (Wisepaw Totem)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }
-- Fire: classicwowforever.com/bis-list/fire-mage (checked 2026-11-08); weapons: Staff setup (not used: One-hand and off-hand); order = the site's, first pick first
DB["MAGE"]["Fire"] = { lvl60 = {
    head = {
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
    },
    neck = {
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(254053, "Tailoring (Netherflame Shoulders)", "crafted", "Needs Tailoring"),
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", nil),
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Needs Tailoring"),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(10042, "Tailoring (Cindercloth Robe)", "crafted", nil),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(254065, "Tailoring (Netherflame Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(18408, "Tailoring (Inferno Gloves)", "crafted", "The pattern comes from a chest in Dire Maul"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "We don't know where the pattern drops"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "The pattern comes from a chest in Dire Maul"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254085, "Tailoring (Fiery Waistcord)", "crafted", "Needs Tailoring"),
    },
    legs = {
        item(14045, "Tailoring (Cindercloth Pants)", "crafted", nil),
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
    },
    feet = {
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254111, "Tailoring (Fiery Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    mainhand = {
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(275648, "Quest: Twisted Tools (Purified Gnarlybark Staff)", "quest", "Mount Hyjal. One of three quest rewards"),
        item(249453, "Enchanting (Radiant Staff)", "crafted", "Needs Enchanting"),
        item(274420, "Barkskin Burrow - Revered (Wisepaw Totem)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }
-- Frost: classicwowforever.com/bis-list/frost-mage (checked 2026-11-08); weapons: Staff setup (not used: One-hand and off-hand); order = the site's, first pick first
DB["MAGE"]["Frost"] = { lvl60 = {
    head = {
        item(22065, "Quest: Saving the Best for Last (Sorcerer's Crown)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
    },
    neck = {
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(15856, "Quest: Hidden Treasures (Archlight Talisman)", "quest", "Eastern Plaguelands"),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(254051, "Tailoring (Netherfroth Shoulders)", "crafted", "Needs Tailoring"),
        item(22068, "Quest: Anthion's Parting Words (Sorcerer's Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(19059, "Tailoring (Argent Shoulders)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", nil),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Made by Leatherworkers; the pattern comes from a chest in Dire Maul"),
    },
    chest = {
        item(14152, "Tailoring (Robe of the Archmage)", "crafted", "Needs Tailoring"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", nil),
        item(22069, "Quest: Saving the Best for Last (Sorcerer's Robes)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Crown and Robes together; you get both"),
        item(14128, "Tailoring (Wizardweave Robe)", "crafted", nil),
    },
    wrist = {
        item(254063, "Tailoring (Netherfroth Cuffs)", "crafted", "Needs Tailoring"),
        item(22063, "Quest: An Earnest Proposition (Sorcerer's Bindings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Bindings and Winterspring Blood Samples"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater"),
    },
    hands = {
        item(22066, "Quest: Just Compensation (Sorcerer's Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Belt and Gloves together; you get both"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "We don't know where the pattern drops"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Winterspring. One of four quest rewards"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "The pattern comes from a chest in Dire Maul"),
        item(22062, "Quest: Just Compensation (Sorcerer's Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Belt and Gloves together; you get both"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254083, "Tailoring (Frothing Waistcord)", "crafted", "Needs Tailoring"),
    },
    legs = {
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
        item(22067, "Quest: Anthion's Parting Words (Sorcerer's Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
    },
    feet = {
        item(22064, "Quest: Anthion's Parting Words (Sorcerer's Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Magister's Boots, Leggings and Mantle together; you get all three"),
        item(254109, "Tailoring (Frothing Sandals)", "crafted", "Needs Tailoring"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(17768, "Quest: Vyletongue Corruption (Woodseed Hoop)", "quest", "Maraudon. One of three quest rewards"),
        item(270081, "Quest: Bring the Light (Purified Ring)", "quest", "Razorfen Downs. The Horde quest is Bring the End. One of three quest rewards"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    mainhand = {
        item(18082, "Witch Doctor Zum'rah, Zul'Farrak (Zum'rah's Vexing Cane)", "dungeon", nil),
        item(275648, "Quest: Twisted Tools (Purified Gnarlybark Staff)", "quest", "Mount Hyjal. One of three quest rewards"),
        item(249453, "Enchanting (Radiant Staff)", "crafted", "Needs Enchanting"),
        item(274420, "Barkskin Burrow - Revered (Wisepaw Totem)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
        item(9654, "Quest: The Morrow Stone (Cairnstone Sliver)", "quest", "Feralas. Alliance only", "Alliance"),
    },
} }

-- ============================================================
-- WARLOCK
-- ============================================================
DB["WARLOCK"] = {}
-- Destruction: classicwowforever.com/bis-list/destruction-warlock (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["WARLOCK"]["Destruction"] = { lvl60 = {
    head = {
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", "You turn this in for the Deathmist Mask"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", "Needs Tailoring. Trainer recipe"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", "You turn this in for the Deathmist Mantle"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(254053, "Tailoring (Netherflame Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    chest = {
        item(14153, "Tailoring (Robe of the Void)", "crafted", "Needs Tailoring. The pattern drops from Darkmaster Gandling"),
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
    },
    wrist = {
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(16703, "Several enemies, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254065, "Tailoring (Netherflame Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(16705, "Several enemies, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
        item(18408, "Tailoring (Inferno Gloves)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    waist = {
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(254085, "Tailoring (Fiery Waistcord)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    legs = {
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", "You turn this in for the Deathmist Leggings"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14045, "Tailoring (Cindercloth Pants)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
    },
    feet = {
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", "You turn this in for the Deathmist Sandals"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(254111, "Tailoring (Fiery Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    mainhand = {
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Affliction: classicwowforever.com/bis-list/affliction-warlock (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["WARLOCK"]["Affliction"] = { lvl60 = {
    head = {
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", "You turn this in for the Deathmist Mask"),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", "You turn this in for the Deathmist Mantle"),
        item(14112, "Tailoring (Felcloth Shoulders)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    chest = {
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", "Needs Tailoring. Pattern drops from Cobalt Mageweavers in Winterspring"),
        item(14106, "Tailoring (Felcloth Robe)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
    },
    wrist = {
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(16703, "Several enemies, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(16705, "Several enemies, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
    },
    waist = {
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(254087, "Tailoring (Black Waistcord)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    legs = {
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", "You turn this in for the Deathmist Leggings"),
        item(14107, "Tailoring (Felcloth Pants)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", "Needs Tailoring. Pattern drops from Spectral Citizens in Stratholme"),
    },
    feet = {
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", "You turn this in for the Deathmist Sandals"),
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    mainhand = {
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }
-- Demonology: classicwowforever.com/bis-list/demonology-warlock (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["WARLOCK"]["Demonology"] = { lvl60 = {
    head = {
        item(22074, "Quest: Saving the Best for Last (Deathmist Mask)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", "You turn this in for the Deathmist Mask"),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", "Same boss as the Dreadmist Mask"),
        item(14111, "Tailoring (Felcloth Hood)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(22657, "Quest: Epic Armaments of Battle - Friend of the Dawn (Amulet of the Dawn)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Talisman of Ascendance"),
    },
    shoulder = {
        item(22073, "Quest: Anthion's Parting Words (Deathmist Mantle)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", "You turn this in for the Deathmist Mantle"),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(254055, "Tailoring (Netherpearl Shoulders)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. Pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", "Needs Leatherworking. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
        item(14044, "Tailoring (Cindercloth Cloak)", "crafted", "Needs Tailoring. Pattern drops in Burning Steppes"),
    },
    chest = {
        item(14153, "Tailoring (Robe of the Void)", "crafted", "Needs Tailoring. The pattern drops from Darkmaster Gandling"),
        item(22075, "Quest: Saving the Best for Last (Deathmist Robe)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Mask and Robe"),
        item(16700, "General Drakkisath, Blackrock Spire (Dreadmist Robe)", "dungeon", "You turn this in for the Deathmist Robe"),
        item(14136, "Tailoring (Robe of Winter Night)", "crafted", "Needs Tailoring. Pattern drops from Cobalt Mageweavers in Winterspring"),
    },
    wrist = {
        item(22071, "Quest: An Earnest Proposition (Deathmist Bracers)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Bracers with Winterspring blood or Silithus venom samples and gold"),
        item(16703, "Several enemies, Blackrock Spire (Dreadmist Bracers)", "dungeon", nil),
        item(11917, "Quest: Shizzle's Flyer (Shizzle's Nozzle Wiper)", "quest", "Un'Goro Crater. Field quest at Marshal's Refuge"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", "Needs Tailoring. Pattern is sold in Mount Hyjal"),
        item(254067, "Tailoring (Netherpearl Cuffs)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    hands = {
        item(22077, "Quest: Just Compensation (Deathmist Wraps)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(16705, "Several enemies, Scholomance (Dreadmist Wraps)", "dungeon", nil),
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold. Quest from Salfa, outside Timbermaw Hold in Winterspring"),
        item(14146, "Tailoring (Gloves of Spell Mastery)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
        item(18407, "Tailoring (Felcloth Gloves)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    waist = {
        item(22070, "Quest: Just Compensation (Deathmist Belt)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Belt and Wraps"),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", "Needs Tailoring. Pattern is in Knot Thimblejack's Cache, Dire Maul"),
    },
    legs = {
        item(22072, "Quest: Anthion's Parting Words (Deathmist Leggings)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", "You turn this in for the Deathmist Leggings"),
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", "Needs Tailoring. Pattern drops from Spectral Citizens in Stratholme"),
    },
    feet = {
        item(22076, "Quest: Anthion's Parting Words (Deathmist Sandals)", "quest", "Ironforge or Orgrimmar. Turn in the Dreadmist Sandals, Leggings and Mantle"),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", "You turn this in for the Deathmist Sandals"),
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(254113, "Tailoring (Black Sandals)", "crafted", "Needs Tailoring. Pattern costs Merchant's Favor"),
    },
    ring1 = {
        item(281635, "Quest: Greater Friend of the Library (Philanthropist's Ring)", "quest", "Stormwind City or Undercity. Hand in books to the librarian. Choose this or Field Researcher's Loop"),
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(20682, "Prince Skaldrenox, Silithus (Elemental Focus Band)", "world", "Unique. Summoned boss in Silithus; needs a group"),
    },
    ring2 = {
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Dungeon quest. Choose this or the other Willix rings"),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(22678, "Quest: Epic Armaments of Battle - Friend of the Dawn (Talisman of Ascendance)", "quest", "Eastern Plaguelands. Argent Dawn quest. Choose this or Amulet of the Dawn"),
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", "Level 24 drop; adds a little Shadow damage to each spell"),
    },
    mainhand = {
        item(22383, "Blacksmithing (Sageblade)", "crafted", "Needs Blacksmithing. We don't know where the plans drop"),
        item(22688, "Quest: Superior Armaments of Battle - Friend of the Dawn (Verimonde's Last Resort)", "quest", "Eastern Plaguelands. Argent Dawn quest; costs fewer Insignias at higher standing. Unique"),
        item(20647, "Quest: Wanted - Deathclasp, Terror of the Sands (Black Crystal Dagger)", "quest", "Silithus. Unique. Choose this or Sandstrider's Mark"),
    },
    offhand = {
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Elite quest at Fire Plume Ridge. Choose this or Linken's Sword of Mastery"),
        item(10770, "Mordresh Fire Eye, Razorfen Downs (Mordresh's Lifeless Skull)", "dungeon", nil),
    },
    ranged = {
        item(249385, "Enchanting (Brilliant Wand)", "crafted", "Needs Enchanting. Formula costs Merchant's Favor"),
        item(16993, "Quest: When Smokey Sings, I Get Violent (Smokey's Fireshooter)", "quest", "Eastern Plaguelands. Choose this or Smokey's Explosive Launcher"),
        item(10766, "Plaguemaw the Rotting, Razorfen Downs (Plaguerot Sprig)", "dungeon", nil),
    },
} }

-- ============================================================
-- DRUID
-- ============================================================
DB["DRUID"] = {}
-- Balance: classicwowforever.com/bis-list/balance-druid (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["DRUID"]["Balance"] = { lvl60 = {
    head = {
        item(16698, "Darkmaster Gandling, Scholomance (Dreadmist Mask)", "dungeon", nil),
        item(16686, "Darkmaster Gandling, Scholomance (Magister's Crown)", "dungeon", nil),
        item(270099, "Quest: Divino-matic Rod (Magister Cowl)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Masons Fraternity Ring"),
        item(10041, "Tailoring (Dreamweave Circlet)", "crafted", nil),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
        item(7722, "High Inquisitor Whitemane, Scarlet Monastery (Triune Amulet)", "dungeon", nil),
    },
    shoulder = {
        item(15067, "Leatherworking (Ironfeather Shoulders)", "crafted", nil),
        item(16689, "Ras Frostwhisper, Scholomance (Magister's Mantle)", "dungeon", nil),
        item(16701, "Jandice Barov, Scholomance (Dreadmist Mantle)", "dungeon", nil),
        item(252537, "Leatherworking (Skycaller's Leather Shoulders)", "crafted", "Needs Leatherworking"),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. The pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(279855, "Quest: Tome of Twilight (Torn Cultist Cloak)", "quest", "Krol'dok Stronghold. Alliance only", "Alliance"),
    },
    chest = {
        item(16688, "General Drakkisath, Blackrock Spire (Magister's Robes)", "dungeon", nil),
        item(15066, "Leatherworking (Ironfeather Breastplate)", "crafted", nil),
        item(8349, "Leatherworking (Feathered Breastplate)", "crafted", nil),
    },
    wrist = {
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
        item(252542, "Leatherworking (Skycaller's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(15092, "Leatherworking (Runic Leather Bracers)", "crafted", nil),
    },
    hands = {
        item(21318, "Quest: Winterfall Activity (Earth Warder's Gloves)", "quest", "Blackmaw Hold"),
        item(10019, "Tailoring (Dreamweave Gloves)", "crafted", nil),
        item(13863, "Tailoring (Runecloth Gloves)", "crafted", nil),
        item(22110, "Quest: Just Compensation (Feralheart Gloves)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Gloves"),
    },
    waist = {
        item(18405, "Tailoring (Belt of the Archmage)", "crafted", nil),
        item(19162, "Leatherworking (Corehound Belt)", "crafted", nil),
        item(17755, "Lord Vyletongue, Maraudon (Satyrmane Sash)", "dungeon", nil),
        item(252476, "Leatherworking (Skycaller's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(18504, "Leatherworking (Girdle of Insight)", "crafted", nil),
    },
    legs = {
        item(16687, "Baron Rivendare, Stratholme (Magister's Leggings)", "dungeon", nil),
        item(16699, "Baron Rivendare, Stratholme (Dreadmist Leggings)", "dungeon", nil),
        item(14144, "Tailoring (Ghostweave Pants)", "crafted", nil),
    },
    feet = {
        item(16682, "Hearthsinger Forresten, Stratholme (Magister's Boots)", "dungeon", nil),
        item(252471, "Leatherworking (Skycaller's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(16704, "Baroness Anastari, Stratholme (Dreadmist Sandals)", "dungeon", nil),
        item(22107, "Quest: Anthion's Parting Words (Feralheart Boots)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Boots"),
    },
    ring1 = {
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Choose one Willix the Importer ring"),
    },
    ring2 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    trinket1 = {
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    mainhand = {
        item(9419, "Galgann Firehammer, Uldaman (Galgann's Firehammer)", "dungeon", nil),
        item(15863, "Quest: Return to Tinkee (Grave Scepter)", "quest", "Winterspring"),
        item(7714, "Arcanist Doan, Scarlet Monastery (Hypnotic Blade)", "dungeon", nil),
        item(6691, "Agathelos the Raging, Razorfen Kraul (Swinetusk Shank)", "dungeon", nil),
    },
    offhand = {
        item(7685, "Bloodmage Thalnos, Scarlet Monastery (Orb of the Forgotten Seer)", "dungeon", nil),
        item(11904, "Quest: It's Dangerous to Go Alone (Spirit of Aquementas)", "quest", "Un'Goro Crater. Group quest; choose this or Linken's Sword of Mastery"),
        item(249455, "Enchanting (Truesilver Conduit)", "crafted", "Needs Enchanting"),
        item(273027, "Shadetooth, Excavation Site: Wetlands (Raptor's Gaze)", "dungeon", nil),
    },
    ranged = {
        item(249441, "Enchanting (Talons of Wrath)", "crafted", "Needs Enchanting"),
        item(249396, "Enchanting (Mystic Mushroom)", "crafted", "Needs Enchanting"),
    },
} }
-- Restoration: classicwowforever.com/bis-list/restoration-druid (checked 2026-11-08); weapons: One-hand and off-hand setup (not used: Staff); order = the site's, first pick first
DB["DRUID"]["Restoration"] = { lvl60 = {
    head = {
        item(16693, "Darkmaster Gandling, Scholomance (Devout Crown)", "dungeon", nil),
        item(16720, "Darkmaster Gandling, Scholomance (Wildheart Cowl)", "dungeon", nil),
        item(9534, "Quest: Divino-matic Rod (Engineer's Guild Headpiece)", "quest", "Zul'Farrak. Choose this or Magister Cowl or Masons Fraternity Ring"),
        item(14140, "Tailoring (Mooncloth Circlet)", "crafted", "Needs Tailoring. We don't know where the pattern drops"),
    },
    neck = {
        item(22149, "Quest: Falrin's Vendetta (Beads of Ogre Mojo)", "quest", "Dire Maul. Choose this or Beads of Ogre Might"),
        item(10769, "Mordresh Fire Eye, Razorfen Downs (Glowing Eye of Mordresh)", "dungeon", nil),
        item(23125, "Balzaphon, Stratholme (Chains of the Lich)", "dungeon", nil),
    },
    shoulder = {
        item(16718, "Gizrul the Slavener, Blackrock Spire (Wildheart Spaulders)", "dungeon", nil),
        item(15061, "Leatherworking (Living Shoulders)", "crafted", nil),
        item(14139, "Tailoring (Mooncloth Shoulders)", "crafted", "We don't know where the pattern drops"),
        item(16695, "Solakar Flamewreath, Blackrock Spire (Devout Mantle)", "dungeon", nil),
    },
    back = {
        item(13860, "Tailoring (Runecloth Cloak)", "crafted", "Needs Tailoring. The pattern is sold in Moonglade"),
        item(18510, "Leatherworking (Hide of the Wild)", "crafted", nil),
        item(11873, "Quest: Ancient Spirit (Ethereal Mist Cape)", "quest", "Felwood. Alliance only; choose this or Clouddrift Mantle", "Alliance"),
        item(279855, "Quest: Tome of Twilight (Torn Cultist Cloak)", "quest", "Krol'dok Stronghold. Alliance only", "Alliance"),
    },
    chest = {
        item(16690, "General Drakkisath, Blackrock Spire (Devout Robe)", "dungeon", nil),
        item(16706, "General Drakkisath, Blackrock Spire (Wildheart Vest)", "dungeon", nil),
        item(14138, "Tailoring (Mooncloth Vest)", "crafted", "We don't know where the pattern drops"),
        item(15059, "Leatherworking (Living Breastplate)", "crafted", nil),
    },
    wrist = {
        item(254061, "Tailoring (Nethergeld Cuffs)", "crafted", "Needs Tailoring"),
        item(252543, "Leatherworking (Mender's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(254123, "Tailoring (Runecloth Cuffs)", "crafted", nil),
    },
    hands = {
        item(16692, "Archivist Galford, Stratholme (Devout Gloves)", "dungeon", nil),
        item(252530, "Leatherworking (Mender's Leather Gloves)", "crafted", "Needs Leatherworking"),
        item(18409, "Tailoring (Mooncloth Gloves)", "crafted", nil),
    },
    waist = {
        item(254081, "Tailoring (Gilded Waistcord)", "crafted", "Needs Tailoring"),
        item(19047, "Tailoring (Wisdom of the Timbermaw)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(252477, "Leatherworking (Mender's Leather Waistguard)", "crafted", "Needs Leatherworking"),
    },
    legs = {
        item(16694, "Baron Rivendare, Stratholme (Devout Skirt)", "dungeon", nil),
        item(16719, "Baron Rivendare, Stratholme (Wildheart Kilt)", "dungeon", nil),
        item(14137, "Tailoring (Mooncloth Leggings)", "crafted", "We don't know where the pattern drops"),
        item(15060, "Leatherworking (Living Leggings)", "crafted", nil),
    },
    feet = {
        item(254107, "Tailoring (Gilded Sandals)", "crafted", "Needs Tailoring"),
        item(16691, "Maleki the Pallid, Stratholme (Devout Sandals)", "dungeon", nil),
        item(15802, "Tailoring (Mooncloth Boots)", "crafted", nil),
        item(16715, "Mother Smolderweb, Blackrock Spire (Wildheart Boots)", "dungeon", nil),
    },
    ring1 = {
        item(18402, "Quest: Uncovering Past Secrets (Glowing Crystal Ring)", "quest", "Moonglade. Choose this or Ring of Living Stone"),
        item(274746, "Booty Bay - Friendly (Sea Giant's Toe Ring)", "reputation", "Sold by Gezzy Gunkgear, Stranglethorn Vale"),
        item(6750, "Quest: Willix the Importer (Snake Hoop)", "quest", "Razorfen Kraul. Choose one Willix the Importer ring"),
    },
    ring2 = {
        item(273030, "Relic Guardian, Excavation Site: Wetlands (Ring of Power Regulation)", "dungeon", nil),
        item(9447, "Electrocutioner 6000, Gnomeregan (Electrocutioner Lagnut)", "dungeon", nil),
        item(273806, "Targorr the Dread, The Stockade (Dark Horde Band)", "dungeon", nil),
    },
    mainhand = {
        item(7721, "High Inquisitor Whitemane, Scarlet Monastery (Hand of Righteousness)", "dungeon", nil),
        item(275647, "Quest: Twisted Tools (Cleansed Ritual Kris)", "quest", "Mount Hyjal. Choose this or Reforged Spear or Purified Gnarlybark Staff"),
    },
    offhand = {
        item(249456, "Enchanting (Twisting Essence Jar)", "crafted", "Needs Enchanting"),
        item(274417, "Barkskin Burrow - Revered (Barkskin Baubles)", "reputation", "Sold by Dala Fairmaw, Mount Hyjal"),
        item(11262, "Quest: In the Name of the Light (Orb of Lorica)", "quest", "Scarlet Monastery. Alliance only", "Alliance"),
    },
    ranged = {
        item(249396, "Enchanting (Mystic Mushroom)", "crafted", "Needs Enchanting"),
    },
} }
-- Feral - Tank: classicwowforever.com/bis-list/feral-druid (checked 2026-11-08); order = the site's, first pick first
DB["DRUID"]["Feral - Tank"] = { lvl60 = {
    head = {
        item(8345, "Leatherworking (Wolfshead Helm)", "crafted", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", nil),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
        item(270095, "Quest: The Lost Tablets of Will (Medal of Valor)", "quest", "Uldaman. Alliance only", "Alliance"),
    },
    shoulder = {
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking"),
        item(11874, "Quest: Ancient Spirit (Clouddrift Mantle)", "quest", "Felwood. Alliance only; choose this or Ethereal Mist Cape", "Alliance"),
        item(19058, "Leatherworking (Golden Mantle of the Dawn)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", nil),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", nil),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Bear option; the pattern needs Friendly with Timbermaw Hold. We don't know where the pattern drops"),
    },
    wrist = {
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", "The pattern needs Revered with Timbermaw Hold"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", nil),
    },
    waist = {
        item(9636, "Quest: Deliver to MacKinley (Swashbuckler Sash)", "quest", "Tanaris. Choose this or Shinkicker Boots"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(252473, "Leatherworking (Prowler's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(252475, "Leatherworking (Warden's Leather Waistguard)", "crafted", "Needs Leatherworking; Bear option"),
    },
    legs = {
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "The pattern needs Friendly with Timbermaw Hold; also a Bear option"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", nil),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(22111, "Quest: Anthion's Parting Words (Feralheart Kilt)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Kilt"),
    },
    feet = {
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(252469, "Leatherworking (Skulker's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(252470, "Leatherworking (Warden's Leather Boots)", "crafted", "Needs Leatherworking; Bear option"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
    },
    trinket1 = {
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Made by a Blacksmith; the plans drop in Stratholme"),
    },
    ranged = {
        item(220606, "Enchanting (Idol of the Dream)", "crafted", "Needs Enchanting"),
    },
} }
-- Feral - DPS: classicwowforever.com/bis-list/feral-druid (checked 2026-11-08); order = the site's, first pick first
DB["DRUID"]["Feral - DPS"] = { lvl60 = {
    head = {
        item(8345, "Leatherworking (Wolfshead Helm)", "crafted", nil),
        item(16707, "Darkmaster Gandling, Scholomance (Shadowcraft Cap)", "dungeon", nil),
        item(15086, "Leatherworking (Wicked Leather Headband)", "crafted", nil),
        item(8348, "Leatherworking (Helm of Fire)", "crafted", nil),
    },
    neck = {
        item(22150, "Quest: Falrin's Vendetta (Beads of Ogre Might)", "quest", "Dire Maul. Choose this or Beads of Ogre Mojo"),
        item(7731, "Azshir the Sleepless, Scarlet Monastery (Ghostshard Talisman)", "dungeon", nil),
        item(270095, "Quest: The Lost Tablets of Will (Medal of Valor)", "quest", "Uldaman. Alliance only", "Alliance"),
    },
    shoulder = {
        item(16708, "Cannon Master Willey, Stratholme (Shadowcraft Spaulders)", "dungeon", nil),
        item(252535, "Leatherworking (Skulker's Leather Shoulder)", "crafted", "Needs Leatherworking"),
        item(11874, "Quest: Ancient Spirit (Clouddrift Mantle)", "quest", "Felwood. Alliance only; choose this or Ethereal Mist Cape", "Alliance"),
        item(19058, "Leatherworking (Golden Mantle of the Dawn)", "crafted", "The pattern needs Revered with the Argent Dawn"),
    },
    back = {
        item(18511, "Leatherworking (Shifting Cloak)", "crafted", nil),
        item(15789, "Quest: Strange Sources (Deep River Cloak)", "quest", "Winterspring"),
    },
    chest = {
        item(16721, "General Drakkisath, Blackrock Spire (Shadowcraft Tunic)", "dungeon", nil),
        item(15085, "Leatherworking (Wicked Leather Armor)", "crafted", nil),
        item(15064, "Leatherworking (Warbear Harness)", "crafted", "Bear option; the pattern needs Friendly with Timbermaw Hold. We don't know where the pattern drops"),
    },
    wrist = {
        item(272186, "Quest: Rot and Regret (Overgrown Cuffs)", "quest", "Maraudon"),
        item(252540, "Leatherworking (Skulker's Leather Bracers)", "crafted", "Needs Leatherworking"),
        item(19508, "High Inquisitor Fairbanks, Scarlet Monastery (Branded Leather Bracers)", "dungeon", nil),
    },
    hands = {
        item(19049, "Leatherworking (Timbermaw Brawlers)", "crafted", "The pattern needs Revered with Timbermaw Hold"),
        item(15063, "Leatherworking (Devilsaur Gauntlets)", "crafted", nil),
        item(16712, "Shadow Hunter Vosh'gajin, Blackrock Spire (Shadowcraft Gloves)", "dungeon", nil),
    },
    waist = {
        item(9636, "Quest: Deliver to MacKinley (Swashbuckler Sash)", "quest", "Tanaris. Choose this or Shinkicker Boots"),
        item(19044, "Leatherworking (Might of the Timbermaw)", "crafted", "The pattern needs Honored with Timbermaw Hold"),
        item(252473, "Leatherworking (Prowler's Leather Waistguard)", "crafted", "Needs Leatherworking"),
        item(252475, "Leatherworking (Warden's Leather Waistguard)", "crafted", "Needs Leatherworking; Bear option"),
    },
    legs = {
        item(15065, "Leatherworking (Warbear Woolies)", "crafted", "The pattern needs Friendly with Timbermaw Hold; also a Bear option"),
        item(16709, "Baron Rivendare, Stratholme (Shadowcraft Pants)", "dungeon", nil),
        item(15062, "Leatherworking (Devilsaur Leggings)", "crafted", "The pattern drops in Un'Goro Crater. We don't know where the pattern drops"),
        item(22111, "Quest: Anthion's Parting Words (Feralheart Kilt)", "quest", "Ironforge or Orgrimmar. Turn in the Wildheart Kilt"),
    },
    feet = {
        item(16711, "Rattlegore, Scholomance (Shadowcraft Boots)", "dungeon", nil),
        item(252469, "Leatherworking (Skulker's Leather Boots)", "crafted", "Needs Leatherworking"),
        item(18506, "Leatherworking (Mongoose Boots)", "crafted", nil),
        item(252470, "Leatherworking (Warden's Leather Boots)", "crafted", "Needs Leatherworking; Bear option"),
    },
    ring1 = {
        item(17713, "Princess Theradras, Maraudon (Blackstone Ring)", "dungeon", nil),
        item(7686, "Ironspine, Scarlet Monastery (Ironspine's Eye)", "dungeon", nil),
    },
    ring2 = {
        item(18400, "Quest: Uncovering Past Secrets (Ring of Living Stone)", "quest", "Moonglade. Choose this or Glowing Crystal Ring"),
        item(9533, "Quest: Divino-matic Rod (Masons Fraternity Ring)", "quest", "Zul'Farrak. Choose this or Engineer's Guild Headpiece or Magister Cowl"),
    },
    trinket1 = {
        item(273840, "Gelihast, Blackfathom Deeps (Cursed Murloc Eye)", "dungeon", nil),
    },
    mainhand = {
        item(250619, "Blacksmithing (Legionite Glaive)", "crafted", "Needs Blacksmithing"),
        item(17766, "Princess Theradras, Maraudon (Princess Theradras' Scepter)", "dungeon", nil),
        item(12796, "Blacksmithing (Hammer of the Titans)", "crafted", "Made by a Blacksmith; the plans drop in Stratholme"),
    },
    ranged = {
        item(220606, "Enchanting (Idol of the Dream)", "crafted", "Needs Enchanting"),
    },
} }

