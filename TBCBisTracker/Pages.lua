-- TBCBisTracker pages
-- The window's content, switched with tabs under it like the character window's:
--   Gear         your slots grouped (Armor, Jewelry & trinkets, Weapons), and the details of the one you pick
--   Where to go  a plan for your next session: dungeons, quests, professions, vendors, the auction house
--   Stat Caps    (TBC) the rating caps
-- Built from Blizzard's own pieces where the client has them (UI.kit, from UI.lua).

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker
local UI = addon.UI
local K = UI.kit

local GetItemInfo = GetItemInfo or (C_Item and C_Item.GetItemInfo)

-- ─────────────────────────────────────────────
-- Layout
-- ─────────────────────────────────────────────

local GEAR_LIST_W = 556
local ROW_H       = 22
local HEADER_H    = 26
local GAP         = 4
local ALT_SIZE    = 34
local MAX_ALTS    = 6

local GROUPS = {
    { title = "Armor",              slots = { "head", "shoulder", "back", "chest", "wrist", "hands", "waist", "legs", "feet" } },
    { title = "Jewelry & trinkets", slots = { "neck", "ring1", "ring2", "trinket1", "trinket2" } },
    { title = "Weapons",            slots = { "mainhand", "offhand", "ranged" } },
}

-- The game's inventory slot of each list slot (GetInventoryItemID)
local INV_SLOT = {
    head = 1, neck = 2, shoulder = 3, back = 15, chest = 5, wrist = 9, hands = 10, waist = 6, legs = 7, feet = 8,
    ring1 = 11, ring2 = 12, trinket1 = 13, trinket2 = 14, mainhand = 16, offhand = 17, ranged = 18,
}
local PAIRED = { ring1 = 12, ring2 = 11, trinket1 = 14, trinket2 = 13 }

-- The marks at the end of a row
local MARK_OBTAINED = "Interface\\RAIDFRAME\\ReadyCheck-Ready"
local MARK_QUEST    = "Interface\\GossipFrame\\AvailableQuestIcon"
local UPGRADE_ATLAS = "bags-greenarrow"
local UPGRADE_FILE  = "Interface\\Buttons\\Arrow-Up-Up"

local function SetUpgradeMark(tex)
    if K.HasAtlas(UPGRADE_ATLAS) then
        tex:SetAtlas(UPGRADE_ATLAS)
        tex:SetVertexColor(1, 1, 1, 1)
    else
        tex:SetTexture(UPGRADE_FILE)
        tex:SetTexCoord(0, 1, 0, 1)
        tex:SetVertexColor(0.3, 1, 0.3, 1)
    end
end

local function ItemLink(itemId)
    local _, link = GetItemInfo(itemId)
    return link
end

local function ShowItemTooltip(owner, itemId, anchor)
    GameTooltip:SetOwner(owner, anchor or "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink("item:" .. itemId .. ":0:0:0:0:0:0:0")
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("|cffaaaaaa" .. addon.WOWHEAD_BASE .. itemId .. "|r", 1, 1, 1, true)
    GameTooltip:Show()
    if IsShiftKeyDown() and GameTooltip_ShowCompareItem then GameTooltip_ShowCompareItem(GameTooltip) end
end

-- ─────────────────────────────────────────────
-- Blizzard pieces
-- ─────────────────────────────────────────────

-- A section title like the character window's stat pane ("General", "Primary Attributes"): its own
-- category template when the client has it, else its title-bar atlas, else gold text over a line.
-- Returns the frame with .title.
local function CreateSectionHeader(parent)
    local title
    local h = K.TEMPLATED and K.FromTemplate("Frame", nil, parent, "CharacterStatFrameCategoryTemplate")
    if h then
        title = K.Child(h, "Title")
        local bg = K.Child(h, "Background")
        if bg then
            bg:ClearAllPoints()
            bg:SetAllPoints()
        end
    else
        h = CreateFrame("Frame", nil, parent)
        if K.TEMPLATED and K.HasAtlas(K.SECTION_ATLAS) then
            local bg = h:CreateTexture(nil, "BACKGROUND")
            bg:SetAtlas(K.SECTION_ATLAS)
            bg:SetAllPoints()
        else
            local line = h:CreateTexture(nil, "ARTWORK")
            line:SetColorTexture(0.62, 0.5, 0.3, 0.6)
            line:SetHeight(1)
            line:SetPoint("BOTTOMLEFT", 4, 2)
            line:SetPoint("BOTTOMRIGHT", -4, 2)
        end
    end
    h.title = title or h:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    h.title:ClearAllPoints()
    h.title:SetPoint("CENTER", h, "CENTER", 0, 1)
    h:SetHeight(HEADER_H)
    h:EnableMouse(false)
    return h
end

-- The light band behind every other line of the stat pane.
local function AddStripe(frame)
    local t = frame:CreateTexture(nil, "BACKGROUND")
    t:SetAllPoints()
    if K.TEMPLATED and K.HasAtlas(K.STRIPE_ATLAS) then
        t:SetAtlas(K.STRIPE_ATLAS)
        t:SetAlpha(0.35)
    else
        t:SetColorTexture(0.59, 0.43, 0.24, 0.16)
    end
    t:Hide()
    return t
end

local function PanelButton(parent, text, width, height)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(width, height or 22)
    b:SetText(text)
    return b
end

-- A scroll frame with the thin scroll bar, in an inset. Returns scroll frame, content, bar.
local function CreateScrollArea(parent)
    local sf = CreateFrame("ScrollFrame", nil, parent)
    sf:SetPoint("TOPLEFT", 6, -6)
    sf:SetPoint("BOTTOMRIGHT", -18, 6)
    sf:EnableMouseWheel(true)
    local content = CreateFrame("Frame", nil, sf)
    content:SetSize(1, 1)
    sf:SetScrollChild(content)

    local bar = CreateFrame("Slider", nil, parent)
    bar:SetOrientation("VERTICAL")
    bar:SetWidth(6)
    bar:EnableMouse(true)
    bar:SetPoint("TOPLEFT", sf, "TOPRIGHT", 4, 0)
    bar:SetPoint("BOTTOMLEFT", sf, "BOTTOMRIGHT", 4, 0)
    local thumb = K.TEMPLATED and K.SkinMinimalScrollBar(bar)
    if not thumb then
        K.AddFill(bar, 0.11, 0.12, 0.14, 1)
        thumb = bar:CreateTexture(nil, "OVERLAY")
        thumb:SetColorTexture(0.42, 0.39, 0.30, 1)
        thumb:SetSize(6, 40)
        bar:SetThumbTexture(thumb)
    end
    bar:SetMinMaxValues(0, 0)
    bar:SetValue(0)
    bar:SetScript("OnValueChanged", function(_, value) sf:SetVerticalScroll(value) end)
    sf:SetScript("OnMouseWheel", function(_, delta)
        local lo, hi = bar:GetMinMaxValues()
        bar:SetValue(math.max(lo, math.min(hi, bar:GetValue() - delta * ROW_H * 3)))
    end)
    sf.bar, sf.thumb, sf.content = bar, thumb, content

    -- Scroll range and thumb for a content height
    function sf:SetContentHeight(h)
        content:SetHeight(math.max(1, h))
        local view = self:GetHeight() or 0
        local max = math.max(0, h - view)
        bar:SetMinMaxValues(0, max)
        if bar:GetValue() > max then bar:SetValue(max) end
        self:SetVerticalScroll(bar:GetValue())
        if view > 0 and max > 0 then
            thumb:SetHeight(math.max(24, view * view / h))
            bar:Show()
        else
            bar:Hide()
        end
    end
    return sf, content, bar
end

-- ─────────────────────────────────────────────
-- Pages and the tabs under the window
-- ─────────────────────────────────────────────

local PAGES = {
    { key = "gear",  label = "Gear" },
    { key = "where", label = "Where to go" },
    { key = "stats", label = "Stat Caps", tbcOnly = true },
}

-- A tab under the window: the character window's own tab when the client has it.
local function CreateBottomTab(parent, name)
    for _, template in ipairs({ "CharacterFrameTabButtonTemplate", "PanelTabButtonTemplate" }) do
        local tab = K.FromTemplate("Button", name, parent, template)
        if tab and PanelTemplates_TabResize and PanelTemplates_SelectTab and PanelTemplates_DeselectTab then
            tab.classic = true
            tab:SetScript("OnShow", nil) -- the template resizes on show from its parent's tab list
            return tab
        end
    end
    return K.CreateTab(parent, name)
end

function UI:BuildPages()
    local f = self.frame
    self.pages, self.pageTabs = {}, {}
    local prev
    for i, p in ipairs(PAGES) do
        if not (p.tbcOnly and addon:IsForever()) then
            local page = CreateFrame("Frame", nil, f)
            page:Hide()
            self.pages[p.key] = page

            local tab = CreateBottomTab(f, "TBCBisTrackerPageTab" .. i)
            K.SetTabLabel(tab, p.label)
            if prev then
                tab:SetPoint("LEFT", prev, "RIGHT", tab.classic and -14 or 2, 0)
            else
                tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 12, tab.classic and 2 or -1)
            end
            tab:SetScript("OnClick", function() UI:SelectPage(p.key) end)
            self.pageTabs[p.key] = tab
            prev = tab
        end
    end
    -- Keep the tabs under the window on screen
    if f.SetClampRectInsets then f:SetClampRectInsets(0, 40, 0, -32) end

    self:BuildGearPage(self.pages.gear)
    self:BuildWherePage(self.pages.where)
    if self.pages.stats then self:BuildStatCapPanel(self.pages.stats) end

    local saved = TBCBisTrackerDB.page
    self:SelectPage(self.pages[saved] and saved or "gear")
