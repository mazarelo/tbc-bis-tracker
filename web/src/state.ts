import type { Database } from "./types";

/**
 * Single AppState shape persisted via useLocalStorage. Nested maps are
 * keyed `class → spec → phase → slot` (mirrors the addon's saved
 * variables schema). Helpers below keep that pyramid tidy.
 */
export interface AppState {
  cls: string | null;
  spec: string | null;
  phase: string;
  missingOnly: boolean;
  /** picks[cls][spec][phase][slot] = chosen item id (overrides default BiS). */
  picks: Record<string, Record<string, Record<string, Record<string, number>>>>;
  /** obtained[cls][spec][phase][slot] = true */
  obtained: Record<string, Record<string, Record<string, Record<string, boolean>>>>;
}

export const STORAGE_KEY = "tbcbis:web:v1";

export const initialState: AppState = {
  cls: null,
  spec: null,
  phase: "prebis",
  missingOnly: false,
  picks: {},
  obtained: {},
};

export function getPicks(state: AppState, cls: string, spec: string, phase: string): Record<string, number> {
  return state.picks[cls]?.[spec]?.[phase] ?? {};
}

export function getObtained(
  state: AppState,
  cls: string,
  spec: string,
  phase: string,
): Record<string, boolean> {
  return state.obtained[cls]?.[spec]?.[phase] ?? {};
}

export function setPick(
  state: AppState,
  cls: string,
  spec: string,
  phase: string,
  slot: string,
  itemId: number | null,
): AppState {
  const next = structuredClone(state);
  next.picks[cls] ??= {};
  next.picks[cls][spec] ??= {};
  next.picks[cls][spec][phase] ??= {};
  if (itemId == null) {
    delete next.picks[cls][spec][phase][slot];
  } else {
    next.picks[cls][spec][phase][slot] = itemId;
  }
  return next;
}

export function setObtained(
  state: AppState,
  cls: string,
  spec: string,
  phase: string,
  slot: string,
  on: boolean,
): AppState {
  const next = structuredClone(state);
  next.obtained[cls] ??= {};
  next.obtained[cls][spec] ??= {};
  next.obtained[cls][spec][phase] ??= {};
  if (on) {
    next.obtained[cls][spec][phase][slot] = true;
  } else {
    delete next.obtained[cls][spec][phase][slot];
  }
  return next;
}

export function resetPhase(state: AppState, cls: string, spec: string, phase: string): AppState {
  const next = structuredClone(state);
  if (next.picks[cls]?.[spec]) delete next.picks[cls][spec][phase];
  if (next.obtained[cls]?.[spec]) delete next.obtained[cls][spec][phase];
  return next;
}

/** Apply a parsed export by adopting class/spec/phase + every slot pick. */
export function applyParsed(
  state: AppState,
  database: Database,
  parsed: { cls: string; spec: string; phase: string; picks: Record<string, number> },
): { state: AppState; applied: number } | null {
  if (!database[parsed.cls]?.[parsed.spec]) return null;
  let next: AppState = {
    ...state,
    cls: parsed.cls,
    spec: parsed.spec,
    phase: parsed.phase,
  };
  let applied = 0;
  for (const [slot, id] of Object.entries(parsed.picks)) {
    next = setPick(next, parsed.cls, parsed.spec, parsed.phase, slot, id);
    applied++;
  }
  return { state: next, applied };
}
