import type { TbcDataBundle } from "./types";

/**
 * `data/data.js` and `data/bosses.js` (generated + curated) load before
 * the Vite bundle and attach their payloads to `window`. Declaring the
 * shape here so the rest of the codebase reads them with type-safety
 * instead of `(window as any).TBC_DATA`.
 */
declare global {
  interface Window {
    TBC_DATA: TbcDataBundle;
    TBC_BOSSES: Record<string, number>;
    /* Wowhead's `power.js` reads this on load (set in index.html). */
    whTooltips?: {
      colorLinks?: boolean;
      iconizeLinks?: boolean;
      iconSize?: string;
      renameLinks?: boolean;
    };
  }
}

export {};
