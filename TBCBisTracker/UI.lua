-- TBCBisTracker UI
-- Full UI: class/spec picker, phase tabs, gear rows with checkboxes, progress bar

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker

addon.UI = {}
local UI = addon.UI

-- Re-fire the current tooltip's owner OnEnter when shift state changes,
-- so pressing/releasing Shift mid-hover toggles the side-by-side comparison.
local modWatcher = CreateFrame("Frame")
modWatcher:RegisterEvent("MODIFIER_STATE_CHANGED")
modWatcher:SetScript("OnEvent", function(_, _, key)
    if key ~= "LSHIFT" and key ~= "RSHIFT" then return end
    if not GameTooltip:IsShown() then return end
    local owner = GameTooltip:GetOwner()
    if not owner then return end
    if not (owner.itemId and owner.itemId > 0) and not (owner.GetParent and owner:GetParent() == DropDownList1) then
        return
    end
    local handler = owner:GetScript("OnEnter")
    if handler then handler(owner) end
end)

-- ─────────────────────────────────────────────
-- Layout constants
-- ─────────────────────────────────────────────
local FRAME_W      = 760
local FRAME_H      = 580
local HEADER_H     = 90   -- class buttons + title
local PHASE_TAB_H  = 30
local PROGRESS_H   = 28
local ROW_H        = 28
local ROW_PAD      = 2
local SCROLL_W     = FRAME_W - 40
local COL_ICON_W   = 26
local COL_SLOT_W   = 80
local COL_ITEM_W   = 260
local COL_SRC_W    = 280
local COL_CHK_W    = 40

local CLASS_ORDER = {
    "WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST",
    "SHAMAN","MAGE","WARLOCK","DRUID",
}

local SOURCE_TYPE_COLORS = {
    crafted    = "|cff00ff96",
    heroic     = "|cff40c0ff",
    raid       = "|cffa335ee",
    reputation = "|cffffd700",
    pvp        = "|cffff4040",
    world      = "|cffaaaaaa",
    quest      = "|cffff9900",
    dungeon    = "|cff7fb2ff",
}

-- ─────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────

local function ColorText(text, hex)
    return "|cff" .. hex .. text .. "|r"
end

local function SetFontNormal(fs)
    fs:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
end

local function SetFontSmall(fs)
    fs:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
end

-- ─────────────────────────────────────────────
-- Main frame
-- ─────────────────────────────────────────────

function UI:Build()
    if self.frame then return end

    -- Outer frame
    local f = CreateFrame("Frame", "TBCBisTrackerFrame", UIParent, "BasicFrameTemplateWithInset")
    f:SetSize(FRAME_W, FRAME_H)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop",  f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    f:SetFrameStrata("HIGH")
    f:Hide()
    self.frame = f

    -- Restore saved position
    local wp = TBCBisTrackerDB.windowPos
    if wp and wp.point then
        f:ClearAllPoints()
        f:SetPoint(wp.point, UIParent, wp.point, wp.x, wp.y)
    end

    f:SetScript("OnHide", function()
        local pt, _, _, x, y = f:GetPoint()
        TBCBisTrackerDB.windowPos = { point = pt or "CENTER", x = x or 0, y = y or 0 }
    end)

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", f, "TOP", 0, -6)
    title:SetText("|cffffd700TBC BIS Tracker|r  |cffaaaaaa— WoW TBC Anniversary|r")
    self.titleText = title

    -- Close button label (frame template already adds X button)

    -- ── Class buttons row ──
    self:BuildClassButtons()

    -- ── Spec dropdown ──
    self:BuildSpecSelector()

    -- ── Phase tabs ──
    self:BuildPhaseTabs()

    -- ── Checkbox: show missing only ──
    self:BuildMissingFilter()

    -- ── Source-type filter dropdown ──
    self:BuildSourceFilter()

    -- ── Export/Import buttons ──
    self:BuildExportImportButtons()

    -- ── Column headers ──
    self:BuildColumnHeaders()

    -- ── Scrollable gear list ──
    self:BuildScrollFrame()

    -- ── Progress bar ──
    self:BuildProgressBar()

    -- ── Badge of Justice status line ──
    self:BuildBadgeStatus()

    -- ── Tier set bonus tracker ──
    self:BuildTierStatus()

    -- ── Farm plan (bottom-right hover) ──
    self:BuildFarmPlan()

    -- Initial population
    self:RefreshClassButtons()
    self:RefreshSpecSelector()
    self:RefreshPhaseTabs()
    self:Refresh()
end

-- ─────────────────────────────────────────────
-- Class buttons
-- ─────────────────────────────────────────────

function UI:BuildClassButtons()
    -- Class is locked to the character; title bar already shows class/spec/phase.
    local _, playerClass = UnitClass("player")
    if not playerClass then playerClass = TBCBisTrackerDB.lastClass end
    if not playerClass then return end

    TBCBisTrackerDB.lastClass = playerClass
    local info = addon.CLASS_INFO[playerClass]
    if not info then return end

    -- Normalize lastSpec for this class (e.g. saved spec from a different class alt)
    local valid = {}
    for _, s in ipairs(info.specs) do valid[s] = true end
    if not (TBCBisTrackerDB.lastSpec and valid[TBCBisTrackerDB.lastSpec]) then
        TBCBisTrackerDB.lastSpec = info.specs[1]
    end
    self.classBtns = {}
end

function UI:RefreshClassButtons()
    -- No-op: only the player's class is shown.
end

-- ─────────────────────────────────────────────
-- Spec selector (dropdown buttons below class row)
-- ─────────────────────────────────────────────

function UI:BuildSpecSelector()
    local f = self.frame
    self.specBtns = {}
    self.specBtnRow = CreateFrame("Frame", nil, f)
    self.specBtnRow:SetSize(FRAME_W - 40, 22)
    self.specBtnRow:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -38)
end

local SPEC_POOL_SIZE = 4

