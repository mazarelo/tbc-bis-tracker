import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { SlotRow } from "./SlotRow";
import {
  mockCraftedItem,
  mockItem,
  mockMeta,
  mockQuestItem,
  mockRaidItem,
} from "../stories/mocks";

const meta: Meta<typeof SlotRow> = {
  title: "Slots/SlotRow",
  component: SlotRow,
  tags: ["autodocs"],
  decorators: [
    (Story) => (
      <ul className="slot-list" style={{ background: "#15171c", padding: 12 }}>
        <Story />
      </ul>
    ),
  ],
  args: {
    slot: "head",
    meta: mockMeta,
    altsCount: 3,
    isObtained: false,
    bosses: { "Epoch Hunter": 18096, "Lady Vashj": 21212 },
    onToggleObtained: fn(),
    onOpenAlts: fn(),
  },
};
export default meta;

type Story = StoryObj<typeof SlotRow>;

export const HeroicDrop: Story = { args: { item: mockItem } };
export const QuestReward: Story = { args: { item: mockQuestItem } };
export const RaidDrop: Story = { args: { item: mockRaidItem } };
export const Crafted: Story = { args: { item: mockCraftedItem } };
export const Obtained: Story = { args: { item: mockItem, isObtained: true } };
export const NoBiS: Story = { args: { item: null, altsCount: 0 } };
export const SinglePick: Story = { args: { item: mockItem, altsCount: 1 } };
