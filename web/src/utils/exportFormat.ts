import type { ParsedExport } from "../types";

/**
 * Round-trip format with the in-game addon.
 *
 *   TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=31105;...
 *
 * This MUST stay byte-compatible with the addon's ExportSetup /
 * ImportSetup helpers (TBCBisTracker/Core.lua). Bumping the `v1` here
 * means an addon update is required as well — don't change it casually.
 */
export const EXPORT_HEADER = "TBCBIS:v1";

export interface BuildArgs {
  cls: string;
  spec: string;
  phase: string;
  slots: readonly string[];
  /** Resolver: given a slot name, return the currently-selected item id. */
  resolveSelectedItemId: (slot: string) => number | null;
}

export function buildExportString(args: BuildArgs): string {
  const parts = [
    EXPORT_HEADER,
    `class=${args.cls}`,
    `spec=${args.spec}`,
    `phase=${args.phase}`,
  ];
  for (const slot of args.slots) {
    const id = args.resolveSelectedItemId(slot);
    if (id && id > 0) parts.push(`${slot}=${id}`);
  }
  return parts.join(";");
}

/**
 * Parse a string produced by buildExportString or by the addon's
 * /tbcbis export command. Accepts both ";"-delimited (current) and
 * "\n"-delimited (legacy) forms. Returns null when the input lacks
 * the class/spec/phase header tuple.
 */
export function parseExportString(text: string | null | undefined): ParsedExport | null {
  if (!text) return null;
  const out: ParsedExport = { cls: "", spec: "", phase: "", picks: {} };
  const normalized = text.replace(/\r/g, "").replace(/\n/g, ";");
  for (let token of normalized.split(";")) {
    token = token.trim();
    if (!token || token.startsWith("TBCBIS")) continue;
    const m = token.match(/^([\w_]+)=(.+)$/);
    if (!m) continue;
    const [, k, v] = m;
    if (k === "class") out.cls = v;
    else if (k === "spec") out.spec = v;
    else if (k === "phase") out.phase = v;
    else if (/^\d+$/.test(v)) out.picks[k] = parseInt(v, 10);
  }
  if (!out.cls || !out.spec || !out.phase) return null;
  return out;
}
