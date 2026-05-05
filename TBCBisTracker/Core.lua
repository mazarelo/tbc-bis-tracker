-- TBCBisTracker Core
-- Handles: initialization, saved variables, events, utilities, minimap button, slash commands

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker
local L     = addon.L

-- ─────────────────────────────────────────────
-- Constants
-- ─────────────────────────────────────────────

addon.PHASES = { "prebis", "phase1", "phase2", "phase3", "phase4", "phase5", "pvp" }

addon.PHASE_LABELS = {
    prebis = "Pre-BIS",
    phase1 = "Phase 1",
    phase2 = "Phase 2",
    phase3 = "Phase 3",
    phase4 = "Phase 4",
    phase5 = "Phase 5",
    pvp    = "PvP",
}

addon.PHASE_DESCRIPTIONS = {
    prebis = "Pre-Raid Best in Slot — Heroic Dungeons, Crafted, Reputation",
    phase1 = "Phase 1 — Karazhan · Gruul's Lair · Magtheridon's Lair",
    phase2 = "Phase 2 — Serpentshrine Cavern · The Eye (Tempest Keep)",
    phase3 = "Phase 3 — Black Temple · Battle for Mount Hyjal",
    phase4 = "Phase 4 — Zul'Aman",
    phase5 = "Phase 5 — Sunwell Plateau",
    pvp    = "PvP — Honor + Arena gear (Battlegrounds, Arena Seasons)",
}

addon.SLOTS = {
    "head","neck","shoulder","back","chest",
    "wrist","hands","waist","legs","feet",
    "ring1","ring2","trinket1","trinket2",
    "mainhand","offhand","ranged",
}

addon.SLOT_LABELS = {
    head     = "Head",
    neck     = "Neck",
    shoulder = "Shoulders",
    back     = "Back",
    chest    = "Chest",
    wrist    = "Wrist",
    hands    = "Hands",
    waist    = "Waist",
    legs     = "Legs",
    feet     = "Feet",
    ring1    = "Ring 1",
    ring2    = "Ring 2",
    trinket1 = "Trinket 1",
    trinket2 = "Trinket 2",
    mainhand = "Main Hand",
    offhand  = "Off Hand",
    ranged   = "Ranged",
}

-- Blizzard inventory slot textures
addon.SLOT_ICONS = {
    head     = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Head",
    neck     = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Neck",
    shoulder = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Shoulder",
    back     = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Chest",
    chest    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Chest",
    wrist    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Wrists",
    hands    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Hands",
    waist    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Waist",
    legs     = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Legs",
    feet     = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Feet",
    ring1    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Finger",
    ring2    = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Finger",
    trinket1 = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Trinket",
    trinket2 = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Trinket",
    mainhand = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-MainHand",
    offhand  = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-SecondaryHand",
    ranged   = "Interface\\PaperDollInfoFrame\\UI-PaperDoll-Slot-Ranged",
}

-- Item quality colors matching Blizzard's
addon.QUALITY_COLORS = {
    [0] = "|cff9d9d9d", -- Poor (grey)
    [1] = "|cffffffff", -- Common (white)
    [2] = "|cff1eff00", -- Uncommon (green)
    [3] = "|cff0070dd", -- Rare (blue)
    [4] = "|cffa335ee", -- Epic (purple)
    [5] = "|cffff8000", -- Legendary (orange)
}

addon.WOWHEAD_BASE = "https://www.wowhead.com/tbc/item="

-- Acceptable equipLoc strings (from GetItemInfo) per BIS slot key
addon.SLOT_INVTYPES = {
    head     = { INVTYPE_HEAD = true },
    neck     = { INVTYPE_NECK = true },
    shoulder = { INVTYPE_SHOULDER = true },
    back     = { INVTYPE_CLOAK = true },
    chest    = { INVTYPE_CHEST = true, INVTYPE_ROBE = true },
    wrist    = { INVTYPE_WRIST = true },
    hands    = { INVTYPE_HAND = true },
    waist    = { INVTYPE_WAIST = true },
    legs     = { INVTYPE_LEGS = true },
    feet     = { INVTYPE_FEET = true },
    ring1    = { INVTYPE_FINGER = true },
    ring2    = { INVTYPE_FINGER = true },
    trinket1 = { INVTYPE_TRINKET = true },
    trinket2 = { INVTYPE_TRINKET = true },
    mainhand = { INVTYPE_WEAPON = true, INVTYPE_2HWEAPON = true, INVTYPE_WEAPONMAINHAND = true },
    offhand  = { INVTYPE_WEAPON = true, INVTYPE_WEAPONOFFHAND = true, INVTYPE_HOLDABLE = true, INVTYPE_SHIELD = true },
    ranged   = { INVTYPE_RANGED = true, INVTYPE_RANGEDRIGHT = true, INVTYPE_THROWN = true, INVTYPE_RELIC = true },
}

