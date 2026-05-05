-- TBCBisTracker UI
-- Full UI: class/spec picker, phase tabs, gear rows with checkboxes, progress bar

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker

addon.UI = {}
local UI = addon.UI

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

    -- ── Column headers ──
    self:BuildColumnHeaders()

    -- ── Scrollable gear list ──
    self:BuildScrollFrame()

    -- ── Progress bar ──
    self:BuildProgressBar()

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
    local f = self.frame
    local btnSize = 36
    local totalW  = #CLASS_ORDER * (btnSize + 4)
    local startX  = (FRAME_W - totalW) / 2 - 10

    self.classBtns = {}
    for i, class in ipairs(CLASS_ORDER) do
        local info = addon.CLASS_INFO[class]
        local btn  = CreateFrame("Button", nil, f)
        btn:SetSize(btnSize, btnSize)
        btn:SetPoint("TOPLEFT", f, "TOPLEFT", startX + (i-1) * (btnSize + 4), -36)

        local icon = btn:CreateTexture(nil, "BACKGROUND")
        icon:SetAllPoints()
        icon:SetTexture(info.icon)

        local border = btn:CreateTexture(nil, "OVERLAY")
        border:SetAllPoints()
        border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        border:SetBlendMode("ADD")
        border:SetAlpha(0)
        btn.border = border

        btn:SetScript("OnClick", function()
            TBCBisTrackerDB.lastClass = class
            -- Set first spec for this class
            local specs = info.specs
            TBCBisTrackerDB.lastSpec = specs[1]
            UI:RefreshClassButtons()
            UI:RefreshSpecSelector()
            UI:Refresh()
        end)

        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cff" .. info.color .. info.name .. "|r", 1, 1, 1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

        self.classBtns[class] = btn
    end
end

function UI:RefreshClassButtons()
    local selectedClass = TBCBisTrackerDB.lastClass
    for class, btn in pairs(self.classBtns) do
        if class == selectedClass then
            btn.border:SetAlpha(1)
        else
            btn.border:SetAlpha(0)
        end
    end
end

-- ─────────────────────────────────────────────
-- Spec selector (dropdown buttons below class row)
-- ─────────────────────────────────────────────

function UI:BuildSpecSelector()
    local f = self.frame
    self.specBtns = {}
    self.specBtnRow = CreateFrame("Frame", nil, f)
    self.specBtnRow:SetSize(FRAME_W - 40, 22)
    self.specBtnRow:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -78)
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
    local yOffset = -100

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
    for phase, btn in pairs(self.phaseTabs) do
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

function UI:BuildMissingFilter()
    local f = self.frame
    local chk = CreateFrame("CheckButton", "TBCBisTrackerMissingChk", f, "UICheckButtonTemplate")
    chk:SetSize(20, 20)
    chk:SetPoint("TOPRIGHT", f, "TOPRIGHT", -30, -132)
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
    local yOff   = -136
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
    local scrollY = -154
    local scrollH = FRAME_H - 154 - 40  -- leave room for progress bar

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

    -- Hover highlight
    row:SetScript("OnEnter", function(self)
        self.bg:SetVertexColor(0.20, 0.20, 0.30, 0.8)
        if self.itemId and self.itemId > 0 then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink("item:" .. self.itemId .. ":0:0:0:0:0:0:0")
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("|cffaaaaaa" .. (addon.WOWHEAD_BASE .. self.itemId) .. "|r", 1, 1, 1, true)
            GameTooltip:Show()
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

    -- Click handlers: shift+left = chat-link item; right = alternatives menu
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    row:SetScript("OnClick", function(self, button)
        if button == "LeftButton" and IsShiftKeyDown() and self.itemId and self.itemId > 0 then
            local _, link = GetItemInfo(self.itemId)
            if link then
                if ChatEdit_InsertLink then
                    ChatEdit_InsertLink(link)
                else
                    DEFAULT_CHAT_FRAME.editBox:Insert(link)
                end
            end
        elseif button == "RightButton" and self.slotKey then
            UI:ShowAlternativesMenu(self, self.slotKey)
        end
    end)

    return row
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
                OnShow = function(s) s.editBox:SetFocus() end,
                OnAccept = function(s)
                    local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
                    local input = eb and eb:GetText() or ""
                    local id = addon:ParseWowheadInput(input)
                    if not id then
                        addon:Print("Could not parse a Wowhead item URL/ID from: " .. tostring(input))
                        return
                    end
                    local added = addon:AddCustomAlt(class, spec, phase, slot, id, "Custom (Wowhead import)")
                    if added then
                        addon:Print("Added item " .. id .. " as alternative for " .. (addon.SLOT_LABELS[slot] or slot) .. ".")
                    else
                        addon:Print("Item " .. id .. " is already an alternative for that slot.")
                    end
                    UI:Refresh()
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
                end)
                btn:HookScript("OnLeave", function() GameTooltip:Hide() end)
            end
        end
    end)
end

-- ─────────────────────────────────────────────
-- Progress bar
-- ─────────────────────────────────────────────

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

    for _, slot in ipairs(addon.SLOTS) do
        local entry, selectedIdx, altCount = addon:GetSlotItem(class, spec, phase, slot)
        local isObtained = entry and addon:IsObtained(class, spec, phase, slot) or false

        if entry then
            total = total + 1
            if isObtained then obtained = obtained + 1 end
        end

        if not (missingOnly and isObtained) then
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
                row.itemLbl:SetText(color .. itemName .. "|r" .. altSuffix)

                local srcColor = SOURCE_TYPE_COLORS[entry.sourceType] or "|cffcccccc"
                local srcText  = entry.source or "Unknown"
                if entry.note then
                    srcText = entry.note .. " (" .. srcText .. ")"
                end
                row.srcLbl:SetText(srcColor .. srcText .. "|r")

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
