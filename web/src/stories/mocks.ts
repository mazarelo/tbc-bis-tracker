import type { Database, Item, Meta, StatCaps } from "../types";

/* Reusable fixtures across .stories.tsx files. Tiny on purpose — the
   real DB is multi-megabyte, and we only need enough to render the
   surrounding UI for visual regression. */

export const mockMeta: Meta = {
  slots: ["head", "neck", "shoulder", "chest", "mainhand"],
  phases: ["prebis", "phase1", "phase2"],
  slotLabels: {
    head: "Head",
    neck: "Neck",
    shoulder: "Shoulders",
    chest: "Chest",
    mainhand: "Main Hand",
  },
  phaseLabels: {
    prebis: "Pre-BIS",
    phase1: "Phase 1",
    phase2: "Phase 2",
  },
  phaseDescriptions: {
    prebis: "Pre-Raid Best in Slot",
    phase1: "Phase 1 — Karazhan · Gruul · Magtheridon",
    phase2: "Phase 2 — SSC · The Eye",
  },
};

export const mockItem: Item = {
  id: 18096,
  source: "H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)",
  sourceType: "heroic",
  note: null,
  questId: null,
};

export const mockQuestItem: Item = {
  id: 31105,
  source: "Quest: Teron Gorefiend, I am... (Overlord's Helmet of Second Sight)",
  sourceType: "quest",
  note: null,
  questId: 10639,
};

export const mockRaidItem: Item = {
  id: 30120,
  source: "Lady Vashj (Serpentshrine Cavern) (Destroyer Battle-Helm)",
  sourceType: "raid",
  note: null,
  questId: null,
};

export const mockCraftedItem: Item = {
  id: 23521,
  source: "Blacksmithing (Ragesteel Helm)",
  sourceType: "crafted",
  note: null,
  questId: null,
};

export const mockAlts: Item[] = [mockItem, mockQuestItem, mockCraftedItem];

export const mockDatabase: Database = {
  WARRIOR: {
    Fury: {
      prebis: {
        head: mockAlts,
        neck: [
          {
            id: 29381,
            source: "Vendor - 25 Badges of Justice (Choker of Vile Intent)",
            sourceType: "raid",
            note: null,
            questId: null,
          },
        ],
      },
      phase1: { head: [mockRaidItem] },
      phase2: {},
    },
    Protection: { prebis: {}, phase1: {}, phase2: {} },
  },
  MAGE: {
    Fire: { prebis: {}, phase1: {}, phase2: {} },
  },
};

export const mockStatCaps: StatCaps = {
  WARRIOR: {
    Fury: [
      { stat: "hit", cap: 142, label: "Hit", info: false },
      { stat: "expertise", cap: 102, label: "Expertise", info: false },
      { stat: "crit", cap: 0, label: "Crit", info: true },
    ],
    Protection: [
      { stat: "defense", cap: 350, label: "Defense", info: false },
      { stat: "hit", cap: 142, label: "Hit", info: false },
    ],
  },
};
