-- TBCBisTracker Core
-- Handles: initialization, saved variables, events, utilities, minimap button, slash commands

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker
local L     = addon.L

-- ─────────────────────────────────────────────
-- Constants
-- ─────────────────────────────────────────────

addon.PHASES = { "prebis", "phase1", "phase2", "phase3", "phase4" }

addon.PHASE_LABELS = {
    prebis = "Pre-BIS",
    phase1 = "Phase 1",
    phase2 = "Phase 2",
    phase3 = "Phase 3",
    phase4 = "Phase 4",
}

addon.PHASE_DESCRIPTIONS = {
    prebis = "Pre-Raid Best in Slot — Heroic Dungeons, Crafted, Reputation",
    phase1 = "Phase 1 — Karazhan · Gruul's Lair · Magtheridon's Lair",
    phase2 = "Phase 2 — Serpentshrine Cavern · The Eye (Tempest Keep)",
    phase3 = "Phase 3 — Black Temple · Battle for Mount Hyjal",
    phase4 = "Phase 4 — Sunwell Plateau",
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

-- ─────────────────────────────────────────────
-- Saved-variable defaults
-- ─────────────────────────────────────────────

local DEFAULT_DB = {
    obtained  = {},   -- ["CLASS-Spec"]["phase"]["slot"] = true
    minimap   = { hide = false, pos = 220 },
    lastClass = nil,
    lastSpec  = nil,
    lastPhase = "prebis",
    showMissingOnly = false,
    windowPos = { point = "CENTER", x = 0, y = 0 },
}

-- ─────────────────────────────────────────────
-- Utility helpers
-- ─────────────────────────────────────────────

function addon:GetSpecKey(class, spec)
    return class .. "-" .. spec
end

function addon:IsObtained(class, spec, phase, slot)
    local key = self:GetSpecKey(class, spec)
    return TBCBisTrackerDB.obtained[key]
               and TBCBisTrackerDB.obtained[key][phase]
               and TBCBisTrackerDB.obtained[key][phase][slot] == true
end

function addon:SetObtained(class, spec, phase, slot, obtained)
    local key = self:GetSpecKey(class, spec)
    TBCBisTrackerDB.obtained[key] = TBCBisTrackerDB.obtained[key] or {}
    TBCBisTrackerDB.obtained[key][phase] = TBCBisTrackerDB.obtained[key][phase] or {}
    TBCBisTrackerDB.obtained[key][phase][slot] = obtained or nil
end

-- Returns obtained count, total count for a given class/spec/phase
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
    TBCBisTrackerDB.obtained = {}
    self:Print("All tracking data has been reset.")
    if self.UI and self.UI.Refresh then
        self.UI:Refresh()
    end
end

function addon:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[TBC BIS]|r " .. tostring(msg))
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
    btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local icon = btn:CreateTexture(nil, "BACKGROUND")
    icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER")

    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    border:SetSize(56, 56)
    border:SetPoint("CENTER", 0, 0)

    -- Position around minimap
    local function UpdatePosition()
        local pos   = TBCBisTrackerDB.minimap.pos or 220
        local angle = math.rad(pos)
        local r     = Minimap:GetWidth() / 2 + 5
        btn:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * r, math.sin(angle) * r)
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
        addon:ResetAllData()
    elseif cmd == "hide" then
        if addon.MinimapBtn then addon.MinimapBtn:Hide() end
        TBCBisTrackerDB.minimap.hide = true
    elseif cmd == "show" then
        if addon.MinimapBtn then addon.MinimapBtn:Show() end
        TBCBisTrackerDB.minimap.hide = false
    elseif cmd == "help" or cmd == "" then
        if cmd == "" then
            addon.UI:Toggle()
        else
            addon:Print("/tbcbis         — toggle window")
            addon:Print("/tbcbis reset   — reset all tracking data")
            addon:Print("/tbcbis hide    — hide minimap button")
            addon:Print("/tbcbis show    — show minimap button")
            addon:Print("/tbcbis help    — show this message")
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

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "TBCBisTracker" then

        -- Initialise saved variables
        TBCBisTrackerDB = TBCBisTrackerDB or {}
        applyDefaults(TBCBisTrackerDB, DEFAULT_DB)

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
    end
end)