-- Map BIS-tracker slot keys to WoW inventory slot IDs.
-- ring1/ring2/trinket1/trinket2 each map to TWO inventory slots — we accept a match in either.
addon.SLOT_INVENTORY_IDS = {
    head     = { 1 },
    neck     = { 2 },
    shoulder = { 3 },
    chest    = { 5 },
    waist    = { 6 },
    legs     = { 7 },
    feet     = { 8 },
    wrist    = { 9 },
    hands    = { 10 },
    ring1    = { 11, 12 },
    ring2    = { 11, 12 },
    trinket1 = { 13, 14 },
    trinket2 = { 13, 14 },
    back     = { 15 },
    mainhand = { 16 },
    offhand  = { 17 },
    ranged   = { 18 },
}

-- ─────────────────────────────────────────────
-- Saved-variable defaults
-- ─────────────────────────────────────────────

-- Account-wide settings (DOES NOT include tracking data)
local DEFAULT_DB = {
    minimap    = { hide = false, pos = 220 },
    lastClass  = nil,
    lastSpec   = nil,
    lastPhase  = "prebis",
    showMissingOnly = false,
    windowPos  = { point = "CENTER", x = 0, y = 0 },
}

-- Per-character tracking data
local DEFAULT_CHAR_DB = {
    obtained   = {},   -- ["CLASS-Spec"]["phase"]["slot"] = true
    selected   = {},   -- ["CLASS-Spec"]["phase"]["slot"] = alternativeIndex (1 = BiS)
    customAlts = {},   -- ["CLASS-Spec"]["phase"]["slot"] = { {id=, source=, sourceType=}, ... }
}

-- ─────────────────────────────────────────────
-- Utility helpers
-- ─────────────────────────────────────────────

function addon:GetSpecKey(class, spec)
    return class .. "-" .. spec
end

function addon:IsObtained(class, spec, phase, slot)
    local key = self:GetSpecKey(class, spec)
    return TBCBisTrackerCharDB.obtained[key]
               and TBCBisTrackerCharDB.obtained[key][phase]
               and TBCBisTrackerCharDB.obtained[key][phase][slot] == true
end

function addon:SetObtained(class, spec, phase, slot, obtained)
    local key = self:GetSpecKey(class, spec)
    TBCBisTrackerCharDB.obtained[key] = TBCBisTrackerCharDB.obtained[key] or {}
    TBCBisTrackerCharDB.obtained[key][phase] = TBCBisTrackerCharDB.obtained[key][phase] or {}
    TBCBisTrackerCharDB.obtained[key][phase][slot] = obtained or nil
end

-- Returns obtained count, total count for a given class/spec/phase
function addon:GetPhaseProgress(class, spec, phase)
    local obtained, total = 0, 0
    for _, slot in ipairs(self.SLOTS) do
        local alts = self:GetSlotAlternatives(class, spec, phase, slot)
        if alts and #alts > 0 then
            total = total + 1
            if self:IsObtained(class, spec, phase, slot) then
                obtained = obtained + 1
            end
        end
    end
    return obtained, total
end

function addon:GetProgress(class, spec, phase)
    local data = self:GetPhaseData(class, spec, phase)
    if not data then return 0, 0 end

    local total, obtained = 0, 0
    for _, slot in ipairs(self.SLOTS) do
        if data[slot] then
            total = total + 1
            if self:IsObtained(class, spec, phase, slot) then
                obtained = obtained + 1
            end
        end
    end
    return obtained, total
end

function addon:GetPhaseData(class, spec, phase)
    local classData = addon.DB[class]
    if not classData then return nil end
    local specData = classData[spec]
    if not specData then return nil end
    return specData[phase]
end

-- Slot data may be either a single item ({id=...}) or a list of items {item, item, ...}
-- where index 1 is BiS and 2+ are alternatives. User-imported alternatives are appended.
function addon:GetSlotAlternatives(class, spec, phase, slot)
    local out = {}
    local entries = self:GetPhaseData(class, spec, phase)
    if entries then
        local list = entries[slot]
        if list then
            if list.id then
                table.insert(out, list)
            else
                for _, it in ipairs(list) do table.insert(out, it) end
            end
        end
    end
    -- Merge user-imported custom alternatives
    local custom = self:GetCustomAlts(class, spec, phase, slot)
    if custom then
        for _, it in ipairs(custom) do table.insert(out, it) end
    end
    if #out == 0 then return nil end
    return out
end

function addon:GetCustomAlts(class, spec, phase, slot)
    local ca = TBCBisTrackerCharDB.customAlts
    if not ca then return nil end
    local key = self:GetSpecKey(class, spec)
    return ca[key] and ca[key][phase] and ca[key][phase][slot]
