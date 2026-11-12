-- TBCBisTracker Forever mode
-- Detects the WoW Forever client on load and swaps the TBC phase/gear data
-- for the Forever data (Database_Forever.lua). Everything else in the add-on
-- (tracking, alternatives, notes, import/export, loot alerts) works the same.

TBCBisTracker = TBCBisTracker or {}
local addon = TBCBisTracker

-- ─────────────────────────────────────────────
-- Forever constants
-- ─────────────────────────────────────────────

-- Stages are added here as content opens up: "lvl60" is the pre-raid list at
-- level 60; the raid stages come next.
local FOREVER_PHASES = { "lvl60" }

-- Forever has lists for specs the TBC data doesn't cover.
local FOREVER_SPECS = {
    WARRIOR = { "Fury", "Arms", "Protection" },
    ROGUE   = { "Combat", "Assassination", "Subtlety" },
}

local FOREVER_PHASE_LABELS = {
    lvl60 = "Pre-BIS",
}

local FOREVER_PHASE_DESCRIPTIONS = {
    lvl60 = "Pre-raid Best in Slot at level 60 — dungeons, quests, crafted and reputation gear",
}

-- ─────────────────────────────────────────────
-- Detection
-- ─────────────────────────────────────────────

-- The Forever client reports a 1.60 interface (16001); TBC Anniversary is 2.5.x.
function addon:IsForeverClient()
    local _, _, _, toc = GetBuildInfo()
    toc = tonumber(toc) or 0
    return toc >= 16000 and toc < 20000
end

-- Saved override: "auto" (default), "forever" or "tbc".
function addon:GetWantedMode()
    local override = TBCBisTrackerDB and TBCBisTrackerDB.gameMode
    if override == "forever" or override == "tbc" then return override end
    return self:IsForeverClient() and "forever" or "tbc"
end

-- ─────────────────────────────────────────────
-- Apply (called once from ADDON_LOADED, before the UI is built)
-- ─────────────────────────────────────────────

function addon:ApplyGameMode()
    if self:GetWantedMode() ~= "forever" or not self.FOREVER_DB then return end

    self.GAME_MODE          = "forever"
    self.TITLE              = "ZenaBis — WoW Forever"
    self.DB                 = self.FOREVER_DB
    self.PHASES             = FOREVER_PHASES
    self.PHASE_LABELS       = FOREVER_PHASE_LABELS
    self.PHASE_DESCRIPTIONS = FOREVER_PHASE_DESCRIPTIONS
    for class, specs in pairs(FOREVER_SPECS) do
        if self.CLASS_INFO and self.CLASS_INFO[class] then self.CLASS_INFO[class].specs = specs end
    end
    -- TBC rating caps don't apply to Classic-style % stats.
    self.STAT_CAPS          = {}
    -- Wowhead's Forever database knows both the new and the carried-over items.
    self.WOWHEAD_BASE       = "https://www.wowhead.com/forever/item="
    self.WOWHEAD_QUEST_BASE = "https://www.wowhead.com/forever/quest="
    self.WOWHEAD_SEARCH_BASE = "https://www.wowhead.com/forever/search?q="
end

function addon:IsForever()
    return self.GAME_MODE == "forever"
end

-- Keep the saved phase valid for whichever phase list is active.
function addon:NormalizeLastPhase()
    for _, p in ipairs(self.PHASES) do
        if p == TBCBisTrackerDB.lastPhase then return end
    end
    TBCBisTrackerDB.lastPhase = self.PHASES[1]
end

-- /tbcbis mode [auto|forever|tbc]
function addon:HandleModeCommand(arg)
    if arg == "auto" or arg == "forever" or arg == "tbc" then
        TBCBisTrackerDB.gameMode = (arg ~= "auto") and arg or nil
        self:Print("Mode set to '" .. arg .. "'. Type /reload to apply.")
        return
    end
    local version, build, _, toc = GetBuildInfo()
    self:Print(string.format("Mode: %s (setting: %s) — client %s.%s, interface %s",
        self.GAME_MODE, TBCBisTrackerDB.gameMode or "auto",
        tostring(version), tostring(build), tostring(toc)))
    self:Print("Use /tbcbis mode auto | forever | tbc, then /reload.")
end
