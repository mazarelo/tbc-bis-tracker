-- TBCBisTracker UI
-- Full UI: class/spec picker, phase tabs, gear rows with checkboxes, progress bar

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker

addon.UI = {}
local UI = addon.UI

-- Newer clients (WoW Forever) only ship this under C_Item.
local GetItemInfo = GetItemInfo or (C_Item and C_Item.GetItemInfo)

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
-- LIST_W is the width of the gear-list / filters / footer area on the left.
-- STAT_AREA_W is the width of the stat-cap column on the right inside the
-- same window (TBC only). FRAME_W is the total window width.
local LIST_W       = 960   -- the window's content width (Pages.lua lays out the tabs' pages in it)
local STAT_AREA_W  = 0     -- (the stat caps have their own tab now)
local FRAME_W      = LIST_W
local FRAME_H      = 640
local PHASE_TAB_H  = 24
local PROGRESS_H   = 18

-- Vertical layout (offsets from the top of the window).
local ROW_A_Y      = -30   -- class dropdown, spec tabs, stage chip
local ROW_A_X      = 0     -- set in Build: right of the portrait on the game's window
local ROW_B_Y      = -62   -- source filter, missing only, export/import
local TABS_Y       = -92   -- phase tabs (only when there's more than one phase)
local BANNER_H     = 26
-- Space kept under the pages: progress footer, plus badge/tier lines on TBC.
local LIST_BOTTOM_FOREVER = 44
local LIST_BOTTOM_TBC     = 80

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

-- Short labels shown in the Source column. Full source description is
-- still preserved on `entry.source` and shown via tooltip on hover.
local SOURCE_TYPE_LABELS = {
    crafted    = "Profession",
    heroic     = "Dungeon HC",
    raid       = "Raid",
    reputation = "Reputation",
    pvp        = "PvP",
    world      = "World",
    quest      = "Quest",
    dungeon    = "Dungeon",
}

-- ─────────────────────────────────────────────
-- Central UI palette  — keep all visual constants here so the addon
-- has a predictable, consistent look. If you need a new color or
-- spacing value, add it here rather than inline.
-- ─────────────────────────────────────────────
local UI_PAL = {
    -- Text colors (escaped color codes for inline use)
    accent      = "|cffffd700", -- gold — headers, BiS markers, quest indicator
    accentSoft  = "|cffd6b85a", -- muted gold
    success     = "|cff60ff60", -- capped/obtained
    warning     = "|cffff8800", -- below cap, alt deltas
    danger      = "|cffff5050", -- way below cap, errors
    info        = "|cff00d0ff", -- hover hint, links
    muted       = "|cff888888", -- dim secondary text
    mutedSoft   = "|cffaaaaaa", -- subdued labels
    text        = "|cffffffff",
    -- Bar colors (r,g,b,a tuples for SetVertexColor)
    barFull     = { 0.20, 0.80, 0.20, 0.85 },
    barMid      = { 0.85, 0.70, 0.20, 0.85 },
    barLow      = { 0.85, 0.30, 0.20, 0.85 },
    barTrack    = { 0.10, 0.10, 0.10, 1.0 },
    -- Section divider line
    divider     = { 0.4, 0.4, 0.4, 0.6 },
    dividerSoft = { 0.3, 0.3, 0.3, 0.4 },
    -- Selection / hover backgrounds
    selectBg    = { 0.25, 0.20, 0.05, 0.9 },  -- gold-ish
    hoverBg     = { 0.25, 0.25, 0.30, 1.0 },
    inactiveBg  = { 0.12, 0.12, 0.12, 0.8 },
    -- Spacing tokens
    pad         = 8,
    padSm       = 4,
    padLg       = 14,
    sectionGap  = 12,
}

-- Helper: create a 1px horizontal divider line on a parent frame.
local function CreateDivider(parent, color)
    color = color or UI_PAL.divider
    local d = parent:CreateTexture(nil, "OVERLAY")
    d:SetColorTexture(color[1], color[2], color[3], color[4])
    return d
end

-- Helper: attach a GameTooltip to a frame that shows a simple title + optional description on hover.
local function AddSimpleTooltip(frame, title, desc, anchor)
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, anchor or "ANCHOR_TOP")
        GameTooltip:SetText(title, 1, 1, 1)
        if desc then GameTooltip:AddLine(desc, 0.8, 0.8, 0.8, true) end
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-- ─────────────────────────────────────────────
-- Blizzard's own templates
-- ─────────────────────────────────────────────
-- Same idea as Forever Chat: the windows are built from the game's own templates,
-- atlases and font objects when the client has them, so they look like the client's
-- own windows and UI add-ons that restyle Blizzard frames restyle these too. Each
-- one falls back to the flat look below on a client without it.

local function HasTemplate(name)
    if C_XMLUtil and C_XMLUtil.GetTemplateInfo then
        local ok, info = pcall(C_XMLUtil.GetTemplateInfo, name)
        return ok and info ~= nil
    end
    return false
end

-- CreateFrame with a template, or nil when the client doesn't have it.
local function FromTemplate(kind, name, parent, template)
    if not HasTemplate(template) then return nil end
    local ok, f = pcall(CreateFrame, kind, name, parent, template)
    return ok and f or nil
end

local function HasAtlas(atlas)
    if not (C_Texture and C_Texture.GetAtlasInfo) then return false end
    local ok, info = pcall(C_Texture.GetAtlasInfo, atlas)
    return ok and info ~= nil
end

-- true: windows are the game's portrait frame (ButtonFrameTemplate).
local TEMPLATED = HasTemplate("ButtonFrameTemplate")

-- A template's child by key path (f, "TitleContainer", "TitleText"), nil when missing.
local function Child(f, ...)
    local node = f
    for _, key in ipairs({ ... }) do
        if type(node) ~= "table" then return nil end
        node = node[key]
    end
    return type(node) == "table" and node or nil
end

-- A movable window closed by Escape: the game's portrait frame (round portrait, title
-- bar, red X; portrait = false hides the portrait) or BasicFrameTemplateWithInset.
-- f.templated says which; f.heading is the template's title text (nil on the fallback).
local function CreateWindow(name, width, height, portrait)
    local f = FromTemplate("Frame", name, UIParent, "ButtonFrameTemplate")
    if f then
        f.templated = true
        f.heading = Child(f, "TitleText") or Child(f, "TitleContainer", "TitleText") or Child(_G, name .. "TitleText")
        f.portrait = Child(f, "PortraitContainer", "portrait") or Child(f, "portrait") or Child(_G, name .. "Portrait")
        local inset = Child(f, "Inset")
        if inset then inset:Hide() end -- the window brings its own insets
        if ButtonFrameTemplate_HideButtonBar then pcall(ButtonFrameTemplate_HideButtonBar, f) end
        if not portrait then
            if ButtonFrameTemplate_HidePortrait then pcall(ButtonFrameTemplate_HidePortrait, f) end
            f.portrait = nil
        end
    else
        f = CreateFrame("Frame", name, UIParent, "BasicFrameTemplateWithInset")
        f.templated, f.heading, f.portrait = false, false, false
    end
    f:SetSize(width, height)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop",  f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    f:SetFrameStrata("HIGH")
    f:SetToplevel(true)
    f:Hide()
    if type(UISpecialFrames) == "table" then table.insert(UISpecialFrames, name) end
    return f
end

-- The game's inset box (InsetFrameTemplate), or nil on a client without it.
local function CreateInset(parent)
    return FromTemplate("Frame", nil, parent, "InsetFrameTemplate")
end

-- The thin scroll bar of the game's newer lists (MinimalScrollBar), drawn from its
-- atlases on the plain slider so scrolling works the same. Returns the thumb, or nil
-- when the client doesn't have the atlases.
local MINIMAL_SCROLL = {
    { track = "minimal-scrollbar-track-middle", top = "minimal-scrollbar-track-top", bottom = "minimal-scrollbar-track-bottom",
      thumb = "minimal-scrollbar-small-thumb-middle", thumbTop = "minimal-scrollbar-small-thumb-top",
      thumbBottom = "minimal-scrollbar-small-thumb-bottom" },
    { track = "minimal-scrollbar-track-middle", top = "minimal-scrollbar-track-top", bottom = "minimal-scrollbar-track-bottom",
      thumb = "minimal-scrollbar-thumb-middle", thumbTop = "minimal-scrollbar-thumb-top",
      thumbBottom = "minimal-scrollbar-thumb-bottom" },
}
local function SkinMinimalScrollBar(bar)
    local art
    for _, set in ipairs(MINIMAL_SCROLL) do
        if HasAtlas(set.track) and HasAtlas(set.thumb) then art = set break end
    end
    if not art then return nil end
    bar:SetWidth(8)
    local function piece(atlas, layer)
        local t = bar:CreateTexture(nil, layer)
        if HasAtlas(atlas) then t:SetAtlas(atlas, true) end
        return t
    end
    local top, bottom = piece(art.top, "BACKGROUND"), piece(art.bottom, "BACKGROUND")
    top:SetPoint("TOP")
    bottom:SetPoint("BOTTOM")
    local track = piece(art.track, "BACKGROUND")
    track:SetPoint("TOPLEFT", top, "BOTTOMLEFT")
    track:SetPoint("BOTTOMRIGHT", bottom, "TOPRIGHT")
    local thumb = bar:CreateTexture(nil, "OVERLAY")
    thumb:SetAtlas(art.thumb)
    thumb:SetSize(8, 40)
    bar:SetThumbTexture(thumb)
    local cap1, cap2 = piece(art.thumbTop, "OVERLAY"), piece(art.thumbBottom, "OVERLAY")
    cap1:SetPoint("BOTTOM", thumb, "TOP")
    cap2:SetPoint("TOP", thumb, "BOTTOM")
    return thumb
