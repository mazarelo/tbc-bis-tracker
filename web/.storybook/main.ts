import type { StorybookConfig } from "@storybook/react-vite";

/**
 * Storybook config — drives both `pnpm storybook` (local dev) and
 * `pnpm build-storybook` (used by Chromatic in CI).
 *
 * The data file is hefty (~1MB), so we skip loading it in stories; each
 * story instead passes in a tiny hand-crafted slice. Components that
 * read `window.TBC_BOSSES` get a stub in preview.tsx.
 */
const config: StorybookConfig = {
  stories: ["../src/**/*.stories.@(ts|tsx|mdx)"],
  addons: [
    "@storybook/addon-essentials",
    "@storybook/addon-a11y",
    "@storybook/addon-interactions",
    "@chromatic-com/storybook",
  ],
  framework: {
    name: "@storybook/react-vite",
    options: {},
  },
  typescript: {
    check: false,
    reactDocgen: "react-docgen-typescript",
    reactDocgenTypescriptOptions: {
      shouldExtractLiteralValuesFromEnum: true,
      propFilter: (prop) =>
        prop.parent ? !/node_modules/.test(prop.parent.fileName) : true,
    },
  },
  docs: {
    autodocs: "tag",
  },
};

export default config;
