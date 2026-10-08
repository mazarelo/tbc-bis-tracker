import type { Faction, Game, Item, TbcDataBundle } from "./types";

/**
 * Per-game presentation: the site serves the TBC Anniversary data
 * (`window.TBC_DATA`) and the WoW Forever data (`window.FOREVER_DATA`)
 * from the same UI. Mirrors the addon, which picks one by client.
 */
export interface GameInfo {
  id: Game;
  /** Short label for the game switch. */
  label: string;
  /** Brand subtitle in the top bar. */
  subtitle: string;
  /** Footer data credit. */
  credit: string;
  /** Wowhead database path segment (wowhead.com/<site>/item=…). */
  wowheadSite: string;
  /** Lists include Alliance-/Horde-only items. */
  hasFactions: boolean;
  /** Show the stat-cap reference panel. */
  hasStatCaps: boolean;
}

export const GAMES: Record<Game, GameInfo> = {
  tbc: {
    id: "tbc",
    label: "TBC",
    subtitle: "Burning Crusade Classic",
    credit: "Data: Wowhead TBC Classic",
    wowheadSite: "tbc",
    hasFactions: false,
    hasStatCaps: true,
  },
  forever: {
    id: "forever",
    label: "Forever",
    subtitle: "WoW Forever · level 30 beta",
    credit: "Data: foreverchanges.pro beta lists (may change before launch)",
    wowheadSite: "forever",
    hasFactions: true,
    hasStatCaps: false,
  },
};

export const GAME_ORDER: readonly Game[] = ["tbc", "forever"];

export type Bundles = Partial<Record<Game, TbcDataBundle>>;

/** Games whose data bundle actually loaded. */
export function availableGames(bundles: Bundles): Game[] {
  return GAME_ORDER.filter((g) => bundles[g]);
}

/** Active game: the saved one when its data loaded, else the first available. */
export function resolveGame(bundles: Bundles, wanted: Game | undefined): Game {
  if (wanted && bundles[wanted]) return wanted;
  return availableGames(bundles)[0] ?? "tbc";
}

/** Which game an export string belongs to, judged by its phase key. */
export function gameForPhase(bundles: Bundles, phase: string): Game | null {
  return availableGames(bundles).find((g) => bundles[g]!.meta.phases.includes(phase)) ?? null;
}

/** Drop items reserved for the other faction. */
export function filterByFaction(alts: Item[], faction: Faction | null): Item[] {
  if (!faction) return alts;
  return alts.filter((a) => !a.faction || a.faction === faction);
}