end

-- The character window's stat pane: section title bars ("General", "Primary
-- Attributes") and the light band behind every other "Label:  value" line.
local SECTION_ATLAS = "UI-Character-Info-Title"
local STRIPE_ATLAS  = "UI-Character-Info-Line-Bounce"

-- Side tabs: the spellbook's skill-line tab (icon in a square frame, gold glow when
-- selected) on the window's right edge, as Alt Command Center and Forever Chat draw them.
local SPELLBOOK_TAB = "Interface\\SpellBook\\SpellBook-SkillLineTab"
local SIDE_TAB      = { w = 40, h = 40, step = 52 }
local CLASS_TABS_Y  = -48   -- under the title bar

local function SetClassIcon(tex, class)
    local coords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[class]
    tex:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    if coords then tex:SetTexCoord(coords[1], coords[2], coords[3], coords[4]) end
end

-- A checkable icon tab for the right edge of a window (:SetChecked for the selected one).
local function CreateSideTab(parent)
    local b = CreateFrame("CheckButton", nil, parent)
    b:SetSize(SIDE_TAB.w, SIDE_TAB.h)
    local bg = b:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture(SPELLBOOK_TAB)
    bg:SetSize(80, 80)
    bg:SetPoint("TOPLEFT", -4, 14)
    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetAllPoints()
    b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    -- The selected glow is added over the icon; SetCheckedTexture takes no blend mode,
    -- and drawn normally the glow's black square hides the icon.
    local glow = b:CreateTexture(nil, "OVERLAY")
    glow:SetTexture("Interface\\Buttons\\CheckButtonHilight")
    glow:SetBlendMode("ADD")
    glow:SetAllPoints()
    b:SetCheckedTexture(glow)
    b.glow = glow
    return b
end

