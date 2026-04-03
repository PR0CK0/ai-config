#!/usr/bin/env bash
# statusline.sh — Claude Code statusLine command
# Receives JSON via stdin; outputs a single status line.

# Locale-independent float parsing (prevents "," decimal separator issues)
export LC_ALL=C

# Wrap everything in a subshell so any unhandled error falls through to the
# fallback at the bottom rather than producing a blank status line.
_statusline_main() {
  input=$(cat)

# ── ANSI colors ────────────────────────────────────────────────────────────────
CYAN="\033[36m"
YELLOW="\033[33m"
GREEN="\033[32m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"
SEP="${DIM}  |  ${RESET}"

# ── Parse JSON fields ──────────────────────────────────────────────────────────
cwd=$(echo "$input"       | jq -r '.cwd // .workspace.current_dir // empty')
used_pct=$(echo "$input"  | jq -r '.context_window.used_percentage // empty')
total_in=$(echo "$input"  | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
model_id=$(echo "$input"  | jq -r '.model.display_name // .model.id // empty')
cost=$(echo "$input"      | jq -r '.cost // empty')

# ── Git info (cyan: ⎇ branch) ─────────────────────────────────────────────────
git_part=""
if git -C "${cwd:-.}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "${cwd:-.}" symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    git_part="${CYAN}⎇ ${branch}${RESET}"
  else
    git_part="${CYAN}⎇ detached${RESET}"
  fi
else
  git_part="${DIM}⎇ no git${RESET}"
fi

# ── Folder display: parent/folder (yellow, with icon) ─────────────────────────
folder_part=""
if [ -n "$cwd" ]; then
  parent=$(basename "$(dirname "$cwd")")
  folder=$(basename "$cwd")
  if [ "$parent" = "." ] || [ "$parent" = "/" ] || [ -z "$parent" ]; then
    folder_part="${YELLOW}📁 ${folder}${RESET}"
  else
    folder_part="${YELLOW}📁 ${parent}/${folder}${RESET}"
  fi
fi

# ── Context progress bar (green <75%, yellow 75-90%, red >90%) ─────────────────
# used_pct may arrive as a float (e.g. 12.34); use awk for all arithmetic.
bar_part=""
read -r pct filled empty < <(awk -v p="${used_pct:-0}" 'BEGIN{
  pct = int(p + 0.5)
  filled = int(pct / 10)
  if (filled > 10) filled = 10
  empty = 10 - filled
  print pct, filled, empty
}')
bar=""
for ((i=0; i<filled; i++)); do bar="${bar}█"; done
for ((i=0; i<empty;  i++)); do bar="${bar}░"; done
if [ "$pct" -gt 90 ]; then
  bar_color="$RED"
elif [ "$pct" -gt 75 ]; then
  bar_color="$YELLOW"
else
  bar_color="$GREEN"
fi
bar_part="${bar_color}${bar} ${pct}%${RESET}"

# ── Token usage (dim/gray) ─────────────────────────────────────────────────────
# total_in / total_out may be floats; use awk to sum and format.
token_part=""
tok_display=$(awk -v i="$total_in" -v o="$total_out" 'BEGIN{
  t = i + o
  if (t >= 1000000) { printf "%.1fM", t/1000000 }
  else if (t >= 1000) { printf "%.1fk", t/1000 }
  else { printf "%d", t }
}')
token_part="${DIM}${tok_display} tok${RESET}"

# ── Cost (green, only if field exists and is non-zero) ────────────────────────
cost_part=""
if [ -n "$cost" ] && [ "$cost" != "0" ] && [ "$cost" != "0.0" ]; then
  cost_fmt=$(awk "BEGIN{printf \"\$%.2f\", ${cost}}" 2>/dev/null)
  [ -n "$cost_fmt" ] && cost_part="${GREEN}${cost_fmt}${RESET}"
fi

# ── Model name (dim/gray, shortened) ──────────────────────────────────────────
model_part=""
if [ -n "$model_id" ]; then
  # Shorten common model names for compactness
  short_model=$(echo "$model_id" \
    | sed 's/Claude //I' \
    | sed 's/ [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}$//' \
    | tr '[:upper:]' '[:lower:]')
  model_part="${DIM}${short_model}${RESET}"
fi

# ── Assemble parts ─────────────────────────────────────────────────────────────
parts=()
[ -n "$folder_part" ] && parts+=("$folder_part")
[ -n "$git_part"    ] && parts+=("$git_part")
parts+=("$bar_part")
parts+=("$token_part")
[ -n "$cost_part"   ] && parts+=("$cost_part")
[ -n "$model_part"  ] && parts+=("$model_part")

# Join with separator
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="${result}${SEP}${part}"
  fi
done

  printf "%b\n" "${result}"
}

# Run main; on any failure output a minimal fallback so the statusline is never blank.
_statusline_main || printf "%s\n" "$(basename "${PWD:-?}")"