end

function UI:SelectPage(key)
    if not self.pages[key] then key = "gear" end
    TBCBisTrackerDB.page = key
    self.page = key
    for k, page in pairs(self.pages) do
        page:SetShown(k == key)
        K.SetTabSelected(self.pageTabs[k], k == key)
    end
    if key == "where" then self:RefreshWhere() end
end

-- ─────────────────────────────────────────────
-- What you wear
-- ─────────────────────────────────────────────

local function ItemLevel(itemId)
    if not itemId then return nil end
    if GetDetailedItemLevelInfo then
        local ok, level = pcall(GetDetailedItemLevelInfo, itemId)
        if ok and level and level > 0 then return level end
    end
    local level = select(4, GetItemInfo(itemId))
    return level and level > 0 and level or nil
end

-- The item you wear in a list slot (nil when it's empty)
function UI:EquippedIn(slot)
    local inv = INV_SLOT[slot]
    return inv and GetInventoryItemID("player", inv) or nil
end

-- The pick has a higher item level than what you wear there (or the slot is empty). Rings and trinkets
-- compare with the weaker of your two. Never while browsing another class, never for an item you have.
function UI:IsUpgrade(class, spec, phase, slot, entry)
    if not (entry and entry.id) or K.IsBrowsing() or addon:IsObtained(class, spec, phase, slot) then return false end
    local want = ItemLevel(entry.id)
    if not want then return false end
    local function worn(inv)
        local id = inv and GetInventoryItemID("player", inv)
        if not id then return 0 end
        return ItemLevel(id) or math.huge
    end
    local have = worn(INV_SLOT[slot])
    if PAIRED[slot] then have = math.min(have, worn(PAIRED[slot])) end
    return want > have
end

-- ─────────────────────────────────────────────
-- Gear page: the list
-- ─────────────────────────────────────────────

local function RowOnEnter(row)
    if not (row.itemId and row.itemId > 0) then
        GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
        GameTooltip:SetText(addon.SLOT_LABELS[row.slotKey] or row.slotKey, 1, 1, 1)
        GameTooltip:AddLine("No BiS pick. Right-click to import one, or drop an item here.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
        return
    end
    GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink("item:" .. row.itemId .. ":0:0:0:0:0:0:0")
    if row.mark and row.markTip then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(row.markTip, 0.4, 1, 0.4, true)
    end
    if row.userNote and row.userNote ~= "" then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|TInterface\\GossipFrame\\TrainerGossipIcon:12:12|t |cffd6b85aYour note|r", 1, 1, 1)
        GameTooltip:AddLine("|cffffffff" .. row.userNote .. "|r", 1, 1, 1, true)
    end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("|cff888888Click: details  ·  Right-click: pick another  ·  Shift+click: link|r", 1, 1, 1, true)
    GameTooltip:Show()
    if IsShiftKeyDown() and GameTooltip_ShowCompareItem then GameTooltip_ShowCompareItem(GameTooltip) end
end

local function RowOnClick(row, button)
    if button == "LeftButton" and CursorHasItem() then
        UI:ImportFromCursor(row.slotKey)
        return
    end
    if button == "RightButton" then
        UI:ShowAlternativesMenu(row, row.slotKey)
        return
    end
    if IsShiftKeyDown() and row.itemId and row.itemId > 0 then
        local link = ItemLink(row.itemId)
        if link and ChatEdit_InsertLink then ChatEdit_InsertLink(link) end
        return
    end
    if IsControlKeyDown() and row.itemId and row.itemId > 0 then
        UI:ShowUrlPopup("Wowhead URL (Ctrl+C to copy):", addon.WOWHEAD_BASE .. tostring(row.itemId))
        return
    end
    UI:SelectSlot(row.slotKey)
end

function UI:CreateGearRow(parent)
    local row = CreateFrame("Button", nil, parent)
    row:SetHeight(ROW_H)
    row.stripe = AddStripe(row)
    row.selected = row:CreateTexture(nil, "BORDER")
    row.selected:SetAllPoints()
    row.selected:SetColorTexture(1, 0.82, 0, 0.16)
    row.selected:Hide()
    local hl = row:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.06)

    row.iconBorder = row:CreateTexture(nil, "ARTWORK")
    row.iconBorder:SetSize(20, 20)
    row.iconBorder:SetPoint("LEFT", row, "LEFT", 4, 0)
    row.iconTex = row:CreateTexture(nil, "OVERLAY")
    row.iconTex:SetSize(18, 18)
    row.iconTex:SetPoint("CENTER", row.iconBorder, "CENTER", 0, 0)
    row.iconTex:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    row.slotLbl = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.slotLbl:SetPoint("LEFT", row, "LEFT", 30, 0)
    row.slotLbl:SetWidth(70)
    row.slotLbl:SetJustifyH("LEFT")

    row.markTex = row:CreateTexture(nil, "OVERLAY")
    row.markTex:SetSize(14, 14)
    row.markTex:SetPoint("RIGHT", row, "RIGHT", -6, 0)

    row.srcLbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.srcLbl:SetPoint("RIGHT", row.markTex, "LEFT", -8, 0)
    row.srcLbl:SetWidth(160)
    row.srcLbl:SetJustifyH("LEFT")
    row.srcLbl:SetWordWrap(false)

    row.itemLbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    row.itemLbl:SetPoint("LEFT", row.slotLbl, "RIGHT", 4, 0)
    row.itemLbl:SetPoint("RIGHT", row.srcLbl, "LEFT", -8, 0)
    row.itemLbl:SetJustifyH("LEFT")
    row.itemLbl:SetWordWrap(false)

    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    row:SetScript("OnEnter", RowOnEnter)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)
    row:SetScript("OnClick", RowOnClick)
    row:SetScript("OnReceiveDrag", function(r) if r.slotKey then UI:ImportFromCursor(r.slotKey) end end)
    return row
