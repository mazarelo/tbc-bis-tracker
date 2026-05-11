import type { Item, Meta } from "../types";
import { nameFromSource, sourceWithoutName } from "../utils/naming";
import { itemWowheadUrl, subtitleWowheadUrl } from "../utils/wowheadUrls";

const SOURCE_LABELS: Record<string, string> = {
  crafted: "Profession",
  heroic: "Dungeon HC",
  raid: "Raid",
  reputation: "Reputation",
  pvp: "PvP",
  world: "World",
  quest: "Quest",
  dungeon: "Dungeon",
};

interface SlotRowProps {
  slot: string;
  meta: Meta;
  item: Item | null;
  altsCount: number;
  isObtained: boolean;
  /** Boss-name → wowhead NPC id, used by the subtitle URL builder. */
  bosses: Record<string, number>;
  onToggleObtained: (on: boolean) => void;
  onOpenAlts: (anchor: HTMLElement) => void;
}

export function SlotRow({
  slot,
  meta,
  item,
  altsCount,
  isObtained,
  bosses,
  onToggleObtained,
  onOpenAlts,
}: SlotRowProps) {
  const className = [
    "slot-row",
    isObtained ? "obtained" : "",
    !item ? "empty" : "",
  ]
    .filter(Boolean)
    .join(" ");

  return (
    <li className={className}>
      <div className="slot-name">{meta.slotLabels[slot] || slot}</div>
      <div className="slot-item">
        {item ? (
          <>
            <div className="slot-item-name">
              <a href={itemWowheadUrl(item.id)} target="_blank" rel="noopener">
                {nameFromSource(item.source) || `Item ${item.id}`}
              </a>
            </div>
            <SourceLine item={item} bosses={bosses} />
          </>
        ) : (
          <div className="slot-item-name">(no BiS in database)</div>
        )}
      </div>
      <button
        className="slot-alts-btn"
        disabled={altsCount <= 1}
        onClick={(e) => onOpenAlts(e.currentTarget)}
      >
        {altsCount > 1 ? `Alts (${altsCount})` : "1 pick"}
      </button>
      <input
        type="checkbox"
        className="chk"
        title="Mark obtained"
        checked={isObtained}
        onChange={(e) => onToggleObtained(e.target.checked)}
      />
    </li>
  );
}

function SourceLine({ item, bosses }: { item: Item; bosses: Record<string, number> }) {
  const text = sourceWithoutName(item.source);
  const type = item.sourceType;
  const url = subtitleWowheadUrl(item, bosses);
  const label = SOURCE_LABELS[type] || type;

  return (
    <div className={`slot-source src-${type}`}>
      <span className={`src-tag src-${type}`}>{label}</span>
      {url ? (
        <a href={url} target="_blank" rel="noopener" title={item.source || undefined}>
          {text}
        </a>
      ) : (
        <span title={item.source || undefined}>{text}</span>
      )}
    </div>
  );
}
