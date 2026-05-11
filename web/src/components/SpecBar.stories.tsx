import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { SpecBar } from "./SpecBar";
import { mockDatabase } from "../stories/mocks";

const meta: Meta<typeof SpecBar> = {
  title: "Chrome/SpecBar",
  component: SpecBar,
  tags: ["autodocs"],
  args: {
    database: mockDatabase,
    onSelect: fn(),
  },
};
export default meta;

type Story = StoryObj<typeof SpecBar>;

export const NoClassSelected: Story = { args: { cls: null, spec: null } };
export const WarriorFury: Story = { args: { cls: "WARRIOR", spec: "Fury" } };
export const WarriorProtection: Story = {
  args: { cls: "WARRIOR", spec: "Protection" },
};
