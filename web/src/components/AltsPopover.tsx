import { useEffect, useLayoutEffect, useRef, useState } from "react";
import type { Item, Meta } from "../types";
import { nameFromSource, sourceWithoutName } from "../utils/naming";
import { itemWowheadUrl } from "../utils/wowheadUrls";

interface AltsPopoverProps {
  slot: string;
  meta: Meta;
  alts: Item[];
  selectedId: number | undefined;
  anchor: HTMLElement;
  onPick: (itemId: number) => void;
  onClose: () => void;
}

export function AltsPopover({
  slot,
  meta,
  alts,
  selectedId,
  anchor,
  onPick,
  onClose,
}: AltsPopoverProps) {
  const ref = useRef<HTMLDivElement>(null);
  const [pos, setPos] = useState<{ top: number; left: number }>({ top: 0, left: 0 });

  // Position the popover under the anchor button, clamped to viewport.
  // On phones the CSS pins it to the bottom edge with `!important`.
  useLayoutEffect(() => {
    const r = anchor.getBoundingClientRect();
    const node = ref.current;
    const width = node?.offsetWidth ?? 280;
    const left = Math.min(
      window.scrollX + r.left,
      window.scrollX + window.innerWidth - width - 8,
    );
    setPos({ top: window.scrollY + r.bottom + 4, left: Math.max(8, left) });
  }, [anchor]);

  // Close on Escape + click-outside.
  useEffect(() => {
    function onClick(e: MouseEvent) {
      if (!ref.current) return;
      if (e.target instanceof Node && ref.current.contains(e.target)) return;
      if (e.target === anchor) return;
      onClose();
    }
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("click", onClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("click", onClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [anchor, onClose]);

  return (
    <div className="popover" ref={ref} style={{ top: pos.top, left: pos.left }}>
      <header className="popover-header">
        <h4>{(meta.slotLabels[slot] || slot) + " alternatives"}</h4>
        <button className="popover-close" aria-label="Close" onClick={onClose}>
          ×
        </button>
      </header>
      <ul className="alts-list">
        {alts.map((alt, i) => {
          const displayName = nameFromSource(alt.source) || `Item ${alt.id}`;
          const sourceText = sourceWithoutName(alt.source);
          const isActive = alt.id === selectedId || (selectedId == null && i === 0);
          return (
            <li
              key={alt.id}
              className={isActive ? "active" : ""}
              onClick={(e) => {
                // Ignore clicks on the wowhead link itself.
                if ((e.target as HTMLElement).tagName === "A") return;
                onPick(alt.id);
              }}
            >
              <div>
                <a href={itemWowheadUrl(alt.id)} target="_blank" rel="noopener">
                  {displayName}
                </a>
              </div>
              <span
                className={`alt-source src-${alt.sourceType}`}
                title={alt.source || undefined}
              >
                {(i === 0 ? "★ BiS · " : "") + sourceText}
              </span>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