end

function addon:AddCustomAlt(class, spec, phase, slot, itemId, source)
    if not itemId then return false end
    TBCBisTrackerCharDB.customAlts = TBCBisTrackerCharDB.customAlts or {}
    local key = self:GetSpecKey(class, spec)
    local ca = TBCBisTrackerCharDB.customAlts
    ca[key] = ca[key] or {}
    ca[key][phase] = ca[key][phase] or {}
    ca[key][phase][slot] = ca[key][phase][slot] or {}
    -- Avoid duplicates
    for _, it in ipairs(ca[key][phase][slot]) do
        if it.id == itemId then return false end
    end
    table.insert(ca[key][phase][slot], { id = itemId, source = source or "Custom (imported)", sourceType = "world" })
    self._itemIndex = nil  -- invalidate search index
    self._trackedIndex = nil  -- invalidate tooltip index
    return true
end

function addon:RemoveCustomAlt(class, spec, phase, slot, itemId)
    local list = self:GetCustomAlts(class, spec, phase, slot)
    if not list then return end
    for i = #list, 1, -1 do
        if list[i].id == itemId then table.remove(list, i) end
    end
    self._itemIndex = nil
    self._trackedIndex = nil
end

-- Serialize the currently-selected items for a (class, spec, phase) into a single-line shareable string.
function addon:ExportSetup(class, spec, phase)
    if not class or not spec or not phase then return nil end
    local parts = {
        "TBCBIS:v1",
        "class=" .. class,
        "spec="  .. spec,
        "phase=" .. phase,
    }
    for _, slot in ipairs(self.SLOTS) do
        local entry = self:GetSlotItem(class, spec, phase, slot)
        if entry and entry.id then
            table.insert(parts, slot .. "=" .. entry.id)
        end
    end
    return table.concat(parts, ";")
end

-- Parse an exported string and apply it: adds missing items as custom alts and selects them.
-- Accepts both legacy newline-separated and current semicolon-separated formats.
-- Returns ok, message.
function addon:ImportSetup(text)
    if not text or text == "" then return false, "empty" end
    local class, spec, phase
    local items = {}
    -- Normalize separators: treat both \n and ; as token boundaries
    local normalized = text:gsub("\r", ""):gsub("\n", ";")
    for token in (normalized .. ";"):gmatch("([^;]+)") do
        token = token:match("^%s*(.-)%s*$")
        if token ~= "" and not token:match("^TBCBIS") then
            local k, v = token:match("^([%w_]+)=(.+)$")
            if k == "class" then class = v
            elseif k == "spec"  then spec  = v
            elseif k == "phase" then phase = v
            elseif k and v then
                local id = tonumber(v)
                if id then items[k] = id end
            end
        end
    end
    if not class or not spec or not phase then return false, "missing class/spec/phase header" end
    if not (self.DB[class] and self.DB[class][spec]) then
        return false, "unknown class/spec: " .. class .. "/" .. spec
    end
    local applied = 0
    for slot, itemId in pairs(items) do
        local alts = self:GetSlotAlternatives(class, spec, phase, slot)
        local foundIdx
        if alts then
            for i, alt in ipairs(alts) do
                if alt.id == itemId then foundIdx = i; break end
            end
        end
        if not foundIdx then
            self:AddCustomAlt(class, spec, phase, slot, itemId, "Imported setup")
            local newAlts = self:GetSlotAlternatives(class, spec, phase, slot)
            if newAlts then
                for i, alt in ipairs(newAlts) do
                    if alt.id == itemId then foundIdx = i; break end
                end
            end
        end
        if foundIdx then
            self:SetSelectedAlt(class, spec, phase, slot, foundIdx)
            applied = applied + 1
        end
    end
    return true, ("imported " .. applied .. " slots into " .. class .. "/" .. spec .. "/" .. phase)
end

-- ─────────────────────────────────────────────
-- Badge of Justice tracker
-- ─────────────────────────────────────────────

addon.BADGE_OF_JUSTICE_ID = 29434

-- Fallback prices for items whose source string omits the explicit Badge cost.
addon.BADGE_COSTS = {
    [29370] = 41,  -- Icon of the Silver Crescent
    [29272] = 75,  -- Orb of the Soul-Eater
    [29273] = 75,  -- Khadgar's Knapsack
    [29383] = 41,  -- Bloodlust Brooch
    [29384] = 25,  -- Ring of Unyielding Force
    [29381] = 25,  -- Choker of Vile Intent
    [29386] = 25,  -- Necklace of the Juggernaut
    [29382] = 25,  -- Blood Knight War Cloak
    [32087] = 50,  -- Mask of the Deceiver
    [32088] = 50,  -- Cowl of Beastly Rage
    [33334] = 60,  -- Fetish of the Primal Gods
    [33192] = 30,  -- Carved Witch Doctor's Stick
}

