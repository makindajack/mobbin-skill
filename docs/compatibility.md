# Compatibility

The skill is just markdown, so any agent that loads custom instructions can read it. To actually call `search_screens` you need an **MCP-capable** host — the table below lists what works end-to-end.

| CLI / agent          | Loads `SKILL.md` | MCP support | End-to-end | Notes                                                                         |
| -------------------- | ---------------- | ----------- | ---------- | ----------------------------------------------------------------------------- |
| Claude Code          | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/claude/`                                             |
| Cursor               | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/cursor/`                                             |
| Codex CLI (OpenAI)   | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/codex/`                                              |
| Gemini CLI (Google)  | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/gemini/`                                             |
| Cline (VS Code ext.) | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/cline/`                                              |
| Goose (Block)        | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/goose/`                                              |
| VS Code Copilot      | ✅               | ✅          | ✅ yes     | Pre-configured: `clients/copilot/` (works for Copilot Chat _and_ Copilot CLI) |
| Lovable              | ✅               | ✅          | ✅ yes     | Manual: paste into custom instructions                                        |
| Aider                | ✅               | ❌          | ⚠️ no      | Loads writing rules with `--read SKILL.md` but can't call Mobbin              |
| `llm` CLI            | ✅               | ❌          | ⚠️ no      | System-prompt only; no MCP host                                               |
| Plain Ollama         | ✅               | ❌          | ⚠️ no      | System-prompt only; no MCP host                                               |

If your CLI isn't listed but supports MCP, copy [`SKILL.md`](../SKILL.md) into whatever file it uses for system instructions and configure the [Mobbin MCP server](mcp-setup.md) per its docs.
