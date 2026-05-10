# Pre-configured client files

Drop-in copies of `SKILL.md` formatted for specific clients. Saves you the file-conversion step in the README install table.

| Client      | File / location                                                                               | Install                                                                                                            |
| ----------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Claude Code | [`claude/skills/mobbin/SKILL.md`](claude/skills/mobbin/SKILL.md) (symlink to root `SKILL.md`) | `cp -R clients/claude/skills/mobbin ~/.claude/skills/` (or symlink the whole `claude/skills/mobbin/` directory)    |
| Cursor      | [`cursor/mobbin.mdc`](cursor/mobbin.mdc)                                                      | Project: `cp clients/cursor/mobbin.mdc .cursor/rules/` <br>Global: `cp clients/cursor/mobbin.mdc ~/.cursor/rules/` |
| Codex CLI   | [`codex/AGENTS.md`](codex/AGENTS.md) (symlink)                                                | Drop into your project root: `cp clients/codex/AGENTS.md ./AGENTS.md`                                              |
| Gemini CLI  | [`gemini/GEMINI.md`](gemini/GEMINI.md) (symlink)                                              | Drop into your project root: `cp clients/gemini/GEMINI.md ./GEMINI.md`                                             |
| Cline       | [`cline/.clinerules/mobbin.md`](cline/.clinerules/mobbin.md) (symlink)                        | Project: `mkdir -p .clinerules && cp clients/cline/.clinerules/mobbin.md .clinerules/`                             |
| Goose       | [`goose/.goosehints`](goose/.goosehints) (symlink)                                            | Project: `cp clients/goose/.goosehints ./.goosehints`                                                              |

These files are kept in sync with the root `SKILL.md` — every entry except the Cursor `.mdc` is a symlink. Cursor adds the required `.mdc` frontmatter on top of the same content.

> **Heads-up:** all six clients above support MCP, which is required for `search_screens` to work. CLIs without MCP support (Aider, `llm`, plain Ollama) can load `SKILL.md` for the writing/output rules but won't be able to call Mobbin — see the **Compatibility** table in the root `README.md`.
