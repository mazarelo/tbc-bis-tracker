import type { Meta } from "../types";

interface TopBarProps {
  phase: string;
  meta: Meta;
  onSelectPhase: (phase: string) => void;
  onExport: () => void;
  onImport: () => void;
  onReset: () => void;
}

export function TopBar({ phase, meta, onSelectPhase, onExport, onImport, onReset }: TopBarProps) {
  return (
    <header className="topbar">
      <a className="brand" href="#" aria-label="TBC BiS Tracker">
        <span className="brand-mark">T</span>
        <span className="brand-labels">
          <span className="brand-name">TBC BIS TRACKER</span>
          <span className="brand-sub">Burning Crusade Classic</span>
        </span>
      </a>

      <nav className="phases" aria-label="Phase">
        {meta.phases.map((p) => (
          <button
            key={p}
            className={p === phase ? "active" : ""}
            title={meta.phaseDescriptions[p] || ""}
            onClick={() => onSelectPhase(p)}
          >
            {meta.phaseLabels[p] || p}
          </button>
        ))}
      </nav>

      <a
        className="btn btn-addon"
        href="https://www.curseforge.com/wow/addons/zenabistracker"
        target="_blank"
        rel="noopener"
        title="Install the in-game addon on CurseForge"
      >
        <span className="addon-icon" aria-hidden="true">
          ⬇
        </span>
        <span className="addon-text">Get the addon</span>
      </a>

      <div className="topbar-actions">
        <button className="btn btn-primary" onClick={onExport}>
          Export
        </button>
        <button className="btn" onClick={onImport}>
          Import
        </button>
        <button
          className="btn btn-ghost"
          onClick={onReset}
          title="Reset all selections + obtained checks for the current spec"
        >
          Reset
        </button>
      </div>
    </header>
  );
}
