# Mobbin UI Research Skill

A Claude Code skill that turns [Mobbin](https://mobbin.com)'s 300K+ screen library into structured UI research. Give it a research goal — it searches Mobbin, visually analyzes the screenshots, and returns pattern clusters, design system components, or competitive comparisons.

## What it does

- Translates abstract UX goals into concrete Mobbin search queries
- Visually analyzes returned screenshots (layout, hierarchy, components, color)
- Clusters findings into recurring UI patterns with linked references
- Surfaces atomic design system primitives when asked about components
- Supports three output modes: research summary, competitive comparison, product decision log

## Install

Requires [Mobbin MCP](#setup-mobbin-mcp) to be connected first.

### Claude Code

```bash
claude skill add --url https://github.com/ddruids/mobbin-skill
```

### Cursor / Windsurf

Copy the `SKILL.md` and `references/` folder into your project's `.cursor/skills/` or equivalent directory.

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

Go to **Settings** in your editor, click **MCP**, and select Mobbin from the list. You'll see setup instructions there.

</details>

## License

MIT
