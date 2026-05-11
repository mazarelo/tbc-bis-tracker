import { useEffect, useRef, useState } from "react";

export type ModalMode = "export" | "import";

interface ModalProps {
  mode: ModalMode;
  initialText: string;
  /** Modal opens with this status pre-populated (used for "Loaded from URL"). */
  initialStatus?: { text: string; level: "ok" | "err" };
  /** "Import" mode: callback for the action button. Return ok+message. */
  onImport?: (text: string) => { ok: boolean; msg: string };
  onClose: () => void;
}

export function Modal({ mode, initialText, initialStatus, onImport, onClose }: ModalProps) {
  const [text, setText] = useState(initialText);
  const [status, setStatus] = useState<{ text: string; level: "ok" | "err" | null }>(
    initialStatus ?? { text: "", level: null },
  );
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    if (mode === "import") textareaRef.current?.focus();
  }, [mode]);

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [onClose]);

  async function handleCopy() {
    try {
      await navigator.clipboard.writeText(text);
      setStatus({ text: "Copied!", level: "ok" });
    } catch {
      textareaRef.current?.select();
      // eslint-disable-next-line @typescript-eslint/no-deprecated
      document.execCommand?.("copy");
      setStatus({ text: "Copied (fallback).", level: "ok" });
    }
  }

  function handleAction() {
    if (mode === "import" && onImport) {
      const res = onImport(text);
      setStatus({ text: res.msg, level: res.ok ? "ok" : "err" });
      if (res.ok) setTimeout(onClose, 700);
    } else {
      onClose();
    }
  }

  const title = mode === "export" ? "Export build" : "Import build";
  const desc =
    mode === "export"
      ? "Copy this string and paste into the addon with /tbcbis import — or share the URL below."
      : "Paste an exported build string (from /tbcbis export or a share URL).";
  const actionLabel = mode === "export" ? "Done" : "Import";

  return (
    <div className="modal" role="dialog" aria-modal="true" aria-labelledby="modal-title">
      <div className="modal-card">
        <header className="modal-header">
          <h3 id="modal-title">{title}</h3>
          <button className="modal-close" aria-label="Close" onClick={onClose}>
            ×
          </button>
        </header>
        <p className="modal-desc">{desc}</p>
        <textarea
          ref={textareaRef}
          value={text}
          onChange={(e) => setText(e.target.value)}
          rows={6}
          spellCheck={false}
        />
        <footer className="modal-footer">
          <span className={`modal-status${status.level ? ` ${status.level}` : ""}`}>
            {status.text}
          </span>
          <div className="modal-buttons">
            {mode === "export" && (
              <button className="btn" onClick={handleCopy}>
                Copy
              </button>
            )}
            <button className="btn btn-primary" onClick={handleAction}>
              {actionLabel}
            </button>
          </div>
        </footer>
      </div>
    </div>
  );
}
