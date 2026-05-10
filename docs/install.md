# Install

Requires the [Mobbin MCP server](mcp-setup.md) to be connected first.

The skill is just markdown — install it however your agent loads custom instructions. The `clients/` folder ships a pre-configured drop-in file for each supported tool so you don't have to reformat anything.

| Client                 | Install method                                                                                                                                                                                                                                              |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Claude Code**        | `npx skills add https://github.com/makindajack/mobbin-skill` <br>_or_ symlink `clients/claude/skills/mobbin/` into `~/.claude/skills/`                                                                                                                      |
| **Cursor**             | Copy [`clients/cursor/mobbin.mdc`](../clients/cursor/mobbin.mdc) into `.cursor/rules/` (project) or `~/.cursor/rules/` (global) — frontmatter pre-filled                                                                                                    |
| **Codex CLI**          | Copy [`clients/codex/AGENTS.md`](../clients/codex/AGENTS.md) into your project root                                                                                                                                                                         |
| **Gemini CLI**         | Copy [`clients/gemini/GEMINI.md`](../clients/gemini/GEMINI.md) into your project root                                                                                                                                                                       |
| **Cline** (VS Code)    | Copy [`clients/cline/.clinerules/mobbin.md`](../clients/cline/.clinerules/mobbin.md) into `.clinerules/` in your project                                                                                                                                    |
| **Goose**              | Copy [`clients/goose/.goosehints`](../clients/goose/.goosehints) into your project root                                                                                                                                                                     |
| **VS Code (Copilot)**  | Copy [`clients/copilot/mobbin.prompt.md`](../clients/copilot/mobbin.prompt.md) into `~/Library/Application Support/Code/User/prompts/` (macOS) — invoke with `/mobbin` in chat. Same file works for the **Copilot CLI** when symlinked into a project root. |
| **Lovable**            | Paste the contents of [`SKILL.md`](../SKILL.md) into your project's custom instructions                                                                                                                                                                     |
| **Any MCP-compatible** | Copy [`SKILL.md`](../SKILL.md) contents into your agent's system prompt or rules file                                                                                                                                                                       |

> **Note:** `npx skills add` only works with agents that support the [skills CLI](https://github.com/anthropics/skills) — currently Claude Code. Other clients need a manual copy.

> Want the **upstream** skill without this fork's Mode A/B, prompt templates, examples, or cost guidance? Install [`ddruids/mobbin-skill`](https://github.com/ddruids/mobbin-skill) instead.

See also:

- [`compatibility.md`](compatibility.md) — which CLIs work end-to-end vs. instructions-only.
- [`mcp-setup.md`](mcp-setup.md) — connecting the Mobbin MCP server.
- [`../clients/README.md`](../clients/README.md) — index of every pre-configured client file.
