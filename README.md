# Mobbin UI Research Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Powered by Mobbin MCP](https://img.shields.io/badge/Powered%20by-Mobbin%20MCP-7c3aed)](https://mobbin.com)
[![Model Context Protocol](https://img.shields.io/badge/MCP-Compatible-1f2937?logo=anthropic&logoColor=white)](https://modelcontextprotocol.io)
[![Works with Claude Code](https://img.shields.io/badge/Claude%20Code-supported-d97706?logo=anthropic&logoColor=white)](https://www.anthropic.com/claude-code)
[![Works with Cursor](https://img.shields.io/badge/Cursor-supported-000000?logo=cursor&logoColor=white)](https://cursor.com)
[![Works with VS Code Copilot](https://img.shields.io/badge/VS%20Code%20Copilot-supported-007ACC?logo=githubcopilot&logoColor=white)](https://code.visualstudio.com/docs/copilot/overview)
[![GitHub stars](https://img.shields.io/github/stars/makindajack/mobbin-skill?style=social)](https://github.com/makindajack/mobbin-skill)

Turn [Mobbin](https://mobbin.com)'s 300K+ screen library into structured UI research. Give your agent a research goal — it searches Mobbin, visually analyzes the screenshots, and returns pattern clusters, design system components, or competitive comparisons.

Works with Claude Code, Cursor, Gemini CLI, Lovable, and any MCP-compatible agent.

## What it does

- Translates abstract UX goals into concrete Mobbin search queries
- Visually analyzes returned screenshots (layout, hierarchy, components, color)
- Clusters findings into recurring UI patterns with linked references
- Surfaces atomic design system primitives when asked about components
- Supports three output modes: research summary, competitive comparison, product decision log

## Install

Requires [Mobbin MCP](#setup-mobbin-mcp) to be connected first.

The skill is just markdown — install it however your agent loads custom instructions.

| Client                 | Install method                                                                                                  |
| ---------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Claude Code**        | `npx skills add https://github.com/ddruids/mobbin-skill` <br>_or_ symlink the repo into `~/.claude/skills/`     |
| **Cursor**             | Copy [`SKILL.md`](SKILL.md) into `.cursor/rules/mobbin.mdc` (project) or `~/.cursor/rules/` (global)            |
| **VS Code (Copilot)**  | Save [`SKILL.md`](SKILL.md) as `mobbin.prompt.md` in `~/Library/Application Support/Code/User/prompts/` (macOS) |
| **Codex CLI**          | Drop the repo into `~/.codex/skills/mobbin/`                                                                    |
| **Gemini CLI**         | Reference [`SKILL.md`](SKILL.md) in your `GEMINI.md` system prompt                                              |
| **Lovable**            | Paste the contents of [`SKILL.md`](SKILL.md) into your project's custom instructions                            |
| **Any MCP-compatible** | Copy [`SKILL.md`](SKILL.md) contents into your agent's system prompt or rules file                              |

> **Note:** `npx skills add` only works with agents that support the [skills CLI](https://github.com/anthropics/skills) — currently Claude Code. Other clients need a manual copy.

## Quick Start

After installing the skill and connecting Mobbin MCP, paste any of these prompts into your agent to see it working in under 30 seconds.

### 1. See 5 examples fast

```
Show me 5 iOS fintech onboarding screens that use a phone number input and a progress indicator.
```

**You'll get:** A short comparison table of 5 real apps (e.g., Chime, Fi, Afterpay) with linked Mobbin URLs and a one-line note on each layout.

### 2. Research a pattern across a category

```
Research how crypto wallet apps handle send/transfer confirmation on iOS. Focus on trust, fee transparency, and recovery from mistakes.
```

**You'll get:** A `Mobbin Research Summary` with pattern clusters (e.g., "Pre-confirmation summary card", "Slide-to-confirm gesture"), key observations, and reusable patterns — every reference linked to its Mobbin screen.

### 3. Extract a design system

```
What components do I need for a crypto wallet design system? Decompose into atomic primitives, not screen patterns.
```

**You'll get:** A list of atomic primitives like `Truncated Address`, `Token Icon`, `Currency Display`, `Fee Breakdown Row`, `Slide-to-Confirm` — each with variants and the apps that use them.

> **Tip:** If you ask vague questions like _"good onboarding"_ or _"trust patterns"_, the skill will rewrite them into concrete visual queries before searching. Use specific UI language for best results.

> **Need more starter prompts?** See [`references/prompt-templates.md`](references/prompt-templates.md) for fill-in-the-blank templates covering quick lookup, pattern research, competitive comparison, design system extraction, and decision support — plus a slot cheatsheet of categories, screen types, and components.

## Cost & context use

`search_screens` returns inline images (base64) alongside metadata. Image payload dominates token cost.

| Mode   | Limit | Approx. images | Approx. payload | When to use                                                                        |
| ------ | ----- | -------------- | --------------- | ---------------------------------------------------------------------------------- |
| `fast` | 5     | 5              | ~1–2 MB         | Quick lookup, exploratory "show me" prompts                                        |
| `fast` | 10    | 10             | ~2–4 MB         | Slightly broader scan, still cheap                                                 |
| `deep` | 10–15 | 10–15          | ~4–6 MB         | Focused research on one screen moment                                              |
| `deep` | 20–30 | 20–30          | ~8–12 MB        | Broad pattern research — may push smaller agents toward their context window limit |

Tips to keep cost down:

- Default to `mode: "fast"` and `limit: 5–10` unless the user explicitly asks for deep research.
- Pass prior result IDs via `exclude_screen_ids` on follow-up calls instead of re-running broader queries:
  ```json
  search_screens({
    "platform": "ios",
    "query": "crypto wallet send confirmation with address and fee",
    "mode": "deep",
    "limit": 10,
    "exclude_screen_ids": ["ed7a0522-...", "18700191-..."]
  })
  ```
- Use `image_format: "jpg"` only if your client doesn't render webp — webp is smaller.
- Analyze each batch as text immediately so older base64 images can drop out of context.

## Usage

Once installed, the skill activates when you ask about UI research, screen patterns, or design system components:

```
"Research how fintech apps handle onboarding"
"Compare how crypto wallets display transaction confirmation"
"What are common components for a SaaS dashboard design system?"
"How do AI apps handle empty states on iOS?"
```

The skill automatically:

1. Resolves the target platform (iOS or web)
2. Generates 3-7 concrete search queries
3. Calls Mobbin's `search_screens` with `mode: "deep"`
4. Analyzes the returned screenshots
5. Synthesizes findings into structured output with Mobbin URLs

## What's inside

| File                                                                     | Purpose                                                                                                |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| [`SKILL.md`](SKILL.md)                                                   | Core skill — query construction, analysis framework, output formats, design system component mode      |
| [`examples/`](examples/)                                                 | 5 real input → output transcripts: quick lookup, pattern research, comparison, design system, recovery |
| [`references/prompt-templates.md`](references/prompt-templates.md)       | Fill-in-the-blank prompt templates by use case, plus a slot cheatsheet of common values                |
| [`references/query-patterns.md`](references/query-patterns.md)           | Query formula, platform-specific guidance, 20+ example queries by category                             |
| [`references/synthesis-framework.md`](references/synthesis-framework.md) | 8 analysis lenses, 3 output templates (research summary, competitive comparison, product decision log) |

---

<details id="setup-mobbin-mcp">
<summary><strong>Setup Mobbin MCP</strong></summary>

1. Sign up at [mobbin.com](https://mobbin.com)
2. Go to [**Settings → MCP**](https://mobbin.com/settings/mcp) (or click your profile icon top right → **Settings** → **MCP**)
3. Select your tool and follow the instructions, or use one of these:

> **Mobbin account & plan tiers**
>
> - You need a **Mobbin account** to use the MCP server (free signup at [mobbin.com](https://mobbin.com)).
> - **Free tier:** limited daily searches and a smaller subset of the screen library. Fine for trying the skill out.
> - **Paid plans (Pro / Team):** higher search quotas, full library access, and the depth needed for serious research workflows like Mode B (Full Research) or design system extraction.
> - Mobbin sets and changes these limits — check your plan page in Settings for current quotas. This skill makes no guarantees about Mobbin's pricing or quotas.

**Claude Code:**

```bash
claude mcp add mobbin \
  --transport http https://api.mobbin.com/mcp
```

**Cursor:**

```json
{
  "mcpServers": {
    "mobbin": {
      "serverUrl": "https://api.mobbin.com/mcp"
    }
  }
}
```

**Codex:**

```bash
codex mcp add mobbin --url https://api.mobbin.com/mcp
```

**Lovable:**

```
https://api.mobbin.com/mcp
```

</details>

## Credits

- Original skill by **[ddruids/mobbin-skill](https://github.com/ddruids/mobbin-skill)** — the foundation this fork builds on.
- Maintained in this fork by **[@makindajack](https://github.com/makindajack)** with UX improvements, mode-aware workflow, prompt templates, examples, and cost guidance.
- Powered by the [Mobbin MCP server](https://mobbin.com) and the [Model Context Protocol](https://modelcontextprotocol.io).
- Contributions welcome — open an issue using the templates in `.github/ISSUE_TEMPLATE/`.

## License

MIT
