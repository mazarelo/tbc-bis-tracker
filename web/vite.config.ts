import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

/**
 * GitHub Pages serves project sites at `https://<user>.github.io/<repo>/`,
 * so all asset paths need that repo segment baked in. Pass it as an env
 * var from the deploy workflow (`VITE_BASE=/tbc-bis-tracker/ npm run build`)
 * so the same repo can deploy under any name without editing this file.
 * Local `vite dev` and root-served previews leave it as "/".
 */
export default defineConfig({
  base: process.env.VITE_BASE || "/",
  plugins: [react()],
  build: {
    outDir: "dist",
    sourcemap: true,
    target: "es2022",
  },
  server: {
    port: 5173,
    open: true,
  },
});
