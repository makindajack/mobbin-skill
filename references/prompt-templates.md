# Prompt Templates

Fill-in-the-blank prompts you can paste into your agent. Replace anything in `[brackets]`.

If you don't know what to put in a slot, the [Slot Cheatsheet](#slot-cheatsheet) at the bottom lists common values.

---

## Quick Lookup (5–10 examples, no synthesis)

Use when you just want to see real screens fast.

```
Show me [N] [iOS|web] [category] [screen type] screens with [component or detail].
```

**Examples:**

```
Show me 5 iOS fintech onboarding screens with phone number input and progress indicator.
```

```
Show me 8 web SaaS dashboard empty states with illustration and primary CTA.
```

```
Find me 6 iOS crypto wallet send screens that include a fee breakdown.
```

---

## Pattern Research (multi-query synthesis)

Use when you want pattern clusters and recommendations.

```
Research how [iOS|web] [category] apps handle [screen moment]. Focus on [trust|recovery|hierarchy|onboarding|errors|...].
```

**Examples:**

```
Research how iOS crypto wallet apps handle send/transfer confirmation. Focus on trust, fee transparency, and recovery from mistakes.
```

```
Research how web SaaS apps onboard first-time users. Focus on time-to-value and progressive disclosure.
```

```
Research how iOS fintech apps communicate transfer status (pending, processing, completed, failed).
```

---

## Competitive Comparison

Use when you want a side-by-side of named apps or two approaches.

```
Compare how [iOS|web] [category] apps handle [screen moment]. Specifically look at [App A], [App B], and [App C] if available.
```

**Examples:**

```
Compare how iOS banking apps handle account creation. Specifically look at Chime, Revolut, and Cash App if available.
```

```
Compare how web AI chat apps present empty states and starter prompts.
```

---

## Design System Extraction

Use when you want atomic primitives, not screen patterns.

```
What design system primitives do [category] [iOS|web] apps share? Decompose into atomic components, not screen patterns.
```

**Examples:**

```
What design system primitives do crypto wallet iOS apps share? Decompose into atomic components, not screen patterns.
```

```
What components do I need for a fintech transfer flow design system on iOS?
```

```
List the atomic UI primitives shared across web SaaS dashboards (tables, filters, headers, empty states).
```

---

## Decision Support

Use when you're choosing between approaches for your own product.

```
I'm designing [feature] for a [category] [iOS|web] app. Research how leading apps solve [problem] and recommend an approach for me.
```

**Examples:**

```
I'm designing a recovery-phrase backup flow for a crypto wallet iOS app. Research how leading apps solve user-error prevention and recommend an approach for me.
```

```
I'm designing a checkout flow for a web ecommerce app. Research how high-conversion checkouts handle guest vs. account creation and recommend an approach for me.
```

---

## Slot Cheatsheet

Use these as drop-in values for the bracket slots above.

### `[category]`

fintech, banking, crypto wallet, neobank, payments, lending, investing, insurance, ecommerce, marketplace, retail, grocery, food delivery, ride-share, travel, hospitality, social, messaging, dating, fitness, health, mental health, meditation, productivity, project management, CRM, analytics, dashboard, dev tools, design tools, AI chat, AI assistant, education, language learning, music, video, streaming, news, podcast.

### `[screen type / screen moment]`

landing, signup, login, onboarding, welcome, permissions, KYC, verification, dashboard, home, feed, search, results, detail, settings, profile, notifications, billing, subscription, upgrade, paywall, checkout, cart, payment, confirmation, receipt, success, empty state, error state, loading, pending, offline, network error, form validation error, modal, bottom sheet, action sheet, drawer, sidebar, filter, sort.

### `[component or detail]`

phone number input, OTP input, progress indicator, stepper, progress bar, illustration, helper text, security message, fee breakdown, recipient card, amount input, currency selector, slide-to-confirm, swipe gesture, biometric prompt, captcha, support link, retry button, undo, toast, banner, warning, status pill, timeline, tabs, segmented control, floating action button, search bar, filter chips, data table, sticky header.

### `[focus area]`

trust, recovery, hierarchy, progressive disclosure, error states, success states, time-to-value, conversion, accessibility, density, mobile ergonomics, performance perception, empty states, fallback content, social proof, transparency, fee disclosure, regulatory disclosure, dark patterns to avoid.

---

## Tips

- **One slot at a time.** If your filled-in prompt is over ~250 characters or stuffs in 5+ slots, split it into two prompts.
- **Concrete > abstract.** "phone number input + progress bar" beats "good UX".
- **Name apps when you have them.** Mobbin returns better results when you anchor the search with 1–2 specific apps you admire.
- **If results are thin**, drop the most specific slot (usually `[component]`) and rerun.
