import type { ClassInfo } from "./types";

/**
 * Class metadata not (yet) extracted by build-db.py — colours and spec
 * ordering are stable WoW data, safe to hard-code.
 */
export const CLASS_INFO: Record<string, ClassInfo> = {
  WARRIOR: { name: "Warrior", color: "#C79C6E", specs: ["Fury", "Arms", "Protection"] },
  PALADIN: {
    name: "Paladin",
    color: "#F58CBA",
    specs: ["Holy", "Protection", "Retribution"],
  },
  HUNTER: {
    name: "Hunter",
    color: "#ABD473",
    specs: ["Marksmanship", "Survival", "Beast Mastery"],
  },
  ROGUE: { name: "Rogue", color: "#FFF569", specs: ["Combat", "Assassination", "Subtlety"] },
  PRIEST: { name: "Priest", color: "#FFFFFF", specs: ["Holy", "Discipline", "Shadow"] },
  SHAMAN: {
    name: "Shaman",
    color: "#0070DE",
    specs: ["Restoration", "Elemental", "Enhancement"],
  },
  MAGE: { name: "Mage", color: "#69CCF0", specs: ["Fire", "Arcane", "Frost"] },
  WARLOCK: {
    name: "Warlock",
    color: "#9482C9",
    specs: ["Destruction", "Affliction", "Demonology"],
  },
  DRUID: {
    name: "Druid",
    color: "#FF7D0A",
    specs: ["Balance", "Restoration", "Feral - Tank", "Feral - DPS"],
  },
};

export const CLASS_ORDER = [
  "WARRIOR",
  "PALADIN",
  "HUNTER",
  "ROGUE",
  "PRIEST",
  "SHAMAN",
  "MAGE",
  "WARLOCK",
  "DRUID",
] as const;
