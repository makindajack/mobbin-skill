---
name: mobbin-ui-research
description: "This skill should be used when the user needs UI/UX research, competitive screen analysis, or design pattern exploration using Mobbin MCP. Triggers on: Mobbin search, UI research, screen references, product flow research, pattern analysis, competitive UI audit, UX benchmarking, onboarding patterns, empty states, error states, confirmation screens, fintech UX, crypto UX, AI product patterns, SaaS dashboard patterns, ecommerce checkout patterns, or turning abstract product questions into concrete screen searches."
---

# Mobbin UI Research Skill

Help the user research UI patterns using Mobbin MCP. Mobbin exposes one tool:

- `search_screens` — AI-powered deep search that interprets natural language intent and returns real app screenshots with metadata.

## Core Rule

Translate abstract product or UX goals into concrete screen descriptions before calling `search_screens`. Describe what is visible on the screen, not abstract UX concepts.

Do not search:

- "trust patterns"
- "good onboarding"
- "transaction confidence"

Search:

- "signup screen with progress indicator, phone number input, security message, and continue button"
- "bank transfer pending screen showing amount, recipient, estimated arrival time, and progress indicator"
- "dashboard empty state with illustration, explanatory text, and primary call to action"

## Platform Resolution

The `platform` parameter is required on every call ("ios" or "web").

**Default behavior: infer and disclose, do not block on a question.** A round-trip question on every call is friction. Pick the most likely platform from the cues below and tell the user which one you chose in a single line, e.g.:

> _Searching iOS (say "web" if you meant web apps)._

Then continue with the search immediately.

1. **Explicit**: User says "mobile app", "iOS", "iPhone", "Android" → `ios`. User says "website", "web app", "SaaS", "desktop", "browser" → `web`. No disclosure needed.
2. **Inferrable from product name**: If the user names a product that is clearly one platform (e.g., "Stripe dashboard" → web, "Duolingo onboarding" → ios, "Notion" → web, "Cash App" → ios), infer silently.
3. **Inferrable from category**: If the category strongly implies a platform, infer with a one-line disclosure. Defaults:
   - Consumer/mobile-first categories (banking, crypto wallet, social, fitness, dating, messaging, ride-share, delivery) → **ios**
   - Productivity/B2B/dashboard categories (SaaS dashboard, CRM, analytics, admin, dev tools, design tools) → **web**
4. **Truly ambiguous**: Only ask when both platforms are equally plausible AND the answer would meaningfully change the result (e.g., "research checkout flows" with no other context). Prefer running both in parallel over asking.
5. **Both**: For cross-platform comparison, run separate searches per platform and note which results come from which in the synthesis.

The user can always correct you in the next turn — that's cheaper than a blocking question on the first turn.

## Workflow

Pick the right depth for the user's question. Doing the full research workflow on a casual "show me…" question wastes time and tokens; doing a quick lookup on a "research…" question gives a shallow answer.

### Mode A — Quick Lookup (single fast call)

Use this when the user just wants to **see examples**, not a synthesis. Trigger phrases:

- "show me…", "show some…", "find me…"
- "examples of…", "what does X look like"
- "any apps that do X?"
- Single screen type, no comparison or framework requested

Steps:

1. Resolve platform (per Platform Resolution rules above).
2. Write **one** concrete query covering the request.
3. Call `search_screens` with `mode: "fast"` and `limit: 5–10`.
4. Return a short comparison table: `App | Pattern | Notable detail | Mobbin link` — no pattern clusters, no recommendations section.
5. End with a one-liner: _"Want me to do a deeper pattern analysis on these?"_

### Mode B — Full Research (multi-batch synthesis)

Use this when the user wants understanding, not just examples. Trigger phrases:

- "research…", "analyze…", "what patterns…"
- "compare…", "competitive audit…"
- "what should I do for…", "help me design…"
- "design system", "common components", "primitives"

Steps:

1. Understand the user's research goal.
2. Resolve the target platform.
3. Break the goal into concrete UI moments (specific screens a user would see).
4. Generate 3–7 search queries using the query construction rules below.
5. Run searches in batches of 2–3 and **analyze each batch immediately** — write down app names, URLs, and key observations as text before moving to the next batch. Screenshots are large and will be dropped from context if you accumulate too many before synthesizing.
6. After all batches are analyzed, merge the per-batch notes into pattern clusters.
7. Synthesize what the patterns mean for product design.
8. Return actionable recommendations using the output format below.

For broad research, use `limit: 20-30`. For focused queries, `limit: 10-15` is sufficient. If the user wants more variety after an initial batch, pass prior result IDs via `exclude_screen_ids` to get fresh results.

**Important: analyze incrementally.** Do not accumulate all search results before writing. Each batch of screenshots consumes significant context. Write your visual analysis (app names, URLs, layout observations, component notes) as text immediately after each batch returns. Text persists through context compaction; base64 images do not.

### When the mode is unclear

Default to **Mode A (Quick Lookup)**. It's cheaper, and the user can always ask for deeper analysis on the results. Only escalate to Mode B without asking when the trigger phrases above are clearly present.

## Query Construction

Each query should include as many of these as relevant:

