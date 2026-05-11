import type { Preview } from "@storybook/react";
import "../src/styles/index.css";

/**
 * Stub the data globals that some components (SlotRow, AltsPopover)
 * read directly off `window`. Stories pass everything else via props,
 * so this is the only piece of "ambient" state Storybook needs.
 */
declare global {
  interface Window {
    TBC_BOSSES: Record<string, number>;
  }
}
window.TBC_BOSSES = window.TBC_BOSSES || {
  "Epoch Hunter": 18096,
  Magtheridon: 17257,
  "Lady Vashj": 21212,
  Archimonde: 17968,
};

const preview: Preview = {
  parameters: {
    backgrounds: {
      default: "tbc-dark",
      values: [
        { name: "tbc-dark", value: "#0e0f12" },
        { name: "light", value: "#f0f0f0" },
      ],
    },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    a11y: {
      // Don't fail the build on contrast issues — manual review in the
      // Chromatic UI is enough until we audit the palette explicitly.
      config: { rules: [{ id: "color-contrast", enabled: false }] },
    },
    layout: "fullscreen",
    viewport: {
      viewports: {
        mobile: { name: "Mobile", styles: { width: "390px", height: "844px" } },
        tablet: { name: "Tablet", styles: { width: "768px", height: "1024px" } },
        desktop: { name: "Desktop", styles: { width: "1280px", height: "800px" } },
      },
    },
  },
};

export default preview;