function addon:GetBadgeCount()
    return (GetItemCount and GetItemCount(self.BADGE_OF_JUSTICE_ID, true) or 0)
end

function addon:IsBadgeItem(entry)
    if not entry or not entry.source then return false end
    return entry.source:find("Badges of Justice") ~= nil
end

-- Detects whether an item is a tier-set piece based on its source string.
-- Returns nil or { tier = "T4"|"T5"|"T6"|"T6.5", boss = "..." }
function addon:GetTierInfo(entry)
    if not entry or not entry.source then return nil end
    local src = entry.source
    if not src:find("Token") and not src:find("Tier") then return nil end

    -- Try to extract the boss name. Wowhead-style: "Tier Token from <boss> (<location>)"
    local boss = src:match("Tier Token from ([^%(]+)%(") or src:match("Token from ([^%(]+)%(")
    if not boss then
        -- Pattern like "Karazhan - Prince Malchezaar Token (Item)"
        boss = src:match("%- ([^%-%(]+)Token") or src:match("([^%-%(]+) Token")
    end
    if boss then boss = boss:match("^%s*(.-)%s*$") end

    -- Identify which tier from boss / zone keywords
    local tier
    if src:find("Karazhan") or src:find("Gruul") or src:find("Magtheridon") then
        tier = "T4"
    elseif src:find("Serpentshrine") or src:find("SSC") or src:find("Tempest Keep") or src:find("TK") or src:find("The Eye") then
        tier = "T5"
    elseif src:find("Black Temple") or src:find("BT") or src:find("Hyjal") then
        tier = "T6"
    elseif src:find("Sunwell") or src:find("SWP") then
        tier = "T6.5"
    end

    if not tier then return nil end
    return { tier = tier, boss = boss }
end

function addon:GetBadgeCost(entry)
    if not entry then return nil end
    local n = entry.source and entry.source:match("(%d+)%s*Badges?%s*of%s*Justice")
    if n then return tonumber(n) end
    if entry.id and self.BADGE_COSTS[entry.id] then return self.BADGE_COSTS[entry.id] end
    return nil
end

-- Returns a per-tier summary: { [tier] = { total=N, obtained=M, slots = {slot,...} } }
function addon:GetTierProgress(class, spec, phase)
    local out = {}
    if not class or not spec or not phase then return out end
    for _, slot in ipairs(self.SLOTS) do
        local entry = self:GetSlotItem(class, spec, phase, slot)
        if entry then
            local info = self:GetTierInfo(entry)
            if info then
                local agg = out[info.tier]
                if not agg then
                    agg = { total = 0, obtained = 0, slots = {} }
                    out[info.tier] = agg
                end
                agg.total = agg.total + 1
                table.insert(agg.slots, slot)
                if self:IsObtained(class, spec, phase, slot) then
                    agg.obtained = agg.obtained + 1
                end
            end
        end
    end
    return out
end

-- Returns: owned, totalCost, items[] (each {slot, cost, entry}) for unobtained badge items in (class,spec,phase).
function addon:GetBadgeProgress(class, spec, phase)
    local owned = self:GetBadgeCount()
    if not class or not spec or not phase then return owned, 0, {} end
    local total, items = 0, {}
    for _, slot in ipairs(self.SLOTS) do
        if not self:IsObtained(class, spec, phase, slot) then
            local entry = self:GetSlotItem(class, spec, phase, slot)
            if entry and self:IsBadgeItem(entry) then
                local cost = self:GetBadgeCost(entry)
                if cost then
                    total = total + cost
                    table.insert(items, { slot = slot, cost = cost, entry = entry })
                end
            end
        end
    end
    return owned, total, items
end

-- ─────────────────────────────────────────────
-- Reverse index: item id → list of (spec, phase, slot, altIdx, totalAlts)
-- for the player's class. Used by tooltip integration.
-- ─────────────────────────────────────────────

function addon:BuildTrackedItemIndex()
    local _, playerClass = UnitClass("player")
    if not playerClass then self._trackedIndex = {}; return self._trackedIndex end
    local classData = self.DB[playerClass]
    if not classData then self._trackedIndex = {}; return self._trackedIndex end
    local idx = {}
    for spec, _ in pairs(classData) do
        for _, phase in ipairs(self.PHASES) do
            for _, slot in ipairs(self.SLOTS) do
                local alts = self:GetSlotAlternatives(playerClass, spec, phase, slot)
                if alts then
                    for i, alt in ipairs(alts) do
                        if alt.id then
                            idx[alt.id] = idx[alt.id] or {}
                            table.insert(idx[alt.id], {
                                spec = spec, phase = phase, slot = slot,
                                idx = i, total = #alts,
                            })
                        end
                    end
                end
            end
        end
    end
    self._trackedIndex = idx
    return idx
