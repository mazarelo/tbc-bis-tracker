import type { StatCaps } from "../types";

interface StatCapsPanelProps {
  cls: string | null;
  spec: string | null;
  statCaps: StatCaps;
}

export function StatCapsPanel({ cls, spec, statCaps }: StatCapsPanelProps) {
  const caps = cls && spec ? statCaps[cls]?.[spec] : null;

  return (
    <section className="panel stats-panel" aria-labelledby="stats-title">
      <header className="panel-header">
        <div className="panel-title">
          <h2 id="stats-title">Stat caps</h2>
          <p className="panel-sub">Reference targets for this spec</p>
        </div>
        <span className="badge">Reference</span>
      </header>
      <ul className="stat-list">
        {!caps || caps.length === 0 ? (
          <li className="stat-row">
            <span className="stat-label muted">No stat caps configured</span>
            <span></span>
          </li>
        ) : (
          caps.map((cap) => (
            <li key={cap.stat} className={`stat-row${cap.info ? " info" : ""}`}>
              <span className="stat-label">{cap.label}</span>
              <span className="stat-value">{cap.info ? "(reference)" : `cap ${cap.cap}`}</span>
            </li>
          ))
        )}
      </ul>
    </section>
  );
}
