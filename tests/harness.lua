-- Mock-WoW smoke test: loads the add-on as each client and checks the mode switch.
-- Run from the repo root:  lua tests/harness.lua

local ADDON_DIR = "TBCBisTracker/"
local failures = 0
local function check(cond, msg)
    if cond then print("  ok   " .. msg) else failures = failures + 1; print("  FAIL " .. msg) end
end

-- ─── Mock WoW API ───
-- Anything not mocked explicitly is a callable no-op stub.
local stub
stub = setmetatable({}, {
    __index = function() return stub end,
    __call  = function() return nil end,
})

local function freshGlobals(toc)
    local env = {}
    for k, v in pairs(_G) do env[k] = v end
    env._G = env
    env.GetBuildInfo = function() return toc >= 20000 and "2.5.5" or "1.60.0", "99999", "Oct 1 2026", toc end
    env.UnitClass = function() return "Warrior", "WARRIOR" end
    env.GetInventoryItemID = function() return nil end
    env.GetItemInfo = function() return nil end
    env.GetItemStats = function() return nil end
    env.events = {}
    env.CreateFrame = function()
        local f = setmetatable({}, { __index = function() return function() return stub end end })
        f.SetScript = function(self, name, fn) if name == "OnEvent" then env.events[#env.events + 1] = fn end end
        return f
    end
    env.printed = {}
    env.DEFAULT_CHAT_FRAME = { AddMessage = function(_, m) env.printed[#env.printed + 1] = m end }
    env.SlashCmdList = {}
    return setmetatable(env, { __index = function() return stub end })
end

-- A tooltip whose client may or may not still have the OnTooltipSetItem script.
local function mockTooltip(hasSetItem)
    local t = { hooks = {} }
    function t:HasScript(name) return name ~= "OnTooltipSetItem" or hasSetItem end
    function t:HookScript(name, fn)
        if not self:HasScript(name) then error("bad argument #2 to '?' (Usage: local success = self:HookScript(...))") end
        self.hooks[name] = fn
    end
    function t:AddLine(line) self.lines = self.lines or {}; self.lines[#self.lines + 1] = line end
    function t:Show() end
    return t
end

local function loadAddon(toc, savedDB, modernTooltips)
    local env = freshGlobals(toc)
    env.GameTooltip = mockTooltip(not modernTooltips)
    env.ItemRefTooltip = mockTooltip(not modernTooltips)
    env.postCalls = {}
    env.TooltipDataProcessor = false  -- old clients don't have it (the stub would look present)
    if modernTooltips then
        env.Enum = { TooltipDataType = { Item = 0 } }
        env.TooltipDataProcessor = {
            AddTooltipPostCall = function(kind, fn) env.postCalls[#env.postCalls + 1] = { kind = kind, fn = fn } end,
        }
    end
    env.TBCBisTrackerDB = savedDB
    env.TBCBisTracker = {}  -- otherwise "TBCBisTracker or {}" picks up the shared stub
    for _, file in ipairs({ "Localization.lua", "Core.lua", "Database.lua", "Database_Forever.lua", "Forever.lua" }) do
        local chunk = assert(loadfile(ADDON_DIR .. file))
        setfenv(chunk, env)
        local ok, err = pcall(chunk)
        if not ok then env.loadError = file .. ": " .. tostring(err); return env end
    end
    for _, fn in ipairs(env.events) do fn(nil, "ADDON_LOADED", "TBCBisTracker") end
    return env
end

-- ─── Tests ───
print("TBC Anniversary client (20505)")
local tbc = loadAddon(20505, { lastPhase = "phase2" })
local a = tbc.TBCBisTracker
check(a.GAME_MODE == "tbc", "stays in TBC mode")
check(a.DB["WARRIOR"]["Fury"].prebis ~= nil, "uses TBC database")
check(#a.PHASES == 7, "7 TBC phases")
check(tbc.TBCBisTrackerDB.lastPhase == "phase2", "keeps saved TBC phase")

print("Forever client (16001)")
local fv = loadAddon(16001, { lastPhase = "phase2" })
a = fv.TBCBisTracker
check(a.GAME_MODE == "forever", "switches to Forever mode")
check(a.DB == a.FOREVER_DB, "uses Forever database")
check(#a.PHASES == 1 and a.PHASES[1] == "lvl60" and a.PHASE_LABELS.lvl60 == "Pre-BIS", "single Pre-BIS stage (key lvl60)")
check(fv.TBCBisTrackerDB.lastPhase == "lvl60", "saved TBC phase moved to lvl60")
check(next(a.STAT_CAPS) == nil, "TBC stat caps disabled")
check(a.WOWHEAD_BASE:find("/forever/"), "Wowhead Forever links")
check(a:GetCapStatus("WARRIOR", "Fury", "lvl60", "selected") == nil, "no cap rows")
check(fv.printed[#fv.printed]:find("Forever"), "load message mentions Forever")

print("Tooltip hooks")
check(rawget(tbc, "loadError") == nil and tbc.GameTooltip.hooks.OnTooltipSetItem ~= nil, "old client: OnTooltipSetItem hooked")
local modern = loadAddon(16001, {}, true)
local modernErr = rawget(modern, "loadError")
check(modernErr == nil, "new client: loads without HookScript error" .. (modernErr and (" (" .. modernErr .. ")") or ""))
check(#modern.postCalls == 1 and modern.GameTooltip.hooks.OnTooltipSetItem == nil, "new client: uses TooltipDataProcessor")
modern.TBCBisTrackerCharDB = { obtained = {}, selected = {}, notes = {}, customAlts = {} }
local ok, err = pcall(modern.postCalls[1] and modern.postCalls[1].fn or error, modern.GameTooltip, { id = 12640 })
check(ok, "item tooltip post-call runs" .. (ok and "" or (" (" .. tostring(err) .. ")")))
local lines = table.concat(modern.GameTooltip.lines or {}, " | ")
check(lines:find("Pre%-BIS"), "tracked item gets a Pre-BIS line: " .. lines)

print("Forever: where to go groups by dungeon, professions")
do
    fv.TBCBisTrackerCharDB = { obtained = {}, selected = {}, notes = {}, customAlts = {} }
    local places, perBoss = {}, false
    for _, g in ipairs(a:GetFarmBreakdown("WARRIOR", "Fury", "lvl60")) do
        if g.type == "dungeon" then
            for _, loc in ipairs(g.locations) do
                places[#places + 1] = loc.location
                if loc.location:find(",") then perBoss = true end
            end
        end
    end
    check(#places > 0 and not perBoss, "dungeon drops listed per dungeon: " .. table.concat(places, " / "))
    -- Neither profession list answers: unknown, not "not learned"
    local rank, _, known = a:GetPlayerProfessionLevel("Blacksmithing")
    check(rank == nil and known == false, "no profession list from the client: can't tell")
    -- Classic skills list
    fv.GetNumSkillLines = function() return 2 end
    fv.GetSkillLineInfo = function(i)
        if i == 1 then return "Professions", true end
        return "Blacksmithing", false, nil, 120, nil, nil, 150
    end
    rank, _, known = a:GetPlayerProfessionLevel("Blacksmithing")
    check(rank == 120 and known == true, "skills list: Blacksmithing 120")
    rank, _, known = a:GetPlayerProfessionLevel("Tailoring")
    check(rank == nil and known == true, "skills list: Tailoring not learned")
    -- Newer clients: empty skills list, GetProfessions answers
    fv.GetNumSkillLines = function() return 0 end
    fv.GetProfessions = function() return 7, nil, 9 end
    fv.GetProfessionInfo = function(index)
        if index == 7 then return "Tailoring", "icon", 95, 150 end
        return "Fishing", "icon", 10, 75
    end
    rank, _, known = a:GetPlayerProfessionLevel("Tailoring")
    check(rank == 95 and known == true, "GetProfessions fallback: Tailoring 95")
end

print("Forever client forced to TBC")
local forced = loadAddon(16001, { gameMode = "tbc" })
check(forced.TBCBisTracker.GAME_MODE == "tbc", "/tbcbis mode tbc override")

print("Forever database shape")
local SLOT_OK = {}
for _, s in ipairs(a.SLOTS) do SLOT_OK[s] = true end
local entries, specs = 0, 0
for cls, info in pairs(a.CLASS_INFO) do
    for _, spec in ipairs(info.specs) do
        local d = a.FOREVER_DB[cls] and a.FOREVER_DB[cls][spec]
        if d then
            specs = specs + 1
            for slot, list in pairs(d.lvl60 or {}) do
                if not SLOT_OK[slot] then check(false, cls .. "/" .. spec .. " unknown slot " .. slot) end
                for _, e in ipairs(list) do
                    entries = entries + 1
                    if type(e.id) ~= "number" or e.id <= 0 then check(false, "bad id in " .. cls .. "/" .. spec .. "/" .. slot) end
                end
            end
        end
    end
    for spec in pairs(a.FOREVER_DB[cls] or {}) do
        local known = false
        for _, s in ipairs(info.specs) do known = known or s == spec end
        if not known then check(false, cls .. " has unknown spec '" .. spec .. "'") end
    end
end
check(specs == 28, specs .. " specs with Forever data, " .. entries .. " items")

print("Faction filter")
local function countFaction(fac)
    fv.UnitFactionGroup = function() return fac end
    local n, wrong = 0, 0
    for cls, specsT in pairs(a.FOREVER_DB) do
        for spec in pairs(specsT) do
            for _, slot in ipairs(a.SLOTS) do
                for _, e in ipairs(a:GetSlotAlternatives(cls, spec, "lvl60", slot) or {}) do
                    n = n + 1
                    if e.faction and e.faction ~= fac then wrong = wrong + 1 end
                end
            end
        end
    end
    return n, wrong
end
local nA, wA = countFaction("Alliance")
local nH, wH = countFaction("Horde")
check(wA == 0 and wH == 0, "no other-faction items shown (" .. nA .. " Alliance / " .. nH .. " Horde rows)")
check(nA < entries and nH < entries, "faction-only items filtered out")

local function windowTest(toc, templated)
    local forever = toc < 20000
    print((forever and "Window (Forever, class browsing)" or "Window (TBC)") .. (templated and ", Blizzard templates" or ""))
    -- Widget mock: tracks shown state, text, scripts; anything else is a no-op.
    local function widget()
        local w = { shown = true, scripts = {}, text = "", checked = false, h = 300, value = 0, lo = 0, hi = 0 }
        local m = {}
        function m:Show() self.shown = true end
        function m:Hide() self.shown = false end
        function m:SetShown(v) self.shown = v and true or false end
        function m:IsShown() return self.shown end
        function m:SetText(t) self.text = t or "" end
        function m:GetText() return self.text end
        function m:SetScript(k, fn) self.scripts[k] = fn end
        function m:HookScript(k, fn) self.scripts[k] = fn end
        function m:GetScript(k) return self.scripts[k] end
        function m:SetChecked(v) self.checked = v and true or false end
        function m:GetChecked() return self.checked end
        function m:GetHeight() return self.h end
        function m:GetWidth() return 100 end
        function m:SetSize(w) self.width = w end
        function m:GetStringWidth() return 50 end
        function m:GetFrameLevel() return 1 end
        function m:GetMinMaxValues() return self.lo, self.hi end
        function m:SetMinMaxValues(lo, hi) self.lo, self.hi = lo, hi end
        function m:GetValue() return self.value end
        function m:SetValue(v) self.value = v end
        function m:CreateTexture() return widget() end
        function m:CreateFontString() return widget() end
        function m:GetPoint() return "CENTER", nil, "CENTER", 0, 0 end
        return setmetatable(w, { __index = function(_, k) return m[k] or function() end end })
    end

    local env = freshGlobals(toc)
    env.TBCBisTracker = {}
    env.TBCBisTrackerDB = {}
    env.TBCBisTrackerCharDB = {}
    env.GetNumSkillLines = function() return 0 end
    -- The client names random-suffix items by their base item.
    env.GetItemInfo = function(id) if id == 7436 then return "Twilight Cape", nil, 2 end end
    env.GetNumFactions = function() return 0 end
    env.UnitClass = function() return "Paladin", "PALADIN" end
    env.UnitFactionGroup = function() return "Alliance" end
    env.templatesUsed = {}
    env.UISpecialFrames = {}
    if templated then
        -- A client with the game's templates and atlases (Forever / newer clients)
        env.C_XMLUtil = { GetTemplateInfo = function() return {} end }
        env.C_Texture = { GetAtlasInfo = function() return {} end }
    else
        env.C_XMLUtil = false
        env.C_Texture = false
    end
    env.CreateFrame = function(_, name, _, template)
        local f = widget()
        f.SetScript = function(self, k, fn) if k == "OnEvent" then env.events[#env.events + 1] = fn end self.scripts[k] = fn end
        if template then env.templatesUsed[template] = (env.templatesUsed[template] or 0) + 1 end
        if template == "ButtonFrameTemplate" then
            f.TitleContainer = { TitleText = widget() }
            f.PortraitContainer = { portrait = widget() }
            f.Inset = widget()
        end
        if name then env[name] = f end
        return f
    end
    env.GameTooltip = widget()
    env.UIParent = widget()
    env.UIDropDownMenu_SetText = function(dd, text) dd.ddText = text end
    env.tabSelected = {}
    env.PanelTemplates_TabResize = function() end
    env.PanelTemplates_SelectTab = function(tab) env.tabSelected[tab] = true end
    env.PanelTemplates_DeselectTab = function(tab) env.tabSelected[tab] = false end
    env.C_Timer = { After = function(_, fn) fn() end }
    for _, file in ipairs({ "Localization.lua", "Core.lua", "Database.lua", "Database_Forever.lua", "Forever.lua", "UI.lua", "Pages.lua" }) do
        local chunk = assert(loadfile(ADDON_DIR .. file))
        setfenv(chunk, env)
        chunk()
    end
    for _, fn in ipairs(env.events) do fn(nil, "ADDON_LOADED", "TBCBisTracker") end
    local addon, UI = env.TBCBisTracker, env.TBCBisTracker.UI
    local ok, err = pcall(function()
        UI:Build()
        UI:Refresh()
    end)
    check(ok, "window builds and fills" .. (ok and "" or (" (" .. tostring(err) .. ")")))
    if not ok then return end

    local db = env.TBCBisTrackerDB
    check(db.lastClass == "PALADIN" and db.lastSpec == "Holy", "opens on your own class")
    if templated and forever then
        -- /tbcbis probe tabs: a talent window with a Primary tab, read texture by texture
        local function region(kind, props)
            local r = props or {}
            function r:GetObjectType() return kind end
            function r:GetName() return nil end
            function r:GetSize() return 120, 28 end
            function r:GetDrawLayer() return "BACKGROUND" end
            function r:IsShown() return true end
            function r:GetText() return r.text end
            function r:GetAtlas() return r.atlas end
            function r:GetTexture() return r.file end
            function r:GetVertexColor() return 1, 1, 1, 1 end
            function r:GetTexCoord() return 0, 1, 0, 1 end
            return r
        end
        local function frame(regions, children)
            local f = region("Button")
            function f:GetRegions() return unpack(regions or {}) end
            function f:GetChildren() return unpack(children or {}) end
            return f
        end
        local tab = frame({ region("Texture", { atlas = "talents-tab-active" }), region("FontString", { text = "Primary" }) })
        env.PlayerSpellsFrame = frame({}, { frame({}, { tab }) })
        env.C_AddOns = { LoadAddOn = function() end }
        env.time = os.time
        local lines, found = UI:ProbeTalentTabs()
        local all = table.concat(lines, "\n")
        check(found == 1 and all:find("atlas=talents-tab-active", 1, true) and all:find("text=Primary", 1, true),
            "probe tabs reads the talent window's tab art")
        check(env.TBCBisTrackerDB.probe and #env.TBCBisTrackerDB.probe.lines == #lines, "probe saved for the author")
    end
    local used = env.templatesUsed
    if templated then
        check(UI.frame.templated and used.ButtonFrameTemplate == 1 and not used.BasicFrameTemplateWithInset,
            "window is the game's portrait frame")
        check(UI.frame.TitleContainer.TitleText.text == addon.TITLE, "title in the template's title bar: " .. addon.TITLE)
        check(UI.frame.portrait ~= nil and not UI.frame.Inset:IsShown(), "portrait kept, template inset hidden")
        if forever then
            check((used.InsetFrameTemplate or 0) >= 2 and UI.listInset ~= nil, "list and banner sit in the game's insets")
        else
            check((used.InsetFrameTemplate or 0) >= 3 and UI.listInset ~= nil and UI.statColInset ~= nil,
                "list, side panel and banner sit in the game's insets")
            check(UI.statPanelTitleBar ~= nil, "side panel title on the character window's section bar")
        end
        UI:ShowBisPreview()
        check(used.ButtonFrameTemplate == 2 and rawget(UI.previewFrame, "portrait") == nil, "preview: game window, no portrait")
    else
        check(not UI.frame.templated and used.BasicFrameTemplateWithInset == 1 and not used.InsetFrameTemplate,
            "old client: the plain dialog frame, no insets")
        check(UI.titleText.text:find("ZenaBis"), "old client: own title")
    end
    check(env.UISpecialFrames[1] == "TBCBisTrackerFrame", "Escape closes the window")
    check(UI.classTabs.PALADIN:GetChecked() and not UI.classTabs.MAGE:GetChecked(), "Paladin's side tab selected")
    check(UI.classLabel.text:find("Paladin"), "class name shown: " .. UI.classLabel.text)
    local n = 0
    for _ in pairs(UI.classTabs) do n = n + 1 end
    check(n == 9, "one side tab per class")
    check(UI.specBtns[1].classic and env.tabSelected[UI.specBtns[1]] == true and env.tabSelected[UI.specBtns[2]] == false,
        "spec tabs use the classic tab template, Holy selected")
    if forever then
        check(UI.stageChip ~= nil and next(UI.phaseTabs) == nil, "single stage shown as a tag, no tab row")
    else
        check(UI.stageChip == nil and next(UI.phaseTabs) ~= nil, "phase tab row")
    end
    check(not UI.browseBanner:IsShown(), "no browsing banner on your own class")
    local row = UI.rowPool[1]
    check(UI.frame.width == 960, "the window is 960 wide (gear list + details)")
    check(UI.pageTabs.gear and UI.pageTabs.where and UI.pages.gear:IsShown() and not UI.pages.where:IsShown(),
        "tabs under the window: Gear (shown) and Where to go")
    if forever then
        check(UI.pageTabs.stats == nil and UI.statPanel == nil, "Forever: no Stat Caps tab")
    else
        check(UI.pageTabs.stats ~= nil and UI.statPanel ~= nil and UI.badgeStatus ~= nil, "TBC: Stat Caps tab and badge line")
    end
    -- Gear: slots grouped under section titles, the first row selected, its details on the right
    local titles = {}
    for _, h in ipairs(UI.sectionPool) do if h:IsShown() then table.insert(titles, h.title.text) end end
    check(table.concat(titles, ",") == "Armor,Jewelry & trinkets,Weapons", "rows grouped: " .. table.concat(titles, ","))
    check(row:IsShown() and row.slotKey == "head" and row.selected:IsShown(), "first row (Head) selected")
    check(UI.detail.lines["Slot"].value.text == "Head" and UI.detail.got:IsShown(), "details show the slot, with Got it")
    -- Click another row: its details
    local neckRow
    for _, r in ipairs(UI.rowPool) do if r:IsShown() and r.slotKey == "neck" then neckRow = r end end
    neckRow.scripts.OnClick(neckRow, "LeftButton")
    check(UI.selectedSlot == "neck" and UI.detail.lines["Slot"].value.text == "Neck" and neckRow.selected:IsShown()
        and not row.selected:IsShown(), "clicking a row shows its details")
    local altsShown = 0
    for _, b in ipairs(UI.detail.alts) do if b:IsShown() then altsShown = altsShown + 1 end end
    local altCount = #(addon:GetSlotAlternatives(db.lastClass, db.lastSpec, db.lastPhase, "neck") or {})
    check(altsShown == math.min(altCount, 6) and altsShown > 0, "its alternatives as item buttons (" .. altsShown .. ")")
    -- Got it ticks the slot, and the row's mark follows
    UI.detail.got:SetChecked(true)
    UI.detail.got.scripts.OnClick(UI.detail.got)
    check(addon:IsObtained(db.lastClass, db.lastSpec, db.lastPhase, "neck") and neckRow.mark == "obtained",
        "Got it in the details marks the row obtained")
    UI.detail.got:SetChecked(false)
    UI.detail.got.scripts.OnClick(UI.detail.got)
    -- Where to go
    UI.pageTabs.where.scripts.OnClick(UI.pageTabs.where)
    check(UI.pages.where:IsShown() and not UI.pages.gear:IsShown() and db.page == "where", "Where to go tab")
    check(UI.whereSummary.text:find("still needed"), "summary line: " .. tostring(UI.whereSummary.text))
    local lines = 0
    for _, col in ipairs(UI.whereCols) do for _, l in ipairs(col.lines) do if l:IsShown() then lines = lines + 1 end end end
    check(lines > 0, "columns list places (" .. lines .. " lines)")
    UI.pageTabs.gear.scripts.OnClick(UI.pageTabs.gear)

    -- Browse Mage
    ok, err = pcall(function() UI.classTabs.MAGE.scripts.OnClick(UI.classTabs.MAGE) end)
    check(ok, "switching class works" .. (ok and "" or (" (" .. tostring(err) .. ")")))
    check(db.lastClass == "MAGE" and db.lastSpec == "Arcane", "Mage selected, first spec")
    check(UI.classLabel.text:find("Mage") and UI.classTabs.MAGE:GetChecked()
        and not UI.classTabs.PALADIN:GetChecked(), "Mage tab selected, name shown")
    check(UI.browseBanner:IsShown() and UI.browseBanner.txt.text:find("Mage"), "browsing banner shown")
    check(not UI.detail.got:IsShown(), "browsing: no Got it (planning only)")
    db.lastSpec = "Frost"

    -- And back
    UI:SetViewClass("PALADIN")
    check(not UI.browseBanner:IsShown() and UI.detail.got:IsShown(), "back to Paladin: Got it back, banner gone")
    UI:SetViewClass("MAGE")
    check(db.lastSpec == "Frost", "remembers the spec you last viewed per class")

    if not forever then return end
    -- Source detail on the Holy rows (the level 60 lists have no random-suffix items to hint at)
    UI:SetViewClass("PALADIN")
    local found
    for _, r in ipairs(UI.rowPool) do
        if r:IsShown() and r.slotKey == "back" then found = r end
    end
    local backPick = addon:GetSlotItem("PALADIN", db.lastSpec, db.lastPhase, "back")
    check(found and backPick and found.srcLbl.text:find(UI.kit.ShortSource(backPick), 1, true),
        "source spelled out: " .. tostring(found and found.srcLbl.text))
end
windowTest(16001)
windowTest(20505)
windowTest(16001, true)
windowTest(20505, true)

print(failures == 0 and "\nALL PASSED" or ("\n" .. failures .. " FAILED"))
os.exit(failures == 0 and 0 or 1)