- **Product category**: fintech, crypto, banking, SaaS, AI, ecommerce, health, social
- **Screen type**: onboarding, dashboard, settings, confirmation, modal, empty state, error state
- **Visible components**: input field, progress bar, tabs, card, warning banner, timeline, bottom sheet
- **User action**: sign up, transfer money, connect wallet, confirm withdrawal
- **State**: loading, pending, failed, completed, empty, disabled
- **Trust elements**: security message, fee breakdown, confirmation checklist, support link

Queries must be under 500 characters. Use concrete visual language, not product theory.

See `references/query-patterns.md` for the full formula and example catalog with platform-specific tips.

## Working with Results

`search_screens` returns inline base64 images alongside metadata (app name, Mobbin URL, image URL).

- **Visually analyze each screen**: Examine layout, hierarchy, component placement, color usage, and interaction patterns. This visual analysis is the core value.
- **Attribute findings**: Every screen referenced in the output MUST include the app name and its Mobbin screen URL as a clickable markdown link (e.g., [Wise](https://mobbin.com/screens/...)). Never reference an app or screen without its URL.
- **Compare across results**: Look for recurring patterns, outliers, and platform-specific conventions.
- **Progressive depth**: Start with the strongest 3-5 queries. If results are thin, expand with additional queries or broaden search terms.

## Analysis Framework

For each useful result, analyze through these lenses (full detail in `references/synthesis-framework.md`):

1. **Screen Moment** — What part of the journey is this?
2. **User Job** — What is the user trying to accomplish?
3. **Information Hierarchy** — What appears first, second, last?
4. **Trust Mechanism** — How does the UI reduce uncertainty?
5. **Action Model** — What is the primary CTA? What is secondary?
6. **Progressive Disclosure** — What is hidden until needed?
7. **Recovery** — What happens when the user is blocked?
8. **Reusable Pattern** — What can be applied to the user's product?

## Output Format

Lead with a **screen comparison table** so the user can scan results before reading prose. Then layer the synthesis on top.

Use this structure by default:

```
# Mobbin Research Summary

## Research Goal
Briefly restate the goal.

## Searches Used
List the concrete Mobbin queries used and platform(s) searched.

## Screens Reviewed

| App | Pattern | Notable detail | Link |
|-----|---------|----------------|------|
| Chime | 3-step icon stepper signup | Legal disclosure inline with CTA | [Mobbin](https://mobbin.com/screens/...) |
| Fi    | Phone-first with custom keypad | Helper copy explains why phone is needed | [Mobbin](https://mobbin.com/screens/...) |
| ...   | ...                              | ...                                       | ...      |

One row per screen referenced in the synthesis. Every row MUST have a Mobbin link. Keep `Notable detail` to one short phrase.

## Pattern Clusters
Group the rows above into 2–5 recurring UI patterns. Each cluster names the pattern and lists the apps in it (linked).

## Key Observations
Explain what the screens reveal about product design thinking.

## UX Opportunities
Translate findings into design opportunities for the user's product.

## Recommendations
Give concrete, actionable design recommendations.

## Reusable Patterns
List reusable UI patterns the user can apply. Every app reference MUST link to its Mobbin screen URL.
```

If the user asks for a competitive comparison or product decision log, see the templates in `references/synthesis-framework.md`.

## Design System Component Research

When the user asks about **design system components**, **common components**, **UI kit**, or **component library** for a product category, shift the output from screen-level patterns to **atomic UI primitives**.

### Detection

Trigger this mode when the request includes phrases like: "design system", "component library", "common components", "UI kit", "what components do I need", "atoms", "primitives", "building blocks".

### How to analyze

After running searches, do NOT cluster by screen type (e.g., "Home Screen Pattern", "Swap Screen Pattern"). Instead, decompose each screen into its **individual reusable UI elements** — the atoms and molecules that appear across multiple screens and apps.

For each component, identify:

- **What it is**: A single, named primitive (e.g., "Token Icon", not "Portfolio Dashboard")
- **Variants**: Size, state, or style variations observed across apps
- **Where it appears**: Which screens and apps use it (with Mobbin URLs)
- **What makes it domain-specific**: Why this component wouldn't exist in a generic design system

### Output format for design system research

```
# Design System Components: [Category]

## Primitives

### [Component Name]
[One-line description of what the element is]
- **Variants**: [sizes, states, styles observed]
- **Seen in**: [App](url), [App](url) — [brief note on how each implements it]

### [Component Name]
...

## Domain-Specific Components
List components that are unique to this product category and would not exist in a generic design system.

## Standard Components with Domain Variants
List components that exist in any design system but need product-specific adaptations.
```

### Key distinction

- **Screen pattern** (wrong): "Send Transaction Screen — shows amount, address, fee, and confirm button"
- **Primitives** (right): `Truncated Address`, `Currency Display`, `Fee Breakdown Row`, `Slide-to-Confirm`, `Numeric Keypad` — each as independent, reusable atoms

Always decompose screens into their smallest reusable parts. A screen is a composition of primitives, not a component itself.

## Important Behavior

**Every screen or app mentioned in the output must include a clickable Mobbin URL.** No exceptions. If a screen's URL was not returned by the tool, do not reference that screen.

Do not only describe screens visually. Always synthesize the product thinking behind them.

Avoid: "Here are some nice references."
Prefer: "These examples reduce uncertainty by repeating critical transaction details before and after confirmation."

## Scope

This skill uses only `search_screens`. Do not reference or call any other Mobbin tools. Do not invent tools like `get_flow`, `get_screen`, or `compare_flows`.
