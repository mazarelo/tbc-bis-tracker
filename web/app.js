/* ──────────────────────────────────────────────────────────────────────
   TBC BiS Tracker — web app (boilerplate)

   Bootstraps from `window.TBC_DATA` (set by data/data.js, produced by
   scripts/build-db.py from the addon's Lua sources). Renders the same
   class / spec / phase / slot picker as the in-game addon, persists
   selections to localStorage, and round-trips with the addon via the
   same `TBCBIS:v1;class=X;spec=Y;phase=Z;slot=id;...` export string.

   Sharing a build by URL: ?build=<URL-encoded export string>. The page
   loads that string on boot and shows a notice in the modal.

   No build step. No framework. Just DOM + a few state hooks.
   ────────────────────────────────────────────────────────────────────── */

(() => {
  "use strict";

  const $ = (id) => document.getElementById(id);

  // ── Class info ─────────────────────────────────────────────────────
  // The extractor doesn't pull addon.CLASS_INFO yet, so it's hard-coded
  // here. Class colours / spec ordering are stable WoW data.
  const CLASS_INFO = {
    WARRIOR: { name: "Warrior", color: "#C79C6E", specs: ["Fury", "Arms", "Protection"] },
    PALADIN: { name: "Paladin", color: "#F58CBA", specs: ["Holy", "Protection", "Retribution"] },
    HUNTER:  { name: "Hunter",  color: "#ABD473", specs: ["Marksmanship", "Survival", "Beast Mastery"] },
    ROGUE:   { name: "Rogue",   color: "#FFF569", specs: ["Combat", "Assassination", "Subtlety"] },
    PRIEST:  { name: "Priest",  color: "#FFFFFF", specs: ["Holy", "Discipline", "Shadow"] },
    SHAMAN:  { name: "Shaman",  color: "#0070DE", specs: ["Restoration", "Elemental", "Enhancement"] },
    MAGE:    { name: "Mage",    color: "#69CCF0", specs: ["Fire", "Arcane", "Frost"] },
    WARLOCK: { name: "Warlock", color: "#9482C9", specs: ["Destruction", "Affliction", "Demonology"] },
    DRUID:   { name: "Druid",   color: "#FF7D0A", specs: ["Balance", "Restoration", "Feral - Tank", "Feral - DPS"] },
  };
  const CLASS_ORDER = ["WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"];

  // ── State ──────────────────────────────────────────────────────────
  const DATA = window.TBC_DATA || { database: {}, statCaps: {}, meta: {} };
  const META = DATA.meta || {};
  const SLOTS = META.slots || [];
  const PHASES = META.phases || [];

  const state = {
    cls: null,
    spec: null,
    phase: PHASES[0] || "prebis",
    missingOnly: false,
    /** picks[cls][spec][phase][slot] = itemId */
    picks: {},
    /** obtained[cls][spec][phase][slot] = true */
    obtained: {},
  };

  const STORAGE_KEY = "tbcbis:web:v1";

  function loadState() {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return;
      const saved = JSON.parse(raw);
      if (saved && typeof saved === "object") {
        Object.assign(state, {
          cls:  saved.cls  || state.cls,
          spec: saved.spec || state.spec,
          phase: saved.phase || state.phase,
          missingOnly: !!saved.missingOnly,
          picks: saved.picks || {},
          obtained: saved.obtained || {},
        });
      }
    } catch (e) { /* ignore corrupt storage */ }
  }

  function saveState() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({
        cls: state.cls, spec: state.spec, phase: state.phase,
        missingOnly: state.missingOnly,
        picks: state.picks, obtained: state.obtained,
      }));
    } catch (e) { /* quota/private-mode: silently drop */ }
  }

  // Nested-map helpers
  function getPicks(cls, spec, phase) {
    return ((state.picks[cls] || {})[spec] || {})[phase] || {};
  }
  function setPick(cls, spec, phase, slot, itemId) {
    state.picks[cls] = state.picks[cls] || {};
    state.picks[cls][spec] = state.picks[cls][spec] || {};
    state.picks[cls][spec][phase] = state.picks[cls][spec][phase] || {};
    if (itemId == null) delete state.picks[cls][spec][phase][slot];
    else state.picks[cls][spec][phase][slot] = itemId;
  }
  function getObtained(cls, spec, phase) {
    return ((state.obtained[cls] || {})[spec] || {})[phase] || {};
  }
  function setObtained(cls, spec, phase, slot, on) {
    state.obtained[cls] = state.obtained[cls] || {};
    state.obtained[cls][spec] = state.obtained[cls][spec] || {};
    state.obtained[cls][spec][phase] = state.obtained[cls][spec][phase] || {};
    if (on) state.obtained[cls][spec][phase][slot] = true;
    else delete state.obtained[cls][spec][phase][slot];
  }

  // ── Data helpers ───────────────────────────────────────────────────
  function getAlts(cls, spec, phase, slot) {
    const node = ((DATA.database[cls] || {})[spec] || {})[phase] || {};
    return node[slot] || [];
  }

  // The addon's source strings end with "(Item Name)" — e.g.
  //   "H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)"
  //   "Helm of the Vanquished Defender from Lady Vashj (SSC) (Destroyer Battle-Helm)"
  // We grab the last parenthesized group as an immediate display name so the
  // user sees a real item name before Wowhead's power.js widget rewrites it.
  function nameFromSource(src) {
    if (!src) return null;
    const matches = src.match(/\(([^()]+)\)\s*$/);
    return matches ? matches[1].trim() : null;
  }
  function sourceWithoutName(src) {
    return src ? src.replace(/\s*\(([^()]+)\)\s*$/, "").trim() : "";
  }

  // Source-type → short label. Mirrors the addon's SOURCE_TYPE_LABELS.
  const SOURCE_LABELS = {
    crafted: "Profession",
    heroic: "Dungeon HC",
    raid: "Raid",
    reputation: "Reputation",
    pvp: "PvP",
    world: "World",
    quest: "Quest",
    dungeon: "Dungeon",
  };

  // Source types whose subtitle is a drop — we try to link the source
  // to the boss's NPC page on wowhead, falling back to the item's
  // "Dropped by" anchor when we don't have an NPC id for that boss.
  const DROP_TYPES = new Set(["dungeon", "heroic", "raid", "world"]);

  // Source prefixes that should NOT be interpreted as boss drops even
  // though their sourceType is "raid"/"world" (vendor purchases tagged
  // as raid because of badge pricing, generic world drops, etc.).
  const NON_BOSS_PREFIXES = /^(Vendor|World Drop|World drop|PvP|Honor|Spirit Shards|Tailoring|Blacksmithing|Leatherworking|Enchanting|Engineering|Alchemy|Jewelcrafting)\b/i;

  /**
   * Pull the boss name out of an addon source string.
   *   "H Old Hillsbrad - Epoch Hunter (Wastewalker Helm)" → "Epoch Hunter"
   *   "Gruul - High King Maulgar Token (...)"            → "High King Maulgar"
   *   "Doomwalker, Shadowmoon Valley (...)"               → "Doomwalker"
   *   "Magtheridon (Girdle of the Endless Pit)"           → "Magtheridon"
   * Returns null when the source clearly isn't a boss drop (vendor,
   * crafted, world drop, …).
   */
  function parseBossName(source) {
    if (!source) return null;
    let s = source.replace(/\s*\([^()]+\)\s*$/, "").trim();
    if (NON_BOSS_PREFIXES.test(s)) return null;
    s = s.replace(/^H\s+/, "");                       // heroic marker
    const dash = s.lastIndexOf(" - ");
    if (dash >= 0) s = s.substring(dash + 3);         // strip zone prefix
    s = s.replace(/\s+Token$/i, "");                  // tier token loot
    const comma = s.indexOf(", ");
    if (comma >= 0) s = s.substring(0, comma);        // strip ", <zone>"
    s = s.trim();
    return s || null;
  }

  /** Lowercase-with-dashes slug for the wowhead NPC URL's display segment. */
  function slugify(name) {
    return name.toLowerCase()
      .replace(/['’"]/g, "")
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "");
  }

  /**
   * Best wowhead URL for the source subtitle:
   *   1. Boss name + known NPC id → npc=<id>/<slug>  (power.js tooltips it)
   *   2. Boss name only           → search?q=<name>  (no tooltip, but a
   *                                 single click takes the user to wowhead)
   *   3. Otherwise                → item=<id>#dropped-by (tooltip = item)
   */
  function dropSubtitleUrl(item) {
    const boss = parseBossName(item.source);
    if (boss) {
      const bosses = window.TBC_BOSSES || {};
      const id = bosses[boss];
      if (id) return `https://www.wowhead.com/tbc/npc=${id}/${slugify(boss)}`;
      return `https://www.wowhead.com/tbc/search?q=${encodeURIComponent(boss)}`;
    }
    if (item.id) return `https://www.wowhead.com/tbc/item=${item.id}#dropped-by`;
    return null;
  }

  /**
   * Build the subtitle row beneath the item name. Two visual cues:
   *   1. A small uppercase "tag" pill carries the source-type label
   *      (Quest / Dungeon / Raid / …) in the addon's chat colour.
   *   2. The body text is coloured to match.
   *
   * The body is clickable + tooltipped when we have a meaningful wowhead
   * target:
   *   - quest      → wowhead.com/tbc/quest=<questId>   (quest tooltip)
   *   - dungeon /
   *     heroic /
   *     raid /
   *     world      → wowhead.com/tbc/item=<id>#dropped-by  (item tooltip,
   *                  click jumps to the drop-list section)
   *   - everything else (crafted, pvp, reputation, vendor) has no useful
   *     wowhead target in our data, so it stays as plain text.
   */
  function renderSourceLine(item) {
    const text = sourceWithoutName(item.source);
    const type = item.sourceType || "world";
    const el = document.createElement("div");
    el.className = `slot-source src-${type}`;

    const tag = document.createElement("span");
    tag.className = `src-tag src-${type}`;
    tag.textContent = SOURCE_LABELS[type] || type;
    el.appendChild(tag);

    const makeLink = (href, label) => {
      const a = document.createElement("a");
      a.href = href;
      a.target = "_blank";
      a.rel = "noopener";
      a.textContent = label;
      a.title = item.source || "";
      return a;
    };

    if (item.questId) {
      el.appendChild(makeLink(
        `https://www.wowhead.com/tbc/quest=${item.questId}`,
        text || `Quest ${item.questId}`,
      ));
    } else if (DROP_TYPES.has(type)) {
      const url = dropSubtitleUrl(item);
      if (url) {
        el.appendChild(makeLink(url, text));
      } else {
        const span = document.createElement("span");
        span.textContent = text;
        span.title = item.source || "";
        el.appendChild(span);
      }
    } else {
      const span = document.createElement("span");
      span.textContent = text;
      span.title = item.source || "";
      el.appendChild(span);
    }
    return el;
  }
  function getSelectedItem(cls, spec, phase, slot) {
    const alts = getAlts(cls, spec, phase, slot);
    if (!alts.length) return null;
    const pick = getPicks(cls, spec, phase)[slot];
    if (pick != null) {
      const found = alts.find((a) => a.id === pick);
      if (found) return found;
    }
    return alts[0];
  }

  // ── Render: top-bar phases ────────────────────────────────────────
  function renderPhases() {
    const nav = $("phases");
    nav.innerHTML = "";
    for (const p of PHASES) {
      const btn = document.createElement("button");
      btn.textContent = (META.phaseLabels || {})[p] || p;
      btn.className = p === state.phase ? "active" : "";
      btn.title = (META.phaseDescriptions || {})[p] || "";
      btn.addEventListener("click", () => {
        state.phase = p;
        renderAll();
        saveState();
      });
      nav.appendChild(btn);
    }
  }

  // ── Render: class bar ──────────────────────────────────────────────
  function renderClasses() {
    const bar = $("classbar");
    bar.innerHTML = "";
    for (const cls of CLASS_ORDER) {
      if (!DATA.database[cls]) continue;
      const info = CLASS_INFO[cls];
      const btn = document.createElement("button");
      btn.textContent = info ? info.name : cls;
      btn.className = cls === state.cls ? "active" : "";
      if (info) btn.style.color = info.color;
      btn.addEventListener("click", () => {
        state.cls = cls;
        // Reset spec to the first defined spec for this class
        const info2 = CLASS_INFO[cls];
        state.spec = (info2 && info2.specs.find((s) => DATA.database[cls][s])) ||
                     Object.keys(DATA.database[cls])[0] || null;
        renderAll();
        saveState();
      });
      bar.appendChild(btn);
    }
  }

  // ── Render: spec bar ───────────────────────────────────────────────
  function renderSpecs() {
    const bar = $("specbar");
    bar.innerHTML = "";
    if (!state.cls) return;
    const info = CLASS_INFO[state.cls];
    const order = info ? info.specs : [];
    const have = DATA.database[state.cls] || {};
    // ordered specs first, then any extras present in DB
    const seen = new Set();
    const list = [];
    for (const s of order) if (have[s]) { list.push(s); seen.add(s); }
    for (const s of Object.keys(have)) if (!seen.has(s)) list.push(s);
    for (const spec of list) {
      const btn = document.createElement("button");
      btn.textContent = spec;
      btn.className = spec === state.spec ? "active" : "";
      btn.addEventListener("click", () => {
        state.spec = spec;
        renderAll();
        saveState();
      });
      bar.appendChild(btn);
    }
  }

  // ── Render: slot list ──────────────────────────────────────────────
  function renderSlots() {
    const list = $("slot-list");
    const empty = $("empty-state");
    list.innerHTML = "";

    const title = $("phase-title");
    const desc = $("phase-desc");
    const phaseLbl = (META.phaseLabels || {})[state.phase] || state.phase;
    if (state.cls && state.spec) {
      title.textContent = `${CLASS_INFO[state.cls]?.name || state.cls} · ${state.spec} · ${phaseLbl}`;
    } else {
      title.textContent = phaseLbl;
    }
    desc.textContent = (META.phaseDescriptions || {})[state.phase] || "";

    let total = 0, owned = 0, rendered = 0;

    if (state.cls && state.spec) {
      const obtainedMap = getObtained(state.cls, state.spec, state.phase);
      for (const slot of SLOTS) {
        const alts = getAlts(state.cls, state.spec, state.phase, slot);
        if (!alts.length) continue;
        total++;
        const isObtained = !!obtainedMap[slot];
        if (isObtained) owned++;
        if (state.missingOnly && isObtained) continue;
        list.appendChild(renderSlotRow(slot, alts, isObtained));
        rendered++;
      }
    }

    empty.hidden = rendered !== 0;
    $("progress-label").textContent = `${owned} / ${total}`;
    $("progress-fill").style.width = total > 0 ? `${(owned / total) * 100}%` : "0%";
  }

  function renderSlotRow(slot, alts, isObtained) {
    const item = getSelectedItem(state.cls, state.spec, state.phase, slot);
    const li = document.createElement("li");
    li.className = "slot-row";
    if (isObtained) li.classList.add("obtained");
    if (!item) li.classList.add("empty");

    const slotName = document.createElement("div");
    slotName.className = "slot-name";
    slotName.textContent = (META.slotLabels || {})[slot] || slot;

    const itemCol = document.createElement("div");
    itemCol.className = "slot-item";
    const name = document.createElement("div");
    name.className = "slot-item-name";
    if (item) {
      const a = document.createElement("a");
      a.href = `https://www.wowhead.com/tbc/item=${item.id}`;
      a.target = "_blank";
      a.rel = "noopener";
      // Seed with the name we pulled out of the source string; Wowhead's
      // power.js widget will replace it with the canonical item name once
      // it loads (renameLinks: true in index.html).
      a.textContent = nameFromSource(item.source) || `Item ${item.id}`;
      name.appendChild(a);
      itemCol.appendChild(name);
      itemCol.appendChild(renderSourceLine(item));
    } else {
      name.textContent = "(no BiS in database)";
      itemCol.appendChild(name);
    }

    const altsBtn = document.createElement("button");
    altsBtn.className = "slot-alts-btn";
    altsBtn.textContent = alts.length > 1 ? `Alts (${alts.length})` : "1 pick";
    altsBtn.disabled = alts.length <= 1;
    altsBtn.addEventListener("click", (e) => {
      e.stopPropagation();
      openAltsPopover(altsBtn, slot, alts);
    });

    const chk = document.createElement("input");
    chk.type = "checkbox";
    chk.className = "chk";
    chk.title = "Mark obtained";
    chk.checked = isObtained;
    chk.addEventListener("change", () => {
      setObtained(state.cls, state.spec, state.phase, slot, chk.checked);
      saveState();
      renderSlots();
    });

    li.appendChild(slotName);
    li.appendChild(itemCol);
    li.appendChild(altsBtn);
    li.appendChild(chk);
    return li;
  }

  // ── Alts popover ───────────────────────────────────────────────────
  function openAltsPopover(anchor, slot, alts) {
    const pop = $("alts-popover");
    $("alts-title").textContent = `${(META.slotLabels || {})[slot] || slot} alternatives`;
    const list = $("alts-list");
    list.innerHTML = "";
    const current = getSelectedItem(state.cls, state.spec, state.phase, slot);
    alts.forEach((alt, i) => {
      const li = document.createElement("li");
      if (current && current.id === alt.id) li.classList.add("active");
      const left = document.createElement("div");
      const displayName = nameFromSource(alt.source) || `Item ${alt.id}`;
      left.innerHTML = `<a href="https://www.wowhead.com/tbc/item=${alt.id}" target="_blank" rel="noopener">${displayName}</a>`;
      const right = document.createElement("span");
      const altType = alt.sourceType || "world";
      right.className = `alt-source src-${altType}`;
      right.textContent = (i === 0 ? "★ BiS · " : "") + sourceWithoutName(alt.source);
      right.title = alt.source || "";
      li.appendChild(left);
      li.appendChild(right);
      li.addEventListener("click", (e) => {
        // ignore clicks on the wowhead link itself
        if (e.target.tagName === "A") return;
        setPick(state.cls, state.spec, state.phase, slot, alt.id);
        closePopover();
        saveState();
        renderSlots();
      });
      list.appendChild(li);
    });
    pop.hidden = false;
    // Position below the anchor, clamped to viewport
    const r = anchor.getBoundingClientRect();
    pop.style.top = `${window.scrollY + r.bottom + 4}px`;
    const left = Math.min(window.scrollX + r.left, window.scrollX + window.innerWidth - pop.offsetWidth - 8);
    pop.style.left = `${Math.max(8, left)}px`;
  }
  function closePopover() { $("alts-popover").hidden = true; }

  // ── Render: stat caps ──────────────────────────────────────────────
  function renderStatCaps() {
    const list = $("stat-list");
    list.innerHTML = "";
    if (!state.cls || !state.spec) return;
    const caps = ((DATA.statCaps || {})[state.cls] || {})[state.spec];
    if (!caps || !caps.length) {
      const li = document.createElement("li");
      li.className = "stat-row";
      li.innerHTML = `<span class="stat-label muted">No stat caps configured</span><span></span>`;
      list.appendChild(li);
      return;
    }
    for (const cap of caps) {
      const li = document.createElement("li");
      li.className = "stat-row" + (cap.info ? " info" : "");
      const label = document.createElement("span");
      label.className = "stat-label";
      label.textContent = cap.label;
      const val = document.createElement("span");
      val.className = "stat-value";
      val.textContent = cap.info ? "(reference)" : `cap ${cap.cap}`;
      li.appendChild(label);
      li.appendChild(val);
      list.appendChild(li);
    }
  }

  // ── Export / Import (addon-compatible) ─────────────────────────────
  const EXPORT_HEADER = "TBCBIS:v1";

  function buildExportString() {
    if (!state.cls || !state.spec) return "";
    const parts = [
      EXPORT_HEADER,
      `class=${state.cls}`,
      `spec=${state.spec}`,
      `phase=${state.phase}`,
    ];
    for (const slot of SLOTS) {
      const item = getSelectedItem(state.cls, state.spec, state.phase, slot);
      if (item && item.id) parts.push(`${slot}=${item.id}`);
    }
    return parts.join(";");
  }

  function parseExportString(text) {
    if (!text) return null;
    const out = { cls: null, spec: null, phase: null, picks: {} };
    const normalized = text.replace(/\r/g, "").replace(/\n/g, ";");
    for (let token of normalized.split(";")) {
      token = token.trim();
      if (!token || token.startsWith("TBCBIS")) continue;
      const m = token.match(/^([\w_]+)=(.+)$/);
      if (!m) continue;
      const [, k, v] = m;
      if (k === "class") out.cls = v;
      else if (k === "spec") out.spec = v;
      else if (k === "phase") out.phase = v;
      else if (/^\d+$/.test(v)) out.picks[k] = parseInt(v, 10);
    }
    if (!out.cls || !out.spec || !out.phase) return null;
    return out;
  }

  /**
   * Apply a parsed export. For each slot pick, if the item is in the
   * extracted DB's alts list we just select it; otherwise we store the
   * raw id so the slot still displays correctly even if it's not in
   * the addon's curated list.
   */
  function applyParsed(p) {
    if (!DATA.database[p.cls] || !DATA.database[p.cls][p.spec]) {
      return { ok: false, msg: `Unknown class/spec: ${p.cls}/${p.spec}` };
    }
    state.cls = p.cls;
    state.spec = p.spec;
    state.phase = p.phase;
    let applied = 0;
    for (const [slot, id] of Object.entries(p.picks)) {
      setPick(p.cls, p.spec, p.phase, slot, id);
      applied++;
    }
    return { ok: true, msg: `Imported ${applied} slot${applied === 1 ? "" : "s"}.` };
  }

  // ── URL ?build=... handling ────────────────────────────────────────
  function readBuildFromURL() {
    const params = new URLSearchParams(window.location.search);
    const raw = params.get("build");
    if (!raw) return null;
    try { return decodeURIComponent(raw); }
    catch { return raw; }
  }

  function updateURL() {
    // Reflect current selection into the URL so the page is shareable.
    const exp = buildExportString();
    if (!exp) return;
    const params = new URLSearchParams();
    params.set("build", exp);
    const url = `${window.location.pathname}?${params.toString()}`;
    history.replaceState(null, "", url);
  }

  // ── Modal (export / import) ────────────────────────────────────────
  let modalMode = null;

  function openExport() {
    modalMode = "export";
    $("modal-title").textContent = "Export build";
    $("modal-desc").textContent = "Copy this string and paste into the addon with /tbcbis import — or share the URL below.";
    const text = buildExportString();
    const url = `${window.location.origin}${window.location.pathname}?build=${encodeURIComponent(text)}`;
    $("modal-text").value = `${text}\n\n# Share URL:\n${url}`;
    $("modal-action").textContent = "Done";
    $("modal-copy").hidden = false;
    $("modal-status").textContent = "";
    $("modal-status").className = "modal-status";
    $("modal").hidden = false;
  }

  function openImport(prefill) {
    modalMode = "import";
    $("modal-title").textContent = "Import build";
    $("modal-desc").textContent = "Paste an exported build string (from /tbcbis export or a share URL).";
    $("modal-text").value = prefill || "";
    $("modal-action").textContent = "Import";
    $("modal-copy").hidden = true;
    $("modal-status").textContent = "";
    $("modal-status").className = "modal-status";
    $("modal").hidden = false;
    $("modal-text").focus();
  }

  function closeModal() { $("modal").hidden = true; modalMode = null; }

  function modalAction() {
    if (modalMode === "import") {
      const p = parseExportString($("modal-text").value);
      if (!p) {
        $("modal-status").textContent = "Couldn't parse — expected TBCBIS:v1;class=...;spec=...;phase=...";
        $("modal-status").className = "modal-status err";
        return;
      }
      const res = applyParsed(p);
      $("modal-status").textContent = res.msg;
      $("modal-status").className = `modal-status ${res.ok ? "ok" : "err"}`;
      if (res.ok) {
        renderAll();
        saveState();
        updateURL();
        setTimeout(closeModal, 700);
      }
    } else {
      closeModal();
    }
  }

  async function modalCopy() {
    const text = $("modal-text").value;
    try {
      await navigator.clipboard.writeText(text);
      $("modal-status").textContent = "Copied!";
      $("modal-status").className = "modal-status ok";
    } catch {
      $("modal-text").select();
      document.execCommand && document.execCommand("copy");
      $("modal-status").textContent = "Copied (fallback).";
      $("modal-status").className = "modal-status ok";
    }
  }

  // ── Reset current spec ─────────────────────────────────────────────
  function resetCurrent() {
    if (!state.cls || !state.spec) return;
    const k = `${state.cls} / ${state.spec} / ${(META.phaseLabels || {})[state.phase] || state.phase}`;
    if (!confirm(`Reset all picks and obtained checks for ${k}?`)) return;
    if (state.picks[state.cls] && state.picks[state.cls][state.spec]) {
      delete state.picks[state.cls][state.spec][state.phase];
    }
    if (state.obtained[state.cls] && state.obtained[state.cls][state.spec]) {
      delete state.obtained[state.cls][state.spec][state.phase];
    }
    saveState();
    renderAll();
  }

  // ── Render everything (after selection changes) ────────────────────
  function renderAll() {
    renderPhases();
    renderClasses();
    renderSpecs();
    renderSlots();
    renderStatCaps();
    const preview = $("export-preview");
    if (preview) preview.textContent = buildExportString() || "Select a class/spec to start.";
    updateURL();
  }

  // ── Boot ───────────────────────────────────────────────────────────
  function pickFirstDefaults() {
    if (!state.cls) state.cls = CLASS_ORDER.find((c) => DATA.database[c]) || null;
    if (state.cls && !state.spec) {
      const info = CLASS_INFO[state.cls];
      state.spec = (info && info.specs.find((s) => DATA.database[state.cls][s])) ||
                   Object.keys(DATA.database[state.cls] || {})[0] || null;
    }
    if (!PHASES.includes(state.phase)) state.phase = PHASES[0] || "prebis";
  }

  function wireEvents() {
    $("missing-only").addEventListener("change", (e) => {
      state.missingOnly = e.target.checked;
      saveState();
      renderSlots();
    });
    $("btn-export").addEventListener("click", openExport);
    $("btn-import").addEventListener("click", () => openImport(""));
    $("btn-reset").addEventListener("click", resetCurrent);
    $("modal-close").addEventListener("click", closeModal);
    $("modal-action").addEventListener("click", modalAction);
    $("modal-copy").addEventListener("click", modalCopy);
    $("alts-close").addEventListener("click", closePopover);
    document.addEventListener("click", (e) => {
      const pop = $("alts-popover");
      if (!pop.hidden && !pop.contains(e.target) && !e.target.classList.contains("slot-alts-btn")) {
        closePopover();
      }
    });
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") { closePopover(); if (!$("modal").hidden) closeModal(); }
    });
  }

  function boot() {
    loadState();
    pickFirstDefaults();
    wireEvents();

    // URL build overrides local state on first load.
    const fromURL = readBuildFromURL();
    if (fromURL) {
      const p = parseExportString(fromURL);
      if (p) {
        const res = applyParsed(p);
        renderAll();
        if (res.ok) {
          // Surface to the user that a shared build was loaded.
          openImport(fromURL);
          $("modal-status").textContent = `Loaded from URL — ${res.msg}`;
          $("modal-status").className = "modal-status ok";
        }
        return;
      }
    }
    $("missing-only").checked = state.missingOnly;
    renderAll();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }
})();
