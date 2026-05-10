# Changelog

All notable changes to this skill are documented here.
The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.3] — 2026-05-10

### Added

- **`validate.sh --doctor`** — new offline mode that diagnoses _why_ the skill isn't working without consuming a Mobbin search. Checks installed MCP host CLIs (claude / copilot / cursor / codex / gemini / goose), confirms the Mobbin MCP server is wired up in at least one host, pings `https://api.mobbin.com/mcp` for reachability, and looks for the skill in known install paths. Directly addresses the most common user confusion: _"skill loaded but `search_screens` isn't in my tool list"_.
- **`SECURITY.md`** — reporting policy (private GitHub Security Advisories), triage expectations, scope.
- **`docs/troubleshooting.md`** — 6 common failure modes with fixes (MCP not wired, chat OOM from base64 images, rate limits, weak results, duplicate `/mobbin` slash command, `validate.sh` failures).
- **`.github/workflows/security.yml`** — `shellcheck` for `validate.sh` and `gitleaks` secret scan on push / PR / weekly.
- **`.github/workflows/docs.yml`** — `markdownlint-cli2` and `lychee` link-check on push / PR / weekly.
- **`.markdownlint-cli2.jsonc`** — lint config tuned for prose-heavy docs.

### Changed

- **`validate.sh`** rewritten with subcommand-style flags (`--doctor` / `--help` / no flag = live test). Fixed a no-op `check` line that silently never ran the no-padding assertion.
- **`.gitignore`** expanded from 2 lines to ~36 — covers OS noise, secret patterns (`.env*`, `*.pem`, `*.key`, `secrets.json`, `credentials.json`), per-tool local config (`.claude/`, `.cursor/`, `.copilot/`, `.codex/`, `.gemini/`, `.goose/`, `.aider*`), and build artifacts.
- **README Quick links** now points to `docs/troubleshooting.md`.
- **5 markdownlint MD031 violations** (missing blank lines around code fences in list items) fixed in `README.md` and `docs/cost-and-context.md`.

## [1.0.2] — 2026-05-10

### Added

- **Pre-configured drop-in files for 5 more CLIs** under `clients/`:
  - `clients/codex/AGENTS.md` (symlink) — Codex CLI auto-loads `AGENTS.md` from the project root.
  - `clients/gemini/GEMINI.md` (symlink) — Gemini CLI's project context file.
  - `clients/cline/.clinerules/mobbin.md` (symlink) — Cline (VS Code extension) project rules.
  - `clients/goose/.goosehints` (symlink) — Goose project hints file.
  - `clients/copilot/mobbin.prompt.md` — VS Code Copilot Chat / Copilot CLI prompt file with `mode: agent` frontmatter; invoke with `/mobbin`.
- **Compatibility section** in `README.md` listing 11 CLIs with `Loads SKILL.md` / `MCP support` / `End-to-end` columns, so users can see at a glance which agents work fully (Claude Code, Cursor, Codex, Gemini, Cline, Goose, VS Code Copilot, Lovable) vs. instructions-only (Aider, `llm`, plain Ollama).

### Changed

- **README install table** expanded with rows for Codex CLI, Gemini CLI, Cline, and Goose pointing to the new `clients/` files (replaces the previous hand-wavy "drop the repo into…" / "reference SKILL.md in your GEMINI.md" notes).
- **`clients/README.md`** index extended to document all 7 client folders (claude, cursor, codex, gemini, cline, goose, copilot) with install commands, plus a heads-up about MCP requirement.
- **VS Code Copilot install row** in the README install table now points to the pre-configured `clients/copilot/mobbin.prompt.md` (with `mode: agent` frontmatter) instead of telling users to rename `SKILL.md` themselves. Same file works for the GitHub Copilot CLI when symlinked into a project root.

## [1.0.1] — 2026-05-10

### Added

- **`validate.sh`** — sanity script that runs a known Mode A query through `claude` CLI and greps the output for required elements (table header, Mobbin link, escalation offer).
- **`clients/`** — pre-configured drop-in files: `clients/claude/skills/mobbin/SKILL.md` (symlink to root) and `clients/cursor/mobbin.mdc` (with required `.mdc` frontmatter pre-filled). Removes the manual file-conversion step.
- **`references/anti-patterns.md`** — catalog of skill behavior failure modes (padding weak results, asking for platform on every call, stacking everything into one Mode B call, ignoring `exclude_screen_ids`, treating Mobbin as generic image search, summarizing without linking) with symptom → cause → fix.
- **"Why this fork?"** subsection in `README.md` explaining what this fork adds vs upstream `ddruids/mobbin-skill`.