end

function UI:BuildGearPage(page)
    local listInset = K.CreateInset(page)
    if not listInset then
        listInset = CreateFrame("Frame", nil, page)
        K.AddFill(listInset, 0.04, 0.035, 0.03, 0.9)
        K.AddBorder(listInset, 0.23, 0.18, 0.11, 1)
    end
    listInset:SetPoint("TOPLEFT")
    listInset:SetPoint("BOTTOMLEFT")
    listInset:SetWidth(GEAR_LIST_W)
    self.listInset = listInset

    local sf, content = CreateScrollArea(listInset)
    self.gearScroll, self.gearContent = sf, content
    sf:SetScript("OnSizeChanged", function() sf:SetContentHeight(UI.gearHeight or 0) end)

    self.rowPool, self.sectionPool = {}, {}
    for i = 1, #addon.SLOTS do self.rowPool[i] = self:CreateGearRow(content) self.rowPool[i]:Hide() end
    for i = 1, #GROUPS do
        self.sectionPool[i] = CreateSectionHeader(content)
        self.sectionPool[i]:Hide()
    end

    local detailInset = K.CreateInset(page)
    if not detailInset then
        detailInset = CreateFrame("Frame", nil, page)
        K.AddFill(detailInset, 0.04, 0.035, 0.03, 0.9)
        K.AddBorder(detailInset, 0.23, 0.18, 0.11, 1)
    end
    detailInset:SetPoint("TOPLEFT", listInset, "TOPRIGHT", 8, 0)
    detailInset:SetPoint("BOTTOMRIGHT")
    self:BuildDetail(detailInset)
end

-- The slots the list shows (filters applied), grouped; returns the rows' data and the counts for the
-- progress bar (over every slot with a pick, filters ignored).
function UI:RefreshGear()
    local class, spec, phase = TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase
    for _, row in ipairs(self.rowPool) do row:Hide() end
    for _, h in ipairs(self.sectionPool) do h:Hide() end
    local width = GEAR_LIST_W - 26
    local obtained, total, upgrades = 0, 0, 0
    if not addon:GetPhaseData(class, spec, phase) then
        self.gearScroll:SetContentHeight(0)
        self.gearHeight = 0
        return 0, 0, 0
    end

    local missingOnly = TBCBisTrackerDB.showMissingOnly
    local sourceFilter = TBCBisTrackerDB.sourceFilter or "all"
    local y, r, firstShown, selectedShown = 0, 0, nil, false
    for g, group in ipairs(GROUPS) do
        local shown = {}
        for _, slot in ipairs(group.slots) do
            local entry, selectedIdx, altCount = addon:GetSlotItem(class, spec, phase, slot)
            local have = entry and addon:IsObtained(class, spec, phase, slot) or false
            local up = entry and self:IsUpgrade(class, spec, phase, slot, entry) or false
            if entry then
                total = total + 1
                if have then obtained = obtained + 1 end
                if up then upgrades = upgrades + 1 end
            end
            local matches = sourceFilter == "all" or (entry and entry.sourceType == sourceFilter)
            if matches and not (missingOnly and have) then
                table.insert(shown, { slot = slot, entry = entry, have = have, up = up, idx = selectedIdx, alts = altCount })
            end
        end
        if #shown > 0 then
            if y > 0 then y = y + GAP end
            local h = self.sectionPool[g]
            h.title:SetText(group.title)
            h:ClearAllPoints()
            h:SetPoint("TOPLEFT", self.gearContent, "TOPLEFT", 0, -y)
            h:SetWidth(width)
            h:Show()
            y = y + HEADER_H
            for n, s in ipairs(shown) do
                r = r + 1
                local row = self.rowPool[r]
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", self.gearContent, "TOPLEFT", 0, -y)
                row:SetWidth(width)
                row.stripe:SetShown(n % 2 == 1)
                self:FillGearRow(row, s, class, spec, phase)
                row:Show()
                firstShown = firstShown or s.slot
                if s.slot == self.selectedSlot then selectedShown = true end
                y = y + ROW_H
            end
        end
    end
    self.gearHeight = y
    self.gearScroll:SetContentHeight(y)

    -- Keep a selection on screen
    if not selectedShown then self.selectedSlot = firstShown or self.selectedSlot end
    for i = 1, r do self.rowPool[i].selected:SetShown(self.rowPool[i].slotKey == self.selectedSlot) end
    return obtained, total, upgrades
end

