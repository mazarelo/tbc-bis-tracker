import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { AppView } from "./AppView";
import {
  mockDatabase,
  mockMeta,
  mockStatCaps,
} from "../stories/mocks";

const bosses = { "Epoch Hunter": 18096, "Lady Vashj": 21212, Magtheridon: 17257 };

/**
 * AppView is a pure presenter, so every reachable state of the app is
 * just a different set of props. Each story below corresponds to a
 * specific UI scenario we want Chromatic to keep an eye on.
 */
const meta: Meta<typeof AppView> = {
  title: "App/AppView",
  component: AppView,
  parameters: { layout: "fullscreen" },
  args: {
    database: mockDatabase,
    statCaps: mockStatCaps,
    meta: mockMeta,
    bosses,
    version: "1.0.0",
    addonVersion: "1.0.0",
    cls: "WARRIOR",
    spec: "Fury",
    phase: "prebis",
    missingOnly: false,
    picks: {},
    obtained: {},
    exportString:
      "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096;neck=29381",
    altsTarget: null,
    modalTarget: null,
    onSelectClass: fn(),
    onSelectSpec: fn(),
    onSelectPhase: fn(),
    onToggleObtained: fn(),
    onReset: fn(),
    onOpenAlts: fn(),
    onPickAlt: fn(),
    onCloseAlts: fn(),
    onOpenExport: fn(),
    onOpenImport: fn(),
    onImportText: fn(() => ({ ok: true, msg: "Imported 5 slots." })),
    onCloseModal: fn(),
  },
};
export default meta;

type Story = StoryObj<typeof AppView>;

export const Default: Story = {};

export const PartiallyObtained: Story = {
  args: { obtained: { head: true } },
};

export const Protection: Story = {
  args: { spec: "Protection", phase: "prebis" },
};

export const EmptyPhase: Story = {
  args: { phase: "phase2" },
};

export const ExportModalOpen: Story = {
  args: {
    modalTarget: {
      mode: "export",
      text: "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096;neck=29381",
    },
  },
};

export const ImportModalLoadedFromURL: Story = {
  args: {
    modalTarget: {
      mode: "import",
      text: "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096",
      status: { text: "Loaded from URL.", level: "ok" },
    },
  },
};

export const Mobile: Story = {
  parameters: { viewport: { defaultViewport: "mobile" } },
};
