# Pre-configured client files

Drop-in copies of `SKILL.md` formatted for specific clients. Saves you the file-conversion step in the README install table.

| Client          | File / location                                                                                                      | Install                                                                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Claude Code     | [`claude/skills/mobbin/SKILL.md`](claude/skills/mobbin/SKILL.md) (symlink to root `SKILL.md`)                        | `cp -R clients/claude/skills/mobbin ~/.claude/skills/` (or symlink the whole `claude/skills/mobbin/` directory)                                    |
| Cursor          | [`cursor/mobbin.mdc`](cursor/mobbin.mdc)                                                                             | Project: `cp clients/cursor/mobbin.mdc .cursor/rules/` <br>Global: `cp clients/cursor/mobbin.mdc ~/.cursor/rules/`                                 |
| Codex CLI       | [`codex/AGENTS.md`](codex/AGENTS.md) (symlink)                                                                       | Drop into your project root: `cp clients/codex/AGENTS.md ./AGENTS.md`                                                                              |
| Gemini CLI      | [`gemini/GEMINI.md`](gemini/GEMINI.md) (symlink)                                                                     | Drop into your project root: `cp clients/gemini/GEMINI.md ./GEMINI.md`                                                                             |
| Cline           | [`cline/.clinerules/mobbin.md`](cline/.clinerules/mobbin.md) (symlink)                                               | Project: `mkdir -p .clinerules && cp clients/cline/.clinerules/mobbin.md .clinerules/`                                                             |
| Goose           | [`goose/.goosehints`](goose/.goosehints) (symlink)                                                                   | Project: `cp clients/goose/.goosehints ./.goosehints`                                                                                              |
| VS Code Copilot | [`copilot/mobbin.prompt.md`](copilot/mobbin.prompt.md) (snapshot of `SKILL.md` body with VS Code prompt frontmatter) | `ln -sf "$PWD/clients/copilot/mobbin.prompt.md" "$HOME/Library/Application Support/Code/User/prompts/mobbin.prompt.md"` then invoke with `/mobbin` |

These files are kept in sync with the root `SKILL.md` — every entry except the Cursor `.mdc` and Copilot `.prompt.md` is a symlink. Cursor and Copilot need their own frontmatter, so they hold a copy of the body that should be re-synced when `SKILL.md` changes.

> **Heads-up:** all six clients above support MCP, which is required for `search_screens` to work. CLIs without MCP support (Aider, `llm`, plain Ollama) can load `SKILL.md` for the writing/output rules but won't be able to call Mobbin — see the **Compatibility** table in the root `README.md`.
