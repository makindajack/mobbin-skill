# Example 1 — Quick Lookup

**Mode:** A (Quick Lookup) — single `mode: "fast"` call, comparison table only, no synthesis.

---

## User prompt

```
Show me 5 iOS fintech onboarding screens that use a phone number input and a progress indicator.
```

## Agent behavior

1. **Platform resolution:** "iOS" is explicit → `ios`. No disclosure needed.
2. **Mode detection:** "Show me…" + a specific number + a single screen type → **Mode A**.
3. **Single query:** writes one concrete query and calls `search_screens` once with `mode: "fast"`, `limit: 5`.

## Tool call

```json
search_screens({
  "platform": "ios",
  "query": "iOS fintech onboarding signup screen with phone number input progress indicator and continue button",
  "mode": "fast",
  "limit": 5
})
```

## Agent output

### Screens Reviewed

| App      | Pattern                                                          | Notable detail                                        | Link                                                                      |
| -------- | ---------------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------- |
| Fi       | Phone-only entry with custom numeric keypad                      | Helper copy explains _why_ the phone number is needed | [Mobbin](https://mobbin.com/screens/ed7a0522-8ee8-4bd9-baa1-ed2031a77955) |
| Afterpay | Single combined email/phone field                                | Minimal — defers progress indicator until later step  | [Mobbin](https://mobbin.com/screens/18700191-54e9-4932-af93-d4eb9856825b) |
| Tonal    | Thin progress bar at top                                         | Opt-in checkbox inline with primary CTA               | [Mobbin](https://mobbin.com/screens/822087ad-367c-4d98-8c11-2b7cf14e9aad) |
| Opal     | Phone first with secondary auth options stacked below            | Apple/Email shown as fallback after phone             | [Mobbin](https://mobbin.com/screens/e44e1290-c30f-4bde-8347-8b999fb091f9) |
| Chime    | Three-step icon stepper (Basic Info → Verification → You're in!) | Legal disclosure linked inline with CTA               | [Mobbin](https://mobbin.com/screens/1fac87e2-445a-4478-84ca-0d01edc25b38) |

> Want me to do a deeper pattern analysis on these?

---

## Why this is correct

- Did **not** generate 3–7 queries.
- Did **not** produce Pattern Clusters / Key Observations / Recommendations.
- Used `mode: "fast"` (not `deep`) — cheaper for exploratory questions.
- Ended with an explicit offer to escalate to Mode B.
- Every row has a Mobbin link.
