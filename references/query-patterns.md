# Mobbin Query Patterns

## Query Formula

```
[product category] + [screen type] + [visible UI components] + [user state/action]
```

Each query should describe what a person would see on screen. Maximum 500 characters. Use `mode: "deep"` for nuanced queries, `mode: "fast"` for quick lookups.

## Platform-Specific Guidance

### iOS Queries

iOS apps use mobile-native patterns. Include these when relevant:

- Bottom sheets, action sheets, half-modals
- Tab bar navigation, swipe gestures
- Pull-to-refresh, floating action buttons
- System-style alerts and permission dialogs
- Full-screen takeovers for onboarding

### Web Queries

Web apps use browser-native patterns. Include these when relevant:

- Sidebar navigation, top navigation bar, breadcrumbs
- Modals, drawers, popovers, dropdown menus
- Multi-column layouts, data tables, dashboards
- Toast notifications, inline validation
- Sticky headers, scroll-based interactions

## Example Queries by Goal

### Onboarding

- "fintech signup screen with phone number input progress indicator security message and continue button"
- "AI app onboarding screen asking user goal with selectable cards and continue button"
- "AI chat welcome screen with suggested prompts and empty conversation state"
- "AI assistant setup screen with permissions integrations and progress steps"
- "SaaS onboarding checklist with completed and pending steps progress bar and skip option"

### Empty States

- "SaaS dashboard empty state with illustration explanatory text primary CTA and secondary link"
- "inbox empty state with illustration and suggested actions"
- "search results empty state with alternative suggestions and filters"

### Error States

- "payment failed screen with error message retry button support link and transaction details"
- "network error screen with retry button offline indicator and cached content"
- "form validation error state with inline error messages and highlighted fields"

### Progress and Pending States

- "transfer pending screen with amount recipient estimated arrival time progress tracker and help link"
- "file upload progress screen with progress bar cancel button and file details"
- "order tracking screen with timeline status steps estimated delivery and contact support"

### Confirmation Screens

- "crypto withdrawal confirmation screen with recipient address network fee warning text and confirm button"
- "money transfer confirmation screen with fee breakdown recipient details and confirm button"
- "subscription upgrade confirmation with plan comparison price change and billing date"

### Success States

- "payment success screen with receipt transaction ID and share button"
- "account created success screen with next steps checklist and primary CTA"
- "transfer completed screen with transaction summary download receipt and done button"

### Settings

- "notification settings screen with grouped toggles channels frequency controls and save button"
- "privacy settings screen with data sharing toggles delete account option and explanation text"
- "security settings screen showing recovery phrase backup option and warning banner"

### Wallet and Crypto

- "crypto wallet seed phrase backup screen with warning text and continue button"
- "wallet recovery phrase confirmation screen with numbered words and validation error"
- "crypto portfolio dashboard with token balances price charts and send receive buttons"

### Fintech Transfers

- "bank transfer pending screen showing amount recipient estimated arrival time and progress status"
- "international transfer screen with exchange rate fee breakdown and delivery estimate"
- "recurring payment setup screen with frequency amount date and recipient fields"

## Multi-Batch Research

For broad research topics, use `exclude_screen_ids` to get fresh results across multiple calls:

1. Run the first search with `limit: 20`.
2. Collect the screen IDs from the results.
3. Pass them as `exclude_screen_ids` in the next call with a varied query.
4. Repeat to build a diverse set of references.

This is useful when the user wants comprehensive coverage across many apps rather than the top results for a single query.

### Copy-paste example

First call:

```json
search_screens({
  "platform": "ios",
  "query": "crypto wallet send transaction confirmation screen with recipient address amount fee breakdown and confirm button",
  "mode": "deep",
  "limit": 15
})
```

Collect the `id` of every result, then run a varied follow-up that excludes them:

```json
search_screens({
  "platform": "ios",
  "query": "crypto wallet swap confirmation screen with token pair slippage and price impact warning",
  "mode": "deep",
  "limit": 15,
  "exclude_screen_ids": [
    "729b8463-bbc5-4ef0-a58c-b833985dfcb2",
    "5f99db5f-92dd-4d01-b841-b1dbc6fd7258",
    "676d6d79-fb58-4dff-a517-af056631e589"
  ]
})
```

This avoids re-fetching the same screens (saving context + tokens) and forces the corpus to surface fresh examples.

## Don't do this

The most common reason `search_screens` returns weak results is an abstract, jargon-heavy query. Always rewrite into concrete visual language before calling.

| ❌ Bad query                             | ✅ Fixed query                                                                                                     |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `"good onboarding for crypto apps"`      | `"crypto wallet welcome screen with seed-phrase backup CTA, biometric setup option, and skip link"`                |
| `"trust patterns for fintech transfers"` | `"fintech transfer confirmation screen with itemized fee breakdown, recipient summary card, and confirm button"`   |
| `"a really clean SaaS dashboard"`        | `"web SaaS analytics dashboard with sidebar navigation, KPI cards, line chart, data table, and date-range filter"` |

Anti-patterns to avoid:

- **Subjective adjectives** ("clean", "modern", "slick", "good", "best") — the search engine can't see aesthetics, only described elements.
- **Product theory** ("trust", "conversion", "engagement", "retention") — these are outcomes, not visible UI elements.
- **Stacking 4+ niche concepts** ("rejection screen with personalized counter-offer and soft-credit-pull explainer") — split into two queries instead. See `examples/05-recovery-from-bad-query.md`.
- **Naming a single screen type with no components** ("a settings screen") — too broad; add 2–3 visible elements to focus the search.
