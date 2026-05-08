# Mobbin UI Research Skill

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

```bash
npx skills add https://github.com/ddruids/mobbin-skill
```

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

| File | Purpose |
|------|---------|
| [`SKILL.md`](SKILL.md) | Core skill — query construction, analysis framework, output formats, design system component mode |
| [`references/query-patterns.md`](references/query-patterns.md) | Query formula, platform-specific guidance, 20+ example queries by category |
| [`references/synthesis-framework.md`](references/synthesis-framework.md) | 8 analysis lenses, 3 output templates (research summary, competitive comparison, product decision log) |

---

<details id="setup-mobbin-mcp">
<summary><strong>Setup Mobbin MCP</strong></summary>

1. Sign up at [mobbin.com](https://mobbin.com)
2. Click your profile icon (top right) → **Settings** → **MCP**
3. Select your tool and follow the instructions, or use one of these:

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

## License

MIT