function UI:FillGearRow(row, s, class, spec, phase)
    local slot, entry = s.slot, s.entry
    row.slotKey = slot
    row.slotLbl:SetText(addon.SLOT_LABELS[slot] or slot)
    row.iconTex:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
    row.iconBorder:SetColorTexture(0.35, 0.35, 0.35, 1)
    row.mark, row.markTip = nil, nil
    row.markTex:Hide()
    row.userNote = nil

    if not entry then
        row.itemId = 0
        row.itemLbl:SetText("|cff666666No BiS pick|r  |cff444444· right-click to import|r")
        row.srcLbl:SetText("")
        return
    end

    row.itemId = entry.id or 0
    local name = addon:GetItemName(entry.id)
    local texture = select(10, GetItemInfo(entry.id)) or (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(entry.id))
    if texture then row.iconTex:SetTexture(texture) end
    row.iconBorder:SetColorTexture(K.ItemQualityRGB(entry.id))
    local suffix = K.SuffixHint(entry, name)
    local tier = addon:GetTierInfo(entry)
    local note = addon:GetNote(class, spec, phase, slot)
    row.userNote = note
    row.itemLbl:SetText((tier and ("|cffffd700[" .. tier.tier .. "]|r ") or "")
        .. addon:GetItemQualityColor(entry.id) .. name .. "|r"
        .. (suffix and ("|cffa39d8c" .. suffix .. "|r") or "")
        .. ((s.alts or 0) > 1 and (" |cff888888[" .. s.idx .. "/" .. s.alts .. "]|r") or "")
        .. ((note and note ~= "") and "  |TInterface\\GossipFrame\\TrainerGossipIcon:12:12|t" or ""))
    if s.have then row.itemLbl:SetAlpha(0.55) else row.itemLbl:SetAlpha(1) end

    -- Where from, in the source type's colour; a profession you don't have in red
    local where = K.ShortSource(entry)
    local color = K.SOURCE_TYPE_COLORS[entry.sourceType] or "|cffcccccc"
    if entry.sourceType == "crafted" then
        local prof = addon:ParseCraftingProfession(entry)
        if prof then
            local rank, _, known = addon:GetPlayerProfessionLevel(prof)
            if not rank and known then where, color = "Needs " .. prof, "|cffff6b5a" end
        end
    end
    row.srcLbl:SetText(color .. where .. "|r")

    if s.have then
        row.markTex:SetTexture(MARK_OBTAINED)
        row.markTex:SetTexCoord(0, 1, 0, 1)
        row.markTex:SetVertexColor(1, 1, 1, 1)
        row.mark, row.markTip = "obtained", "You have it."
    elseif s.up then
        SetUpgradeMark(row.markTex)
        row.mark, row.markTip = "upgrade", "Higher item level than what you wear in this slot."
    elseif entry.questId and entry.questId > 0 then
        row.markTex:SetTexture(MARK_QUEST)
        row.markTex:SetTexCoord(0, 1, 0, 1)
        row.markTex:SetVertexColor(1, 1, 1, 1)
        row.mark, row.markTip = "quest", "A quest reward."
    end
    row.markTex:SetShown(row.mark ~= nil)
end

-- ─────────────────────────────────────────────
-- Gear page: the slot's details
-- ─────────────────────────────────────────────

local DETAIL_LINES = { "Slot", "Source", "Where", "You", "Wearing now" }

local function StatLine(parent, label, striped)
    local line = CreateFrame("Frame", nil, parent)
    line:SetHeight(22)
    local stripe = AddStripe(line)
    stripe:SetShown(striped)
    line.label = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    line.label:SetPoint("LEFT", 8, 0)
    line.label:SetText(label .. ":")
    line.value = line:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    line.value:SetPoint("RIGHT", -8, 0)
    line.value:SetPoint("LEFT", line.label, "RIGHT", 8, 0)
    line.value:SetJustifyH("RIGHT")
    line.value:SetWordWrap(false)
    return line
end

