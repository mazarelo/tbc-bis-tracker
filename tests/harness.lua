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
check(#a.PHASES == 1 and a.PHASES[1] == "lvl30", "single Level 30 stage")
check(fv.TBCBisTrackerDB.lastPhase == "lvl30", "saved TBC phase moved to lvl30")
check(next(a.STAT_CAPS) == nil, "TBC stat caps disabled")
check(a.WOWHEAD_BASE:find("/forever/"), "Wowhead Forever links")
check(a:GetCapStatus("WARRIOR", "Fury", "lvl30", "selected") == nil, "no cap rows")
check(fv.printed[#fv.printed]:find("Forever"), "load message mentions Forever")

print("Tooltip hooks")
check(rawget(tbc, "loadError") == nil and tbc.GameTooltip.hooks.OnTooltipSetItem ~= nil, "old client: OnTooltipSetItem hooked")
local modern = loadAddon(16001, {}, true)
local modernErr = rawget(modern, "loadError")
check(modernErr == nil, "new client: loads without HookScript error" .. (modernErr and (" (" .. modernErr .. ")") or ""))
check(#modern.postCalls == 1 and modern.GameTooltip.hooks.OnTooltipSetItem == nil, "new client: uses TooltipDataProcessor")
local ok, err = pcall(modern.postCalls[1] and modern.postCalls[1].fn or error, modern.GameTooltip, { id = 6686 })
check(ok, "item tooltip post-call runs" .. (ok and "" or (" (" .. tostring(err) .. ")")))
local lines = table.concat(modern.GameTooltip.lines or {}, " | ")
check(lines:find("Level 30"), "tracked item gets a Level 30 line: " .. lines)

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
            for slot, list in pairs(d.lvl30 or {}) do
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
check(specs == 26, specs .. " specs with Forever data, " .. entries .. " items")

print("Faction filter")
local function countFaction(fac)
    fv.UnitFactionGroup = function() return fac end
    local n, wrong = 0, 0
    for cls, specsT in pairs(a.FOREVER_DB) do
        for spec in pairs(specsT) do
            for _, slot in ipairs(a.SLOTS) do
                for _, e in ipairs(a:GetSlotAlternatives(cls, spec, "lvl30", slot) or {}) do
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

local function windowTest(toc)
    local forever = toc < 20000
    print(forever and "Window (Forever, class browsing)" or "Window (TBC)")
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
    env.CreateFrame = function()
        local f = widget()
        local orig = f.SetScript
        f.SetScript = function(self, k, fn) if k == "OnEvent" then env.events[#env.events + 1] = fn end self.scripts[k] = fn end
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
    for _, file in ipairs({ "Localization.lua", "Core.lua", "Database.lua", "Database_Forever.lua", "Forever.lua", "UI.lua" }) do
        local chunk = assert(loadfile(ADDON_DIR .. file))
        setfenv(chunk, env)
        chunk()
    end
    for _, fn in ipairs(env.events) do fn(nil, "ADDON_LOADED", "TBCBisTracker") end
    local addon, UI = env.TBCBisTracker, env.TBCBisTracker.UI
    local ok, err = pcall(function() UI:Build(); UI:Refresh() end)
    check(ok, "window builds and fills" .. (ok and "" or (" (" .. tostring(err) .. ")")))
    if not ok then return end

    local db = env.TBCBisTrackerDB
    check(db.lastClass == "PALADIN" and db.lastSpec == "Holy", "opens on your own class")
    check(tostring(UI.classDropdown.ddText):find("Paladin"), "class dropdown shows Paladin")
    check(UI.specBtns[1].classic and env.tabSelected[UI.specBtns[1]] == true and env.tabSelected[UI.specBtns[2]] == false,
        "spec tabs use the classic tab template, Holy selected")
    if forever then
        check(UI.stageChip ~= nil and next(UI.phaseTabs) == nil, "single stage shown as a tag, no tab row")
    else
        check(UI.stageChip == nil and next(UI.phaseTabs) ~= nil, "phase tab row")
    end
    check(not UI.browseBanner:IsShown(), "no browsing banner on your own class")
    local row = UI.rowPool[1]
    check(row:IsShown() and row.chk:IsShown() and not row.dash:IsShown(), "own class: Got it ticks shown")
    local shown = 0
    for _, line in ipairs(UI.farmLines or {}) do if line:IsShown() then shown = shown + 1 end end
    if forever then
        check(shown > 0, "side panel lists where to get items (" .. shown .. " lines)")
    else
        check(UI.farmLines == nil and UI.badgeStatus ~= nil, "stat caps and badge line kept")
    end

    -- Browse Mage
    ok, err = pcall(function() UI:SetViewClass("MAGE") end)
    check(ok, "switching class works" .. (ok and "" or (" (" .. tostring(err) .. ")")))
    check(db.lastClass == "MAGE" and db.lastSpec == "Arcane", "Mage selected, first spec")
    check(tostring(UI.classDropdown.ddText):find("Mage"), "dropdown shows Mage")
    check(UI.browseBanner:IsShown() and UI.browseBanner.txt.text:find("Mage"), "browsing banner shown")
    check(not row.chk:IsShown() and row.dash:IsShown(), "browsing: ticks replaced by a dash")
    db.lastSpec = "Frost"

    -- And back
    UI:SetViewClass("PALADIN")
    check(not UI.browseBanner:IsShown() and row.chk:IsShown(), "back to Paladin: ticks back, banner gone")
    UI:SetViewClass("MAGE")
    check(db.lastSpec == "Frost", "remembers the spec you last viewed per class")

    if not forever then return end
    -- Suffix hint and source detail on the Holy rows
    UI:SetViewClass("PALADIN")
    local found
    for _, r in ipairs(UI.rowPool) do
        if r:IsShown() and r.slotKey == "back" then found = r end
    end
    check(found and found.srcDetail.text:find("World drop · auction house"), "source detail spelled out: " .. tostring(found and found.srcDetail.text))
    check(found and found.itemLbl.text:find("Twilight Cape|r|cffa39d8c of Healing", 1, true), "suffix shown next to the base name: " .. tostring(found and found.itemLbl.text))
end
windowTest(16001)
windowTest(20505)

print(failures == 0 and "\nALL PASSED" or ("\n" .. failures .. " FAILED"))
os.exit(failures == 0 and 0 or 1)
