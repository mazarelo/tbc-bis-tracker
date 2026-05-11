interface SyncPanelProps {
  exportPreview: string;
}

export function SyncPanel({ exportPreview }: SyncPanelProps) {
  return (
    <section className="panel sync-panel" aria-labelledby="sync-title">
      <header className="sync-header">
        <span className="sync-icon" aria-hidden="true">
          ⇆
        </span>
        <h2 id="sync-title">Sync with addon</h2>
      </header>
      <p className="muted small sync-intro">
        Track BiS progress in-game with the companion addon — same data, live tooltips,
        per-character checklists, stat-cap bars.
      </p>
      <a
        className="btn btn-primary install-cta"
        href="https://www.curseforge.com/wow/addons/zenabistracker"
        target="_blank"
        rel="noopener"
      >
        Install from CurseForge →
      </a>
      <pre className="code-box">{exportPreview || "Select a class/spec to start."}</pre>
      <p className="muted small">
        Press <strong>Export</strong> for a copyable string, or <strong>Import</strong> to paste one
        from <code>/tbcbis</code>.
      </p>
    </section>
  );
}
