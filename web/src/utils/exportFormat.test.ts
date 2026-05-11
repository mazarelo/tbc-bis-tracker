import { describe, expect, it } from "vitest";
import { EXPORT_HEADER, buildExportString, parseExportString } from "./exportFormat";

describe("buildExportString", () => {
  it("emits the canonical addon-compatible format", () => {
    const out = buildExportString({
      cls: "WARRIOR",
      spec: "Fury",
      phase: "prebis",
      slots: ["head", "neck"],
      resolveSelectedItemId: (slot) => (slot === "head" ? 31105 : 12345),
    });
    expect(out).toBe(`${EXPORT_HEADER};class=WARRIOR;spec=Fury;phase=prebis;head=31105;neck=12345`);
  });

  it("skips slots with no item", () => {
    const out = buildExportString({
      cls: "WARRIOR",
      spec: "Fury",
      phase: "prebis",
      slots: ["head", "neck"],
      resolveSelectedItemId: (slot) => (slot === "head" ? 31105 : null),
    });
    expect(out).toBe(`${EXPORT_HEADER};class=WARRIOR;spec=Fury;phase=prebis;head=31105`);
  });
});

describe("parseExportString", () => {
  it("round-trips with buildExportString", () => {
    const s = `${EXPORT_HEADER};class=WARRIOR;spec=Fury;phase=prebis;head=31105;neck=12345`;
    const parsed = parseExportString(s);
    expect(parsed).toEqual({
      cls: "WARRIOR",
      spec: "Fury",
      phase: "prebis",
      picks: { head: 31105, neck: 12345 },
    });
  });

  it("accepts newline-delimited legacy form", () => {
    const s = "TBCBIS:v1\nclass=WARRIOR\nspec=Fury\nphase=prebis\nhead=31105";
    expect(parseExportString(s)).toEqual({
      cls: "WARRIOR",
      spec: "Fury",
      phase: "prebis",
      picks: { head: 31105 },
    });
  });

  it("rejects strings without a class/spec/phase header", () => {
    expect(parseExportString("garbage")).toBeNull();
    expect(parseExportString("")).toBeNull();
    expect(parseExportString(null)).toBeNull();
  });
});