function UI:BuildDetail(parent)
    local d = {}
    self.detail = d

    d.header = CreateSectionHeader(parent)
    d.header:SetPoint("TOPLEFT", 4, -6)
    d.header:SetPoint("TOPRIGHT", -4, -6)

    d.lines = {}
    local prev = d.header
    for i, label in ipairs(DETAIL_LINES) do
        local line = StatLine(parent, label, i % 2 == 1)
        line:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, i == 1 and -4 or 0)
        line:SetPoint("TOPRIGHT", prev, "BOTTOMRIGHT", 0, i == 1 and -4 or 0)
        d.lines[label] = line
        prev = line
    end
    -- Where: the whole source text (and the quest) on hover
    local where = d.lines["Where"]
    where:EnableMouse(true)
    where:SetScript("OnEnter", function(line)
        local entry = d.entry
        if not entry then return end
        GameTooltip:SetOwner(line, "ANCHOR_LEFT")
        if K.SetQuestTooltip(line, entry.questId) then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(entry.source or "", 1, 1, 1, true)
        else
            GameTooltip:SetText(entry.source or "Unknown", 1, 1, 1, 1, true)
        end
        -- What the list says about getting it (maker only, elite, drop chance…)
        if entry.note and entry.note ~= "" then
            GameTooltip:AddLine(entry.note, 1, 0.82, 0, true)
        end
        GameTooltip:Show()
    end)
    where:SetScript("OnLeave", function() GameTooltip:Hide() end)
    -- Wearing now: that item's tooltip
    local wearing = d.lines["Wearing now"]
    wearing:EnableMouse(true)
    wearing:SetScript("OnEnter", function(line)
        if d.wornId then ShowItemTooltip(line, d.wornId, "ANCHOR_LEFT") end
    end)
    wearing:SetScript("OnLeave", function() GameTooltip:Hide() end)

    d.altHeader = CreateSectionHeader(parent)
    d.altHeader.title:SetText("Alternatives")
    d.altHeader:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -8)
    d.altHeader:SetPoint("TOPRIGHT", prev, "BOTTOMRIGHT", 0, -8)

    d.alts = {}
    for i = 1, MAX_ALTS do
        local b = CreateFrame("Button", nil, parent)
        b:SetSize(ALT_SIZE, ALT_SIZE)
        b:SetPoint("TOPLEFT", d.altHeader, "BOTTOMLEFT", 8 + (i - 1) * (ALT_SIZE + 6), -8)
        b.border = b:CreateTexture(nil, "BACKGROUND")
        b.border:SetAllPoints()
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetPoint("TOPLEFT", 2, -2)
        b.icon:SetPoint("BOTTOMRIGHT", -2, 2)
        b.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        b.glow = b:CreateTexture(nil, "OVERLAY")
        b.glow:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        b.glow:SetBlendMode("ADD")
        b.glow:SetAllPoints()
        b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        b:SetScript("OnClick", function(btn)
            local class, spec, phase = TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase
            addon:SetSelectedAlt(class, spec, phase, d.slot, btn.index)
            UI:Refresh()
        end)
        b:SetScript("OnEnter", function(btn)
            if btn.itemId then ShowItemTooltip(btn, btn.itemId, "ANCHOR_LEFT") end
            GameTooltip:AddLine(btn.index == 1 and "|cffffd700Best in slot|r" or ("|cffaaaaaaAlternative " .. (btn.index - 1) .. "|r"))
            GameTooltip:AddLine("|cff888888Click to track this one instead.|r")
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
        b:Hide()
        d.alts[i] = b
    end
    d.more = PanelButton(parent, "More...", 70, 22)
    d.more:SetScript("OnClick", function(btn) if d.slot then UI:ShowAlternativesMenu(btn, d.slot) end end)

    d.noteHeader = CreateSectionHeader(parent)
    d.noteHeader.title:SetText("Your note")
    d.noteHeader:SetPoint("TOPLEFT", d.altHeader, "BOTTOMLEFT", 0, -(ALT_SIZE + 16))
    d.noteHeader:SetPoint("TOPRIGHT", d.altHeader, "BOTTOMRIGHT", 0, -(ALT_SIZE + 16))
    d.note = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    d.note:SetPoint("TOPLEFT", d.noteHeader, "BOTTOMLEFT", 8, -6)
    d.note:SetPoint("TOPRIGHT", d.noteHeader, "BOTTOMRIGHT", -8, -6)
    d.note:SetJustifyH("LEFT")
    d.note:SetWordWrap(true)
    d.editNote = PanelButton(parent, "Edit note", 90, 22)
    d.editNote:SetPoint("TOPRIGHT", d.noteHeader, "BOTTOMRIGHT", -8, -40)
    d.editNote:SetScript("OnClick", function()
        if d.slot then UI:ShowNoteEditor(TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase, d.slot) end
    end)

    -- Bottom: Got it, link, Wowhead
    d.got = CreateFrame("CheckButton", "TBCBisTrackerGotIt", parent, "UICheckButtonTemplate")
    d.got:SetSize(24, 24)
    d.got:SetPoint("BOTTOMLEFT", 8, 8)
    d.gotLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    d.gotLabel:SetPoint("LEFT", d.got, "RIGHT", 2, 0)
    d.gotLabel:SetText("Got it")
    d.got:SetScript("OnClick", function(chk)
        if not d.slot then return end
        addon:SetObtained(TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase, d.slot, chk:GetChecked())
        UI:Refresh()
    end)
    d.wowhead = PanelButton(parent, "Wowhead", 84, 22)
    d.wowhead:SetPoint("BOTTOMRIGHT", -8, 9)
    d.wowhead:SetScript("OnClick", function()
        if d.entry and d.entry.id then
            UI:ShowUrlPopup("Wowhead URL (Ctrl+C to copy):", addon.WOWHEAD_BASE .. tostring(d.entry.id))
        end
    end)
    d.link = PanelButton(parent, "Link", 64, 22)
    d.link:SetPoint("RIGHT", d.wowhead, "LEFT", -6, 0)
    d.link:SetScript("OnClick", function()
        local link = d.entry and d.entry.id and ItemLink(d.entry.id)
        if link and ChatEdit_InsertLink then ChatEdit_InsertLink(link) end
    end)
end

function UI:SelectSlot(slot)
    self.selectedSlot = slot
    for _, row in ipairs(self.rowPool) do
        row.selected:SetShown(row:IsShown() and row.slotKey == slot)
    end
    self:RefreshDetail()
end

function UI:RefreshDetail()
    local d = self.detail
    if not d then return end
    local class, spec, phase = TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase
    local slot = self.selectedSlot
    d.slot = slot
    for _, b in ipairs(d.alts) do b:Hide() end
    local browsing = K.IsBrowsing()
    d.got:SetShown(slot ~= nil and not browsing)
    d.gotLabel:SetShown(slot ~= nil and not browsing)

    local entry = slot and addon:GetSlotItem(class, spec, phase, slot) or nil
    d.entry = entry
    local L = d.lines
    L["Slot"].value:SetText(slot and (addon.SLOT_LABELS[slot] or slot) or "")
    if not entry then
        d.header.title:SetText(slot and "|cff888888No BiS pick|r" or "")
        L["Source"].value:SetText("")
        L["Where"].value:SetText(slot and "|cff888888Right-click the row to import one|r" or "")
        L["You"].value:SetText("")
        L["Wearing now"].value:SetText("")
        d.note:SetText("")
        d.wornId = nil
        d.got:SetShown(false)
        d.gotLabel:SetShown(false)
        d.more:ClearAllPoints()
        d.more:SetPoint("TOPLEFT", d.altHeader, "BOTTOMLEFT", 8, -14)
        return
    end

    local have = addon:IsObtained(class, spec, phase, slot)
    d.header.title:SetText(addon:GetItemQualityColor(entry.id) .. addon:GetItemName(entry.id) .. "|r")
    L["Source"].value:SetText((K.SOURCE_TYPE_COLORS[entry.sourceType] or "|cffcccccc")
        .. (K.SOURCE_TYPE_LABELS[entry.sourceType] or entry.sourceType or "Unknown") .. "|r")
    L["Where"].value:SetText(K.ShortSource(entry)
        .. ((entry.questId and entry.questId > 0) and "  |TInterface\\GossipFrame\\AvailableQuestIcon:12:12|t" or ""))

    -- You: have it, browsing, or what stands between you and it
    local you
    if browsing then
        you = "|cff888888Planning only (not your class)|r"
    elseif have then
        you = "|cff60ff60Obtained|r"
    else
        local prof = entry.sourceType == "crafted" and addon:ParseCraftingProfession(entry)
        local rank, known
        if prof then
            local r, _, k = addon:GetPlayerProfessionLevel(prof)
            rank, known = r, k
        end
        local makerOnly = entry.note and entry.note:find("Only its maker", 1, true) and " (only its maker can wear it)" or ""
        if prof and not rank then
            you = known and ("|cffff6b5aNeeds " .. prof .. makerOnly .. "|r") or ("Crafted with " .. prof .. makerOnly)
        elseif prof then
            you = prof .. " " .. rank
        else
            you = "Not yet"
        end
    end
    L["You"].value:SetText(you)

    -- Wearing now
    local worn = (not browsing) and self:EquippedIn(slot) or nil
    d.wornId = worn
    if browsing then
        L["Wearing now"].value:SetText("|cff888888—|r")
    elseif not worn then
        L["Wearing now"].value:SetText("|cff888888Nothing|r")
    elseif worn == entry.id then
        L["Wearing now"].value:SetText("|cff60ff60This item|r")
    else
        L["Wearing now"].value:SetText(addon:GetItemQualityColor(worn) .. addon:GetItemName(worn) .. "|r"
            .. (self:IsUpgrade(class, spec, phase, slot, entry) and "  |cff40ff40(upgrade)|r" or ""))
    end

    -- Alternatives: the BiS first, then the rest; the one you track glows
    local alts = addon:GetSlotAlternatives(class, spec, phase, slot) or {}
    local current = addon:GetSelectedAlt(class, spec, phase, slot)
    local shown = math.min(#alts, MAX_ALTS)
    for i = 1, shown do
        local b, alt = d.alts[i], alts[i]
        b.index, b.itemId = i, alt.id
        b.icon:SetTexture(select(10, GetItemInfo(alt.id))
            or (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(alt.id))
            or "Interface\\Icons\\INV_Misc_QuestionMark")
        b.border:SetColorTexture(K.ItemQualityRGB(alt.id))
        b.glow:SetShown(i == current)
        b:Show()
    end
    d.more:ClearAllPoints()
    if shown > 0 then
        d.more:SetPoint("LEFT", d.alts[shown], "RIGHT", 8, 0)
    else
        d.more:SetPoint("TOPLEFT", d.altHeader, "BOTTOMLEFT", 8, -14)
    end

    local note = addon:GetNote(class, spec, phase, slot)
    d.note:SetText((note and note ~= "") and ("|cffd6b85a" .. note .. "|r")
        or "|cff888888No note yet.|r")
    d.got:SetChecked(have)
end

-- ─────────────────────────────────────────────
-- Where to go page
-- ─────────────────────────────────────────────

local COLUMN_LINES = 22

-- Quests: in your log or not, opened there when you have them.
local function QuestInLog(questId, title)
    if questId and C_QuestLog and C_QuestLog.GetLogIndexForQuestID then
        local ok, index = pcall(C_QuestLog.GetLogIndexForQuestID, questId)
        if ok and index and index > 0 then return true end
    end
    if questId and GetQuestLogIndexByID then
        local ok, index = pcall(GetQuestLogIndexByID, questId)
        if ok and index and index > 0 then return true end
    end
    local want = title and title:lower()
    local count = GetNumQuestLogEntries and tonumber((GetNumQuestLogEntries())) or 0
    if want and GetQuestLogTitle then
        for i = 1, count do
            local qTitle, _, _, isHeader = GetQuestLogTitle(i)
            if not isHeader and qTitle and qTitle:lower() == want then return true end
        end
    end
    return false
end

local function OpenQuestInMap(want, questId)
    if C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo and QuestMapFrame_OpenToQuestDetails then
        for i = 1, tonumber((C_QuestLog.GetNumQuestLogEntries())) or 0 do
            local info = C_QuestLog.GetInfo(i)
            if info and not info.isHeader and info.questID
                and ((questId and info.questID == questId) or (info.title and info.title:lower() == want)) then
                QuestMapFrame_OpenToQuestDetails(info.questID)
                return true
            end
        end
    end
    return false
end

local function OpenQuestInLog(want, questId)
    local count = GetNumQuestLogEntries and tonumber((GetNumQuestLogEntries())) or 0
    if GetQuestLogTitle then
        for i = 1, count do
            local qTitle, _, _, isHeader, _, _, _, qId = GetQuestLogTitle(i)
            if not isHeader and ((questId and qId == questId) or (qTitle and qTitle:lower() == want)) then
                if QuestLog_OpenToQuest then
                    QuestLog_OpenToQuest(i)
                elseif QuestLogFrame then
                    ShowUIPanel(QuestLogFrame)
                    if QuestLog_SetSelection then QuestLog_SetSelection(i) end
                    if QuestLog_Update then QuestLog_Update() end
                else
                    return false
                end
                return true
            end
        end
    end
    return false
end

local function OpenQuest(title, questId)
    local want = title and title:lower()
    if not want then return false end
    local ok, opened = pcall(OpenQuestInMap, want, questId)
    if ok and opened then return true end
    ok, opened = pcall(OpenQuestInLog, want, questId)
    return ok and opened or false
end

-- Auction house: put the name in its search box and search (newer and classic auction house).
local function SearchAuctionHouse(name)
    local ok, done = pcall(function()
        local ah = AuctionHouseFrame
        if ah and ah:IsShown() and ah.SearchBar and ah.SearchBar.SearchBox then
            ah.SearchBar.SearchBox:SetText(name)
            if ah.SearchBar.StartSearch then ah.SearchBar:StartSearch() end
            return true
        end
        if AuctionFrame and AuctionFrame:IsShown() and BrowseName then
            if AuctionFrameTab_OnClick and AuctionFrameTab1 then AuctionFrameTab_OnClick(AuctionFrameTab1) end
            BrowseName:SetText(name)
            if AuctionFrameBrowse_Search then AuctionFrameBrowse_Search() end
            return true
        end
        return false
    end)
    return ok and done
end

-- A column: an inset with section headers and lines laid out top down.
local function CreateColumn(parent)
    local col = K.CreateInset(parent)
    if not col then
        col = CreateFrame("Frame", nil, parent)
        K.AddFill(col, 0.04, 0.035, 0.03, 0.9)
        K.AddBorder(col, 0.23, 0.18, 0.11, 1)
    end
    col.headers, col.lines = {}, {}
    for i = 1, 4 do col.headers[i] = CreateSectionHeader(col) col.headers[i]:Hide() end
    for i = 1, COLUMN_LINES do
        local line = CreateFrame("Button", nil, col)
        line:SetHeight(ROW_H)
        line.stripe = AddStripe(line)
        local hl = line:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.06)
        line.right = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        line.right:SetPoint("RIGHT", -6, 0)
        line.right:SetJustifyH("RIGHT")
        line.button = PanelButton(line, "", 60, 18)
        line.button:SetPoint("RIGHT", -4, 0)
        line.icons = {}
        for k = 1, 4 do
            local ic = CreateFrame("Frame", nil, line)
            ic:SetSize(18, 18)
            ic.border = ic:CreateTexture(nil, "BACKGROUND")
            ic.border:SetAllPoints()
            ic.tex = ic:CreateTexture(nil, "ARTWORK")
            ic.tex:SetPoint("TOPLEFT", 1, -1)
            ic.tex:SetPoint("BOTTOMRIGHT", -1, 1)
            ic.tex:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            ic:EnableMouse(true)
            ic:SetScript("OnEnter", function(self) if self.itemId then ShowItemTooltip(self, self.itemId) end end)
            ic:SetScript("OnLeave", function() GameTooltip:Hide() end)
            line.icons[k] = ic
        end
        line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line.text:SetPoint("LEFT", 8, 0)
        line.text:SetJustifyH("LEFT")
        line.text:SetWordWrap(false)
        line:SetScript("OnLeave", function() GameTooltip:Hide() end)
        line:Hide()
        col.lines[i] = line
    end

    function col:Reset()
        for _, h in ipairs(self.headers) do h:Hide() end
        for _, l in ipairs(self.lines) do l:Hide() end
        self.y, self.nh, self.nl, self.hidden, self.striped = 6, 0, 0, 0, 0
    end
    function col:Room(h)
        local height = self:GetHeight() or 0
        return height <= 0 or self.y + h + 6 <= height
    end
    function col:Header(text)
        if self.nh >= #self.headers or not self:Room(HEADER_H + ROW_H) then return false end
        self.nh = self.nh + 1
        local h = self.headers[self.nh]
        if self.nh > 1 then self.y = self.y + GAP end
        h.title:SetText(text)
        h:ClearAllPoints()
        h:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -self.y)
        h:SetPoint("TOPRIGHT", self, "TOPRIGHT", -4, -self.y)
        h:Show()
        self.y = self.y + HEADER_H
        self.striped = 0
        return true
    end
    -- o = { text, right, items = { itemIds }, button = { label, onClick }, onClick, onEnter }
    function col:Line(o)
        if self.nl >= #self.lines or not self:Room(ROW_H) then
            self.hidden = self.hidden + (o.count or 1)
            return nil
        end
        self.nl = self.nl + 1
        self.striped = self.striped + 1
        local line = self.lines[self.nl]
        line:ClearAllPoints()
        line:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -self.y)
        line:SetPoint("TOPRIGHT", self, "TOPRIGHT", -4, -self.y)
        line.stripe:SetShown(self.striped % 2 == 1)
        line.text:SetText(o.text or "")
        line.right:SetText(o.right or "")
        line.right:SetShown(o.button == nil)
        line.button:SetShown(o.button ~= nil)
        if o.button then
            line.button:SetText(o.button.label)
            line.button:SetScript("OnClick", o.button.onClick)
        end
        -- item icons, right to left before the count
        local anchor = o.button and line.button or line.right
        local n = 0
        for k, ic in ipairs(line.icons) do
            local id = o.items and o.items[k]
            if id then
                n = n + 1
                ic.itemId = id
                ic.tex:SetTexture(select(10, GetItemInfo(id))
                    or (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(id))
                    or "Interface\\Icons\\INV_Misc_QuestionMark")
                ic.border:SetColorTexture(K.ItemQualityRGB(id))
                ic:ClearAllPoints()
                ic:SetPoint("RIGHT", anchor, "LEFT", -4, 0)
                anchor = ic
                ic:Show()
            else
                ic:Hide()
            end
        end
        line.text:SetPoint("RIGHT", anchor, "LEFT", -6, 0)
        line:SetScript("OnClick", o.onClick)
        line:SetScript("OnEnter", o.onEnter)
        line:EnableMouse(o.onClick ~= nil or o.onEnter ~= nil)
        line.data = o
        line:Show()
        self.y = self.y + ROW_H
        return line
    end
    function col:Note(text)
        local line = self:Line({ text = "|cff888888" .. text .. "|r" })
        if line then line.stripe:Hide() end
    end
    function col:Finish()
        if self.hidden > 0 then
            local line = self.lines[self.nl]
            if line and self.nl > 0 then line.right:SetText("|cff888888+" .. self.hidden .. " more|r") end
        end
    end
    return col
