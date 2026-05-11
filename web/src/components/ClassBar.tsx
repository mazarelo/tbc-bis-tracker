import type { Database } from "../types";
import { CLASS_INFO, CLASS_ORDER } from "../classInfo";

interface ClassBarProps {
  database: Database;
  cls: string | null;
  onSelect: (cls: string) => void;
}

export function ClassBar({ database, cls, onSelect }: ClassBarProps) {
  return (
    <nav className="classbar" aria-label="Class">
      {CLASS_ORDER.filter((c) => database[c]).map((c) => {
        const info = CLASS_INFO[c];
        return (
          <button
            key={c}
            className={c === cls ? "active" : ""}
            style={{ color: info?.color }}
            onClick={() => onSelect(c)}
          >
            {info?.name ?? c}
          </button>
        );
      })}
    </nav>
  );
}
