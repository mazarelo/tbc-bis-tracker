import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { ClassBar } from "./ClassBar";
import { mockDatabase } from "../stories/mocks";

const meta: Meta<typeof ClassBar> = {
  title: "Chrome/ClassBar",
  component: ClassBar,
  tags: ["autodocs"],
  args: {
    database: mockDatabase,
    onSelect: fn(),
  },
};
export default meta;

type Story = StoryObj<typeof ClassBar>;

export const Unselected: Story = { args: { cls: null } };
export const WarriorActive: Story = { args: { cls: "WARRIOR" } };
export const MageActive: Story = { args: { cls: "MAGE" } };