end

function addon:GetItemTrackingInfo(itemId)
    if not itemId then return nil end
    if not self._trackedIndex then self:BuildTrackedItemIndex() end
    local matches = self._trackedIndex[itemId]
    if not matches or #matches == 0 then return nil end
    local _, playerClass = UnitClass("player")
    local out = {}
    for _, m in ipairs(matches) do
        local selected = self:GetSelectedAlt(playerClass, m.spec, m.phase, m.slot)
        table.insert(out, {
            spec = m.spec, phase = m.phase, slot = m.slot,
            idx = m.idx, total = m.total,
            isSelected = (m.idx == selected),
        })
    end
    return out
end

-- ─────────────────────────────────────────────
-- Item search index (built from internal DB; AtlasLoot can extend it)
-- ─────────────────────────────────────────────

function addon:BuildItemIndex()
    local idx = {}
    local seen = {}

    local function add(it)
        if it and it.id and not seen[it.id] then
            seen[it.id] = true
            table.insert(idx, it)
        end
    end

    -- Walk the static DB
    for _, classData in pairs(self.DB or {}) do
        if type(classData) == "table" then
            for _, specData in pairs(classData) do
                if type(specData) == "table" then
                    for _, phase in ipairs(self.PHASES) do
                        local pdata = specData[phase]
                        if pdata then
                            for _, slot in ipairs(self.SLOTS) do
                                local list = pdata[slot]
                                if list then
                                    if list.id then add(list)
                                    else for _, it in ipairs(list) do add(it) end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Include user custom imports
    if TBCBisTrackerCharDB and TBCBisTrackerCharDB.customAlts then
        for _, byPhase in pairs(TBCBisTrackerCharDB.customAlts) do
            for _, bySlot in pairs(byPhase) do
                for _, slotItems in pairs(bySlot) do
                    if type(slotItems) == "table" then
                        for _, it in ipairs(slotItems) do add(it) end
                    end
                end
            end
        end
    end

    -- Best-effort AtlasLoot harvest
    self.atlasLootDetected = false
    if IsAddOnLoaded and IsAddOnLoaded("AtlasLootClassic") then
        self.atlasLootDetected = true
        -- AtlasLoot's data structure varies by version; safe harvest harmless on failure
        local ok = pcall(function()
            local al = _G.AtlasLoot
            if not al or type(al) ~= "table" then return end
            -- Walk any registered data tables looking for items with [1]=number ids
            for _, modName in ipairs({ "AtlasLootClassic_DungeonsAndRaids", "AtlasLootClassic_Crafting", "AtlasLootClassic_Factions", "AtlasLootClassic_PvP", "AtlasLootClassic_Collections" }) do
                local mod = _G[modName]
                if mod and type(mod) == "table" then
                    local function walk(t)
                        if type(t) ~= "table" then return end
                        for k, v in pairs(t) do
                            if type(v) == "table" then
                                if type(v[1]) == "number" and v[2] and type(v[2]) == "number" and v[2] > 100 then
                                    add({ id = v[2], source = "AtlasLoot data", sourceType = "world" })
                                else
                                    walk(v)
                                end
                            end
                        end
                    end
                    walk(mod)
                end
            end
        end)
    end

    self._itemIndex = idx
    return idx
end

-- Search the index for items whose cached name (or source string) contains the query.
function addon:SearchItems(query, limit)
    if not self._itemIndex then self:BuildItemIndex() end
    query = tostring(query or ""):lower():match("^%s*(.-)%s*$")
    if query == "" then return {} end
    limit = limit or 20
    local matches = {}
    for _, it in ipairs(self._itemIndex) do
        local name = GetItemInfo(it.id)
        local hay = (name or it.source or ""):lower()
        if hay:find(query, 1, true) then
            table.insert(matches, { id = it.id, name = name, source = it.source })
            if #matches >= limit then break end
        end
    end
    return matches
end

-- Parse a Wowhead URL, in-game item link, or bare numeric id.
function addon:ParseWowheadInput(input)
    if not input or input == "" then return nil end
    input = tostring(input):match("^%s*(.-)%s*$")
    local patterns = {
        "item=(%d+)",        -- wowhead query-style: ...item=29370
        "item:(%d+)",        -- in-game hyperlink: |Hitem:29370:0:...
        "/item/(%d+)",       -- path style: /item/29370
        "/items/(%d+)",      -- plural variant
        "wowhead%.com/[%w%-/]*/(%d+)",  -- last segment of a wowhead path
        "^(%d+)$",           -- bare number
    }
    for _, p in ipairs(patterns) do
        local id = input:match(p)
        if id then return tonumber(id) end
    end
    return nil
end

