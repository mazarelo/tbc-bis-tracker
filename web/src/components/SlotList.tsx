import type { Database, Item, Meta } from "../types";
import { CLASS_INFO } from "../classInfo";
import { SlotRow } from "./SlotRow";

interface SlotListProps {
  database: Database;
  meta: Meta;
  bosses: Record<string, number>;
  cls: string | null;
  spec: string | null;
  phase: string;
  missingOnly: boolean;
  picks: Record<string, number>;
  obtained: Record<string, boolean>;
  onToggleObtained: (slot: string, on: boolean) => void;
  onOpenAlts: (slot: string, alts: Item[], anchor: HTMLElement) => void;
}

export function SlotList(props: SlotListProps) {
  const { database, meta, bosses, cls, spec, phase, missingOnly, picks, obtained } = props;

  const phaseLabel = meta.phaseLabels[phase] || phase;
  const title =
    cls && spec ? `${CLASS_INFO[cls]?.name ?? cls} · ${spec} · ${phaseLabel}` : phaseLabel;
  const description = meta.phaseDescriptions[phase] || "";

  type RowSpec = { slot: string; alts: Item[]; selected: Item; isObtained: boolean };
  const rows: RowSpec[] = [];
  let owned = 0;
  let total = 0;

  if (cls && spec) {
    for (const slot of meta.slots) {
      const alts = database[cls]?.[spec]?.[phase]?.[slot] ?? [];
      if (!alts.length) continue;
      total++;
      const pickedId = picks[slot];
      const selected = (pickedId && alts.find((a) => a.id === pickedId)) || alts[0];
      const isObtained = !!obtained[slot];
      if (isObtained) owned++;
      if (missingOnly && isObtained) continue;
      rows.push({ slot, alts, selected, isObtained });
    }
  }

  const pct = total > 0 ? (owned / total) * 100 : 0;

  return (
    <section className="panel slots-panel" aria-labelledby="phase-title">
      <header className="panel-header">
        <div className="panel-title">
          <h2 id="phase-title">{title}</h2>
          <p className="panel-sub">{description}</p>
        </div>
        <div className="progress" aria-label="Phase progress">
          <div className="progress-track">
            <div className="progress-fill" style={{ width: `${pct}%` }} />
          </div>
          <span className="progress-label">
            {owned} / {total}
          </span>
        </div>
      </header>

      {rows.length > 0 ? (
        <ul className="slot-list" role="list">
          {rows.map(({ slot, alts, selected, isObtained }) => (
            <SlotRow
              key={slot}
              slot={slot}
              meta={meta}
              item={selected}
              altsCount={alts.length}
              isObtained={isObtained}
              bosses={bosses}
              onToggleObtained={(on) => props.onToggleObtained(slot, on)}
              onOpenAlts={(anchor) => props.onOpenAlts(slot, alts, anchor)}
            />
          ))}
        </ul>
      ) : (
        <div className="empty-state">
          <p>No items in the database for this phase yet.</p>
          <p className="muted small">
            The addon's Database.lua only ships pre-BIS and Phase 1 data for most specs —
            later phases are placeholders.
          </p>
        </div>
      )}
    </section>
  );
}
