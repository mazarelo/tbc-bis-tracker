import type { Database } from "../types";
import { CLASS_INFO } from "../classInfo";

interface SpecBarProps {
  database: Database;
  cls: string | null;
  spec: string | null;
  onSelect: (spec: string) => void;
}

export function SpecBar({ database, cls, spec, onSelect }: SpecBarProps) {
  if (!cls) return <nav className="specbar" aria-label="Specialisation" />;

  // Preferred order from CLASS_INFO first, then anything else the DB ships.
  const ordered = CLASS_INFO[cls]?.specs ?? [];
  const have = database[cls] ?? {};
  const seen = new Set<string>();
  const list: string[] = [];
  for (const s of ordered) if (have[s]) { list.push(s); seen.add(s); }
  for (const s of Object.keys(have)) if (!seen.has(s)) list.push(s);

  return (
    <nav className="specbar" aria-label="Specialisation">
      {list.map((s) => (
        <button key={s} className={s === spec ? "active" : ""} onClick={() => onSelect(s)}>
          {s}
        </button>
      ))}
    </nav>
  );
}
