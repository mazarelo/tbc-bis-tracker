import type { Meta, StoryObj } from "@storybook/react";

import { SyncPanel } from "./SyncPanel";

const meta: Meta<typeof SyncPanel> = {
  title: "Sidebar/SyncPanel",
  component: SyncPanel,
  tags: ["autodocs"],
  decorators: [
    (Story) => (
      <div style={{ width: 320, padding: 12 }}>
        <Story />
      </div>
    ),
  ],
};
export default meta;

type Story = StoryObj<typeof SyncPanel>;

export const EmptySelection: Story = { args: { exportPreview: "" } };

export const Populated: Story = {
  args: {
    exportPreview:
      "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096;neck=29381;shoulder=27797",
  },
};
