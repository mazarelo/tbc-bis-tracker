import type { Database, Item, Meta, StatCaps } from "../types";
import { TopBar } from "./TopBar";
import { ClassBar } from "./ClassBar";
import { SpecBar } from "./SpecBar";
import { SlotList } from "./SlotList";
import { StatCapsPanel } from "./StatCapsPanel";
import { SyncPanel } from "./SyncPanel";
import { Modal, type ModalMode } from "./Modal";
import { AltsPopover } from "./AltsPopover";

/**
 * Open-overlay descriptors. The container owns the lifecycle; the view
 * just renders what it's told. Storybook stories can pass `null` (no
 * overlay) or a fully-mocked object to snapshot the open state.
 */
export interface AltsTarget {
  slot: string;
  alts: Item[];
  anchor: HTMLElement;
}

export interface ModalTarget {
  mode: ModalMode;
  text: string;
  status?: { text: string; level: "ok" | "err" };
}

/**
 * Pure presenter — every piece of state and every callback is a prop.
 *
 * This shape is what Storybook drives: pass a snapshot of the app's
 * world (database, meta, current selection, picks, obtained, derived
 * export string, overlay state) plus stub callbacks, and you get the
 * full UI in any reachable state without booting localStorage, URL
 * parsing, or the data globals.
 */
export interface AppViewProps {
  // ── Data (read-only) ────────────────────────────────────────────
  database: Database;
  statCaps: StatCaps;
  meta: Meta;
  bosses: Record<string, number>;
  version?: string;
  addonVersion?: string;

  // ── Current selection ──────────────────────────────────────────
  cls: string | null;
  spec: string | null;
  phase: string;
  missingOnly: boolean;
  /** Slot → selected item id, for the active (cls, spec, phase) tuple. */
  picks: Record<string, number>;
  /** Slot → obtained flag, for the active (cls, spec, phase) tuple. */
  obtained: Record<string, boolean>;
  /** Pre-built export string for the active selection — shown in the
   *  sync panel and the export modal. */
  exportString: string;

  // ── Selection / mutation callbacks ─────────────────────────────
  onSelectClass: (cls: string) => void;
  onSelectSpec: (spec: string) => void;
  onSelectPhase: (phase: string) => void;
  onToggleObtained: (slot: string, on: boolean) => void;
  onReset: () => void;

  // ── Overlay control ────────────────────────────────────────────
  altsTarget: AltsTarget | null;
  onOpenAlts: (slot: string, alts: Item[], anchor: HTMLElement) => void;
  onPickAlt: (slot: string, itemId: number) => void;
  onCloseAlts: () => void;

  modalTarget: ModalTarget | null;
  onOpenExport: () => void;
  onOpenImport: () => void;
  onImportText: (text: string) => { ok: boolean; msg: string };
  onCloseModal: () => void;
}

export function AppView(props: AppViewProps) {
  const footerVersions = (() => {
    const parts = ["Round-trips with TBCBisTracker addon"];
    if (props.addonVersion) parts.push(`addon v${props.addonVersion}`);
    if (props.version) parts.push(`web v${props.version}`);
    return parts.join(" · ");
  })();

  return (
    <>
      <TopBar
        phase={props.phase}
        meta={props.meta}
        onSelectPhase={props.onSelectPhase}
        onExport={props.onOpenExport}
        onImport={props.onOpenImport}
        onReset={props.onReset}
      />
      <ClassBar
        database={props.database}
        cls={props.cls}
        onSelect={props.onSelectClass}
      />
      <SpecBar
        database={props.database}
        cls={props.cls}
        spec={props.spec}
        onSelect={props.onSelectSpec}
      />

      <main className="main">
        <SlotList
          database={props.database}
          meta={props.meta}
          bosses={props.bosses}
          cls={props.cls}
          spec={props.spec}
          phase={props.phase}
          missingOnly={props.missingOnly}
          picks={props.picks}
          obtained={props.obtained}
          onToggleObtained={props.onToggleObtained}
          onOpenAlts={props.onOpenAlts}
        />
        <aside className="side">
          <StatCapsPanel cls={props.cls} spec={props.spec} statCaps={props.statCaps} />
          <SyncPanel exportPreview={props.exportString} />
        </aside>
      </main>

      <footer className="bottom">
        <span className="muted small">
          Data: Wowhead TBC Classic · Selections persist locally in your browser.
        </span>
        <span className="muted small">{footerVersions}</span>
      </footer>

      {props.altsTarget && (
        <AltsPopover
          slot={props.altsTarget.slot}
          meta={props.meta}
          alts={props.altsTarget.alts}
          selectedId={props.picks[props.altsTarget.slot]}
          anchor={props.altsTarget.anchor}
          onPick={(id) => props.onPickAlt(props.altsTarget!.slot, id)}
          onClose={props.onCloseAlts}
        />
      )}

      {props.modalTarget && (
        <Modal
          mode={props.modalTarget.mode}
          initialText={props.modalTarget.text}
          initialStatus={props.modalTarget.status}
          onImport={props.onImportText}
          onClose={props.onCloseModal}
        />
      )}
    </>
  );
}