end

function UI:BuildWherePage(page)
    local summary = K.CreateInset(page)
    if not summary then
        summary = CreateFrame("Frame", nil, page)
        K.AddFill(summary, 0.04, 0.035, 0.03, 0.9)
        K.AddBorder(summary, 0.23, 0.18, 0.11, 1)
    end
    summary:SetPoint("TOPLEFT")
    summary:SetPoint("TOPRIGHT")
    summary:SetHeight(34)
    self.whereSummary = summary:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    self.whereSummary:SetPoint("LEFT", 12, 0)
    self.whereSummary:SetPoint("RIGHT", -12, 0)
    self.whereSummary:SetJustifyH("LEFT")
    self.whereSummary:SetWordWrap(false)

    self.whereCols = {}
    for i = 1, 3 do
        local col = CreateColumn(page)
        col:SetPoint("TOP", summary, "BOTTOM", 0, -8)
        col:SetPoint("BOTTOM", page, "BOTTOM")
        self.whereCols[i] = col
    end
    -- three equal columns
    page:SetScript("OnSizeChanged", function(p, w)
        local colW = ((w or p:GetWidth() or 0) - 16) / 3
        for i, col in ipairs(UI.whereCols) do
            col:ClearAllPoints()
            col:SetPoint("TOPLEFT", summary, "BOTTOMLEFT", (i - 1) * (colW + 8), -8)
            col:SetPoint("BOTTOM", p, "BOTTOM")
            col:SetWidth(colW)
        end
        if UI.page == "where" then UI:RefreshWhere() end
    end)
