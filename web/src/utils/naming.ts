/**
 * Helpers that operate on the addon's free-form `source` strings —
 * e.g. "H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)".
 *
 * The source string is the only authoritative place where item names,
 * zones, and boss names live in the extracted JSON, so a few small
 * regex helpers go a long way.
 */

/** Last parenthesized group in the source string — almost always the item name. */
export function nameFromSource(src: string | null | undefined): string | null {
  if (!src) return null;
  const m = src.match(/\(([^()]+)\)\s*$/);
  return m ? m[1].trim() : null;
}

/** Source string with the trailing "(Item Name)" stripped off. */
export function sourceWithoutName(src: string | null | undefined): string {
  return src ? src.replace(/\s*\(([^()]+)\)\s*$/, "").trim() : "";
}

/** Sources whose prefix means "not a boss drop", even though the
 *  sourceType might be tagged otherwise (vendor purchases priced in
 *  raid badges, generic world drops, profession recipes, …). */
const NON_BOSS_PREFIXES =
  /^(Vendor|World Drop|World drop|PvP|Honor|Spirit Shards|Tailoring|Blacksmithing|Leatherworking|Enchanting|Engineering|Alchemy|Jewelcrafting)\b/i;

/**
 * Pull the boss name out of a source string. Returns `null` when the
 * source clearly isn't a boss drop.
 *
 *   "H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)" → "Epoch Hunter"
 *   "Gruul - High King Maulgar Token (...)"            → "High King Maulgar"
 *   "Doomwalker, Shadowmoon Valley (...)"               → "Doomwalker"
 *   "Magtheridon (Girdle of the Endless Pit)"           → "Magtheridon"
 */
export function parseBossName(source: string | null | undefined): string | null {
  if (!source) return null;
  let s = source.replace(/\s*\([^()]+\)\s*$/, "").trim();
  if (NON_BOSS_PREFIXES.test(s)) return null;
  s = s.replace(/^H\s+/, ""); // heroic marker
  const dash = s.lastIndexOf(" - ");
  if (dash >= 0) s = s.substring(dash + 3); // strip zone prefix
  s = s.replace(/\s+Token$/i, ""); // tier-token loot phrasing
  const comma = s.indexOf(", ");
  if (comma >= 0) s = s.substring(0, comma); // strip ", <zone>"
  s = s.trim();
  return s || null;
}

/** wowhead-style URL slug for the boss-name display segment. */
export function slugify(name: string): string {
  return name
    .toLowerCase()
    .replace(/['’"]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
