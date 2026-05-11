/* Boss name → Wowhead TBC NPC id lookup.
 *
 * Why this exists: the addon's Database.lua source strings carry boss
 * names ("H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)") but no
 * NPC ids. The website parses the boss name from the source string and
 * looks it up here to build a direct wowhead link like
 *   https://www.wowhead.com/tbc/npc=18096/epoch-hunter
 * which Wowhead's power.js then tooltips.
 *
 * Keys are the canonical boss name as it appears in the source string,
 * after stripping the trailing "(Item Name)", the leading "H " heroic
 * marker, and the leading "<Zone> - " prefix (see parseBossName() in
 * app.js for the exact normalization rules).
 *
 * Coverage is intentionally a starter set — the headline raid and
 * world bosses where the NPC id is unambiguous. Bosses not listed here
 * fall back to a wowhead search URL, so the link still works; you just
 * lose the hover tooltip and the click lands on a results page.
 *
 * Adding entries is safe: just append `"Boss Name": npcId,` below and
 * re-load. The matching is exact and case-sensitive — copy the boss
 * name verbatim from the relevant Database.lua source string. Wrong
 * ids are worse than missing ids (a wrong id links to the wrong NPC),
 * so prefer to omit when uncertain.
 */
window.TBC_BOSSES = {
  // ── Karazhan ────────────────────────────────────────────────────
  "Attumen the Huntsman": 16152,
  "Moroes": 15687,
  "The Curator": 15691,
  "Prince Malchezaar": 15690,

  // ── Gruul's Lair / Magtheridon's Lair ───────────────────────────
  "Gruul the Dragonkiller": 19044,
  "High King Maulgar": 18831,
  "Magtheridon": 17257,

  // ── Serpentshrine Cavern ────────────────────────────────────────
  "Hydross the Unstable": 21216,
  "The Lurker Below": 21217,
  "Leotheras the Blind": 21215,
  "Fathom-Lord Karathress": 21214,
  "Morogrim Tidewalker": 21213,
  "Lady Vashj": 21212,

  // ── Tempest Keep: The Eye ───────────────────────────────────────
  "Al'ar": 19514,
  "Void Reaver": 19516,
  "High Astromancer Solarian": 18805,
  "Kael'thas Sunstrider": 19622,

  // ── Battle for Mount Hyjal ──────────────────────────────────────
  "Rage Winterchill": 17767,
  "Anetheron": 17808,
  "Kaz'rogal": 17888,
  "Azgalor": 17842,
  "Archimonde": 17968,

  // ── Black Temple ────────────────────────────────────────────────
  "Illidan Stormrage": 22917,

  // ── World bosses ────────────────────────────────────────────────
  "Doom-Lord Kazzak": 18728,
};
