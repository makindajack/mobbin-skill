# Changelog

All notable changes to this skill are documented here.
The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- **Quick Start** section in `README.md` with 3 copy-pasteable example prompts and expected output snippets.
- **Per-client install table** in `README.md` covering Claude Code, Cursor, VS Code Copilot, Codex CLI, Gemini CLI, Lovable, and a generic MCP fallback. Clarified that `npx skills add` is Claude-Code-only.
- **Mode A (Quick Lookup)** workflow in `SKILL.md` — single `mode: "fast"` call for exploratory "show me" prompts. Default when intent is unclear.
- **Mode B (Full Research)** workflow in `SKILL.md` — original multi-batch synthesis, now explicitly trigger-gated.
- **`references/prompt-templates.md`** — fill-in-the-blank prompt templates for 5 use cases plus a slot cheatsheet (categories, screen types, components, focus areas).
- **Screen comparison table** as the lead element of Mode B output in `SKILL.md` and `references/synthesis-framework.md` Template A.
- **Fallback rule for weak results** in `SKILL.md`: auto-broaden once → swap mode → stop and report honestly with rephrasings, instead of padding output with off-topic results.
- **`examples/`** — 5 transcripts demonstrating Mode A, Mode B, competitive comparison, design system extraction, and recovery from a bad query.
- **Cost & context use** section in `README.md` with a mode/limit/payload table and `exclude_screen_ids` example.
- `.gitignore` to keep local working notes (`TODO.md`, `.DS_Store`) out of the repo.
- `CHANGELOG.md`, GitHub issue templates.

### Changed

- **Platform Resolution** in `SKILL.md` now defaults to inference + a one-line disclosure (`Searching iOS (say "web" if you meant web apps)`) instead of asking. Added category-based defaults: consumer/mobile-first → ios; B2B/dashboard → web. Blocking questions reserved for truly ambiguous cases.

## [0.1.0] — Initial release

- Core `SKILL.md` covering query construction, platform resolution, workflow, output format, and design system component mode.
- `references/query-patterns.md` with the query formula and example catalog.
- `references/synthesis-framework.md` with 8 analysis lenses and 3 output templates.
