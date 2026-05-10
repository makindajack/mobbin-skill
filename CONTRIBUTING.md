# Contributing

Thanks for considering a contribution. This skill is intentionally small — a few markdown files that teach an AI agent how to use the Mobbin MCP well. Keep changes minimal and focused.

## Before opening an issue

- For **Mobbin server / search quality / quota** problems, contact [Mobbin support](mailto:support@mobbin.com) — those aren't fixable here.
- For **skill behavior** issues (wrong output format, mode misfires, bad instructions), open a [bug report](.github/ISSUE_TEMPLATE/bug_report.yml).
- For **new modes, templates, or examples**, open a [feature request](.github/ISSUE_TEMPLATE/feature_request.yml).

## Before opening a PR

1. **Run the skill against your change.** Try at least one Mode A query and one Mode B query in your agent. Confirm output still matches the format documented in `SKILL.md`.
2. **Keep `SKILL.md` lean.** Every line is loaded into the agent's context on every invocation. Long reference content belongs in `references/`, not in `SKILL.md`.
3. **Never commit screenshots, base64 image dumps, or cached MCP responses.** They're large, they're not ours to redistribute (see Mobbin's [Terms](https://mobbin.com/terms) §10.3), and `.gitignore` already excludes the obvious ones.
4. **Update `CHANGELOG.md`** under `[Unreleased]` describing what changed and why.
5. **Update `examples/` if behavior changes.** If your change affects the output format, regenerate the relevant transcript with a real Mobbin call so it stays accurate.

## Style

- Markdown only. No build step.
- Prefer concrete visual language over abstract UX theory (the same rule the skill itself enforces).
- One topic per file in `references/`.
- Fence code blocks with language hints (` ```json `, ` ```bash `).

## Scope

This repo is a thin wrapper around the Mobbin MCP. Out of scope:

- Re-implementing or wrapping Mobbin's API directly.
- Caching or storing Mobbin screen data.
- Generic prompt-engineering tips unrelated to Mobbin / UI research.

If in doubt, open an issue first to check fit before writing the PR.
