# Example 3 — Competitive Comparison

**Mode:** B with Template B (Competitive Comparison) from `references/synthesis-framework.md`.

---

## User prompt

```
Compare how iOS fintech apps handle the moment right before a user confirms a transfer. Look at Wise, Revolut, ANZ, and Mercury if available.
```

## Agent behavior

1. **Platform resolution:** "iOS" is explicit → `ios`.
2. **Mode detection:** "Compare how…" + named apps → **Mode B, Template B**.
3. **Searches:** one targeted query, named apps anchor the result set.

## Tool call

```json
search_screens({
  "platform": "ios",
  "query": "fintech transfer confirmation screen with recipient amount fee breakdown and confirm button used by Wise Revolut ANZ Mercury",
  "mode": "deep",
  "limit": 12
})
```

## Agent output

# Competitive UI Comparison

## Screen / Flow Compared
The pre-confirmation review screen for an outbound money transfer on iOS — the moment right before the user taps "Confirm" / "Send".

## Comparison Table

| App | Pattern | Strength | Weakness | Reusable Idea |
|-----|---------|----------|----------|---------------|
| [Wise](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589) | Itemized cost breakdown with a locked-rate countdown | Highest fee transparency; rate-lock timer is honest about volatility | Dense — small type may be hard for low-vision users | Rate-locked timer that forces re-review on expiry |
| [Revolut Business](https://mobbin.com/screens/0770c453-3143-4ee6-af90-ade99c6260da) | Compact two-line summary above bold confirm CTA | Fast to scan; every field is edit-in-place | Less detail on the fee composition | Edit-in-place affordances on every reviewed field |
| [ANZ Plus](https://mobbin.com/screens/9b896824-78ca-4eff-86ca-95001cee0c73) | Plain-language "You're sending / They receive" framing | Beginner-friendly; reduces math-load | Light on fee detail | Human-language framing of sender vs. recipient amounts |
| [Mercury](https://mobbin.com/screens/4d3c5e36-9671-4244-ba41-c2d830feb68a) | Wire-transfer review with routing details + estimated arrival | Sets expectation for a slow rail (B2B audience) | Heavy for consumer use case | Prominent estimated arrival time for non-instant rails |

## Winner Analysis
**Wise wins on transparency**, but at the cost of density. **Revolut Business wins on speed**, trading off fee detail for scan-ability. The right choice depends on audience:

- Consumer + first-time use → **ANZ Plus** model (human framing, less math).
- Power user + recurring transfers → **Revolut Business** model (compact, editable).
- Cross-currency or volatile rates → **Wise** model (itemized + rate lock).
- Slow / high-stakes rails (wire, ACH) → **Mercury** model (arrival estimate, routing context).

## Recommendation
**Combine Wise's itemization with Revolut's edit-in-place affordances.**
- Use ANZ's "You're sending / They receive" labels on the two amount rows.
- Borrow Mercury's estimated-arrival pill for any non-instant rail.
- Skip the rate-lock timer unless your rates are actually volatile — it adds anxiety without payoff for stable-currency transfers.

---

## Why this is correct

- Used the comparison table as the centerpiece, not pattern clusters.
- Named-app anchoring kept results focused.
- Each row has a clear strength + weakness — opinionated, not just descriptive.
- Recommendation **combines** patterns rather than picking a single winner.
