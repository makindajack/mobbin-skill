# Quick Start

After [installing the skill](install.md) and [connecting Mobbin MCP](mcp-setup.md), paste any of these prompts into your agent to see it working in under 30 seconds.

## 1. See 5 examples fast

```
Show me 5 iOS fintech onboarding screens that use a phone number input and a progress indicator.
```

**You'll get:** A short comparison table of 5 real apps (e.g., apps like Chime, Fi, or Revolut — actual results vary per query) with linked Mobbin URLs and a one-line note on each layout.

## 2. Research a pattern across a category

```
Research how crypto wallet apps handle send/transfer confirmation on iOS. Focus on trust, fee transparency, and recovery from mistakes.
```

**You'll get:** A `Mobbin Research Summary` with pattern clusters (e.g., "Pre-confirmation summary card", "Slide-to-confirm gesture"), key observations, and reusable patterns — every reference linked to its Mobbin screen.

## 3. Extract a design system

```
What components do I need for a crypto wallet design system? Decompose into atomic primitives, not screen patterns.
```

**You'll get:** A list of atomic primitives like `Truncated Address`, `Token Icon`, `Currency Display`, `Fee Breakdown Row`, `Slide-to-Confirm` — each with variants and the apps that use them.

> **Tip:** If you ask vague questions like _"good onboarding"_ or _"trust patterns"_, the skill will rewrite them into concrete visual queries before searching. Use specific UI language for best results.

> **Need more starter prompts?** See [`references/prompt-templates.md`](../references/prompt-templates.md) for fill-in-the-blank templates covering quick lookup, pattern research, competitive comparison, design system extraction, and decision support — plus a slot cheatsheet of categories, screen types, and components.

## How the skill activates

Once installed, the skill activates whenever you ask about UI research, screen patterns, or design system components. Example prompts:

```
"Research how fintech apps handle onboarding"
"Compare how crypto wallets display transaction confirmation"
"What are common components for a SaaS dashboard design system?"
"How do AI apps handle empty states on iOS?"
```

The skill automatically:

1. Resolves the target platform (iOS or web)
2. Generates 3–7 concrete search queries
3. Calls Mobbin's `search_screens` with the right `mode`
4. Analyzes the returned screenshots
5. Synthesizes findings into structured output with Mobbin URLs

For an end-to-end transcript walkthrough, see [`examples/`](../examples/).
