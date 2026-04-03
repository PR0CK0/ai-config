#!/usr/bin/env bash
# test-build.sh — delete generated files, rebuild, verify all outputs
set -euo pipefail

GENERATED=(
  claude/CLAUDE.md
  gemini/GEMINI.md
  codex/AGENTS.md
  cursor/user-rules.md
  cursor/rules/global.mdc
)

echo "Deleting generated files..."
for f in "${GENERATED[@]}"; do
  rm -f "$f" && echo "  deleted: $f"
done

echo ""
echo "Building..."
bash build.sh

echo ""
echo "Verifying..."
failed=0
for f in "${GENERATED[@]}"; do
  if [[ -s "$f" ]]; then
    echo "  ✓ $f ($(wc -l < "$f" | tr -d ' ') lines)"
  else
    echo "  ✗ $f — MISSING OR EMPTY"
    failed=1
  fi
done

echo ""
if [[ "$failed" -eq 0 ]]; then
  echo "All generated files OK."
else
  echo "Build verification FAILED." >&2
  exit 1
fi