local function GetOrCreateSpecBtn(self, idx)
    local btn = self.specBtns[idx]
    if btn then return btn end

    btn = CreateFrame("Button", nil, self.specBtnRow)
    btn:SetHeight(22)

    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    btn.bg = bg

    local fs = btn:CreateFontString(nil, "OVERLAY")
    SetFontSmall(fs)
    fs:SetAllPoints()
    btn.fs = fs

    btn:SetScript("OnEnter", function(s)
        if s.spec ~= TBCBisTrackerDB.lastSpec then
            s.bg:SetVertexColor(0.25, 0.25, 0.25, 1)
        end
    end)
    btn:SetScript("OnLeave", function(s)
        if s.spec == TBCBisTrackerDB.lastSpec then
            s.bg:SetVertexColor(0.25, 0.20, 0.05, 0.9)
        else
            s.bg:SetVertexColor(0.12, 0.12, 0.12, 0.8)
        end
    end)
    btn:SetScript("OnClick", function(s)
        if not s.spec then return end
        TBCBisTrackerDB.lastSpec = s.spec
        UI:RefreshSpecSelector()
        UI:Refresh()
    end)

    self.specBtns[idx] = btn
    return btn
end

function UI:RefreshSpecSelector()
    local class = TBCBisTrackerDB.lastClass
    if not class then return end
    local info  = addon.CLASS_INFO[class]
    if not info then return end

    local x = 0
    for i = 1, SPEC_POOL_SIZE do
        local spec = info.specs[i]
        local btn  = GetOrCreateSpecBtn(self, i)
        if spec then
            btn.spec = spec
            btn.fs:SetText(spec)
            local w = btn.fs:GetStringWidth() + 24
            btn:SetWidth(w)
            btn:ClearAllPoints()
            btn:SetPoint("LEFT", self.specBtnRow, "LEFT", x, 0)
            if spec == TBCBisTrackerDB.lastSpec then
                btn.fs:SetTextColor(1, 0.82, 0, 1)
                btn.bg:SetVertexColor(0.25, 0.20, 0.05, 0.9)
            else
                btn.fs:SetTextColor(0.8, 0.8, 0.8, 1)
                btn.bg:SetVertexColor(0.12, 0.12, 0.12, 0.8)
            end
            btn:Show()
            x = x + w + 4
        else
            btn.spec = nil
            btn:Hide()
        end
    end
end

-- ─────────────────────────────────────────────
-- Phase tabs
-- ─────────────────────────────────────────────