function addon:GetSelectedAlt(class, spec, phase, slot)
    local sel = TBCBisTrackerCharDB.selected
    if not sel then return 1 end
    local key = self:GetSpecKey(class, spec)
    return (sel[key] and sel[key][phase] and sel[key][phase][slot]) or 1
end

function addon:SetSelectedAlt(class, spec, phase, slot, idx)
    TBCBisTrackerCharDB.selected = TBCBisTrackerCharDB.selected or {}
    local key = self:GetSpecKey(class, spec)
    TBCBisTrackerCharDB.selected[key] = TBCBisTrackerCharDB.selected[key] or {}
    TBCBisTrackerCharDB.selected[key][phase] = TBCBisTrackerCharDB.selected[key][phase] or {}
    TBCBisTrackerCharDB.selected[key][phase][slot] = idx
end

-- Returns the currently-selected item entry for a slot, the index, and total alternative count.
function addon:GetSlotItem(class, spec, phase, slot)
    local alts = self:GetSlotAlternatives(class, spec, phase, slot)
    if not alts or #alts == 0 then return nil, 1, 0 end
    local idx = self:GetSelectedAlt(class, spec, phase, slot)
    if idx > #alts then idx = 1 end
    return alts[idx], idx, #alts
end

function addon:GetItemLink(itemId)
    if not itemId then return "|cffffffff[Unknown]|r" end
    local name, _, quality = GetItemInfo(itemId)
    if name then
        local color = self.QUALITY_COLORS[quality] or "|cffffffff"
        return color .. "|Hitem:" .. itemId .. ":0:0:0:0:0:0:0|h[" .. name .. "]|h|r"
    end
    return "|cff9d9d9d[Item " .. itemId .. "]|r"
end

function addon:GetItemName(itemId)
    if not itemId then return "Unknown" end
    local name = GetItemInfo(itemId)
    return name or ("Item " .. itemId)
end

function addon:GetItemQualityColor(itemId)
    if not itemId then return self.QUALITY_COLORS[1] end
    local _, _, quality = GetItemInfo(itemId)
    return self.QUALITY_COLORS[quality or 1] or self.QUALITY_COLORS[1]
end

function addon:ResetAllData()
    TBCBisTrackerCharDB.obtained = {}
    self:Print("All tracking data has been reset.")
    if self.UI and self.UI.Refresh then
        self.UI:Refresh()
    end
end

-- Reset obtained checkmarks for a single (class, spec, phase). Selections + custom alts kept.
function addon:ResetPhase(class, spec, phase)
    if not class or not spec or not phase then return end
    local key = self:GetSpecKey(class, spec)
    if TBCBisTrackerCharDB.obtained[key] then
        TBCBisTrackerCharDB.obtained[key][phase] = nil
    end
    self:Print("Reset " .. class .. " " .. spec .. " " .. (self.PHASE_LABELS[phase] or phase) .. ".")
    if self.UI and self.UI.Refresh then
        self.UI:Refresh()
    end
end

function addon:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[TBC BIS]|r " .. tostring(msg))
end

-- ─────────────────────────────────────────────
-- Auto-detect: mark BIS items obtained from currently equipped gear.
-- One-way: never auto-unticks; manual untick stays unticked until item re-equipped.
-- ─────────────────────────────────────────────

function addon:ScanEquipped()
    local _, playerClass = UnitClass("player")
    if not playerClass then return end
    local classData = self.DB[playerClass]
    if not classData then return end

    -- Collect every item id the player currently owns (equipped + bags 0-4)
    local owned = {}
    for invSlot = 1, 19 do
        local id = GetInventoryItemID("player", invSlot)
        if id then owned[id] = true end
    end
    for bag = 0, NUM_BAG_SLOTS or 4 do
        local slots = GetContainerNumSlots and GetContainerNumSlots(bag) or 0
        for slotIdx = 1, slots do
            local id = GetContainerItemID and GetContainerItemID(bag, slotIdx) or nil
            if id then owned[id] = true end
        end
    end

    local marked = 0
    for spec, _ in pairs(classData) do
        for _, phase in ipairs(self.PHASES) do
            for _, slot in ipairs(self.SLOTS) do
                local entry = self:GetSlotItem(playerClass, spec, phase, slot)
                if entry and entry.id and owned[entry.id] then
                    if not self:IsObtained(playerClass, spec, phase, slot) then
                        self:SetObtained(playerClass, spec, phase, slot, true)
                        marked = marked + 1
                    end
                end
            end
        end
    end

    if marked > 0 and self.UI and self.UI.Refresh then
        self.UI:Refresh()
    end
    return marked
end

-- ─────────────────────────────────────────────
-- Merge defaults (non-destructive)
-- ─────────────────────────────────────────────

