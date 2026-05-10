# Mobbin UI Research Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Powered by Mobbin MCP](https://img.shields.io/badge/Powered%20by-Mobbin%20MCP-7c3aed)](https://mobbin.com)
[![Model Context Protocol](https://img.shields.io/badge/MCP-Compatible-1f2937?logo=anthropic&logoColor=white)](https://modelcontextprotocol.io)
[![Works with Claude Code](https://img.shields.io/badge/Claude%20Code-supported-d97706?logo=anthropic&logoColor=white)](https://www.anthropic.com/claude-code)
[![Works with Cursor](https://img.shields.io/badge/Cursor-supported-000000?logo=cursor&logoColor=white)](https://cursor.com)
[![Works with VS Code Copilot](https://img.shields.io/badge/VS%20Code%20Copilot-supported-007ACC?logo=githubcopilot&logoColor=white)](https://code.visualstudio.com/docs/copilot/overview)
[![GitHub stars](https://img.shields.io/github/stars/makindajack/mobbin-skill?style=social)](https://github.com/makindajack/mobbin-skill)

Turn [Mobbin](https://mobbin.com)'s 300K+ screen library into structured UI research. Give your agent a research goal — it searches Mobbin, visually analyzes the screenshots, and returns pattern clusters, design system components, or competitive comparisons.

Works with Claude Code, Cursor, Codex CLI, Gemini CLI, Cline, Goose, VS Code Copilot, Lovable, and any other MCP-compatible agent.

## Disclaimer

This is an independent, community-maintained skill — **not affiliated with Mobbin Inc., Anthropic, GitHub, Cursor, or any other product mentioned**. Compatibility badges describe technical interoperability only. Using the Mobbin MCP server means you're bound by [Mobbin's Terms of Service](https://mobbin.com/terms) — see [`docs/responsible-use.md`](docs/responsible-use.md) for what to avoid (account sharing, bulk caching, building competing products).

## Quick links

| I want to…                                       | Go here                                                |
| ------------------------------------------------ | ------------------------------------------------------ |
| **Install** the skill in my agent                | [`docs/install.md`](docs/install.md)                   |
| **Connect** the Mobbin MCP server                | [`docs/mcp-setup.md`](docs/mcp-setup.md)               |
| **See if my CLI is supported**                   | [`docs/compatibility.md`](docs/compatibility.md)       |
| **Try it in 30 seconds**                         | [`docs/quick-start.md`](docs/quick-start.md)           |
| **Understand cost / token use**                  | [`docs/cost-and-context.md`](docs/cost-and-context.md) |
| **Fix something that's broken**                  | [`docs/troubleshooting.md`](docs/troubleshooting.md)   |
| **See real input → output transcripts**          | [`examples/`](examples/)                               |
| **Use the MCP without losing my Mobbin account** | [`docs/responsible-use.md`](docs/responsible-use.md)   |
| **Read the skill itself**                        | [`SKILL.md`](SKILL.md)                                 |

## Why this fork?

This is a fork of [`ddruids/mobbin-skill`](https://github.com/ddruids/mobbin-skill) with the following additions:

- **Mode A / Mode B split** — a fast single-call lookup mode for "show me…" prompts, separate from the original multi-batch research mode.
- **Prompt templates** for 5 common use cases plus a slot cheatsheet ([`references/prompt-templates.md`](references/prompt-templates.md)).
- **Examples folder** with 5 real input → output transcripts.
- **Cost & context guidance** — mode/limit/payload table, `exclude_screen_ids` pattern, `image_format: webp` default ([`docs/cost-and-context.md`](docs/cost-and-context.md)).
- **Fallback rule** for weak results: auto-broaden → swap mode → honest report instead of padding output.
- **Behavior anti-patterns** catalog ([`references/anti-patterns.md`](references/anti-patterns.md)).
- **Pre-configured client files** for 7 tools — see [`clients/`](clients/).
- **`validate.sh`** sanity check + `CONTRIBUTING.md` + GitHub issue templates + Mobbin-ToS responsible-use guidance.

If you want the original skill as-is, install [`ddruids/mobbin-skill`](https://github.com/ddruids/mobbin-skill) instead.

## What it does

- Translates abstract UX goals into concrete Mobbin search queries
- Visually analyzes returned screenshots (layout, hierarchy, components, color)
- Clusters findings into recurring UI patterns with linked references
- Surfaces atomic design system primitives when asked about components
- Supports three output modes: research summary, competitive comparison, product decision log

## 30-second install

1. **Connect the MCP server** — see [`docs/mcp-setup.md`](docs/mcp-setup.md). For most clients it's a single command pointing at `https://api.mobbin.com/mcp`.
2. **Drop the skill into your agent** — pick your tool from [`docs/install.md`](docs/install.md). For Claude Code:

   ```bash
   npx skills add https://github.com/makindajack/mobbin-skill
   ```

3. **Try it** — paste a [Quick Start prompt](docs/quick-start.md) like:

   ```
   Show me 5 iOS fintech onboarding screens that use a phone number input and a progress indicator.
   ```

## Credits

- Original skill by **[ddruids/mobbin-skill](https://github.com/ddruids/mobbin-skill)** — the foundation this fork builds on.
- Maintained in this fork by **[@makindajack](https://github.com/makindajack)**. Additions on top of the original:
  - **Mode-aware workflow** (Mode A discovery vs Mode B deep-dive) with cost-conscious defaults.
  - **11-CLI compatibility matrix** and per-client install paths (Claude Code, Cursor, Codex, Gemini, Cline, Goose, Copilot CLI, VS Code Copilot, Lovable, plus warnings for non-MCP tools).
  - **VS Code Copilot prompt** (`/mobbin`) and Copilot CLI MCP wiring.
  - **`docs/` split** — install, MCP setup, quick-start, compatibility, cost & context, responsible use, troubleshooting (6 common failure modes with fixes).
  - **Reusable prompt templates** and worked examples for fintech, crypto, and design-system research.
  - **Cost & context guidance** — payload-size table, image-handling tips, screen-id exclusion patterns.
  - **Responsible-use notes** aligned with Mobbin ToS (no account-sharing, bulk download, derivative works).
  - **`validate.sh --doctor`** — offline environment health check (MCP host CLIs, Mobbin wiring, endpoint reachability, skill install).
  - **CI hardening** — `shellcheck` + `gitleaks` (security) and `markdownlint` + `lychee` link-check (docs).
  - **`SECURITY.md`** with private vulnerability reporting via GitHub Security Advisories.
- Powered by the [Mobbin MCP server](https://mobbin.com) and the [Model Context Protocol](https://modelcontextprotocol.io).
- Contributions welcome — see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT — see [`LICENSE`](LICENSE).
