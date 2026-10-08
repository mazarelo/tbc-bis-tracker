import { GAMES } from "../games";
import type { Faction, Game, Meta } from "../types";

const FACTIONS: readonly Faction[] = ["Alliance", "Horde"];

interface TopBarProps {
  phase: string;
  meta: Meta;
  /** Active game data set. */
  game?: Game;
  /** Games with loaded data; the switch only shows when there's a choice. */
  games?: readonly Game[];
  onSelectGame?: (game: Game) => void;
  /** Player faction — only shown for games with faction-only items. */
  faction?: Faction;
  onSelectFaction?: (faction: Faction) => void;
  onSelectPhase: (phase: string) => void;
  onExport: () => void;
  onImport: () => void;
  onReset: () => void;
}

export function TopBar({
  phase,
  meta,
  game = "tbc",
  games = [],
  onSelectGame,
  faction,
  onSelectFaction,
  onSelectPhase,
  onExport,
  onImport,
  onReset,
}: TopBarProps) {
  const info = GAMES[game];
  return (
    <header className="topbar">
      <a className="brand" href="#" aria-label={`${info.label} BiS Tracker`}>
        <span className="brand-mark">{game === "forever" ? "F" : "T"}</span>
        <span className="brand-labels">
          <span className="brand-name">{info.label.toUpperCase()} BIS TRACKER</span>
          <span className="brand-sub">{info.subtitle}</span>
        </span>
      </a>

      {games.length > 1 && onSelectGame && (
        <div className="segmented" role="group" aria-label="Game">
          {games.map((g) => (
            <button
              key={g}
              className={g === game ? "active" : ""}
              aria-pressed={g === game}
              title={GAMES[g].subtitle}
              onClick={() => onSelectGame(g)}
            >
              {GAMES[g].label}
            </button>
          ))}
        </div>
      )}

      {info.hasFactions && faction && onSelectFaction && (
        <div className="segmented" role="group" aria-label="Faction">
          {FACTIONS.map((f) => (
            <button
              key={f}
              className={`${f === faction ? "active" : ""} faction-${f.toLowerCase()}`}
              aria-pressed={f === faction}
              title={`Hide ${f === "Alliance" ? "Horde" : "Alliance"}-only items`}
              onClick={() => onSelectFaction(f)}
            >
              {f}
            </button>
          ))}
        </div>
      )}

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