local function applyDefaults(target, defaults)
    for k, v in pairs(defaults) do
        if target[k] == nil then
            if type(v) == "table" then
                target[k] = {}
                applyDefaults(target[k], v)
            else
                target[k] = v
            end
        end
    end
end

-- ─────────────────────────────────────────────
-- Minimap button
-- ─────────────────────────────────────────────

local function CreateMinimapButton()
    local btn = CreateFrame("Button", "TBCBisTrackerMinimapBtn", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetClampedToScreen(true)

    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetPoint("TOPLEFT", 6, -6)
    bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetSize(18, 18)
    icon:SetPoint("TOPLEFT", 7, -6)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetSize(54, 54)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetSize(20, 20)
    highlight:SetPoint("TOPLEFT", 6, -6)
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")

    -- Position around minimap
    local MINIMAP_RADIUS = 80
    local function UpdatePosition()
        local pos   = TBCBisTrackerDB.minimap.pos or 220
        local angle = math.rad(pos)
        btn:ClearAllPoints()
        btn:SetPoint("CENTER", Minimap, "CENTER",
            math.cos(angle) * MINIMAP_RADIUS, math.sin(angle) * MINIMAP_RADIUS)
    end

    -- Drag to reposition
    btn:SetMovable(true)
    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        self:LockHighlight()
    end)
    btn:SetScript("OnDragStop", function(self)
        self:UnlockHighlight()
        local cx, cy  = Minimap:GetCenter()
        local mx, my  = GetCursorPosition()
        local scale   = UIParent:GetEffectiveScale()
        mx, my = mx / scale, my / scale
        local angle   = math.deg(math.atan2(my - cy, mx - cx))
        TBCBisTrackerDB.minimap.pos = angle % 360
        UpdatePosition()
    end)

    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            addon.UI:Toggle()
        end
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("|cffffd700TBC BIS Tracker|r", 1, 1, 1)
        GameTooltip:AddLine("Left-click to toggle", 1, 1, 1)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    UpdatePosition()
    btn:Show()
    addon.MinimapBtn = btn
    return btn
end

-- ─────────────────────────────────────────────
-- Slash commands
-- ─────────────────────────────────────────────

SLASH_TBCBISTRACKER1 = "/tbcbis"
SLASH_TBCBISTRACKER2 = "/tbcbistracker"

SlashCmdList["TBCBISTRACKER"] = function(msg)
    local cmd = msg and msg:lower():match("^%s*(.-)%s*$") or ""
    if cmd == "reset" then
        addon:ResetPhase(TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase)
    elseif cmd == "reset all" then
        addon:ResetAllData()
    elseif cmd == "hide" then
        if addon.MinimapBtn then addon.MinimapBtn:Hide() end
        TBCBisTrackerDB.minimap.hide = true
    elseif cmd == "show" then
        if addon.MinimapBtn then addon.MinimapBtn:Show() end
        TBCBisTrackerDB.minimap.hide = false
    elseif cmd == "export" then
        if addon.UI and addon.UI.ShowExportPopup then addon.UI:ShowExportPopup() end
    elseif cmd == "import" then
        if addon.UI and addon.UI.ShowImportPopup then addon.UI:ShowImportPopup() end
    elseif cmd == "help" or cmd == "" then
        if cmd == "" then
            addon.UI:Toggle()
        else
            addon:Print("/tbcbis           — toggle window")
            addon:Print("/tbcbis export    — export current spec/phase setup")
            addon:Print("/tbcbis import    — import a setup string")
            addon:Print("/tbcbis reset     — reset checkmarks for current phase")
            addon:Print("/tbcbis reset all — reset ALL tracking data")
            addon:Print("/tbcbis hide      — hide minimap button")
            addon:Print("/tbcbis show      — show minimap button")
            addon:Print("/tbcbis help      — show this message")
        end
    else
        addon.UI:Toggle()
    end
end

