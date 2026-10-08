import type { Meta as SBMeta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { TopBar } from "./TopBar";
import { mockForeverMeta, mockMeta } from "../stories/mocks";

const meta: SBMeta<typeof TopBar> = {
  title: "Chrome/TopBar",
  component: TopBar,
  tags: ["autodocs"],
  args: {
    phase: "prebis",
    meta: mockMeta,
    games: ["tbc", "forever"],
    game: "tbc",
    faction: "Alliance",
    onSelectGame: fn(),
    onSelectFaction: fn(),
    onSelectPhase: fn(),
    onExport: fn(),
    onImport: fn(),
    onReset: fn(),
  },
};
export default meta;

type Story = StoryObj<typeof TopBar>;

export const Default: Story = {};

export const Phase1Active: Story = { args: { phase: "phase1" } };

export const Forever: Story = {
  args: { game: "forever", meta: mockForeverMeta, phase: "lvl30" },
};

export const Mobile: Story = {
  parameters: { viewport: { defaultViewport: "mobile" } },
};
