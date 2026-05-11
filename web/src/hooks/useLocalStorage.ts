import { useCallback, useEffect, useState } from "react";

/**
 * Typed wrapper around `localStorage` that behaves like `useState` but
 * persists across reloads. Reads lazily on mount, writes on every set.
 *
 * Failure modes (quota, private-browsing, JSON corruption) are swallowed
 * silently — the UI keeps working in memory.
 */
export function useLocalStorage<T>(key: string, initial: T): [T, (value: T | ((v: T) => T)) => void] {
  const [value, setValue] = useState<T>(() => {
    try {
      const raw = localStorage.getItem(key);
      return raw == null ? initial : (JSON.parse(raw) as T);
    } catch {
      return initial;
    }
  });

  useEffect(() => {
    try {
      localStorage.setItem(key, JSON.stringify(value));
    } catch {
      /* quota / private mode */
    }
  }, [key, value]);

  const set = useCallback(
    (next: T | ((v: T) => T)) => {
      setValue((prev) => (typeof next === "function" ? (next as (v: T) => T)(prev) : next));
    },
    [],
  );

  return [value, set];
}
