import type { Item, SourceType } from "../types";
import { parseBossName, slugify } from "./naming";

/** Source types that represent a drop — we try to link to a boss / item-source page. */
export const DROP_TYPES: ReadonlySet<SourceType> = new Set([
  "dungeon",
  "heroic",
  "raid",
  "world",
]);

/**
 * Best wowhead URL for an item's subtitle row, in priority order:
 *
 *   1. Quest reward            → wowhead.com/tbc/quest=<questId>
 *   2. Known boss              → wowhead.com/tbc/npc=<id>/<slug>
 *   3. Parseable boss name     → wowhead.com/tbc/search?q=<name>
 *   4. Otherwise (still a drop)→ wowhead.com/tbc/item=<id>#dropped-by
 *   5. No useful target        → null
 *
 * Power.js will tooltip 1, 2, and 4 (search URLs are not supported).
 */
export function subtitleWowheadUrl(item: Item, bosses: Record<string, number>): string | null {
  if (item.questId) {
    return `https://www.wowhead.com/tbc/quest=${item.questId}`;
  }
  if (!DROP_TYPES.has(item.sourceType)) {
    return null;
  }
  const boss = parseBossName(item.source);
  if (boss) {
    const id = bosses[boss];
    if (id) return `https://www.wowhead.com/tbc/npc=${id}/${slugify(boss)}`;
    return `https://www.wowhead.com/tbc/search?q=${encodeURIComponent(boss)}`;
  }
  if (item.id) return `https://www.wowhead.com/tbc/item=${item.id}#dropped-by`;
  return null;
}

export function itemWowheadUrl(itemId: number): string {
  return `https://www.wowhead.com/tbc/item=${itemId}`;
}
