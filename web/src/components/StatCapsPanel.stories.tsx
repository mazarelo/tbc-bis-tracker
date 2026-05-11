import type { Meta, StoryObj } from "@storybook/react";

import { StatCapsPanel } from "./StatCapsPanel";
import { mockStatCaps } from "../stories/mocks";

const meta: Meta<typeof StatCapsPanel> = {
  title: "Sidebar/StatCapsPanel",
  component: StatCapsPanel,
  tags: ["autodocs"],
  decorators: [
    (Story) => (
      <div style={{ width: 320, padding: 12 }}>
        <Story />
      </div>
    ),
  ],
  args: { statCaps: mockStatCaps },
};
export default meta;

type Story = StoryObj<typeof StatCapsPanel>;

export const Fury: Story = { args: { cls: "WARRIOR", spec: "Fury" } };
export const Protection: Story = { args: { cls: "WARRIOR", spec: "Protection" } };
export const NoCapsConfigured: Story = { args: { cls: "MAGE", spec: "Fire" } };
export const NothingSelected: Story = { args: { cls: null, spec: null } };
