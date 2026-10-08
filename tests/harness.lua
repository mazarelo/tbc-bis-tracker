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

local function loadAddon(toc, savedDB)
    local env = freshGlobals(toc)
    env.TBCBisTrackerDB = savedDB
    env.TBCBisTracker = {}  -- otherwise "TBCBisTracker or {}" picks up the shared stub
    for _, file in ipairs({ "Localization.lua", "Core.lua", "Database.lua", "Database_Forever.lua", "Forever.lua" }) do
        local chunk = assert(loadfile(ADDON_DIR .. file))
        setfenv(chunk, env)
        chunk()
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

print(failures == 0 and "\nALL PASSED" or ("\n" .. failures .. " FAILED"))
os.exit(failures == 0 and 0 or 1)