-- ─────────────────────────────────────────────
-- Event frame & initialisation
-- ─────────────────────────────────────────────

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "TBCBisTracker" then

        -- Initialise saved variables
        TBCBisTrackerDB = TBCBisTrackerDB or {}
        applyDefaults(TBCBisTrackerDB, DEFAULT_DB)
        TBCBisTrackerCharDB = TBCBisTrackerCharDB or {}
        applyDefaults(TBCBisTrackerCharDB, DEFAULT_CHAR_DB)

        -- One-time migration: if account-wide had tracking data and char DB is empty, copy it over
        if TBCBisTrackerDB.obtained and not TBCBisTrackerCharDB.__migrated then
            if next(TBCBisTrackerDB.obtained) and not next(TBCBisTrackerCharDB.obtained) then
                TBCBisTrackerCharDB.obtained = TBCBisTrackerDB.obtained
            end
            if TBCBisTrackerDB.selected and next(TBCBisTrackerDB.selected) and not next(TBCBisTrackerCharDB.selected) then
                TBCBisTrackerCharDB.selected = TBCBisTrackerDB.selected
            end
            if TBCBisTrackerDB.customAlts and next(TBCBisTrackerDB.customAlts) and not next(TBCBisTrackerCharDB.customAlts) then
                TBCBisTrackerCharDB.customAlts = TBCBisTrackerDB.customAlts
            end
            TBCBisTrackerCharDB.__migrated = true
            -- Drop legacy account-wide tracking blobs to avoid drift
            TBCBisTrackerDB.obtained, TBCBisTrackerDB.selected, TBCBisTrackerDB.customAlts = nil, nil, nil
        end

        -- Detect player class if no stored preference
        if not TBCBisTrackerDB.lastClass then
            local _, playerClass = UnitClass("player")
            TBCBisTrackerDB.lastClass = playerClass
            -- Set first spec using the ordered list from CLASS_INFO
            local classInfo = addon.CLASS_INFO and addon.CLASS_INFO[playerClass]
            if classInfo and classInfo.specs and classInfo.specs[1] then
                TBCBisTrackerDB.lastSpec = classInfo.specs[1]
            end
        end

        -- Normalize lastSpec: if the saved spec was renamed/removed (e.g. Druid "Feral" → "Feral - Tank"/"Feral - DPS"),
        -- fall back to the first valid spec for the class.
        local cls = TBCBisTrackerDB.lastClass
        if cls and addon.CLASS_INFO and addon.CLASS_INFO[cls] then
            local valid = {}
            for _, s in ipairs(addon.CLASS_INFO[cls].specs) do valid[s] = true end
            if TBCBisTrackerDB.lastSpec and not valid[TBCBisTrackerDB.lastSpec] then
                TBCBisTrackerDB.lastSpec = addon.CLASS_INFO[cls].specs[1]
            end
        end

        -- Create minimap button
        CreateMinimapButton()
        if TBCBisTrackerDB.minimap.hide then
            addon.MinimapBtn:Hide()
        end

        addon:Print("Loaded! Type /tbcbis to open.")

    elseif event == "PLAYER_LOGIN" then
        -- Build the UI after all data is ready
        if addon.UI and addon.UI.Build then
            addon.UI:Build()
        end
        addon:ScanEquipped()

    elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE_DELAYED" then
        addon:ScanEquipped()
        if addon.UI and addon.UI.RefreshBadgeStatus then
            addon.UI:RefreshBadgeStatus()
        end
    end
end)

-- ─────────────────────────────────────────────
-- Tooltip integration: append tracking info to any item tooltip
-- ─────────────────────────────────────────────

local function appendTrackingLines(tooltip)
    if not tooltip or not tooltip.GetItem then return end
    local _, link = tooltip:GetItem()
    if not link then return end
    local itemId = tonumber(link:match("item:(%d+)"))
    if not itemId then return end

    local matches = addon:GetItemTrackingInfo(itemId)
    if not matches or #matches == 0 then return end

    -- Avoid duplicate stamping on the same render
    if tooltip.tbcbisStamp == itemId then return end
    tooltip.tbcbisStamp = itemId

    tooltip:AddLine(" ")
    for _, m in ipairs(matches) do
        local phaseLabel = addon.PHASE_LABELS[m.phase] or m.phase
        local slotLabel  = addon.SLOT_LABELS[m.slot] or m.slot
        local prefix, line
        if m.isSelected then
            prefix = "|cffffd700[BIS]|r"
            line = string.format("%s Selected for %s %s", prefix, phaseLabel, slotLabel)
        elseif m.idx == 1 then
            prefix = "|cff00ff00[BIS]|r"
            line = string.format("%s Top pick for %s %s (currently tracking Alt %d)", prefix, phaseLabel, slotLabel,
                addon:GetSelectedAlt(select(2, UnitClass("player")), m.spec, m.phase, m.slot))
        else
            prefix = "|cffaaaaaa[Alt " .. m.idx .. "/" .. m.total .. "]|r"
            line = string.format("%s for %s %s", prefix, phaseLabel, slotLabel)
        end
        if m.spec ~= TBCBisTrackerDB.lastSpec then
            line = line .. " |cff888888(" .. m.spec .. ")|r"
        end
        tooltip:AddLine(line)
    end
    tooltip:Show()  -- recompute height
end

local function clearStamp(self) self.tbcbisStamp = nil end

GameTooltip:HookScript("OnTooltipSetItem", appendTrackingLines)
GameTooltip:HookScript("OnHide", clearStamp)
if ItemRefTooltip then
    ItemRefTooltip:HookScript("OnTooltipSetItem", appendTrackingLines)
    ItemRefTooltip:HookScript("OnHide", clearStamp)
end
