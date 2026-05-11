import { describe, expect, it } from "vitest";
import { nameFromSource, parseBossName, slugify, sourceWithoutName } from "./naming";

describe("nameFromSource", () => {
  it("extracts the last parenthesized group", () => {
    expect(nameFromSource("H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)")).toBe(
      "Wastewalker Helm",
    );
  });
  it("returns null when no parens", () => {
    expect(nameFromSource("just a string")).toBeNull();
    expect(nameFromSource("")).toBeNull();
  });
});

describe("sourceWithoutName", () => {
  it("strips the trailing (Name)", () => {
    expect(sourceWithoutName("Doomwalker (Black-Iron Battlecloak)")).toBe("Doomwalker");
  });
});

describe("parseBossName", () => {
  it("handles `Zone - Boss (Item)` form", () => {
    expect(parseBossName("H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)")).toBe(
      "Epoch Hunter",
    );
  });
  it("strips trailing Token phrasing", () => {
    expect(parseBossName("Gruul - High King Maulgar Token (Warbringer Shoulderplates)")).toBe(
      "High King Maulgar",
    );
  });
  it("handles `Boss, Zone (Item)` form", () => {
    expect(parseBossName("Doomwalker, Shadowmoon Valley (X)")).toBe("Doomwalker");
  });
  it("returns null for non-boss sources", () => {
    expect(parseBossName("Vendor - 25 Badges of Justice (Choker of Vile Intent)")).toBeNull();
    expect(parseBossName("Tailoring (Vengeance Wrap)")).toBeNull();
    expect(parseBossName("World Drop (Chestguard of Exile)")).toBeNull();
  });
});

describe("slugify", () => {
  it("lowercases and dashes", () => {
    expect(slugify("Epoch Hunter")).toBe("epoch-hunter");
  });
  it("strips apostrophes and punctuation", () => {
    expect(slugify("Kael'thas Sunstrider")).toBe("kaelthas-sunstrider");
  });
});
