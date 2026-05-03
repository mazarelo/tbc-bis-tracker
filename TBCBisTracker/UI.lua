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
            btn:SetScale(1.15)
        else
            btn.border:SetAlpha(0)
            btn:SetScale(1.0)
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

function UI:RefreshSpecSelector()
    local class = TBCBisTrackerDB.lastClass
    if not class then return end
    local info  = addon.CLASS_INFO[class]
    if not info then return end

    -- Remove old buttons
    for _, b in ipairs(self.specBtns) do b:Hide() end
    self.specBtns = {}

    local x = 0
    for _, spec in ipairs(info.specs) do
        local btn = CreateFrame("Button", nil, self.specBtnRow)
        btn:SetHeight(22)
        btn:SetPoint("LEFT", self.specBtnRow, "LEFT", x, 0)

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        bg:SetVertexColor(0.15, 0.15, 0.15, 0.8)
        btn.bg = bg

        local fs = btn:CreateFontString(nil, "OVERLAY")
        SetFontSmall(fs)
        fs:SetAllPoints()
        fs:SetText(spec)
        btn.fs = fs

        -- measure width
        btn:SetWidth(fs:GetStringWidth() + 24)
        x = x + fs:GetStringWidth() + 28

        local capturedSpec = spec
        btn:SetScript("OnClick", function()
            TBCBisTrackerDB.lastSpec = capturedSpec
            UI:RefreshSpecSelector()
            UI:Refresh()
        end)

        btn:SetScript("OnEnter", function(self)
            self.bg:SetVertexColor(0.25, 0.25, 0.25, 1)
        end)
        btn:SetScript("OnLeave", function(self)
            UI:RefreshSpecSelector()
        end)

        table.insert(self.specBtns, btn)

        -- apply colour based on selection
        if spec == TBCBisTrackerDB.lastSpec then
            fs:SetTextColor(1, 0.82, 0, 1)
            bg:SetVertexColor(0.25, 0.20, 0.05, 0.9)
        else
            fs:SetTextColor(0.8, 0.8, 0.8, 1)
            bg:SetVertexColor(0.12, 0.12, 0.12, 0.8)
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
    if idx % 2 == 0 then
        bg:SetTexture(0.10, 0.10, 0.10, 0.5)
    else
        bg:SetTexture(0.06, 0.06, 0.06, 0.5)
    end
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

    return row
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
        local entry = data[slot]
        if not entry then goto continue end

        total = total + 1
        local isObtained = addon:IsObtained(class, spec, phase, slot)
        if isObtained then obtained = obtained + 1 end

        if missingOnly and isObtained then goto continue end

        rowIdx = rowIdx + 1
        local row = self.rowPool[rowIdx]
        if not row then break end

        -- Position row
        row:SetWidth(SCROLL_W)
        row:SetPoint("TOPLEFT", self.scrollContent, "TOPLEFT", 0, -(rowIdx - 1) * (ROW_H + ROW_PAD))
        row:Show()

        -- Slot icon
        row.iconTex:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")

        -- Slot name
        row.slotLbl:SetText(addon.SLOT_LABELS[slot] or slot)

        -- Item name + quality colour
        local itemId   = entry.id
        row.itemId     = itemId or 0
        local itemName = addon:GetItemName(itemId)
        local color    = addon:GetItemQualityColor(itemId)
        row.itemLbl:SetText(color .. itemName .. "|r")

        -- Source
        local srcColor = SOURCE_TYPE_COLORS[entry.sourceType] or "|cffcccccc"
        local srcText  = entry.source or "Unknown"
        if entry.note then
            srcText = entry.note .. " (" .. srcText .. ")"
        end
        row.srcLbl:SetText(srcColor .. srcText .. "|r")

        -- Checkbox state
        row.chk:SetChecked(isObtained)
        row.chk:SetScript("OnClick", function(chkSelf)
            local val = chkSelf:GetChecked()
            addon:SetObtained(class, spec, phase, slot, val)
            UI:Refresh()
        end)

        -- Strike through obtained items
        if isObtained then
            row.itemLbl:SetTextColor(0.4, 0.4, 0.4, 1)
            row.slotLbl:SetTextColor(0.4, 0.4, 0.4, 1)
        else
            row.slotLbl:SetTextColor(0.7, 0.7, 0.7, 1)
        end

        ::continue::
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