function UI:BuildPhaseTabs()
    local f = self.frame
    self.phaseTabs = {}
    local tabW    = (FRAME_W - 40) / #addon.PHASES
    local yOffset = -64

    for i, phase in ipairs(addon.PHASES) do
        local btn = CreateFrame("Button", nil, f)
        btn:SetSize(tabW - 2, PHASE_TAB_H)
        btn:SetPoint("TOPLEFT", f, "TOPLEFT", 20 + (i-1) * tabW, yOffset)

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        btn.bg = bg

        local fs = btn:CreateFontString(nil, "OVERLAY")
        SetFontNormal(fs)
        fs:SetAllPoints()
        fs:SetText(addon.PHASE_LABELS[phase])
        btn.fs = fs

        local capturedPhase = phase
        btn:SetScript("OnClick", function()
            TBCBisTrackerDB.lastPhase = capturedPhase
            UI:RefreshPhaseTabs()
            UI:Refresh()
        end)

        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(addon.PHASE_DESCRIPTIONS[capturedPhase], 1, 1, 1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

        self.phaseTabs[phase] = btn
    end

    -- separator line below tabs
    local sep = f:CreateTexture(nil, "OVERLAY")
    sep:SetSize(FRAME_W - 40, 1)
    sep:SetPoint("TOPLEFT", f, "TOPLEFT", 20, yOffset - PHASE_TAB_H)
    sep:SetTexture(1, 0.82, 0, 0.4)
end

function UI:RefreshPhaseTabs()
    local selected = TBCBisTrackerDB.lastPhase
    local class    = TBCBisTrackerDB.lastClass
    local spec     = TBCBisTrackerDB.lastSpec
    for phase, btn in pairs(self.phaseTabs) do
        local label = addon.PHASE_LABELS[phase] or phase
        if class and spec then
            local got, tot = addon:GetPhaseProgress(class, spec, phase)
            if tot > 0 then
                local pctColor = (got == tot) and "|cffffd700" or "|cffaaaaaa"
                label = label .. " " .. pctColor .. "(" .. got .. "/" .. tot .. ")|r"
            end
        end
        btn.fs:SetText(label)
        if phase == selected then
            btn.bg:SetVertexColor(0.25, 0.20, 0.05, 0.9)
            btn.fs:SetTextColor(1, 0.82, 0, 1)
        else
            btn.bg:SetVertexColor(0.10, 0.10, 0.10, 0.8)
            btn.fs:SetTextColor(0.70, 0.70, 0.70, 1)
        end
    end
end

-- ─────────────────────────────────────────────
-- Missing-only filter checkbox
-- ─────────────────────────────────────────────

function UI:ShowExportPopup()
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local text  = addon:ExportSetup(class, spec, phase)
    if not text then addon:Print("Nothing to export."); return end
    StaticPopupDialogs["TBCBIS_EXPORT"] = {
        text = "Export — Ctrl+A then Ctrl+C to copy:",
        button1 = "Close",
        hasEditBox = true,
        editBoxWidth = 350,
        maxLetters = 999,
        OnShow = function(s)
            local eb = s.editBox or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            if not eb then return end
            eb:SetMaxLetters(999)
            eb:SetMaxBytes(0)
            eb:SetText(text)
            eb:HighlightText()
            eb:SetFocus()
        end,
        EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("TBCBIS_EXPORT")
end

function UI:ShowImportPopup()
    StaticPopupDialogs["TBCBIS_IMPORT"] = {
        text = "Paste an exported setup string:",
        button1 = "Import",
        button2 = "Cancel",
        hasEditBox = true,
        editBoxWidth = 350,
        OnShow = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            if eb then eb:SetText(""); eb:SetFocus() end
        end,
        OnAccept = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            local input = eb and eb:GetText() or ""
            local ok, msg = addon:ImportSetup(input)
            addon:Print(ok and ("Import: " .. msg) or ("Import failed: " .. tostring(msg)))
            if ok then UI:Refresh() end
        end,
        EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("TBCBIS_IMPORT")
end

local SOURCE_FILTER_OPTIONS = { "all", "raid", "heroic", "dungeon", "crafted", "reputation", "world", "quest", "pvp" }
local SOURCE_FILTER_LABELS = {
    all        = "All sources",
    raid       = "Raid only",
    heroic     = "Heroic only",
    dungeon    = "Dungeon only",
    crafted    = "Crafted only",
    reputation = "Reputation only",
    world      = "World drop only",
    quest      = "Quest only",
    pvp        = "PvP only",
}

function UI:BuildSourceFilter()
    local f = self.frame
    local dd = CreateFrame("Frame", "TBCBisTrackerSourceFilterDropdown", f, "UIDropDownMenuTemplate")
    dd:SetPoint("TOPRIGHT", f, "TOPRIGHT", -150, -32)
    UIDropDownMenu_SetWidth(dd, 110)
    self.sourceFilterDropdown = dd

    UIDropDownMenu_Initialize(dd, function(_, level)
        for _, opt in ipairs(SOURCE_FILTER_OPTIONS) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = SOURCE_FILTER_LABELS[opt] or opt
            info.value = opt
            info.checked = (TBCBisTrackerDB.sourceFilter or "all") == opt
            info.func = function()
                TBCBisTrackerDB.sourceFilter = opt
                UIDropDownMenu_SetSelectedValue(dd, opt)
                UIDropDownMenu_SetText(dd, SOURCE_FILTER_LABELS[opt])
                UI:Refresh()
                CloseDropDownMenus()
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)
    UIDropDownMenu_SetSelectedValue(dd, TBCBisTrackerDB.sourceFilter or "all")
    UIDropDownMenu_SetText(dd, SOURCE_FILTER_LABELS[TBCBisTrackerDB.sourceFilter or "all"])
end

function UI:BuildExportImportButtons()
    local f = self.frame
    local importBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    importBtn:SetSize(60, 18)
    importBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -30, -8)
    importBtn:SetText("Import")
    importBtn:SetScript("OnClick", function() UI:ShowImportPopup() end)

    local exportBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    exportBtn:SetSize(60, 18)
    exportBtn:SetPoint("RIGHT", importBtn, "LEFT", -4, 0)
    exportBtn:SetText("Export")
    exportBtn:SetScript("OnClick", function() UI:ShowExportPopup() end)
end

function UI:BuildMissingFilter()
    local f = self.frame
    local chk = CreateFrame("CheckButton", "TBCBisTrackerMissingChk", f, "UICheckButtonTemplate")
    chk:SetSize(20, 20)
    chk:SetPoint("TOPRIGHT", f, "TOPRIGHT", -30, -98)
    chk:SetChecked(TBCBisTrackerDB.showMissingOnly or false)

    local lbl = f:CreateFontString(nil, "OVERLAY")
    SetFontSmall(lbl)
    lbl:SetText("Show missing only")
    lbl:SetPoint("RIGHT", chk, "LEFT", -2, 0)

    chk:SetScript("OnClick", function(self)
        TBCBisTrackerDB.showMissingOnly = self:GetChecked()
        UI:Refresh()
    end)
    self.missingChk = chk
end

-- ─────────────────────────────────────────────
-- Column headers
-- ─────────────────────────────────────────────

function UI:BuildColumnHeaders()
    local f      = self.frame
    local yOff   = -100
    local xStart = 20

    local headers = {
        { text = "",        w = COL_ICON_W },
        { text = "Slot",    w = COL_SLOT_W },
        { text = "Item",    w = COL_ITEM_W },
        { text = "Source",  w = COL_SRC_W  },
        { text = "Got It",  w = COL_CHK_W  },
    }

    local x = xStart
    for _, h in ipairs(headers) do
        if h.text ~= "" then
            local fs = f:CreateFontString(nil, "OVERLAY")
            SetFontSmall(fs)
            fs:SetTextColor(0.7, 0.7, 0.7, 1)
            fs:SetWidth(h.w)
            fs:SetJustifyH("LEFT")
            fs:SetPoint("TOPLEFT", f, "TOPLEFT", x, yOff)
            fs:SetText(h.text)
        end
        x = x + h.w + 4
    end

    -- divider
    local div = f:CreateTexture(nil, "OVERLAY")
    div:SetSize(FRAME_W - 40, 1)
    div:SetPoint("TOPLEFT", f, "TOPLEFT", xStart, yOff - 14)
    div:SetTexture(0.4, 0.4, 0.4, 0.8)
end

-- ─────────────────────────────────────────────
-- Scrollable gear list
-- ─────────────────────────────────────────────

function UI:BuildScrollFrame()
    local f       = self.frame
    local scrollY = -118
    local scrollH = FRAME_H - 118 - 80  -- leave room for progress bar + badge/tier status

    -- Scroll frame
    local sf = CreateFrame("ScrollFrame", "TBCBisTrackerScroll", f, "UIPanelScrollFrameTemplate")
    sf:SetSize(FRAME_W - 44, scrollH)
    sf:SetPoint("TOPLEFT", f, "TOPLEFT", 20, scrollY)
    self.scrollFrame = sf

    -- Content frame inside scroll frame
    local content = CreateFrame("Frame", nil, sf)
    content:SetSize(FRAME_W - 44, 17 * (ROW_H + ROW_PAD))
    sf:SetScrollChild(content)
    self.scrollContent = content

    -- Pool of row frames
    self.rowPool = {}
    for i = 1, 18 do
        local row = self:CreateRowFrame(content, i)
        self.rowPool[i] = row
        row:Hide()
    end
end

function UI:CreateRowFrame(parent, idx)
    local row = CreateFrame("Button", nil, parent)
    row:SetHeight(ROW_H)

    -- Background (alternating)
    local bg = row:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    if idx % 2 == 0 then
        bg:SetVertexColor(0.10, 0.10, 0.14, 0.6)
    else
        bg:SetVertexColor(0.06, 0.06, 0.09, 0.4)
    end
    row.bg = bg

    local x = 0

    -- Slot icon
    local iconTex = row:CreateTexture(nil, "ARTWORK")
    iconTex:SetSize(22, 22)
    iconTex:SetPoint("LEFT", row, "LEFT", x + 2, 0)
    row.iconTex = iconTex
    x = x + COL_ICON_W + 4

    -- Slot label
    local slotLbl = row:CreateFontString(nil, "OVERLAY")
    SetFontSmall(slotLbl)
    slotLbl:SetWidth(COL_SLOT_W)
    slotLbl:SetJustifyH("LEFT")
    slotLbl:SetPoint("LEFT", row, "LEFT", x, 0)
    slotLbl:SetTextColor(0.7, 0.7, 0.7, 1)
    row.slotLbl = slotLbl
    x = x + COL_SLOT_W + 4

    -- Item name
    local itemLbl = row:CreateFontString(nil, "OVERLAY")
    SetFontNormal(itemLbl)
    itemLbl:SetWidth(COL_ITEM_W)
    itemLbl:SetJustifyH("LEFT")
    itemLbl:SetPoint("LEFT", row, "LEFT", x, 0)
    row.itemLbl = itemLbl
    x = x + COL_ITEM_W + 4

    -- Source label
    local srcLbl = row:CreateFontString(nil, "OVERLAY")
    SetFontSmall(srcLbl)
    srcLbl:SetWidth(COL_SRC_W)
    srcLbl:SetJustifyH("LEFT")
    srcLbl:SetPoint("LEFT", row, "LEFT", x, 0)
    srcLbl:SetTextColor(0.65, 0.65, 0.65, 1)
    row.srcLbl = srcLbl
    x = x + COL_SRC_W + 4

    -- Checkbox
    local chk = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
    chk:SetSize(20, 20)
    chk:SetPoint("LEFT", row, "LEFT", x + 4, 0)
    row.chk = chk

    -- Hover highlight + tooltip; shift = side-by-side comparison
    row:SetScript("OnEnter", function(self)
        self.bg:SetVertexColor(0.20, 0.20, 0.30, 0.8)
        if self.itemId and self.itemId > 0 then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink("item:" .. self.itemId .. ":0:0:0:0:0:0:0")
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("|cffaaaaaa" .. (addon.WOWHEAD_BASE .. self.itemId) .. "|r", 1, 1, 1, true)
            GameTooltip:Show()
            if IsShiftKeyDown() and GameTooltip_ShowCompareItem then
                GameTooltip_ShowCompareItem(GameTooltip)
            end
        end
    end)
    row:SetScript("OnLeave", function(self)
        if idx % 2 == 0 then
            self.bg:SetVertexColor(0.10, 0.10, 0.14, 0.6)
        else
            self.bg:SetVertexColor(0.06, 0.06, 0.09, 0.4)
        end
        GameTooltip:Hide()
    end)

    -- Click handlers: cursor-drop = import; shift+left = chat-link; ctrl+left = URL; right = alts menu
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    row:SetScript("OnClick", function(self, button)
        if button == "LeftButton" and CursorHasItem() then
            UI:ImportFromCursor(self.slotKey)
            return
        end
        if button == "LeftButton" and IsShiftKeyDown() and self.itemId and self.itemId > 0 then
            local _, link = GetItemInfo(self.itemId)
            if link then
                if ChatEdit_InsertLink then
                    ChatEdit_InsertLink(link)
                else
                    DEFAULT_CHAT_FRAME.editBox:Insert(link)
                end
            end
        elseif button == "LeftButton" and IsControlKeyDown() and self.itemId and self.itemId > 0 then
            local capturedId = self.itemId
            StaticPopupDialogs["TBCBIS_WOWHEAD_URL"] = {
                text = "Wowhead URL (Ctrl+C to copy):",
                button1 = "Close",
                hasEditBox = true,
                editBoxWidth = 350,
                OnShow = function(s)
                    local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
                    if not eb then return end
                    eb:SetText(addon.WOWHEAD_BASE .. capturedId)
                    eb:HighlightText()
                    eb:SetFocus()
                end,
                EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
                timeout = 0, whileDead = true, hideOnEscape = true,
            }
            StaticPopup_Show("TBCBIS_WOWHEAD_URL")
        elseif button == "RightButton" and self.slotKey then
            UI:ShowAlternativesMenu(self, self.slotKey)
        end
    end)

    -- Drag-drop: drop a bag or equipped item onto the row to import it as an alternative
    row:SetScript("OnReceiveDrag", function(self)
        if self.slotKey then UI:ImportFromCursor(self.slotKey) end
    end)

    return row
end

-- Set selected alternative by item id; returns true if found
local function selectAltById(class, spec, phase, slot, itemId)
    local alts = addon:GetSlotAlternatives(class, spec, phase, slot)
    if not alts then return false end
    for i, alt in ipairs(alts) do
        if alt.id == itemId then
            addon:SetSelectedAlt(class, spec, phase, slot, i)
            return true
        end
    end
    return false
end

function UI:ImportOrSelect(slot, itemId, sourceLabel)
    if not itemId then return end
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local nameOrId = GetItemInfo(itemId) or itemId
    if selectAltById(class, spec, phase, slot, itemId) then
        addon:Print(nameOrId .. " — already in list; selected.")
    else
        addon:AddCustomAlt(class, spec, phase, slot, itemId, sourceLabel or "Custom")
        selectAltById(class, spec, phase, slot, itemId)
        addon:Print("Added " .. nameOrId .. " to " .. (addon.SLOT_LABELS[slot] or slot) .. " and selected.")
    end
    addon:ScanEquipped()  -- tick obtained if the item is in bags/equipped
    UI:Refresh()
end

-- Find the BIS slot whose equipLoc whitelist accepts this item.
-- If the dropped slot accepts it, keep it. Otherwise pick the first matching slot in SLOTS order.
local function routeSlotForItem(equipLoc, droppedSlot)
    if not equipLoc or equipLoc == "" then return droppedSlot end
    if addon.SLOT_INVTYPES[droppedSlot] and addon.SLOT_INVTYPES[droppedSlot][equipLoc] then
        return droppedSlot
    end
    for _, slot in ipairs(addon.SLOTS) do
        local map = addon.SLOT_INVTYPES[slot]
        if map and map[equipLoc] then
            return slot
        end
    end
    return nil
end

function UI:ShowSearchDialog(slot)
    StaticPopupDialogs["TBCBIS_SEARCH"] = {
        text = "Search items by name (target slot: " .. (addon.SLOT_LABELS[slot] or slot) .. "):",
        button1 = "Search",
        button2 = "Cancel",
        hasEditBox = true,
        editBoxWidth = 250,
        OnShow = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            if eb then eb:SetText(""); eb:SetFocus() end
        end,
        OnAccept = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            local query = eb and eb:GetText() or ""
            if query == "" then return end
            local results = addon:SearchItems(query, 20)
            if #results == 0 then
                addon:Print("No items found for: " .. query)
                return
            end
            UI:ShowSearchResults(slot, query, results)
        end,
        EditBoxOnEnterPressed = function(s)
            local parent = s:GetParent()
            local dialog = StaticPopupDialogs[parent.which]
            if dialog and dialog.OnAccept then dialog.OnAccept(parent) end
            parent:Hide()
        end,
        EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("TBCBIS_SEARCH")
end

function UI:ShowSearchResults(slot, query, results)
    if not self.searchDropdown then
        self.searchDropdown = CreateFrame("Frame", "TBCBisTrackerSearchDropdown", UIParent, "UIDropDownMenuTemplate")
    end
    self.searchMenuItemIds = {}
    UIDropDownMenu_Initialize(self.searchDropdown, function(_, level)
        local title = UIDropDownMenu_CreateInfo()
        title.text = "Results for \"" .. query .. "\" — click to import"
        title.isTitle = true
        title.notCheckable = true
        UIDropDownMenu_AddButton(title, level)
        for i, r in ipairs(results) do
            local label = r.name or ("item:" .. r.id)
            local color = addon:GetItemQualityColor(r.id) or "|cffffffff"
            local info = UIDropDownMenu_CreateInfo()
            info.text = color .. label .. "|r"
            info.notCheckable = true
            info.func = function()
                UI:ImportOrSelect(slot, r.id, "Search import")
                CloseDropDownMenus()
            end
            UIDropDownMenu_AddButton(info, level)
            UI.searchMenuItemIds[i + 1] = r.id  -- offset +1 for the title row
        end
        local cancel = UIDropDownMenu_CreateInfo()
        cancel.text = "Cancel"
        cancel.notCheckable = true
        cancel.func = function() CloseDropDownMenus() end
        UIDropDownMenu_AddButton(cancel, level)
    end, "MENU")
    ToggleDropDownMenu(1, nil, self.searchDropdown, "cursor", 0, 0)

    -- Attach item tooltips on hover
    C_Timer.After(0, function()
        for i = 1, 32 do
            local btn = _G["DropDownList1Button" .. i]
            if not btn or not btn:IsShown() then break end
            local id = UI.searchMenuItemIds[i]
            if id and not btn.tbcbisSearchHooked then
                btn.tbcbisSearchHooked = true
                btn:HookScript("OnEnter", function(s)
                    GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink("item:" .. id .. ":0:0:0:0:0:0:0")
                    GameTooltip:Show()
                    if IsShiftKeyDown() and GameTooltip_ShowCompareItem then
                        GameTooltip_ShowCompareItem(GameTooltip)
                    end
                end)
                btn:HookScript("OnLeave", function() GameTooltip:Hide() end)
            end
        end
    end)
end

function UI:ImportFromCursor(droppedSlot)
    if not CursorHasItem() then return end
    local cursorType, _, itemLink = GetCursorInfo()
    ClearCursor()
    if cursorType ~= "item" or not itemLink then return end
    local itemId = tonumber(itemLink:match("item:(%d+)"))
    if not itemId then return end
    local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(itemId)
    local targetSlot = routeSlotForItem(equipLoc, droppedSlot)
    if not targetSlot then
        addon:Print((GetItemInfo(itemId) or itemId) .. " can't be routed to a tracked slot (equipLoc=" .. tostring(equipLoc) .. ").")
        return
    end
    if targetSlot ~= droppedSlot then
        addon:Print("Routed to " .. (addon.SLOT_LABELS[targetSlot] or targetSlot) .. ".")
    end
    UI:ImportOrSelect(targetSlot, itemId, "Custom (drag-drop)")
end

function UI:ShowAlternativesMenu(anchorFrame, slot)
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local alts  = addon:GetSlotAlternatives(class, spec, phase, slot)
    if not alts or #alts == 0 then
        -- Empty slot in DB and no custom imports yet; offer the import option from a minimal menu
        alts = {}
    end
    local currentIdx = addon:GetSelectedAlt(class, spec, phase, slot)

    if not self.altDropdown then
        self.altDropdown = CreateFrame("Frame", "TBCBisTrackerAltDropdown", UIParent, "UIDropDownMenuTemplate")
    end

    UIDropDownMenu_Initialize(self.altDropdown, function(_, level)
        local title = UIDropDownMenu_CreateInfo()
        title.text = "Track for " .. (addon.SLOT_LABELS[slot] or slot)
        title.isTitle = true
        title.notCheckable = true
        UIDropDownMenu_AddButton(title, level)

        for i, alt in ipairs(alts) do
            local name  = addon:GetItemName(alt.id)
            local color = addon:GetItemQualityColor(alt.id)
            local prefix = (i == 1) and "|cffffd700[BiS]|r " or "|cffaaaaaa[Alt " .. (i-1) .. "]|r "
            local info = UIDropDownMenu_CreateInfo()
            info.text     = prefix .. color .. name .. "|r"
            info.checked  = (i == currentIdx)
            info.func     = function()
                addon:SetSelectedAlt(class, spec, phase, slot, i)
                UI:Refresh()
                CloseDropDownMenus()
            end
            UIDropDownMenu_AddButton(info, level)
        end

        local sep = UIDropDownMenu_CreateInfo()
        sep.text = ""
        sep.isTitle = true
        sep.notCheckable = true
        UIDropDownMenu_AddButton(sep, level)

        local search = UIDropDownMenu_CreateInfo()
        local searchLabel = "|cffaaff00Search by name...|r"
        if addon.atlasLootDetected then searchLabel = searchLabel .. " |cff888888(AtlasLoot)|r" end
        search.text = searchLabel
        search.notCheckable = true
        search.func = function()
            CloseDropDownMenus()
            UI:ShowSearchDialog(slot)
        end
        UIDropDownMenu_AddButton(search, level)

        local imp = UIDropDownMenu_CreateInfo()
        imp.text = "|cff00ff00Import from Wowhead...|r"
        imp.notCheckable = true
        imp.func = function()
            StaticPopupDialogs["TBCBIS_IMPORT_WOWHEAD"] = {
                text = "Paste a Wowhead URL or item ID for " .. (addon.SLOT_LABELS[slot] or slot) .. ":",
                button1 = "Add",
                button2 = "Cancel",
                hasEditBox = true,
                editBoxWidth = 350,
                OnShow = function(s)
                    local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
                    if eb then eb:SetFocus() end
                end,
                OnAccept = function(s)
                    local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
                    local input = eb and eb:GetText() or ""
                    local id = addon:ParseWowheadInput(input)
                    if not id then
                        addon:Print("Could not parse a Wowhead item URL/ID from: " .. tostring(input))
                        return
                    end
                    UI:ImportOrSelect(slot, id, "Custom (Wowhead import)")
                end,
                EditBoxOnEnterPressed = function(s)
                    local parent = s:GetParent()
                    if parent.OnAccept then parent.OnAccept(parent) end
                    parent:Hide()
                end,
                EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
                timeout = 0, whileDead = true, hideOnEscape = true,
            }
            StaticPopup_Show("TBCBIS_IMPORT_WOWHEAD")
            CloseDropDownMenus()
        end
        UIDropDownMenu_AddButton(imp, level)

        -- Allow removing user-added alternatives
        local custom = addon:GetCustomAlts(class, spec, phase, slot)
        if custom and #custom > 0 then
            for _, ci in ipairs(custom) do
                local removeInfo = UIDropDownMenu_CreateInfo()
                local nm = addon:GetItemName(ci.id)
                removeInfo.text = "|cffff6060Remove|r " .. nm
                removeInfo.notCheckable = true
                local capturedId = ci.id
                removeInfo.func = function()
                    addon:RemoveCustomAlt(class, spec, phase, slot, capturedId)
                    -- Reset selection if it pointed past the new list end
                    addon:SetSelectedAlt(class, spec, phase, slot, 1)
                    UI:Refresh()
                    CloseDropDownMenus()
                end
                UIDropDownMenu_AddButton(removeInfo, level)
            end
        end

        local cancel = UIDropDownMenu_CreateInfo()
        cancel.text = "Cancel"
        cancel.notCheckable = true
        cancel.func = function() CloseDropDownMenus() end
        UIDropDownMenu_AddButton(cancel, level)
    end, "MENU")

    -- Track which item id corresponds to which menu position so we can attach item tooltips
    self.altMenuItemIds = {}
    local pos = 1
    pos = pos + 1  -- skip title row
    for i = 1, #alts do
        self.altMenuItemIds[pos] = alts[i].id
        pos = pos + 1
    end

    ToggleDropDownMenu(1, nil, self.altDropdown, "cursor", 0, 0)

    -- After the dropdown renders, attach item tooltips to each button
    C_Timer.After(0, function()
        local list = _G["DropDownList1"]
        if not list then return end
        for i = 1, 32 do
            local btn = _G["DropDownList1Button" .. i]
            if not btn or not btn:IsShown() then break end
            local itemId = UI.altMenuItemIds[i]
            if itemId and not btn.tbcbisHooked then
                btn.tbcbisHooked = true
                btn:HookScript("OnEnter", function(s)
                    local id = UI.altMenuItemIds[i]
                    if not id then return end
                    GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink("item:" .. id .. ":0:0:0:0:0:0:0")
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine("|cffaaaaaa" .. addon.WOWHEAD_BASE .. id .. "|r", 1, 1, 1, true)
                    GameTooltip:Show()
                    if IsShiftKeyDown() and GameTooltip_ShowCompareItem then
                        GameTooltip_ShowCompareItem(GameTooltip)
                    end
                end)
                btn:HookScript("OnLeave", function() GameTooltip:Hide() end)
            end
        end
    end)
end

-- ─────────────────────────────────────────────
-- Progress bar
-- ─────────────────────────────────────────────

function UI:BuildBadgeStatus()
    local f = self.frame
    local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 22, 42)
    fs:SetJustifyH("LEFT")
    self.badgeStatus = fs

    -- Hover: show breakdown of unobtained badge items
    local hoverFrame = CreateFrame("Frame", nil, f)
    hoverFrame:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 18, 38)
    hoverFrame:SetSize(380, 16)
    hoverFrame:EnableMouse(true)
    hoverFrame:SetScript("OnEnter", function(self)
        local class = TBCBisTrackerDB.lastClass
        local spec  = TBCBisTrackerDB.lastSpec
        local phase = TBCBisTrackerDB.lastPhase
        local owned, total, items = addon:GetBadgeProgress(class, spec, phase)
        if #items == 0 then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Badge purchases (" .. addon.PHASE_LABELS[phase] .. ")")
        GameTooltip:AddLine(string.format("Owned: %d   Total cost: %d", owned, total), 1, 1, 1)
        GameTooltip:AddLine(" ")
        for _, it in ipairs(items) do
            local name = GetItemInfo(it.entry.id) or ("item:" .. it.entry.id)
            local color = addon:GetItemQualityColor(it.entry.id) or "|cffffffff"
            GameTooltip:AddDoubleLine(
                color .. name .. "|r — " .. (addon.SLOT_LABELS[it.slot] or it.slot),
                it.cost .. " BoJ",
                1, 1, 1, 1, 0.84, 0
            )
        end
        GameTooltip:Show()
    end)
    hoverFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
    self.badgeHover = hoverFrame
end

function UI:BuildFarmPlan()
    local f = self.frame
    local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -22, 42)
    fs:SetJustifyH("RIGHT")
    fs:SetText("|cff00d0ff[Hover for farm plan]|r")
    self.farmHint = fs

    local hover = CreateFrame("Frame", nil, f)
    hover:SetSize(160, 16)
    hover:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -18, 38)
    hover:EnableMouse(true)
    hover:SetScript("OnEnter", function(self)
        local class = TBCBisTrackerDB.lastClass
        local spec  = TBCBisTrackerDB.lastSpec
        local phase = TBCBisTrackerDB.lastPhase
        local groups = addon:GetFarmBreakdown(class, spec, phase)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Farm plan — " .. (addon.PHASE_LABELS[phase] or phase))
        if not groups or #groups == 0 then
            GameTooltip:AddLine("Nothing left to farm — all items obtained!", 1, 0.84, 0)
        else
            for _, group in ipairs(groups) do
                GameTooltip:AddLine(" ")
                GameTooltip:AddDoubleLine("|cffffd700" .. group.label .. "|r", group.count .. " unobtained", 1, 0.84, 0, 0.9, 0.9, 0.9)
                for _, sub in ipairs(group.locations or {}) do
                    if group.type == "reputation" then
                        local fname, requiredStanding, requiredId = addon:ParseRepLocation(sub.location)
                        if fname and requiredStanding then
                            local matched, currentId = addon:GetCurrentReputation(fname)
                            local statusText
                            if currentId then
                                local current = addon.STANDING_NAMES[currentId] or "?"
                                if currentId >= requiredId then
                                    statusText = "|cff00ff00✓ " .. current .. "|r"
                                else
                                    statusText = "|cffff8800" .. current .. " → " .. requiredStanding .. "|r"
                                end
                            else
                                statusText = "|cff888888not yet discovered|r"
                            end
                            GameTooltip:AddDoubleLine("  " .. (matched or fname) .. " (" .. requiredStanding .. ")", statusText, 0.8, 0.85, 0.95, 1, 1, 1)
                        else
                            GameTooltip:AddDoubleLine("  " .. sub.location, sub.count, 0.8, 0.85, 0.95, 1, 1, 1)
                        end
                    else
                        GameTooltip:AddDoubleLine("  " .. sub.location, sub.count, 0.8, 0.85, 0.95, 1, 1, 1)
                    end
                end
            end
        end
        GameTooltip:Show()
    end)
    hover:SetScript("OnLeave", function() GameTooltip:Hide() end)
    self.farmHover = hover
