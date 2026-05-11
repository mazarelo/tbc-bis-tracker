import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";

import { Modal } from "./Modal";

const meta: Meta<typeof Modal> = {
  title: "Overlays/Modal",
  component: Modal,
  tags: ["autodocs"],
  args: { onClose: fn(), onImport: fn(() => ({ ok: true, msg: "Imported 5 slots." })) },
};
export default meta;

type Story = StoryObj<typeof Modal>;

export const ExportEmpty: Story = {
  args: { mode: "export", initialText: "" },
};

export const ExportPopulated: Story = {
  args: {
    mode: "export",
    initialText:
      "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096;neck=29381\n\n# Share URL:\nhttps://example.com/?build=TBCBIS%3Av1%3Bclass%3DWARRIOR",
  },
};

export const ImportEmpty: Story = {
  args: { mode: "import", initialText: "" },
};

export const ImportWithSuccess: Story = {
  args: {
    mode: "import",
    initialText: "TBCBIS:v1;class=WARRIOR;spec=Fury;phase=prebis;head=18096",
    initialStatus: { text: "Loaded from URL.", level: "ok" },
  },
};