### Changed

- **README install table** Claude Code and Cursor rows now point to the new `clients/` files so users can copy/symlink directly without manual conversion.
- **README "What's inside"** table extended with `references/anti-patterns.md`, `clients/`, and `validate.sh`.

## [1.0.0] — 2026-05-10

First release of this fork. Includes the original skill from upstream `ddruids/mobbin-skill` (core `SKILL.md`, `references/query-patterns.md`, `references/synthesis-framework.md`) plus the additions and changes below.

### Added

- **Quick Start** section in `README.md` with 3 copy-pasteable example prompts and expected output snippets.
- **Per-client install table** in `README.md` covering Claude Code, Cursor, VS Code Copilot, Codex CLI, Gemini CLI, Lovable, and a generic MCP fallback. Clarified that `npx skills add` is Claude-Code-only.
- **Mode A (Quick Lookup)** workflow in `SKILL.md` — single `mode: "fast"` call for exploratory "show me" prompts. Default when intent is unclear.
- **Mode B (Full Research)** workflow in `SKILL.md` — original multi-batch synthesis, now explicitly trigger-gated.
- **`references/prompt-templates.md`** — fill-in-the-blank prompt templates for 5 use cases plus a slot cheatsheet (categories, screen types, components, focus areas).
- **Screen comparison table** as the lead element of Mode B output in `SKILL.md` and `references/synthesis-framework.md` Template A.
- **Fallback rule for weak results** in `SKILL.md`: auto-broaden once → swap mode → stop and report honestly with rephrasings, instead of padding output with off-topic results.
- **`examples/`** — 5 transcripts demonstrating Mode A, Mode B, competitive comparison, design system extraction, and recovery from a bad query, plus an `examples/README.md` index.
- **Cost & context use** section in `README.md` with a mode/limit/payload table and `exclude_screen_ids` + `image_format: "webp"` example.
- **Cost-saver parameters** documented in `SKILL.md` Mode B Workflow (`exclude_screen_ids`, `image_format` default of `webp`).
- `.gitignore` to keep local working notes (`TODO.md`, `.DS_Store`) out of the repo.
- `CHANGELOG.md`, GitHub issue templates (`bug_report.yml`, `feature_request.yml`, `config.yml`).
- **`CONTRIBUTING.md`** — issue routing, PR checklist, style, and scope guidance.
- **Plan-tier callout** in `README.md` Setup section: free vs Pro/Team Mobbin tiers and the note that Mobbin sets the actual quotas.
- **`exclude_screen_ids` copy-paste example** in `references/query-patterns.md` Multi-Batch Research subsection.
- **"Don't do this"** section in `references/query-patterns.md` with 3 bad → fixed query pairs and an anti-pattern checklist.
- **Badges** at the top of `README.md` (MIT, Mobbin MCP, MCP-compatible, Claude Code, Cursor, VS Code Copilot, GitHub stars).
- **Credits** section in `README.md` attributing the original `ddruids/mobbin-skill` repo and this fork's maintainer.
- **Disclaimer** section in `README.md` — independence statement, trademark notices, and screenshot ownership.
- **Responsible use of the Mobbin MCP** subsection in `README.md` covering the Mobbin ToS items most likely to trigger account suspension (no account sharing, no bulk download / mirroring, no derivative works or competitive products, screenshot crediting, no automated bulk crawlers). Inline account-sharing warning added to the Setup section.
- **GitHub Discussions link** in `.github/ISSUE_TEMPLATE/config.yml`.

### Changed

- **Platform Resolution** in `SKILL.md` now defaults to inference + a one-line disclosure (`Searching iOS (say "web" if you meant web apps)`) instead of asking. Added category-based defaults: consumer/mobile-first → ios; B2B/dashboard → web. Blocking questions reserved for truly ambiguous cases.
- **Claude Code install URL** in `README.md` install table now points to this fork (`makindajack/mobbin-skill`) with a note pointing to upstream `ddruids/mobbin-skill` for the original.
- **Quick Start example #1** expected-output line softened to "apps like Chime, Fi, or Revolut — actual results vary per query" so first-run users don't expect deterministic app names.
- **`SKILL.md` `description` frontmatter** trimmed from ~80 words of trigger phrases to a focused one-liner.
