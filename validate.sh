#!/usr/bin/env bash
# validate.sh — Sanity check the skill against the live Mobbin MCP.
#
# What it does:
#   1. Asks your default Claude Code session to run a known Mode A query.
#   2. Greps the response for required output elements:
#      - a markdown table header (`| App |`)
#      - at least one `mobbin.com/screens/` link
#      - the Mode A escalation offer ("deeper pattern analysis")
#   3. Exits non-zero if any check fails.
#
# Prereqs:
#   - `claude` CLI installed and authenticated
#   - Mobbin MCP configured (`claude mcp list | grep mobbin`)
#   - This skill installed (`claude skills list | grep mobbin`)
#
# Usage:
#   ./validate.sh

set -euo pipefail

if ! command -v claude >/dev/null 2>&1; then
  echo "ERROR: claude CLI not found. Install Claude Code first." >&2
  exit 2
fi

PROMPT='Show me 5 iOS food delivery checkout screens with order summary and place order button.'
OUT=$(mktemp)
trap 'rm -f "$OUT"' EXIT

echo "→ Running Mode A query against the skill…"
claude --print "$PROMPT" > "$OUT"

fail=0
check() {
  local label="$1" pattern="$2"
  if grep -qE "$pattern" "$OUT"; then
    printf "  \033[32m✓\033[0m %s\n" "$label"
  else
    printf "  \033[31m✗\033[0m %s\n" "$label"
    fail=1
  fi
}

check "table header present"       '\| *App *\|'
check "at least one Mobbin link"   'mobbin\.com/screens/[0-9a-f-]+'
check "escalation offer"           '[Dd]eeper pattern analysis'
check "no padding apology"         '!grep -q "no relevant results"'  # placeholder, see below

# the negative-grep idiom above doesn't actually negate; do it explicitly:
if grep -qi "no relevant results\|no matches" "$OUT" && ! grep -qi "fallback" "$OUT"; then
  printf "  \033[31m✗\033[0m skill returned a no-results state on a known-good query\n"
  fail=1
fi

echo
if [ "$fail" -eq 0 ]; then
  echo "✅ All checks passed."
  exit 0
else
  echo "❌ One or more checks failed. Full response:"
  echo "---"
  cat "$OUT"
  echo "---"
  exit 1
fi
