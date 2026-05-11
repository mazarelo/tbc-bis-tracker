/**
 * Shared domain types. Everything the addon's Lua DB exports and the
 * extractor (scripts/build-db.py) re-emits as JSON ends up shaped like
 * this in the runtime `window.TBC_DATA` payload.
 */

/** A single curated BiS pick / alternative for one slot. */
export interface Item {
  id: number;
  source: string;
  /** Drop / acquisition category — see `SOURCE_TYPES` for the canonical set. */
  sourceType: SourceType;
  note: string | null;
  /** Wowhead quest id (when the item is a quest reward). */
  questId: number | null;
}

export type SourceType =
  | "crafted"
  | "heroic"
  | "raid"
  | "reputation"
  | "pvp"
  | "world"
  | "quest"
  | "dungeon";

/** Stable display order of source types — used for legend / filter UI. */
export const SOURCE_TYPES: readonly SourceType[] = [
  "quest",
  "dungeon",
  "heroic",
  "raid",
  "world",
  "reputation",
  "pvp",
  "crafted",
];

/** DB[CLASS][SPEC][PHASE][SLOT] = list of items (BiS first, then alts). */
export type Database = Record<
  string,
  Record<string, Record<string, Record<string, Item[]>>>
>;

export interface StatCap {
  stat: string;
  cap: number;
  label: string;
  info: boolean;
}

export type StatCaps = Record<string, Record<string, StatCap[]>>;

export interface Meta {
  slots: string[];
  phases: string[];
  slotLabels: Record<string, string>;
  phaseLabels: Record<string, string>;
  phaseDescriptions: Record<string, string>;
}

export interface TbcDataBundle {
  database: Database;
  statCaps: StatCaps;
  meta: Meta;
  version?: string;
  addonVersion?: string;
}

/** Static class info that isn't pulled from the addon (yet). */
export interface ClassInfo {
  name: string;
  color: string;
  specs: string[];
}

/** Parsed result of an export string (TBCBIS:v1;class=…;…). */
export interface ParsedExport {
  cls: string;
  spec: string;
  phase: string;
  picks: Record<string, number>;
}
