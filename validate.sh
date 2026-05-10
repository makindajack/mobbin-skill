#!/usr/bin/env bash
# validate.sh — Sanity check the skill against the live Mobbin MCP.
#
# Modes:
#   ./validate.sh             # default: live end-to-end test (consumes a Mobbin search)
#   ./validate.sh --doctor    # offline-ish env check: no API call, no skill execution
#   ./validate.sh --help
#
# Live mode does:
#   1. Asks your default Claude Code session to run a known Mode A query.
#   2. Greps the response for required output elements:
#      - a markdown table header (`| App |`)
#      - at least one `mobbin.com/screens/` link
#      - the Mode A escalation offer ("deeper pattern analysis")
#      - and that the skill did not silently fall back to "no relevant results"
#   3. Exits non-zero if any check fails.
#
# Doctor mode does:
#   1. Verifies `claude` (or another MCP host) is installed.
#   2. Confirms the Mobbin MCP server is configured for at least one host.
#   3. Pings https://api.mobbin.com to confirm DNS/reachability (no auth).
#   4. Looks for the skill in known install locations.
#   5. Reports what's wired and what isn't, with fix suggestions.
#
# Prereqs (live mode):
#   - `claude` CLI installed and authenticated
#   - Mobbin MCP configured (`claude mcp list | grep mobbin`)
#   - This skill installed (`claude skills list | grep mobbin`)

set -euo pipefail

GREEN=$'\033[32m'
RED=$'\033[31m'
YEL=$'\033[33m'
RST=$'\033[0m'

ok()   { printf "  ${GREEN}\xe2\x9c\x93${RST} %s\n" "$1"; }
bad()  { printf "  ${RED}\xe2\x9c\x97${RST} %s\n" "$1"; fail=1; }
warn() { printf "  ${YEL}\xe2\x9a\xa0${RST}  %s\n" "$1"; }

usage() {
  sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'
  exit 0
}

doctor() {
  fail=0
  echo "Doctor: checking environment (no API calls will be made)"
  echo

  echo "1. MCP host CLIs"
  local found_host=0
  for cli in claude copilot cursor codex gemini goose; do
    if command -v "$cli" >/dev/null 2>&1; then
      ok "$cli installed ($(command -v "$cli"))"
      found_host=1
    fi
  done
  [ "$found_host" -eq 0 ] && bad "no MCP-capable CLI found (install one of: claude, copilot, cursor, codex, gemini, goose)"
  echo

  echo "2. Mobbin MCP configured (only one host needs it)"
  local found_mcp=0
  if command -v claude >/dev/null 2>&1 && claude mcp list 2>/dev/null | grep -qi mobbin; then
    ok "claude has 'mobbin' MCP server"
    found_mcp=1
  fi
  if command -v copilot >/dev/null 2>&1 && copilot mcp list 2>/dev/null | grep -qi mobbin; then
    ok "copilot has 'mobbin' MCP server"
    found_mcp=1
  fi
  local vscode_mcp="$HOME/Library/Application Support/Code/User/mcp.json"
  if [ -f "$vscode_mcp" ] && grep -qi mobbin "$vscode_mcp"; then
    ok "VS Code mcp.json has 'mobbin'"
    found_mcp=1
  fi
  if [ "$found_mcp" -eq 0 ]; then
    bad "no host has Mobbin MCP wired — see docs/mcp-setup.md for one-line setup"
  fi
  echo

  echo "3. Mobbin endpoint reachable"
  if command -v curl >/dev/null 2>&1; then
    local code
    code=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 5 https://api.mobbin.com/mcp || echo "000")
    case "$code" in
      000) bad "could not reach https://api.mobbin.com/mcp (network / DNS / firewall?)";;
      2*|3*|4*) ok "https://api.mobbin.com/mcp responded with HTTP $code";;
      5*) warn "https://api.mobbin.com/mcp responded with HTTP $code (Mobbin server-side issue?)";;
    esac
  else
    warn "curl not installed — skipping reachability check"
  fi
  echo

  echo "4. Skill installed locally"
  local found_skill=0
  for path in \
    "$HOME/.claude/skills/mobbin/SKILL.md" \
    "$HOME/.claude/skills/mobbin-skill/SKILL.md" \
    "$HOME/.cursor/rules/mobbin.mdc" \
    "$PWD/.cursor/rules/mobbin.mdc" \
    "$PWD/AGENTS.md" \
    "$PWD/GEMINI.md" \
    "$PWD/.clinerules/mobbin.md" \
    "$PWD/.goosehints" \
    "$HOME/Library/Application Support/Code/User/prompts/mobbin.prompt.md"
  do
    if [ -e "$path" ]; then
      ok "found: $path"
      found_skill=1
    fi
  done
  [ "$found_skill" -eq 0 ] && warn "skill not detected in any known install location — see docs/install.md"
  echo

  if [ "${fail:-0}" -eq 0 ]; then
    printf "%b\n" "${GREEN}Doctor: environment looks healthy.${RST}"
    echo "Run \`./validate.sh\` (no flag) to do a live end-to-end test against Mobbin."
    exit 0
  else
    printf "%b\n" "${RED}Doctor: one or more checks failed. See messages above.${RST}"
    exit 1
  fi
}

live_test() {
  if ! command -v claude >/dev/null 2>&1; then
    echo "ERROR: claude CLI not found. Install Claude Code, or run \`./validate.sh --doctor\` instead." >&2
    exit 2
  fi

  local prompt='Show me 5 iOS food delivery checkout screens with order summary and place order button.'
  local out
  out=$(mktemp)
  trap 'rm -f "$out"' EXIT

  echo "Live test: running a Mode A query against the skill (consumes one Mobbin search)…"
  claude --print "$prompt" > "$out"

  fail=0
  check() {
    local label="$1" pattern="$2"
    if grep -qE "$pattern" "$out"; then ok "$label"; else bad "$label"; fi
  }

  check "table header present"     '\| *App *\|'
  check "at least one Mobbin link" 'mobbin\.com/screens/[0-9a-f-]+'
  check "escalation offer"         '[Dd]eeper pattern analysis'

  if grep -qi "no relevant results\|no matches" "$out" && ! grep -qi "fallback" "$out"; then
    bad "skill returned a no-results state on a known-good query"
  else
    ok "no silent no-results fallback"
  fi

  echo
  if [ "$fail" -eq 0 ]; then
    printf "%b\n" "${GREEN}\xe2\x9c\x85 All checks passed.${RST}"
    exit 0
  else
    printf "%b\n" "${RED}\xe2\x9d\x8c One or more checks failed. Full response:${RST}"
    echo "---"
    cat "$out"
    echo "---"
    exit 1
  fi
}

case "${1:-}" in
  --help|-h) usage ;;
  --doctor)  doctor ;;
  "")        live_test ;;
  *)         echo "Unknown flag: $1" >&2; echo; usage ;;
esac