end

local function ItemIds(loc)
    local ids = {}
    for _, it in ipairs(loc.items or {}) do table.insert(ids, it.entry.id) end
    return ids
end

local function PlaceTooltip(line)
    local loc = line.data and line.data.loc
    if not loc then return end
    GameTooltip:SetOwner(line, "ANCHOR_RIGHT")
    local first = loc.items and loc.items[1] and loc.items[1].entry
    if K.SetQuestTooltip(line, first and first.questId) then
        GameTooltip:AddLine(" ")
    else
        GameTooltip:SetText(loc.location, 1, 1, 1, 1, true)
    end
    for _, it in ipairs(loc.items or {}) do
        GameTooltip:AddDoubleLine(addon:GetItemQualityColor(it.entry.id) .. addon:GetItemName(it.entry.id) .. "|r",
            addon.SLOT_LABELS[it.slot] or it.slot, 1, 1, 1, 0.6, 0.6, 0.6)
    end
    if line.data.hint then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(line.data.hint, 0.6, 0.6, 0.6, true)
    end
    GameTooltip:Show()
end

function UI:RefreshWhere()
    if not self.whereCols then return end
    local class, spec, phase = TBCBisTrackerDB.lastClass, TBCBisTrackerDB.lastSpec, TBCBisTrackerDB.lastPhase
    local groups = (class and spec and phase) and addon:GetFarmBreakdown(class, spec, phase) or {}
    local byType = {}
    for _, g in ipairs(groups) do byType[g.type] = g end
    local c1, c2, c3 = self.whereCols[1], self.whereCols[2], self.whereCols[3]
    for _, col in ipairs(self.whereCols) do col:Reset() end

    -- 1: dungeons and raids, the places with most of your items first
    local best
    local any1 = false
    for _, t in ipairs({ "dungeon", "heroic", "raid" }) do
        local g = byType[t]
        if g and c1:Header(({ dungeon = "Dungeons", heroic = "Heroic dungeons", raid = "Raids" })[t]) then
            any1 = true
            for _, loc in ipairs(g.locations) do
                local where = K.ShortSource({ source = loc.location .. " (x)" })
                if not best or loc.count > best.count then best = { where = where, count = loc.count } end
                c1:Line({ text = where, right = tostring(loc.count), items = ItemIds(loc), loc = loc, count = loc.count,
                    onEnter = PlaceTooltip })
            end
        end
    end
    if not any1 then
        c1:Header("Dungeons")
        c1:Note("Nothing left from dungeons.")
    end
    c1:Finish()

    -- 2: quests (in your log or not), then professions
    local quests = 0
    local gq = byType.quest
    if gq and c2:Header("Quests") then
        for _, loc in ipairs(gq.locations) do
            quests = quests + loc.count
            local where = K.ShortSource({ source = loc.location .. " (x)" })
            local questId = loc.items[1] and loc.items[1].entry.questId
            local inLog = QuestInLog(questId, where)
            c2:Line({
                text = where, loc = loc, count = loc.count,
                right = inLog and "|cff60ff60In your log|r" or "|cff888888Not started|r",
                hint = inLog and "Click: open it in your quest log" or "Click: its Wowhead page",
                onEnter = PlaceTooltip,
                onClick = function()
                    if OpenQuest(where, questId) then return end
                    if questId then
                        UI:ShowUrlPopup("Wowhead quest (Ctrl+C to copy):", addon.WOWHEAD_QUEST_BASE .. questId)
                    else
                        UI:ShowUrlPopup("Wowhead search (Ctrl+C to copy):", addon.WOWHEAD_SEARCH_BASE .. where:gsub(" ", "+"))
                    end
                end,
            })
        end
    end
    local gc = byType.crafted
    if gc and c2:Header("Professions") then
        -- one line per profession: your skill against the highest recipe you need
        local profs, order = {}, {}
        for _, loc in ipairs(gc.locations) do
            for _, it in ipairs(loc.items) do
                local prof = addon:ParseCraftingProfession(it.entry) or loc.location
                if not profs[prof] then
                    profs[prof] = { need = 0, items = {}, loc = { location = prof, items = {} } }
                    table.insert(order, prof)
                end
                local p = profs[prof]
                local need = tonumber((it.entry.source or ""):match("%((%d+)%)") or "") or 0
                if need > p.need then p.need = need end
                table.insert(p.items, it.entry.id)
                table.insert(p.loc.items, it)
            end
        end
        for _, prof in ipairs(order) do
            local p = profs[prof]
            local rank, _, known = addon:GetPlayerProfessionLevel(prof)
            local right
            if not rank and not known then
                right = "|cff888888" .. (p.need > 0 and ("needs " .. p.need) or "crafted") .. "|r"
            elseif not rank then
                right = "|cffff6b5anot learned" .. (p.need > 0 and (" · " .. p.need) or "") .. "|r"
            elseif p.need > 0 then
                right = (rank >= p.need and "|cff60ff60" or "|cffffd100") .. rank .. " / " .. p.need .. "|r"
            else
                right = "|cff60ff60" .. rank .. "|r"
            end
            c2:Line({ text = prof, right = right, items = p.items, loc = p.loc, count = #p.items, onEnter = PlaceTooltip })
        end
    end
    if not gq and not gc then
        c2:Header("Quests")
        c2:Note("No quest or crafted items left.")
    end
    c2:Finish()

    -- 3: vendors, the auction house (world drops), PvP
    local gr = byType.reputation
    if gr and c3:Header("Vendors") then
        for _, loc in ipairs(gr.locations) do
            local right = tostring(loc.count)
            local fname, standing, needId = addon:ParseRepLocation(loc.location)
            if fname and standing then
                local _, currentId = addon:GetCurrentReputation(fname)
                if currentId then
                    right = (currentId >= needId and "|cff60ff60" or "|cffff8800") .. standing .. "|r"
                else
                    right = "|cff888888" .. standing .. "|r"
                end
            end
            c3:Line({ text = K.ShortSource({ source = loc.location .. " (x)" }), right = right, items = ItemIds(loc),
                loc = loc, count = loc.count, onEnter = PlaceTooltip })
        end
    end
    local auction = 0
    local gw = byType.world
    if gw and c3:Header("Auction house") then
        for _, loc in ipairs(gw.locations) do
            for _, it in ipairs(loc.items) do
                auction = auction + 1
                local name = addon:GetItemName(it.entry.id)
                c3:Line({
                    text = addon:GetItemQualityColor(it.entry.id) .. name .. "|r", count = 1,
                    loc = { location = loc.location, items = { it } }, onEnter = PlaceTooltip,
                    hint = "World drop: buy it, or keep an eye out.",
                    button = { label = "Search", onClick = function()
                        if not SearchAuctionHouse(name) then
                            addon:Print("Open the auction house, then click Search to look for " .. name .. ".")
                        end
                    end },
                })
            end
        end
    end
    local gp = byType.pvp
    if gp and c3:Header("PvP") then
        for _, loc in ipairs(gp.locations) do
            c3:Line({ text = K.ShortSource({ source = loc.location .. " (x)" }), right = tostring(loc.count),
                items = ItemIds(loc), loc = loc, count = loc.count, onEnter = PlaceTooltip })
        end
    end
    if not gr and not gw and not gp then
        c3:Header("Vendors")
        c3:Note("Nothing to buy.")
    end
    c3:Finish()

    -- The line on top: where your next session pays most
    local needed = 0
    for _, g in ipairs(groups) do needed = needed + g.count end
    local _, total = addon:GetPhaseProgress(class, spec, phase)
    if needed == 0 then
        self.whereSummary:SetText("|cffffd700Everything obtained!|r")
        return
    end
    local parts = {}
    if best then table.insert(parts, best.where .. " |cff60ff60" .. best.count .. " for you|r") end
    if quests > 0 then table.insert(parts, "Quests |cff60ff60" .. quests .. "|r") end
    if auction > 0 then table.insert(parts, "Auction house |cff60ff60" .. auction .. "|r") end
    self.whereSummary:SetText("|cffffd100Best next session:|r  " .. table.concat(parts, "  |cff888888·|r  ")
        .. "    |cff888888" .. needed .. " of " .. (total or needed) .. " still needed|r")
end