-- What the client offers for the add-on's native look (/tbcbis probe).
function UI:ProbeLines()
    local lines = {}
    local function add(kind, name, yes) lines[#lines + 1] = kind .. " " .. name .. ": " .. (yes and "yes" or "no") end
    for _, t in ipairs({ "ButtonFrameTemplate", "InsetFrameTemplate", "CharacterStatFrameCategoryTemplate",
        "QuestLogTabButtonTemplate", "LargeSideTabButtonTemplate", "SideTabsTemplate",
        "TabButtonTemplate", "PanelTabButtonTemplate", "PanelTopTabButtonTemplate", "TabSystemButtonTemplate",
        "TabSystemTopButtonTemplate", "MinimalTabTemplate" }) do
        add("template", t, HasTemplate(t))
    end
    for _, a in ipairs({ SECTION_ATLAS, STRIPE_ATLAS, "minimal-scrollbar-track-middle" }) do
        add("atlas", a, HasAtlas(a))
    end
    lines[#lines + 1] = "spec tabs: " .. ((self.specBtns and self.specBtns[1] and self.specBtns[1].classic)
        and "TabButtonTemplate" or "flat fallback")
    return lines
end

-- ─── Reading the game's own tabs (/tbcbis probe tabs) ───
-- The talent window's tabs (Primary / Secondary on Forever) are drawn from art whose
-- names aren't known here. This finds those tabs in the live window and lists every
-- texture on them (atlas or file, layer, size), so the spec tabs can copy them exactly.

local TALENT_UI_ADDONS = { "Blizzard_PlayerSpells", "Blizzard_ClassTalentUI", "Blizzard_TalentUI" }
local TALENT_FRAMES    = { "PlayerSpellsFrame", "ClassTalentFrame", "PlayerTalentFrame", "TalentFrame" }
local TAB_WORDS        = { "Primary", "Secondary" }

local function RegionText(region)
    if region:GetObjectType() ~= "FontString" then return nil end
    local ok, text = pcall(region.GetText, region)
    return ok and type(text) == "string" and text or nil
end

-- The frame's own font strings mention one of the tab words.
local function IsTalentTab(frame)
    if not frame.GetRegions then return false end
    for _, region in ipairs({ frame:GetRegions() }) do
        local text = RegionText(region)
        if text then
            for _, word in ipairs(TAB_WORDS) do
                if text:find(word, 1, true) then return true end
            end
        end
    end
    return false
end

local function DescribeRegion(region)
    local kind = region:GetObjectType()
    local name = region.GetName and region:GetName() or nil
    local w, h = region:GetSize()
    local layer = region.GetDrawLayer and region:GetDrawLayer() or "?"
    local parts = { kind, name or "", layer, string.format("%dx%d", w or 0, h or 0),
        region:IsShown() and "shown" or "hidden" }
    if kind == "Texture" then
        local atlas = region.GetAtlas and region:GetAtlas()
        if atlas then parts[#parts + 1] = "atlas=" .. atlas end
        local file = region:GetTexture()
        if file then parts[#parts + 1] = "file=" .. tostring(file) end
        if region.GetVertexColor then
            local r, g, b, a = region:GetVertexColor()
            parts[#parts + 1] = string.format("color=%.2f,%.2f,%.2f,%.2f", r or 1, g or 1, b or 1, a or 1)
        end
        if region.GetTexCoord then
            local c = { region:GetTexCoord() }
            if #c > 0 then
                for i, v in ipairs(c) do c[i] = string.format("%.3f", v) end
                parts[#parts + 1] = "coords=" .. table.concat(c, ",")
            end
        end
    elseif kind == "FontString" then
        parts[#parts + 1] = "text=" .. tostring(RegionText(region))
        local font = region.GetFontObject and region:GetFontObject()
        if font and font.GetName then parts[#parts + 1] = "font=" .. tostring(font:GetName()) end
    end
    return table.concat(parts, " | ")
end

local function DescribeTab(frame, lines)
    local w, h = frame:GetSize()
    lines[#lines + 1] = string.format("TAB %s (%s) %dx%d", tostring(frame:GetName()), frame:GetObjectType(), w or 0, h or 0)
    for _, region in ipairs({ frame:GetRegions() }) do
        lines[#lines + 1] = "  " .. DescribeRegion(region)
    end
    for _, child in ipairs({ frame:GetChildren() }) do
        local cw, ch = child:GetSize()
        lines[#lines + 1] = string.format("  child %s (%s) %dx%d", tostring(child:GetName()), child:GetObjectType(), cw or 0, ch or 0)
        for _, region in ipairs({ child:GetRegions() }) do
            lines[#lines + 1] = "    " .. DescribeRegion(region)
        end
    end
end

function UI:ProbeTalentTabs()
    local load = (C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn
    if load then
        for _, name in ipairs(TALENT_UI_ADDONS) do pcall(load, name) end
    end
    local lines, found, seen = {}, 0, {}
    local function walk(frame, depth)
        if depth > 10 or seen[frame] then return end
        seen[frame] = true
        if IsTalentTab(frame) and frame:GetObjectType() ~= "FontString" then
            found = found + 1
            if found <= 4 then DescribeTab(frame, lines) end
        end
        if frame.GetChildren then
            for _, child in ipairs({ frame:GetChildren() }) do walk(child, depth + 1) end
        end
    end
    for _, name in ipairs(TALENT_FRAMES) do
        local root = _G[name]
        if type(root) == "table" and root.GetChildren then
            lines[#lines + 1] = "window " .. name
            pcall(walk, root, 0)
        end
    end
    lines[#lines + 1] = found .. " tab(s) with " .. table.concat(TAB_WORDS, "/") .. " found"
    TBCBisTrackerDB.probe = { t = time and time() or 0, lines = lines }
    return lines, found
end

-- ─────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────

local function ColorText(text, hex)
    return "|cff" .. hex .. text .. "|r"
end

-- Text in the game's font objects (which UI add-ons restyle), or the outlined Friz Quadrata.
local function SetFontNormal(fs)
    if TEMPLATED and GameFontHighlight then
        fs:SetFontObject(GameFontHighlight)
    else
        fs:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    end
end

local function SetFontSmall(fs)
    if TEMPLATED and GameFontHighlightSmall then
        fs:SetFontObject(GameFontHighlightSmall)
    else
        fs:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    end
end

-- 1px border around a frame (no BackdropTemplate needed, works on every client).
local function AddBorder(frame, r, g, b, a)
    local edges = {}
    for i, pts in ipairs({
        { "TOPLEFT", "TOPRIGHT", nil, 1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", nil, 1 },
        { "TOPLEFT", "BOTTOMLEFT", 1, nil }, { "TOPRIGHT", "BOTTOMRIGHT", 1, nil },
    }) do
        local t = frame:CreateTexture(nil, "BORDER")
        t:SetColorTexture(r, g, b, a or 1)
        t:SetPoint(pts[1]); t:SetPoint(pts[2])
        if pts[3] then t:SetWidth(pts[3]) else t:SetHeight(pts[4]) end
        edges[i] = t
    end
    frame.borderEdges = edges
end

local function SetBorderColor(frame, r, g, b, a)
    for _, t in ipairs(frame.borderEdges or {}) do t:SetColorTexture(r, g, b, a or 1) end
end

-- Flat dark background for a frame.
local function AddFill(frame, r, g, b, a)
    local t = frame:CreateTexture(nil, "BACKGROUND")
    t:SetAllPoints()
    t:SetColorTexture(r, g, b, a or 1)
    return t
end

-- Classic tab: Blizzard's TabButtonTemplate (the Macro window's tabs) when the
-- client has it, else a flat fallback. Tabs get global names because older
-- PanelTemplates_* code finds their textures by name. The selected tab is the
-- template's "disabled" look, so it can't be clicked again.
local function CreateTab(parent, name)
    local ok, tab = pcall(CreateFrame, "Button", name, parent, "TabButtonTemplate")
    if ok and tab and PanelTemplates_TabResize and PanelTemplates_SelectTab and PanelTemplates_DeselectTab then
        tab.classic = true
        return tab
    end
    tab = CreateFrame("Button", name, parent)
    tab:SetHeight(24)
    tab.bg = AddFill(tab, 0.12, 0.12, 0.12, 0.8)
    local accent = tab:CreateTexture(nil, "OVERLAY")
    accent:SetColorTexture(1, 0.82, 0, 1)
    accent:SetPoint("BOTTOMLEFT", 2, 0)
    accent:SetPoint("BOTTOMRIGHT", -2, 0)
    accent:SetHeight(2)
    accent:Hide()
    tab.accent = accent
    local fs = tab:CreateFontString(nil, "OVERLAY")
    SetFontNormal(fs)
    fs:SetAllPoints()
    tab:SetFontString(fs)
    return tab
end

-- Label a tab and size it to the text (or to a fixed width).
local function SetTabLabel(tab, text, width)
    tab:SetText(text)
    if tab.classic then
        PanelTemplates_TabResize(tab, 0, width)
    else
        tab:SetWidth(width or (tab:GetFontString():GetStringWidth() + 24))
    end
end

local function SetTabSelected(tab, selected)
    if tab.classic then
        if selected then PanelTemplates_SelectTab(tab) else PanelTemplates_DeselectTab(tab) end
    else
        tab.bg:SetColorTexture(unpack(selected and UI_PAL.selectBg or UI_PAL.inactiveBg))
        tab:GetFontString():SetTextColor(selected and 1 or 0.8, selected and 0.82 or 0.8, selected and 0 or 0.8, 1)
        tab.accent:SetShown(selected)
    end
end

local function PlayerClass()
    local _, class = UnitClass("player")
    return class
end

-- Viewing a class other than your own: planning only, no ticks.
local function IsBrowsing()
    local class = PlayerClass()
    return class ~= nil and TBCBisTrackerDB.lastClass ~= class
end

-- Where-it-comes-from text without the trailing "(Item Name)", shortened.
local function ShortSource(entry)
    local src = entry.source or ""
    src = src:gsub("%s*%(([^()]*)%)%s*$", "")
    src = src:gsub("^World drop, sold at the auction house", "World drop · auction house")
    src = src:gsub("^Quest:%s*", "")
    return src
end

-- Random-suffix items are listed by their base ID, so the client names them
-- without the suffix ("Twilight Cape" for "Twilight Cape of Healing"). The
-- list's own name keeps it: return the missing part to show next to the name.
local function SuffixHint(entry, itemName)
    local listed = entry.source and entry.source:match("%(([^()]*)%)%s*$")
    if not (listed and itemName) then return nil end
    if #listed > #itemName and listed:sub(1, #itemName) == itemName then
        return listed:sub(#itemName + 1)
    end
    return nil
end

local function ItemQualityRGB(itemId)
    local quality = itemId and select(3, GetItemInfo(itemId))
    if quality and GetItemQualityColor then
        local r, g, b = GetItemQualityColor(quality)
        if r then return r, g, b end
    end
    return 0.35, 0.35, 0.35
end

-- ─────────────────────────────────────────────
-- Main frame
-- ─────────────────────────────────────────────

function UI:Build()
    if self.frame then return end

    -- Outer frame: the game's portrait window (your character's face top left), like
    -- the character window, or the plain dialog frame on older clients.
    local f = CreateWindow("TBCBisTrackerFrame", FRAME_W, FRAME_H, true)
    f:SetPoint("CENTER")
    self.frame = f
    ROW_A_X = f.portrait and 58 or 0

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

    -- Title: just the add-on name; class and spec live in the toolbar below.
    if f.heading then
        f.heading:SetText(addon.TITLE)
        self.titleText = f.heading
    else
        -- Left-aligned so it can never run under anything else in the title bar.
        local title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        title:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -5)
        title:SetText(UI_PAL.accent .. addon.TITLE .. "|r")
        self.titleText = title
    end
    self:RefreshPortrait()

    -- ── Row A: class dropdown + spec tabs + stage ──
    self:BuildClassButtons()
    self:BuildSpecSelector()
    self:BuildPhaseTabs()

    -- ── Row B: source filter, missing only, export/import ──
    self:BuildSourceFilter()
    self:BuildMissingFilter()
    self:BuildExportImportButtons()

    -- ── "Browsing another class" banner ──
    self:BuildBrowseBanner()

    -- ── Pages (Gear, Where to go, TBC: Stat Caps) and their tabs under the window ──
    self:BuildPages()

    -- ── Progress footer ──
    self:BuildProgressBar()

    -- ── TBC extras under the pages: badges, tier sets ──
    if not addon:IsForever() then self:BuildBadgeStatus() end
    self:BuildTierStatus()

    -- Initial population
    self:RefreshClassButtons()
    self:RefreshSpecSelector()
    self:RefreshPhaseTabs()
    self:Refresh()
end

-- Your character's face in the window's portrait, as on the character window.
function UI:RefreshPortrait()
    local portrait = self.frame and self.frame.portrait
    if not portrait then return end
    if SetPortraitTexture then
        pcall(SetPortraitTexture, portrait, "player")
    end
end

-- ─────────────────────────────────────────────
-- Class buttons
-- ─────────────────────────────────────────────

-- The window opens on your own class; the class dropdown lets you browse the
-- others (planning only: ticks and auto-detect stay on your own class).

-- Pick a valid spec for a class: the one last viewed for it, else its first.
local function SpecForClass(class)
    local info = addon.CLASS_INFO[class]
    if not info then return nil end
    local remembered = TBCBisTrackerDB.specByClass and TBCBisTrackerDB.specByClass[class]
    for _, s in ipairs(info.specs) do
        if s == remembered then return s end
    end
    return info.specs[1]
end

function UI:SetViewClass(class)
    if not addon.CLASS_INFO[class] then return end
    TBCBisTrackerDB.specByClass = TBCBisTrackerDB.specByClass or {}
    if TBCBisTrackerDB.lastClass and TBCBisTrackerDB.lastSpec then
        TBCBisTrackerDB.specByClass[TBCBisTrackerDB.lastClass] = TBCBisTrackerDB.lastSpec
    end
    TBCBisTrackerDB.lastClass = class
    TBCBisTrackerDB.lastSpec = SpecForClass(class)
    self:RefreshClassButtons()
    self:RefreshSpecSelector()
    self:Refresh()
end

function UI:BuildClassButtons()
    local f = self.frame
    local playerClass = PlayerClass() or TBCBisTrackerDB.lastClass
    if not playerClass then return end

    -- Every session starts on your own class.
    local info = addon.CLASS_INFO[playerClass]
    if info then
        if TBCBisTrackerDB.lastClass ~= playerClass then
            TBCBisTrackerDB.lastClass = playerClass
            TBCBisTrackerDB.lastSpec = SpecForClass(playerClass)
        end
        local valid = false
        for _, s in ipairs(info.specs) do valid = valid or s == TBCBisTrackerDB.lastSpec end
        if not valid then TBCBisTrackerDB.lastSpec = info.specs[1] end
    end

    -- One icon tab per class down the window's right edge, like the side tabs of the
    -- game's own windows (group finder, spellbook).
    self.classTabs = {}
    for i, class in ipairs(CLASS_ORDER) do
        local tab = CreateSideTab(f)
        tab:SetPoint("TOPLEFT", f, "TOPRIGHT", f.templated and 0 or -4, CLASS_TABS_Y - (i - 1) * SIDE_TAB.step)
        tab.class = class
        SetClassIcon(tab.icon, class)
        tab:SetScript("OnClick", function(t)
            UI:SetViewClass(t.class)
            t:SetChecked(TBCBisTrackerDB.lastClass == t.class)
        end)
        tab:SetScript("OnEnter", function(t)
            local c = addon.CLASS_INFO[t.class]
            GameTooltip:SetOwner(t, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cff" .. c.color .. c.name .. "|r"
                .. (t.class == playerClass and ("  " .. UI_PAL.muted .. "(you)|r") or ""))
            if t.class ~= playerClass then
                GameTooltip:AddLine("Browse its lists. Ticks and auto-detect stay on your own class.",
                    0.8, 0.8, 0.8, true)
            end
            GameTooltip:Show()
        end)
        tab:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.classTabs[class] = tab
    end
    -- Keep the tabs on screen when the window is dragged to the right edge.
    if f.SetClampRectInsets then f:SetClampRectInsets(0, SIDE_TAB.w, 0, 0) end

    -- The class you're viewing, in its colour, where the dropdown used to be.
    local label = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    label:SetPoint("LEFT", f, "TOPLEFT", 20 + ROW_A_X, ROW_A_Y - 12)
    self.classLabel = label
end

function UI:RefreshClassButtons()
    local class = TBCBisTrackerDB.lastClass
    local info = class and addon.CLASS_INFO[class]
    if not (self.classTabs and info) then return end
    for c, tab in pairs(self.classTabs) do tab:SetChecked(c == class) end
    self.classLabel:SetText("|cff" .. info.color .. info.name .. "|r")
end

function UI:BuildSpecSelector()
    local f = self.frame
    self.specBtns = {}
    self.specBtnRow = CreateFrame("Frame", nil, f)
    self.specBtnRow:SetSize(400, 24)
    -- Right of the class name.
    if self.classLabel then
        self.specBtnRow:SetPoint("BOTTOMLEFT", self.classLabel, "BOTTOMRIGHT", 14, -6)
    else
        self.specBtnRow:SetPoint("TOPLEFT", f, "TOPLEFT", 20 + ROW_A_X, ROW_A_Y)
    end
end

local SPEC_POOL_SIZE = 4

local function GetOrCreateSpecBtn(self, idx)
    local btn = self.specBtns[idx]
    if btn then return btn end

    btn = CreateTab(self.specBtnRow, "TBCBisTrackerSpecTab" .. idx)
    btn:SetScript("OnEnter", function(s)
        if s.spec then
            GameTooltip:SetOwner(s, "ANCHOR_TOP")
            GameTooltip:SetText(s.spec, 1, 1, 1)
            GameTooltip:AddLine("Click to view BiS for this spec.", 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
        end
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
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
            SetTabLabel(btn, spec)
            btn:ClearAllPoints()
            btn:SetPoint("BOTTOMLEFT", self.specBtnRow, "BOTTOMLEFT", x, 0)
            SetTabSelected(btn, spec == TBCBisTrackerDB.lastSpec)
            btn:Show()
            x = x + btn:GetWidth() + 2
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

    -- One stage (WoW Forever: Level 30): a single selected tab on the right of row A.
    if #addon.PHASES == 1 then
        local phase = addon.PHASES[1]
        local tab = CreateTab(f, "TBCBisTrackerStageTab")
        SetTabLabel(tab, addon.PHASE_LABELS[phase] or phase)
        tab:SetPoint("TOPRIGHT", f, "TOPRIGHT", -(STAT_AREA_W + 20), ROW_A_Y)
        SetTabSelected(tab, true)
        local lbl = f:CreateFontString(nil, "OVERLAY")
        SetFontSmall(lbl)
        lbl:SetPoint("RIGHT", tab, "LEFT", -6, 0)
        lbl:SetText(UI_PAL.muted .. "STAGE|r")
        AddSimpleTooltip(tab, addon.PHASE_DESCRIPTIONS[phase] or phase)
        self.stageChip = tab
        return
    end

    -- Several phases (TBC): a tab row of their own.
    local tabW = (LIST_W - 40) / #addon.PHASES
    for i, phase in ipairs(addon.PHASES) do
        local btn = CreateTab(f, "TBCBisTrackerPhaseTab" .. i)
        btn.tabW = tabW - 2
        SetTabLabel(btn, addon.PHASE_LABELS[phase], btn.tabW)
        btn:SetPoint("TOPLEFT", f, "TOPLEFT", 20 + (i-1) * tabW, TABS_Y)

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
        SetTabLabel(btn, label, btn.tabW)
        SetTabSelected(btn, phase == selected)
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

-- Per-slot note editor popup. Saves on Accept; clearing the field deletes the note.
function UI:ShowNoteEditor(class, spec, phase, slot)
    local slotLabel = addon.SLOT_LABELS[slot] or slot
    local entry = addon:GetSlotItem(class, spec, phase, slot)
    local itemName = entry and entry.id and addon:GetItemName(entry.id) or "(empty)"
    local existing = addon:GetNote(class, spec, phase, slot) or ""

    StaticPopupDialogs["TBCBIS_NOTE"] = {
        text = "Note for |cffffffff" .. slotLabel .. "|r — " .. itemName .. "\n(empty to clear)",
        button1 = "Save",
        button2 = "Cancel",
        hasEditBox = true,
        editBoxWidth = 380,
        maxLetters = 200,
        OnShow = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            if eb then eb:SetText(existing); eb:HighlightText(); eb:SetFocus() end
        end,
        OnAccept = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            local txt = (eb and eb:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
            addon:SetNote(class, spec, phase, slot, txt ~= "" and txt or nil)
            UI:Refresh()
        end,
        EditBoxOnEnterPressed = function(s)
            local eb = (s and s.editBox) or _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            local txt = (eb and eb:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
            addon:SetNote(class, spec, phase, slot, txt ~= "" and txt or nil)
            s:GetParent():Hide()
            UI:Refresh()
        end,
        EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("TBCBIS_NOTE")
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
    -- Row B, left. The template draws ~16 px inside its frame, hence the offset.
    dd:SetPoint("TOPLEFT", f, "TOPLEFT", 2, ROW_B_Y + 2)
    UIDropDownMenu_SetWidth(dd, 110)
    self.sourceFilterDropdown = dd
    -- Hover tooltip on the dropdown caret
    AddSimpleTooltip(dd, "Source filter", "Show only items from this source type. Useful for planning farms (e.g. show only Heroic dungeon items).")

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
    importBtn:SetSize(70, 22)
    importBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -(STAT_AREA_W + 20), ROW_B_Y)
    importBtn:SetText("Import")
    importBtn:SetScript("OnClick", function() UI:ShowImportPopup() end)
    -- Preserve the OnClick by adding tooltip via separate scripts (hooking, not overwriting)
    importBtn:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Import setup", 1, 1, 1)
        GameTooltip:AddLine("Paste a setup string to load someone else's BiS picks for this spec/phase.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    importBtn:HookScript("OnLeave", function() GameTooltip:Hide() end)

    local exportBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    exportBtn:SetSize(70, 22)
    exportBtn:SetPoint("RIGHT", importBtn, "LEFT", -6, 0)
    exportBtn:SetText("Export")
    exportBtn:SetScript("OnClick", function() UI:ShowExportPopup() end)
    exportBtn:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Export setup", 1, 1, 1)
        GameTooltip:AddLine("Copy your current spec/phase BiS picks as a sharable string.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    exportBtn:HookScript("OnLeave", function() GameTooltip:Hide() end)
end

function UI:BuildMissingFilter()
    local f = self.frame
    local chk = CreateFrame("CheckButton", "TBCBisTrackerMissingChk", f, "UICheckButtonTemplate")
    chk:SetSize(22, 22)
    -- Row B, right of the source filter.
    chk:SetPoint("TOPLEFT", f, "TOPLEFT", 172, ROW_B_Y)
    chk:SetChecked(TBCBisTrackerDB.showMissingOnly or false)

    local lbl = f:CreateFontString(nil, "OVERLAY")
    SetFontNormal(lbl)
    lbl:SetText("Missing only")
    lbl:SetPoint("LEFT", chk, "RIGHT", 2, 0)

    chk:SetScript("OnClick", function(self)
        TBCBisTrackerDB.showMissingOnly = self:GetChecked()
        UI:Refresh()
    end)
    chk:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("Show missing only", 1, 1, 1)
        GameTooltip:AddLine("Hide rows for items you've already obtained, so the list only shows what you still need to chase.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    chk:HookScript("OnLeave", function() GameTooltip:Hide() end)
    self.missingChk = chk
end

-- ─────────────────────────────────────────────
-- Column headers
-- ─────────────────────────────────────────────

function UI:BuildBrowseBanner()
    local f = self.frame
    local banner = CreateInset(f)
    if not banner then
        banner = CreateFrame("Frame", nil, f)
        AddFill(banner, 0.10, 0.13, 0.19, 0.95)
        AddBorder(banner, 0.18, 0.23, 0.32, 1)
    end
    banner:SetSize(LIST_W - 24, BANNER_H)

    local back = CreateFrame("Button", nil, banner, "UIPanelButtonTemplate")
    back:SetSize(130, 20)
    back:SetPoint("RIGHT", banner, "RIGHT", -4, 0)
    back:SetScript("OnClick", function() UI:SetViewClass(PlayerClass()) end)
    banner.back = back

    local txt = banner:CreateFontString(nil, "OVERLAY")
    SetFontNormal(txt)
    txt:SetPoint("LEFT", banner, "LEFT", 10, 0)
    txt:SetPoint("RIGHT", back, "LEFT", -8, 0)
    txt:SetJustifyH("LEFT")
    txt:SetTextColor(0.79, 0.84, 0.93, 1)
    banner.txt = txt

    banner:Hide()
    self.browseBanner = banner
end

-- Positions the browse banner and the pages for the current state: one stage or
-- phase tabs, browsing banner or not, TBC footer lines or not.
function UI:ApplyLayout()
    local f = self.frame
    local top = (#addon.PHASES > 1) and (TABS_Y - PHASE_TAB_H - 6) or (ROW_B_Y - 30)
    if IsBrowsing() then
        self.browseBanner:ClearAllPoints()
        self.browseBanner:SetPoint("TOPLEFT", f, "TOPLEFT", 12, top)
        self.browseBanner:Show()
        top = top - BANNER_H - 6
    else
        self.browseBanner:Hide()
    end
    local bottom = addon:IsForever() and LIST_BOTTOM_FOREVER or LIST_BOTTOM_TBC
    for _, page in pairs(self.pages) do
        page:ClearAllPoints()
        page:SetPoint("TOPLEFT", f, "TOPLEFT", 12, top)
        page:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -12, bottom)
    end
end

-- Copyable link popup. The URL goes in via StaticPopup_Show's `data`: on TBC
-- Classic the popup has no `self.editBox`, only the global `<frameName>EditBox`,
-- and some popup slots clear the box after OnShow, so the text is re-applied
-- on the next frame.
function UI:ShowUrlPopup(label, url)
    local function findEditBox(s)
        if s and s.editBox then return s.editBox end
        local name = s and s.GetName and s:GetName()
        if name then return _G[name .. "EditBox"] end
        return _G["StaticPopup1EditBox"] or _G["StaticPopup2EditBox"]
            or _G["StaticPopup3EditBox"] or _G["StaticPopup4EditBox"]
    end
    StaticPopupDialogs["TBCBIS_URL"] = {
        text = label,
        button1 = "Close",
        hasEditBox = true,
        editBoxWidth = 350,
        OnShow = function(s, data)
            local eb = findEditBox(s)
            if not eb then return end
            local value = tostring(data or "")
            eb:SetText(value)
            eb:HighlightText()
            eb:SetFocus()
            C_Timer.After(0, function()
                if eb:GetText() ~= value then
                    eb:SetText(value)
                    eb:HighlightText()
                end
            end)
        end,
        EditBoxOnEscapePressed = function(s) s:GetParent():Hide() end,
        timeout = 0, whileDead = true, hideOnEscape = true,
    }
    StaticPopup_Show("TBCBIS_URL", nil, nil, url)
end

-- ─────────────────────────────────────────────
-- Native quest tooltips
-- ─────────────────────────────────────────────
-- The game draws a quest tooltip from a "quest:<id>" link. Newer clients may
-- need the quest loaded first: ask once, and re-open the tooltip when
-- QUEST_DATA_LOAD_RESULT says it arrived (if it's still showing that quest).
local questRequested = {}
local questLoader = CreateFrame("Frame")
pcall(questLoader.RegisterEvent, questLoader, "QUEST_DATA_LOAD_RESULT")
questLoader:SetScript("OnEvent", function(_, _, questId, success)
    local owner = GameTooltip:IsShown() and GameTooltip:GetOwner()
    if success and owner and owner.pendingQuestId == questId then
        local handler = owner:GetScript("OnEnter")
        if handler then handler(owner) end
    end
end)

-- Fills GameTooltip (already owned) with the game's quest tooltip. Returns
-- false when this client can't draw one, so the caller shows its own text.
local function SetQuestTooltip(owner, questId)
    owner.pendingQuestId = nil
    if not (questId and questId > 0) then return false end
    if C_QuestLog and C_QuestLog.RequestLoadQuestByID and not questRequested[questId] then
        questRequested[questId] = true
        owner.pendingQuestId = questId
        pcall(C_QuestLog.RequestLoadQuestByID, questId)
    end
    for _, link in ipairs({ "quest:" .. questId, "quest:" .. questId .. ":0" }) do
        GameTooltip:ClearLines()
        local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, link)
        if ok and (GameTooltip:NumLines() or 0) > 0 then return true end
    end
    return false
end

-- The pieces Pages.lua builds with (it can't see this file's locals).
UI.kit = {
    TEMPLATED = TEMPLATED, HasAtlas = HasAtlas, FromTemplate = FromTemplate, Child = Child,
    CreateInset = CreateInset, SkinMinimalScrollBar = SkinMinimalScrollBar,
    SECTION_ATLAS = SECTION_ATLAS, STRIPE_ATLAS = STRIPE_ATLAS,
    AddFill = AddFill, AddBorder = AddBorder, SetFontNormal = SetFontNormal, SetFontSmall = SetFontSmall,
    CreateTab = CreateTab, SetTabLabel = SetTabLabel, SetTabSelected = SetTabSelected,
    SOURCE_TYPE_COLORS = SOURCE_TYPE_COLORS, SOURCE_TYPE_LABELS = SOURCE_TYPE_LABELS, UI_PAL = UI_PAL,
    ShortSource = ShortSource, SuffixHint = SuffixHint, ItemQualityRGB = ItemQualityRGB,
    SetQuestTooltip = SetQuestTooltip, PlayerClass = PlayerClass, IsBrowsing = IsBrowsing,
}

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

        -- Per-slot note editor
        local noteSep = UIDropDownMenu_CreateInfo()
        noteSep.text = ""; noteSep.disabled = true; noteSep.notCheckable = true
        UIDropDownMenu_AddButton(noteSep, level)

        local noteInfo = UIDropDownMenu_CreateInfo()
        local existingNote = addon:GetNote(class, spec, phase, slot)
        noteInfo.text = (existingNote and "Edit note...") or "Add note..."
        noteInfo.notCheckable = true
        noteInfo.func = function()
            UI:ShowNoteEditor(class, spec, phase, slot)
            CloseDropDownMenus()
        end
        UIDropDownMenu_AddButton(noteInfo, level)

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
    fs:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 22, 44)
    fs:SetJustifyH("LEFT")
    self.badgeStatus = fs

    -- Hover: show breakdown of unobtained badge items
    local hoverFrame = CreateFrame("Frame", nil, f)
    hoverFrame:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 18, 40)
    hoverFrame:SetSize(380, 16)
    hoverFrame:EnableMouse(true)
    hoverFrame:SetScript("OnEnter", function(self)
        local class = TBCBisTrackerDB.lastClass
        local spec  = TBCBisTrackerDB.lastSpec
        local phase = TBCBisTrackerDB.lastPhase
        local owned, total, items = addon:GetBadgeProgress(class, spec, phase)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Badges of Justice (" .. (addon.PHASE_LABELS[phase] or phase) .. ")", 1, 1, 1)
        if #items == 0 then
            GameTooltip:AddLine("No BoJ-purchasable BiS items in this phase.", 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
            return
        end
        GameTooltip:AddLine(string.format("You have: %d badges   |cff888888Total cost of unobtained items: %d|r", owned, total), 1, 1, 1)
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

-- ─────────────────────────────────────────────
-- Stat-cap side panel
-- ─────────────────────────────────────────────

local STAT_PANEL_W = 420
local STAT_PANEL_BAR_H = 14
local STAT_PANEL_ROW_H = 38   -- label + bar + spacing
local STAT_PANEL_MAX_ROWS = 8

-- The Stat Caps tab (TBC): a column of bars in the game's inset box.
function UI:BuildStatCapPanel(page)
    local inset = CreateInset(page)
    if inset then
        inset:SetPoint("TOPLEFT")
        inset:SetPoint("BOTTOMLEFT")
        inset:SetWidth(STAT_PANEL_W + 12)
        self.statColInset = inset
    end

    local panel = CreateFrame("Frame", "TBCBisTrackerStatCapPanel", page)
    panel:SetPoint("TOPLEFT", page, "TOPLEFT", 6, -6)
    panel:SetPoint("BOTTOMLEFT", page, "BOTTOMLEFT", 6, 6)
    panel:SetWidth(STAT_PANEL_W)
    self.statPanel = panel

    -- The panel starts with its main section (the BiS icon grid that used to sit
    -- above it was removed; the 3D preview window stays on minimap right-click).
    local slotsBottom = 0

    -- ── Stat Caps (TBC) / Where to get it (Forever) ──
    -- Always sums the stats of the SELECTED BiS pick for each slot in the
    -- currently-active phase tab. No mode dropdown — switching alts directly
    -- updates the bars.
    local statTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statTitle:SetPoint("TOPLEFT", panel, "TOPLEFT", UI_PAL.pad, slotsBottom - 8)
    statTitle:SetText(UI_PAL.accent .. "Stat Caps|r  " .. UI_PAL.muted .. "Selected BiS|r")
    self.statPanelTitle = statTitle

    local sdivY = slotsBottom - 22
    local bodyY = slotsBottom - 30
    local sdiv = CreateDivider(panel, UI_PAL.dividerSoft)
    sdiv:SetPoint("TOPLEFT", panel, "TOPLEFT", UI_PAL.pad, sdivY)
    sdiv:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -UI_PAL.pad, sdivY)
    sdiv:SetHeight(1)
    self.statPanelBodyDiv = sdiv

    -- On the game's window the title sits on the character window's section bar.
    if TEMPLATED and HasAtlas(SECTION_ATLAS) then
        local bar = panel:CreateTexture(nil, "BACKGROUND")
        bar:SetAtlas(SECTION_ATLAS)
        bar:SetPoint("TOPLEFT", panel, "TOPLEFT", 2, slotsBottom - 2)
        bar:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -2, slotsBottom - 2)
        bar:SetHeight(26)
        self.statPanelTitleBar = bar
        statTitle:ClearAllPoints()
        statTitle:SetPoint("CENTER", bar, "CENTER", 0, 1)
        sdiv:Hide()
    end

    -- Body container
    local body = CreateFrame("Frame", nil, panel)
    body:SetPoint("TOPLEFT", panel, "TOPLEFT", UI_PAL.pad + 4, bodyY)
    body:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -UI_PAL.pad - 4, 32)
    self.statPanelBody = body

    -- Pool of stat rows
    self.statRowPool = {}
    local rowW = STAT_PANEL_W - 2 * (UI_PAL.pad + 4)
    for i = 1, STAT_PANEL_MAX_ROWS do
        local row = CreateFrame("Frame", nil, body)
        row:SetSize(rowW, STAT_PANEL_ROW_H)
        row:SetPoint("TOPLEFT", body, "TOPLEFT", 0, -(i-1) * STAT_PANEL_ROW_H)
        row:EnableMouse(true)

        local lbl = row:CreateFontString(nil, "OVERLAY")
        SetFontSmall(lbl)
        lbl:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
        lbl:SetJustifyH("LEFT")
        lbl:SetWidth(rowW)
        row.lbl = lbl

        local bg = row:CreateTexture(nil, "BACKGROUND")
        bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
        bg:SetVertexColor(unpack(UI_PAL.barTrack))
        bg:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -15)
        bg:SetSize(rowW, STAT_PANEL_BAR_H)
        row.bg = bg

        local fill = row:CreateTexture(nil, "ARTWORK")
        fill:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
        fill:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -15)
        fill:SetSize(0, STAT_PANEL_BAR_H)
        row.fill = fill

        local val = row:CreateFontString(nil, "OVERLAY")
        SetFontSmall(val)
        val:SetPoint("TOP", row, "TOP", 0, -16)
        val:SetJustifyH("CENTER")
        row.val = val

        row:SetScript("OnEnter", function(self)
            local data = self._data
            if not data then return end
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:SetText(data.label, 1, 1, 1)
            if data.cap and data.cap > 0 then
                if data.missing > 0 then
                    GameTooltip:AddLine(string.format("Current: %d / %d  (need %d more)", data.current, data.cap, data.missing), 1, 0.6, 0.2)
                else
                    GameTooltip:AddLine(string.format("Capped: %d / %d  (+%d over)", data.current, data.cap, data.current - data.cap), 0.2, 1, 0.2)
                end
            else
                GameTooltip:AddLine(string.format("Total: %d", data.current), 1, 1, 1)
            end
            if data.contributors and #data.contributors > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(UI_PAL.muted .. "Top contributors:|r", 1, 1, 1)
                table.sort(data.contributors, function(a, b) return a.value > b.value end)
                for i = 1, math.min(6, #data.contributors) do
                    local c = data.contributors[i]
                    local slotLabel = addon.SLOT_LABELS[c.slot] or c.slot
                    local name = addon:GetItemName(c.itemId)
                    GameTooltip:AddDoubleLine(slotLabel .. " — " .. name, "+" .. c.value, 0.8, 0.85, 0.95, 1, 1, 1)
                end
            end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)

        row:Hide()
        self.statRowPool[i] = row
    end

    -- Footer divider above note
    local fdiv = CreateDivider(panel, UI_PAL.dividerSoft)
    fdiv:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", UI_PAL.pad, 26)
    fdiv:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -UI_PAL.pad, 26)
    fdiv:SetHeight(1)
    self.statPanelFooterDiv = fdiv

    -- Footer note
    local note = panel:CreateFontString(nil, "OVERLAY")
    SetFontSmall(note)
    note:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", UI_PAL.pad + 4, 8)
    note:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -UI_PAL.pad - 4, 8)
    note:SetJustifyH("LEFT")
    note:SetTextColor(0.6, 0.6, 0.6, 1)
    self.statPanelNote = note
end

function UI:RefreshStatCaps()
    if not self.statPanel then return end
    local class = TBCBisTrackerDB.lastClass
    local spec  = TBCBisTrackerDB.lastSpec
    local phase = TBCBisTrackerDB.lastPhase
    local mode  = "selected"

    -- Hide all rows
    for _, row in ipairs(self.statRowPool) do row:Hide() end

    if not (class and spec) then
        self.statPanelNote:SetText("No spec selected.")
        return
    end

    local rows, pending = addon:GetCapStatus(class, spec, phase, mode)
    if not rows then
        self.statPanelNote:SetText("|cff888888No stat caps configured for " .. spec .. ".|r")
        return
    end

    local showCount = math.min(#rows, STAT_PANEL_MAX_ROWS)
    for i = 1, showCount do
        local data = rows[i]
        local row = self.statRowPool[i]
        row._data = data
        local pct = (data.cap > 0) and math.min(1, data.current / data.cap) or 0
        local labelText
        if data.info then
            labelText = "|cffaaaaaa" .. data.label .. "|r"
        elseif data.missing == 0 and data.cap > 0 then
            labelText = "|cff60ff60" .. data.label .. "|r |TInterface\\RAIDFRAME\\ReadyCheck-Ready:10:10|t"
        else
            labelText = data.label
        end
        row.lbl:SetText(labelText)

        if data.info then
            -- Info rows: no bar, just show value
            row.bg:Hide()
            row.fill:Hide()
            row.val:SetText("|cffffffff" .. data.current .. "|r")
            row.val:ClearAllPoints()
            row.val:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -16)
        else
            row.bg:Show()
            row.fill:Show()
            row.val:ClearAllPoints()
            row.val:SetPoint("TOP", row, "TOP", 0, -17)
            local barW = (STAT_PANEL_W - 24) * pct
            row.fill:SetWidth(math.max(0.01, barW))
            if data.missing == 0 then
                row.fill:SetVertexColor(0.20, 0.80, 0.20, 0.85)
            elseif pct > 0.6 then
                row.fill:SetVertexColor(0.85, 0.70, 0.20, 0.85)
            else
                row.fill:SetVertexColor(0.85, 0.30, 0.20, 0.85)
            end
            local pctNum = math.floor(pct * 100 + 0.5)
            local txt
            if data.missing == 0 then
                txt = string.format("|cff60ff60%d / %d  (%d%%)|r", data.current, data.cap, pctNum)
            else
                txt = string.format("%d / %d  |cff888888%d%%|r  |cffff8800(-%d)|r", data.current, data.cap, pctNum, data.missing)
            end
            row.val:SetText(txt)
        end
        row:Show()
    end

    if pending and pending > 0 then
        self.statPanelNote:SetText("|cffaaaaaa" .. pending .. " items loading…|r")
    elseif #rows > STAT_PANEL_MAX_ROWS then
        self.statPanelNote:SetText("|cff888888…and " .. (#rows - STAT_PANEL_MAX_ROWS) .. " more|r")
    else
        -- Multi-line note that fits the panel width
        self.statPanelNote:SetText("|cff666666Item base stats only.|r\n|cff666666Gems & enchants not included.|r")
    end
end

function UI:BuildTierStatus()
    local f = self.frame
    local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fs:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 22, 60)
    fs:SetJustifyH("LEFT")
    self.tierStatus = fs

    -- Hover area covering the tier-set text — explains 2pc/4pc bonuses
    local hover = CreateFrame("Frame", nil, f)
    hover:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 18, 58)
    hover:SetSize(380, 16)
    hover:EnableMouse(true)
    hover:SetScript("OnEnter", function(self)
        local class = TBCBisTrackerDB.lastClass
        local spec  = TBCBisTrackerDB.lastSpec
        local phase = TBCBisTrackerDB.lastPhase
        local progress = addon:GetTierProgress(class, spec, phase)
        if not progress or not next(progress) then
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText("Tier set tracker", 1, 1, 1)
            GameTooltip:AddLine("No tier-set BiS items in this phase for your spec.", 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
            return
        end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Tier set progress (" .. (addon.PHASE_LABELS[phase] or phase) .. ")", 1, 1, 1)
        GameTooltip:AddLine("Counts BiS-listed tier pieces you've obtained. 2/4 piece bonuses noted.", 0.8, 0.8, 0.8, true)
        GameTooltip:AddLine(" ")
        local order = { "T4", "T5", "T6", "T6.5" }
        for _, t in ipairs(order) do
            local p = progress[t]
            if p and p.total > 0 then
                local bonusText = ""
                if p.obtained >= 4 then bonusText = " — 4-piece bonus active!"
                elseif p.obtained >= 2 then bonusText = " — 2-piece bonus active"
                end
                GameTooltip:AddDoubleLine(t, p.obtained .. " / " .. p.total .. bonusText, 0.9, 0.9, 0.9, 1, 1, 1)
            end
        end
        GameTooltip:Show()
    end)
    hover:SetScript("OnLeave", function() GameTooltip:Hide() end)
    self.tierHover = hover
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
    -- Compact badge readout. The verbose breakdown lives in the hover tooltip.
    -- Format: "[icon] 0 / 66 BoJ  ·  2 items"
    local coin = "|TInterface\\Icons\\Spell_Holy_ChampionsBond:14:14|t"
    if total == 0 then
        self.badgeStatus:SetText(coin .. " " .. UI_PAL.muted .. owned .. " BoJ|r")
    elseif owned >= total then
        self.badgeStatus:SetText(string.format(
            "%s %s%d / %d BoJ|r  %s|cff60ff60enough!|r  %s%d items|r",
            coin, UI_PAL.accent, owned, total, UI_PAL.muted .. "·|r ", UI_PAL.muted, #items
        ))
    else
        local diff = total - owned
        self.badgeStatus:SetText(string.format(
            "%s %s%d / %d BoJ|r  %s|cffff8800need %d more|r  %s%d items|r",
            coin, UI_PAL.mutedSoft, owned, total, UI_PAL.muted .. "·|r ", diff, UI_PAL.muted .. "· ", #items
        ))
    end
end

function UI:BuildProgressBar()
    local f = self.frame

    -- Divider above the footer (the list's inset box does that on the game's window)
    local fdiv = CreateDivider(f, UI_PAL.dividerSoft)
    fdiv:SetShown(not self.listInset)
    fdiv:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 20, 38)
    fdiv:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -20 - STAT_AREA_W, 38)
    fdiv:SetHeight(1)

    local container = CreateFrame("Frame", nil, f)
    container:SetSize(LIST_W - 24, PROGRESS_H)
    container:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 12, 12)
    container:EnableMouse(true)
    self.progressContainer = container

    -- Text on the right, slim bar filling the rest
    local txt = container:CreateFontString(nil, "OVERLAY")
    SetFontNormal(txt)
    txt:SetPoint("RIGHT", container, "RIGHT", 0, 0)
    txt:SetJustifyH("RIGHT")
    self.progressTxt = txt

    -- What the marks at the end of the gear rows mean
    local legend = container:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    legend:SetPoint("LEFT", container, "LEFT", 340, 0)
    legend:SetText("|TInterface\\RAIDFRAME\\ReadyCheck-Ready:12:12|t obtained    "
        .. (HasAtlas("bags-greenarrow") and "|A:bags-greenarrow:12:12|a" or "|TInterface\\Buttons\\Arrow-Up-Up:12:12|t")
        .. " upgrade over what you wear    "
        .. "|TInterface\\GossipFrame\\AvailableQuestIcon:12:12|t quest reward")
    self.progressLegend = legend

    local trackW = 320
    -- The game's status bar texture (as on the stat bars), tinted.
    local track = container:CreateTexture(nil, "BACKGROUND")
    track:SetSize(trackW, 10)
    track:SetPoint("LEFT", container, "LEFT", 0, 0)
    track:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
    track:SetVertexColor(unpack(UI_PAL.barTrack))
    self.progressTrackW = trackW

    local fill = container:CreateTexture(nil, "ARTWORK")
    fill:SetPoint("LEFT", track, "LEFT", 0, 0)
    fill:SetHeight(10)
    fill:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
    fill:SetVertexColor(0.25, 0.62, 0.18, 1)
    self.progressFill = fill

    container:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("BiS progress", 1, 1, 1)
        GameTooltip:AddLine("How many BiS slots you've ticked off. Items you equip or carry are ticked automatically.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    container:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-- ─────────────────────────────────────────────
-- Populate gear rows (called on every Refresh)
-- ─────────────────────────────────────────────

function UI:Refresh()
    if not self.frame then return end
    local class = TBCBisTrackerDB.lastClass

    self:ApplyLayout()
    if IsBrowsing() then
        local info = addon.CLASS_INFO[class]
        local home = addon.CLASS_INFO[PlayerClass()]
        self.browseBanner.txt:SetText(
            "Browsing |cff" .. info.color .. info.name .. "|r: planning only. Ticks stay on your |cff"
            .. home.color .. home.name .. "|r.")
        self.browseBanner.back:SetText("Back to " .. home.name)
    end

    local obtained, total, upgrades = self:RefreshGear()
    self:RefreshDetail()
    if self.page == "where" then self:RefreshWhere() end

    self:UpdateProgress(obtained, total, upgrades)
    self:RefreshPhaseTabs()
    self:RefreshBadgeStatus()
    self:RefreshTierStatus()
    self:RefreshStatCaps()
end

function UI:UpdateProgress(obtained, total, upgrades)
    if total == 0 then
        self.progressFill:SetWidth(1)
        self.progressTxt:SetText("|cffaaaaaaNo data for this selection.|r")
        return
    end

    local pct = obtained / total
    self.progressFill:SetWidth(math.max(1, self.progressTrackW * pct))
    if obtained == total then
        self.progressFill:SetVertexColor(0.9, 0.75, 0.1, 1)  -- gold when complete
        self.progressTxt:SetText("|cffffd700All " .. total .. " obtained!|r")
    else
        self.progressFill:SetVertexColor(0.25, 0.62, 0.18, 1)
        self.progressTxt:SetText("|cff6fdc55" .. obtained .. " / " .. total .. "|r obtained  "
            .. UI_PAL.muted .. math.floor(pct * 100) .. "%|r"
            .. ((upgrades or 0) > 0 and ("  |cff40ff40" .. upgrades .. " upgrades|r") or ""))
    end
end

-- ─────────────────────────────────────────────
-- BiS Preview window — character-pane-style mockup with 3D model,
-- slot icons, and stats summary. Triggered by right-click on the
-- minimap button or "/tbcbis preview".
-- ─────────────────────────────────────────────

local PREV_SLOT     = 40
local PREV_GAP      = 6
local PREV_PAD      = 10
-- Match the WoW character pane distribution: left column of 7 + right column
-- of 7 + 3 weapons across the bottom. The empty middle is for the optional
-- 3D model.
local PREV_LEFT_SLOTS   = { "head", "neck", "shoulder", "chest", "waist", "legs", "feet" }
local PREV_RIGHT_SLOTS  = { "wrist", "hands", "ring1", "ring2", "trinket1", "trinket2", "back" }
local PREV_BOTTOM_SLOTS = { "mainhand", "offhand", "ranged" }
local PREV_COL_ROWS     = math.max(#PREV_LEFT_SLOTS, #PREV_RIGHT_SLOTS)

-- Width math: column width = pad + slot + pad on each side, with a configurable
-- middle area between them. Compact = 110 px gap, model = 220 px gap.
local PREV_COL_W      = PREV_PAD + PREV_SLOT + PREV_PAD
local PREV_MID_COMPACT = 110
local PREV_MID_WITH_MODEL = 220
local PREV_W_COMPACT      = 2 * PREV_COL_W + PREV_MID_COMPACT
local PREV_W_WITH_MODEL   = 2 * PREV_COL_W + PREV_MID_WITH_MODEL

local PREV_HEADER_H = 48
local PREV_FOOTER_H = 90  -- bottom-row weapons + spacing + stats divider + text
local PREV_H = PREV_HEADER_H + PREV_COL_ROWS * (PREV_SLOT + PREV_GAP) - PREV_GAP + PREV_FOOTER_H

function UI:BuildBisPreview()
    if self.previewFrame then return self.previewFrame end

    local startW = (TBCBisTrackerDB.previewShowModel and PREV_W_WITH_MODEL) or PREV_W_COMPACT
    local f = CreateWindow("TBCBisTrackerPreview", startW, PREV_H, false)
    f:SetPoint("CENTER", UIParent, "CENTER", 200, 0)
    self.previewFrame = f

    if f.heading then
        f.heading:SetText("BiS Preview")
        self.previewTitle = f.heading
    else
        local title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        title:SetPoint("TOP", f, "TOP", 0, -6)
        title:SetText(UI_PAL.accent .. "BiS Preview|r")
        self.previewTitle = title
    end

    local subtitle = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    subtitle:SetPoint("TOP", f, "TOP", 0, -28)
    self.previewSubtitle = subtitle

    -- "3D model" toggle button — small text button just under the close X.
    local toggle = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    toggle:SetSize(76, 18)
    -- Under the title bar on the game's window (its close button sits in the bar).
    if f.templated then
        toggle:SetPoint("TOPRIGHT", f, "TOPRIGHT", -8, -26)
    else
        toggle:SetPoint("TOPRIGHT", f, "TOPRIGHT", -28, -8)
    end
    toggle:SetText(TBCBisTrackerDB.previewShowModel and "Hide model" or "Show model")
    toggle:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("3D model preview", 1, 1, 1)
        GameTooltip:AddLine("Toggle the player model on the right of the slot grid.", 0.8, 0.8, 0.8, true)
        GameTooltip:Show()
    end)
    toggle:HookScript("OnLeave", function() GameTooltip:Hide() end)
    self.previewModelToggle = toggle

    -- 3D model panel — fills the middle area between the two columns,
    -- below the header and above the footer (bottom row + stats).
    local model = CreateFrame("PlayerModel", nil, f)
    model:SetPoint("TOPLEFT", f, "TOPLEFT", PREV_COL_W, -PREV_HEADER_H)
    model:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -PREV_COL_W, PREV_FOOTER_H)
    if model.SetUnit then model:SetUnit("player") end
    if model.SetFacing then model:SetFacing(0.4) end
    model:SetShown(TBCBisTrackerDB.previewShowModel == true)
    self.previewModel = model
    -- Drag-to-rotate
    model:EnableMouse(true)
    model:SetScript("OnMouseDown", function(self) self._rot_start = GetCursorPosition() end)
    model:SetScript("OnMouseUp",   function(self) self._rot_start = nil end)
    model:SetScript("OnUpdate", function(self)
        if self._rot_start then
            local x = GetCursorPosition()
            self:SetFacing((self:GetFacing() or 0) + (x - self._rot_start) * 0.005)
            self._rot_start = x
        end
    end)

    toggle:SetScript("OnClick", function(btn)
        local newVal = not TBCBisTrackerDB.previewShowModel
        TBCBisTrackerDB.previewShowModel = newVal
        btn:SetText(newVal and "Hide model" or "Show model")
        f:SetWidth(newVal and PREV_W_WITH_MODEL or PREV_W_COMPACT)
        if newVal then
            model:Show()
            UI:RefreshBisPreview()
        else
            model:Hide()
        end
    end)

    -- Slot button factory
    local function makeSlotBtn(parent, x, y, slot)
        local btn = CreateFrame("Button", nil, parent)
        btn:SetSize(PREV_SLOT, PREV_SLOT)
        btn:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
        btn._slot = slot

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled")
        btn.bg = bg

        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4)
        icon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4)
        icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)  -- crop default icon border
        icon:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
        btn.icon = icon

        local border = btn:CreateTexture(nil, "OVERLAY")
        border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
        border:SetSize(PREV_SLOT + 24, PREV_SLOT + 24)
        border:SetPoint("CENTER")
        btn.border = border

        local mark = btn:CreateTexture(nil, "OVERLAY")
        mark:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
        mark:SetSize(16, 16)
        mark:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 2, -2)
        mark:Hide()
        btn.mark = mark

        btn:SetScript("OnEnter", function(self)
            if self._itemId and self._itemId > 0 then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink("item:" .. self._itemId .. ":0:0:0:0:0:0:0")
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(UI_PAL.muted .. (addon.SLOT_LABELS[self._slot] or self._slot) .. "|r", 1, 1, 1)
                if self._obtained then
                    GameTooltip:AddLine("|cff60ff60Obtained|r", 1, 1, 1)
                else
                    GameTooltip:AddLine("|cff888888Not obtained|r", 1, 1, 1)
                end
                GameTooltip:Show()
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(addon.SLOT_LABELS[self._slot] or self._slot, 1, 1, 1)
                GameTooltip:AddLine("|cff888888No BiS pick set|r", 1, 1, 1)
                GameTooltip:Show()
            end
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        return btn
    end

    self.previewSlotBtns = {}

    -- Left column — anchored to TOPLEFT.
    local colTopY = -PREV_HEADER_H
    for i, slot in ipairs(PREV_LEFT_SLOTS) do
        local x = PREV_PAD
        local y = colTopY - (i - 1) * (PREV_SLOT + PREV_GAP)
        self.previewSlotBtns[slot] = makeSlotBtn(f, x, y, slot)
    end

    -- Right column — anchored to TOPRIGHT (positions are relative to TOPLEFT
    -- but use the right edge of the *compact* width; right column moves with
    -- the frame's right edge through SetPoint when shown with the model).
    for i, slot in ipairs(PREV_RIGHT_SLOTS) do
        local btn = CreateFrame("Button", nil, f)
        btn:SetSize(PREV_SLOT, PREV_SLOT)
        btn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PREV_PAD, colTopY - (i - 1) * (PREV_SLOT + PREV_GAP))
        btn._slot = slot
        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints(); bg:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled")
        btn.bg = bg
        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4)
        icon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4)
        icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        icon:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
        btn.icon = icon
        local border = btn:CreateTexture(nil, "OVERLAY")
        border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
        border:SetSize(PREV_SLOT + 24, PREV_SLOT + 24)
        border:SetPoint("CENTER")
        btn.border = border
        local mark = btn:CreateTexture(nil, "OVERLAY")
        mark:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
        mark:SetSize(16, 16); mark:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 2, -2); mark:Hide()
        btn.mark = mark
        btn:SetScript("OnEnter", function(self)
            if self._itemId and self._itemId > 0 then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT")
                GameTooltip:SetHyperlink("item:" .. self._itemId .. ":0:0:0:0:0:0:0")
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(UI_PAL.muted .. (addon.SLOT_LABELS[self._slot] or self._slot) .. "|r", 1, 1, 1)
                GameTooltip:AddLine(self._obtained and "|cff60ff60Obtained|r" or "|cff888888Not obtained|r", 1, 1, 1)
                GameTooltip:Show()
            else
                GameTooltip:SetOwner(self, "ANCHOR_LEFT")
                GameTooltip:SetText(addon.SLOT_LABELS[self._slot] or self._slot, 1, 1, 1)
                GameTooltip:AddLine("|cff888888No BiS pick set|r", 1, 1, 1)
                GameTooltip:Show()
            end
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.previewSlotBtns[slot] = btn
    end

    -- Bottom row (3 weapons), centered horizontally.
    local bottomTotal = #PREV_BOTTOM_SLOTS * PREV_SLOT + (#PREV_BOTTOM_SLOTS - 1) * 8
    local bottomY = -(PREV_HEADER_H + PREV_COL_ROWS * (PREV_SLOT + PREV_GAP) - PREV_GAP + 4)
    for i, slot in ipairs(PREV_BOTTOM_SLOTS) do
        local btn = CreateFrame("Button", nil, f)
        btn:SetSize(PREV_SLOT, PREV_SLOT)
        -- Anchor relative to TOP center so it stays centered when the frame width changes
        local xOff = (i - 1) * (PREV_SLOT + 8) - bottomTotal / 2 + PREV_SLOT / 2
        btn:SetPoint("TOP", f, "TOP", xOff, bottomY)
        btn._slot = slot
        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints(); bg:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled")
        btn.bg = bg
        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4)
        icon:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4)
        icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        icon:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
        btn.icon = icon
        local border = btn:CreateTexture(nil, "OVERLAY")
        border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
        border:SetSize(PREV_SLOT + 24, PREV_SLOT + 24); border:SetPoint("CENTER")
        btn.border = border
        local mark = btn:CreateTexture(nil, "OVERLAY")
        mark:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
        mark:SetSize(16, 16); mark:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 2, -2); mark:Hide()
        btn.mark = mark
        btn:SetScript("OnEnter", function(self)
            if self._itemId and self._itemId > 0 then
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetHyperlink("item:" .. self._itemId .. ":0:0:0:0:0:0:0")
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(UI_PAL.muted .. (addon.SLOT_LABELS[self._slot] or self._slot) .. "|r", 1, 1, 1)
                GameTooltip:AddLine(self._obtained and "|cff60ff60Obtained|r" or "|cff888888Not obtained|r", 1, 1, 1)
                GameTooltip:Show()
            else
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(addon.SLOT_LABELS[self._slot] or self._slot, 1, 1, 1)
                GameTooltip:AddLine("|cff888888No BiS pick set|r", 1, 1, 1)
                GameTooltip:Show()
            end
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        self.previewSlotBtns[slot] = btn
    end

    -- Stats summary at the bottom — anchored to bottom edges so it follows
    -- frame width changes when the model toggle resizes the frame.
    local statsLbl = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statsLbl:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PREV_PAD, 10)
    statsLbl:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -PREV_PAD, 10)
    statsLbl:SetJustifyH("CENTER")
    self.previewStatsLbl = statsLbl

    local statsDiv = CreateDivider(f, UI_PAL.dividerSoft)
    statsDiv:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PREV_PAD, 28)
    statsDiv:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -PREV_PAD, 28)
    statsDiv:SetHeight(1)

    return f
end

function UI:RefreshBisPreview(class, spec, phase)
    class = class or TBCBisTrackerDB.lastClass
    spec  = spec  or TBCBisTrackerDB.lastSpec
    phase = phase or TBCBisTrackerDB.lastPhase
    if not (self.previewFrame and class and spec and phase) then return end

    -- Title context
    local info = addon.CLASS_INFO[class]
    local subtitle = ""
    if info then
        subtitle = "|cff" .. info.color .. info.name .. " " .. spec .. "|r  " ..
                   UI_PAL.muted .. (addon.PHASE_LABELS[phase] or phase) .. "|r"
    end
    self.previewSubtitle:SetText(subtitle)

    -- Reset the 3D model if visible — undress the player and we'll re-try-on each pick.
    local showModel = self.previewModel and self.previewModel:IsShown()
    if showModel then
        if self.previewModel.SetUnit then self.previewModel:SetUnit("player") end
        if self.previewModel.Undress then self.previewModel:Undress() end
    end

    -- Update each slot button — show item icon if BiS pick exists, faded slot icon otherwise.
    for slot, btn in pairs(self.previewSlotBtns) do
        local entry = addon:GetSlotItem(class, spec, phase, slot)
        if entry and entry.id and entry.id > 0 then
            local _, link = GetItemInfo(entry.id)
            local texture = select(10, GetItemInfo(entry.id))
            btn._itemId = entry.id
            btn._obtained = addon:IsObtained(class, spec, phase, slot)
            btn.icon:SetTexture(texture or addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
            btn.icon:SetAlpha(1)
            btn.mark:SetShown(btn._obtained == true)
            if showModel and link and self.previewModel.TryOn then
                self.previewModel:TryOn(link)
            end
        else
            btn._itemId = nil
            btn._obtained = false
            btn.icon:SetTexture(addon.SLOT_ICONS[slot] or "Interface\\Icons\\INV_Misc_QuestionMark")
            btn.icon:SetAlpha(0.35)
            btn.mark:Hide()
        end
    end

    -- Stats summary line
    local rows = addon:GetCapStatus(class, spec, phase, "selected")
    if rows then
        local parts = {}
        for _, r in ipairs(rows) do
            if r.cap and r.cap > 0 then
                local color = (r.missing == 0) and "|cff60ff60" or "|cffaaaaaa"
                parts[#parts + 1] = color .. r.label .. ": " .. r.current .. " / " .. r.cap .. "|r"
            else
                parts[#parts + 1] = UI_PAL.mutedSoft .. r.label .. ": " .. r.current .. "|r"
            end
        end
        self.previewStatsLbl:SetText(table.concat(parts, "  ·  "))
    else
        self.previewStatsLbl:SetText("")
    end
end

function UI:ShowBisPreview(class, spec, phase)
    self:BuildBisPreview()
    self:RefreshBisPreview(class, spec, phase)
    self.previewFrame:Show()
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
        self:RefreshPortrait()
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
