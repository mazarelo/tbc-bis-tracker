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
 * Best URL for an item's subtitle row, in priority order:
 *
 *   1. Quest reward            → wowhead.com/<site>/quest=<questId>
 *   2. Curated source page     → item.sourceUrl (WoW Forever data)
 *   3. Known boss              → wowhead.com/<site>/npc=<id>/<slug>
 *   4. Parseable boss name     → wowhead.com/<site>/search?q=<name>
 *   5. Otherwise (still a drop)→ wowhead.com/<site>/item=<id>#dropped-by
 *   6. No useful target        → null
 *
 * `site` is the Wowhead database segment: "tbc" or "forever".
 * Power.js will tooltip 1, 3, and 5 (search URLs are not supported).
 */
export function subtitleWowheadUrl(
  item: Item,
  bosses: Record<string, number>,
  site = "tbc",
): string | null {
  if (item.questId) {
    return `https://www.wowhead.com/${site}/quest=${item.questId}`;
  }
  if (item.sourceUrl) return item.sourceUrl;
  if (!DROP_TYPES.has(item.sourceType)) {
    return null;
  }
  const boss = parseBossName(item.source);
  if (boss) {
    const id = bosses[boss];
    if (id) return `https://www.wowhead.com/${site}/npc=${id}/${slugify(boss)}`;
    return `https://www.wowhead.com/${site}/search?q=${encodeURIComponent(boss)}`;
  }
  if (item.id) return `https://www.wowhead.com/${site}/item=${item.id}#dropped-by`;
  return null;
}

export function itemWowheadUrl(itemId: number, site = "tbc"): string {
  return `https://www.wowhead.com/${site}/item=${itemId}`;
}