end

function UI:BuildTierStatus()
    local f = self.frame
    local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 22, 58)
    fs:SetJustifyH("LEFT")
    self.tierStatus = fs
end

function UI:RefreshTierStatus()
    if not self.tierStatus then return end
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local progress = addon:GetTierProgress(class, spec, phase)

    -- Stable ordering (T4, T5, T6, T6.5)
    local order = { "T4", "T5", "T6", "T6.5" }
    local parts = {}
    for _, t in ipairs(order) do
        local p = progress[t]
        if p and p.total > 0 then
            local bonus
            if p.obtained >= 4 then bonus = " |cffff8000(4pc!)|r"
            elseif p.obtained >= 2 then bonus = " |cff00ff00(2pc)|r"
            else bonus = ""
            end
            local color = (p.obtained >= p.total) and "|cffffd700" or "|cffaaaaaa"
            table.insert(parts, color .. t .. ": " .. p.obtained .. "/" .. p.total .. "|r" .. bonus)
        end
    end
    if #parts == 0 then
        self.tierStatus:SetText("")
    else
        self.tierStatus:SetText("|cff888888Tier set:|r  " .. table.concat(parts, "   "))
    end
end

function UI:RefreshBadgeStatus()
    if not self.badgeStatus then return end
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local owned, total, items = addon:GetBadgeProgress(class, spec, phase)
    if total == 0 then
        self.badgeStatus:SetText("|cff888888Badges of Justice: " .. owned .. "|r")
    elseif owned >= total then
        self.badgeStatus:SetText(string.format("|cffffd700Badges: %d / %d (enough!)|r — %d items remaining", owned, total, #items))
    else
        local diff = total - owned
        self.badgeStatus:SetText(string.format("|cffaaaaaaBadges: %d / %d|r — need |cffff8800%d more|r for %d unobtained items", owned, total, diff, #items))
    end
end

function UI:BuildProgressBar()
    local f = self.frame

    local container = CreateFrame("Frame", nil, f)
    container:SetSize(FRAME_W - 40, PROGRESS_H)
    container:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 20, 8)
    self.progressContainer = container

    -- Background track
    local track = container:CreateTexture(nil, "BACKGROUND")
    track:SetAllPoints()
    track:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    track:SetVertexColor(0.1, 0.1, 0.1, 0.8)

    -- Fill bar
    local fill = container:CreateTexture(nil, "ARTWORK")
    fill:SetPoint("LEFT", container, "LEFT", 2, 0)
    fill:SetHeight(PROGRESS_H - 4)
    fill:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
    fill:SetVertexColor(0.1, 0.7, 0.2, 0.85)
    self.progressFill = fill

    -- Text
    local txt = container:CreateFontString(nil, "OVERLAY")
    SetFontNormal(txt)
    txt:SetAllPoints()
    txt:SetJustifyH("CENTER")
    self.progressTxt = txt
end

-- ─────────────────────────────────────────────
-- Populate gear rows (called on every Refresh)
-- ─────────────────────────────────────────────

function UI:Refresh()
    if not self.frame then return end
    local class  = TBCBisTrackerDB.lastClass
    local spec   = TBCBisTrackerDB.lastSpec
    local phase  = TBCBisTrackerDB.lastPhase
    local missingOnly = TBCBisTrackerDB.showMissingOnly

    -- Hide all rows first
    for _, row in ipairs(self.rowPool) do row:Hide() end

    local data = addon:GetPhaseData(class, spec, phase)

    -- Update title
    if class and spec then
        local info = addon.CLASS_INFO[class]
        if info then
            self.titleText:SetText(
                "|cffffd700TBC BIS Tracker|r  " ..
                "|cff" .. info.color .. info.name .. "|r" ..
                " — " .. spec ..
                "  |cffaaaaaa" .. addon.PHASE_LABELS[phase] .. "|r"
            )
        end
    end

    if not data then
        self:UpdateProgress(0, 0)
        return
    end

    local rowIdx = 0
    local obtained, total = 0, 0

    local sourceFilter = TBCBisTrackerDB.sourceFilter or "all"
    for _, slot in ipairs(addon.SLOTS) do
        local entry, selectedIdx, altCount = addon:GetSlotItem(class, spec, phase, slot)
        local isObtained = entry and addon:IsObtained(class, spec, phase, slot) or false

        if entry then
            total = total + 1
            if isObtained then obtained = obtained + 1 end
        end

        local matchesSource = (sourceFilter == "all") or (entry and entry.sourceType == sourceFilter)

        if not (missingOnly and isObtained) and matchesSource then
            rowIdx = rowIdx + 1
            local row = self.rowPool[rowIdx]
            if not row then break end

            -- Position row
            row:SetWidth(SCROLL_W)
            row:SetPoint("TOPLEFT", self.scrollContent, "TOPLEFT", 0, -(rowIdx - 1) * (ROW_H + ROW_PAD))
            row:Show()
            row.slotKey = slot

            -- Slot icon + name (always shown)
            row.iconTex:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
            row.slotLbl:SetText(addon.SLOT_LABELS[slot] or slot)

            if entry then
                -- Populated slot — show item details
                local itemId   = entry.id
                row.itemId     = itemId or 0
                local itemName = addon:GetItemName(itemId)
                local color    = addon:GetItemQualityColor(itemId)
                local altSuffix = (altCount > 1) and (" |cff888888[" .. selectedIdx .. "/" .. altCount .. "]|r") or ""

                local tierInfo = addon:GetTierInfo(entry)
                local tierPrefix = ""
                if tierInfo then
                    tierPrefix = "|cffffd700[" .. tierInfo.tier .. "]|r "
                end
                row.itemLbl:SetText(tierPrefix .. color .. itemName .. "|r" .. altSuffix)

                local srcColor = SOURCE_TYPE_COLORS[entry.sourceType] or "|cffcccccc"
                local srcText  = entry.source or "Unknown"
                if entry.note then
                    srcText = entry.note .. " (" .. srcText .. ")"
                end
                -- For crafted items, append the player's profession status inline
                if entry.sourceType == "crafted" then
                    local prof = addon:ParseCraftingProfession(entry)
                    if prof then
                        local level = addon:GetPlayerProfessionLevel(prof)
                        if level then
                            srcText = srcText .. " |cff00ff00[your " .. prof .. ": " .. level .. "]|r"
                        else
                            srcText = srcText .. " |cffff6060[no " .. prof .. "]|r"
                        end
                    end
                end
                row.srcLbl:SetText(srcColor .. srcText .. "|r")

                local slotName = addon.SLOT_LABELS[slot] or slot
                if tierInfo then
                    row.slotLbl:SetText("|cffffd700★|r " .. slotName)
                else
                    row.slotLbl:SetText(slotName)
                end

                row.chk:Show()
                row.chk:Enable()
                row.chk:SetChecked(isObtained)
                row.chk:SetScript("OnClick", function(chkSelf)
                    local val = chkSelf:GetChecked()
                    addon:SetObtained(class, spec, phase, slot, val)
                    UI:Refresh()
                end)

                if isObtained then
                    row.itemLbl:SetTextColor(0.4, 0.4, 0.4, 1)
                    row.slotLbl:SetTextColor(0.4, 0.4, 0.4, 1)
                elseif tierInfo then
                    row.slotLbl:SetTextColor(1, 0.82, 0, 1)
                else
                    row.slotLbl:SetTextColor(0.7, 0.7, 0.7, 1)
                end
            else
                -- Empty slot — placeholder, prompt right-click to import
                row.itemId = 0
                row.itemLbl:SetText("|cff666666(empty — right-click to import)|r")
                row.srcLbl:SetText("")
                row.chk:SetChecked(false)
                row.chk:Hide()
                row.slotLbl:SetTextColor(0.5, 0.5, 0.5, 1)
            end
        end
    end

    -- Resize content frame
    self.scrollContent:SetHeight(math.max(1, rowIdx) * (ROW_H + ROW_PAD))

    self:UpdateProgress(obtained, total)
    self:RefreshPhaseTabs()
    self:RefreshBadgeStatus()
    self:RefreshTierStatus()
end

function UI:UpdateProgress(obtained, total)
    if total == 0 then
        self.progressFill:SetWidth(2)
        self.progressTxt:SetText("|cffaaaaaa No data for this selection.|r")
        return
    end

    local pct  = obtained / total
    local barW = (FRAME_W - 44) * pct
    self.progressFill:SetWidth(math.max(2, barW))

    if obtained == total then
        self.progressFill:SetVertexColor(0.9, 0.75, 0.1, 0.9)  -- gold when complete
        self.progressTxt:SetText(
            "|cffffd700All " .. total .. " items obtained!|r  " ..
            ColorText("Phase complete!", "ffffd700")
        )
    else
        self.progressFill:SetVertexColor(0.1, 0.7, 0.2, 0.85)
        self.progressTxt:SetText(
            "|cff00ff00" .. obtained .. "/" .. total .. "|r items obtained" ..
            "  |cffaaaaaa(" .. math.floor(pct * 100) .. "% complete)|r"
        )
    end
end

-- ─────────────────────────────────────────────
-- Toggle / Show / Hide
-- ─────────────────────────────────────────────

function UI:Toggle()
    if not self.frame then
        self:Build()
    end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
        self:RefreshClassButtons()
        self:RefreshSpecSelector()
        self:RefreshPhaseTabs()
        self:Refresh()
    end
end

function UI:Show()
    if not self.frame then self:Build() end
    self.frame:Show()
    self:Refresh()
end

function UI:Hide()
    if self.frame then self.frame:Hide() end
end
