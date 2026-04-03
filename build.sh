#!/usr/bin/env bash
# build.sh — generates tool-specific configs from AGENTS.md
# Usage: ./build.sh [--symlink]
#   --symlink  create symlinks instead of copies (tools must support symlink resolution)
set -euo pipefail

SRC="AGENTS.md"
SYMLINK="${1:-}"

if [[ ! -f "$SRC" ]]; then
  echo "error: $SRC not found" >&2
  exit 1
fi

generate() {
  local dst="$1"
  local prefix="${2:-}"
  if [[ "$SYMLINK" == "--symlink" && -z "$prefix" ]]; then
    ln -sf "$SRC" "$dst"
    echo "symlinked: $dst → $SRC"
  else
    { [[ -n "$prefix" ]] && printf '%s' "$prefix"; cat "$SRC"; } > "$dst"
    echo "generated: $dst"
  fi
}

# Claude Code — reads CLAUDE.md from project root or ~/.claude/CLAUDE.md
generate CLAUDE.md

# Gemini CLI — reads GEMINI.md from project root or ~/.gemini/GEMINI.md
generate GEMINI.md

# Cursor — needs YAML frontmatter; auto-attach to all files
mkdir -p cursor
generate cursor/user-rules.md "$(printf 'description: Global rules\nalwaysApply: true\n---\n')"

# Wire up git hooks so pre-push enforces rebuild on AGENTS.md changes
if git rev-parse --git-dir > /dev/null 2>&1; then
  git config core.hooksPath .githooks
  chmod +x .githooks/pre-push
  echo "hooks:    .githooks wired via core.hooksPath"
fi
