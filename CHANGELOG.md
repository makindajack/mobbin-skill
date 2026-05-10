# Changelog

All notable changes to this skill are documented here.
The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.2.0] — 2026-05-10

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

## [0.1.0] — Initial release

- Core `SKILL.md` covering query construction, platform resolution, workflow, output format, and design system component mode.
- `references/query-patterns.md` with the query formula and example catalog.
- `references/synthesis-framework.md` with 8 analysis lenses and 3 output templates.
