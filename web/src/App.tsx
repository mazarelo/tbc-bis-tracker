import { useCallback, useEffect, useMemo, useRef, useState } from "react";

import { AppView, type AltsTarget, type ModalTarget } from "./components/AppView";
import { CLASS_INFO, CLASS_ORDER } from "./classInfo";
import { useLocalStorage } from "./hooks/useLocalStorage";
import {
  STORAGE_KEY,
  applyParsed,
  getObtained,
  getPicks,
  initialState,
  resetPhase,
  setObtained,
  setPick,
  type AppState,
} from "./state";
import {
  EXPORT_HEADER,
  buildExportString,
  parseExportString,
} from "./utils/exportFormat";

/**
 * Container — wires the pure `AppView` presenter up to:
 *   - the `window.TBC_DATA` / `window.TBC_BOSSES` globals (data source),
 *   - `useLocalStorage` (persistent state),
 *   - the browser URL (`?build=…` round-trip),
 *   - the export/import format helpers.
 *
 * No JSX of its own beyond `<AppView />` — all rendering lives in the
 * presenter, which means stories and tests can drive the entire UI by
 * constructing AppView props directly, without touching any of the
 * side-effecting machinery here.
 */
export function App() {
  const data = window.TBC_DATA;
  const { database, statCaps, meta, version, addonVersion } = data;
  const bosses = window.TBC_BOSSES ?? {};

  const [state, setState] = useLocalStorage<AppState>(STORAGE_KEY, initialState);

  // ── First-run / stale-state defaults ───────────────────────────────
  const initRanRef = useRef(false);
  useEffect(() => {
    if (initRanRef.current) return;
    initRanRef.current = true;

    setState((s) => {
      let next = s;
      // Header toggle was removed; reset stale `true` from older sessions.
      if (next.missingOnly) next = { ...next, missingOnly: false };
      if (!next.cls) {
        const firstCls = CLASS_ORDER.find((c) => database[c]) ?? null;
        next = { ...next, cls: firstCls };
      }
      if (next.cls && !next.spec) {
        const info = CLASS_INFO[next.cls];
        const firstSpec =
          info?.specs.find((s) => database[next.cls!]?.[s]) ??
          Object.keys(database[next.cls!] ?? {})[0] ??
          null;
        next = { ...next, spec: firstSpec };
      }
      if (!meta.phases.includes(next.phase)) {
        next = { ...next, phase: meta.phases[0] || "prebis" };
      }
      return next;
    });
  }, [database, meta, setState]);

  // ── Derived: picks / obtained / export string for active selection ─
  const currentPicks = useMemo(
    () => (state.cls && state.spec ? getPicks(state, state.cls, state.spec, state.phase) : {}),
    [state],
  );
  const currentObtained = useMemo(
    () =>
      state.cls && state.spec ? getObtained(state, state.cls, state.spec, state.phase) : {},
    [state],
  );
  const exportString = useMemo(() => {
    if (!state.cls || !state.spec) return "";
    return buildExportString({
      cls: state.cls,
      spec: state.spec,
      phase: state.phase,
      slots: meta.slots,
      resolveSelectedItemId: (slot) => {
        const alts = database[state.cls!]?.[state.spec!]?.[state.phase]?.[slot] ?? [];
        if (!alts.length) return null;
        const pickedId = currentPicks[slot];
        const found = pickedId && alts.find((a) => a.id === pickedId);
        return (found || alts[0])?.id ?? null;
      },
    });
  }, [database, meta.slots, state.cls, state.spec, state.phase, currentPicks]);

  // Mirror the export string to the URL so the page is shareable.
  useEffect(() => {
    if (!exportString) return;
    const url = `${window.location.pathname}?build=${encodeURIComponent(exportString)}`;
    window.history.replaceState(null, "", url);
  }, [exportString]);

  // ── Overlay state ─────────────────────────────────────────────────
  const [altsTarget, setAltsTarget] = useState<AltsTarget | null>(null);
  const [modalTarget, setModalTarget] = useState<ModalTarget | null>(null);

  // ── One-shot: parse ?build=… from the URL on first load. ──────────
  const buildAppliedRef = useRef(false);
  useEffect(() => {
    if (buildAppliedRef.current) return;
    buildAppliedRef.current = true;

    const params = new URLSearchParams(window.location.search);
    const raw = params.get("build");
    if (!raw) return;
    let text = raw;
    try {
      text = decodeURIComponent(raw);
    } catch {
      /* keep raw */
    }
    const parsed = parseExportString(text);
    if (!parsed) return;
    setState((s) => {
      const res = applyParsed(s, database, parsed);
      return res?.state ?? s;
    });
    setModalTarget({
      mode: "import",
      text,
      status: { text: "Loaded from URL.", level: "ok" },
    });
  }, [database, setState]);

  // ── Callbacks ─────────────────────────────────────────────────────
  const onSelectPhase = useCallback(
    (phase: string) => setState((s) => ({ ...s, phase })),
    [setState],
  );
  const onSelectClass = useCallback(
    (cls: string) => {
      setState((s) => {
        const info = CLASS_INFO[cls];
        const firstSpec =
          info?.specs.find((sp) => database[cls]?.[sp]) ??
          Object.keys(database[cls] ?? {})[0] ??
          null;
        return { ...s, cls, spec: firstSpec };
      });
    },
    [database, setState],
  );
  const onSelectSpec = useCallback(
    (spec: string) => setState((s) => ({ ...s, spec })),
    [setState],
  );
  const onToggleObtained = useCallback(
    (slot: string, on: boolean) => {
      setState((s) => {
        if (!s.cls || !s.spec) return s;
        return setObtained(s, s.cls, s.spec, s.phase, slot, on);
      });
    },
    [setState],
  );
  const onPickAlt = useCallback(
    (slot: string, itemId: number) => {
      setState((s) => {
        if (!s.cls || !s.spec) return s;
        return setPick(s, s.cls, s.spec, s.phase, slot, itemId);
      });
      setAltsTarget(null);
    },
    [setState],
  );
  const onReset = useCallback(() => {
    if (!state.cls || !state.spec) return;
    const label = `${state.cls} / ${state.spec} / ${meta.phaseLabels[state.phase] || state.phase}`;
    if (!confirm(`Reset all picks and obtained checks for ${label}?`)) return;
    setState((s) => (s.cls && s.spec ? resetPhase(s, s.cls, s.spec, s.phase) : s));
  }, [state.cls, state.spec, state.phase, meta.phaseLabels, setState]);

  const onOpenAlts = useCallback(
    (slot: string, alts: AltsTarget["alts"], anchor: HTMLElement) => {
      setAltsTarget({ slot, alts, anchor });
    },
    [],
  );
  const onCloseAlts = useCallback(() => setAltsTarget(null), []);

  const onOpenExport = useCallback(() => {
    if (!exportString) return;
    const shareUrl = `${window.location.origin}${window.location.pathname}?build=${encodeURIComponent(exportString)}`;
    setModalTarget({ mode: "export", text: `${exportString}\n\n# Share URL:\n${shareUrl}` });
  }, [exportString]);
  const onOpenImport = useCallback(() => setModalTarget({ mode: "import", text: "" }), []);
  const onCloseModal = useCallback(() => setModalTarget(null), []);

  const onImportText = useCallback(
    (text: string) => {
      const parsed = parseExportString(text);
      if (!parsed) {
        return {
          ok: false,
          msg: `Couldn't parse — expected ${EXPORT_HEADER};class=...;spec=...;phase=...`,
        };
      }
      let result: { ok: boolean; msg: string } = { ok: false, msg: "Unknown class/spec." };
      setState((s) => {
        const r = applyParsed(s, database, parsed);
        if (!r) {
          result = { ok: false, msg: `Unknown class/spec: ${parsed.cls}/${parsed.spec}` };
          return s;
        }
        result = {
          ok: true,
          msg: `Imported ${r.applied} slot${r.applied === 1 ? "" : "s"}.`,
        };
        return r.state;
      });
      return result;
    },
    [database, setState],
  );

  // ── Render ─────────────────────────────────────────────────────────
  return (
    <AppView
      database={database}
      statCaps={statCaps}
      meta={meta}
      bosses={bosses}
      version={version}
      addonVersion={addonVersion}
      cls={state.cls}
      spec={state.spec}
      phase={state.phase}
      missingOnly={state.missingOnly}
      picks={currentPicks}
      obtained={currentObtained}
      exportString={exportString}
      onSelectClass={onSelectClass}
      onSelectSpec={onSelectSpec}
      onSelectPhase={onSelectPhase}
      onToggleObtained={onToggleObtained}
      onReset={onReset}
      altsTarget={altsTarget}
      onOpenAlts={onOpenAlts}
      onPickAlt={onPickAlt}
      onCloseAlts={onCloseAlts}
      modalTarget={modalTarget}
      onOpenExport={onOpenExport}
      onOpenImport={onOpenImport}
      onImportText={onImportText}
      onCloseModal={onCloseModal}
    />
  );
}
