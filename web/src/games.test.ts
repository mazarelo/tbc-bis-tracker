import { describe, expect, it } from "vitest";

import { availableGames, filterByFaction, gameForPhase, resolveGame, type Bundles } from "./games";
import type { Item, TbcDataBundle } from "./types";

const bundle = (phases: string[]): TbcDataBundle => ({
  database: {},
  statCaps: {},
  meta: { slots: [], phases, slotLabels: {}, phaseLabels: {}, phaseDescriptions: {} },
});

const both: Bundles = { tbc: bundle(["prebis", "phase1"]), forever: bundle(["lvl30"]) };

describe("games", () => {
  it("lists only loaded bundles", () => {
    expect(availableGames(both)).toEqual(["tbc", "forever"]);
    expect(availableGames({ tbc: both.tbc })).toEqual(["tbc"]);
  });

  it("keeps the saved game when its data loaded, else falls back", () => {
    expect(resolveGame(both, "forever")).toBe("forever");
    expect(resolveGame({ tbc: both.tbc }, "forever")).toBe("tbc");
    expect(resolveGame(both, undefined)).toBe("tbc");
  });

  it("maps an export's phase to its game", () => {
    expect(gameForPhase(both, "lvl30")).toBe("forever");
    expect(gameForPhase(both, "phase1")).toBe("tbc");
    expect(gameForPhase(both, "nope")).toBeNull();
  });

  it("hides the other faction's items", () => {
    const item = (id: number, faction?: Item["faction"]): Item => ({
      id,
      source: "x",
      sourceType: "quest",
      note: null,
      questId: null,
      faction,
    });
    const alts = [item(1), item(2, "Alliance"), item(3, "Horde")];
    expect(filterByFaction(alts, "Horde").map((a) => a.id)).toEqual([1, 3]);
    expect(filterByFaction(alts, "Alliance").map((a) => a.id)).toEqual([1, 2]);
    expect(filterByFaction(alts, null)).toHaveLength(3);
  });
});
