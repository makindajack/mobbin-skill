# Example 2 — Pattern Research

**Mode:** B (Full Research) — multi-batch, pattern clusters, recommendations.

---

## User prompt

```
Research how iOS crypto wallet and fintech apps handle send/transfer confirmation. Focus on trust, fee transparency, and recovery from mistakes.
```

## Agent behavior

1. **Platform resolution:** "iOS" is explicit → `ios`.
2. **Mode detection:** "Research how…" + focus areas → **Mode B**.
3. **Goal decomposition:** Three concrete UI moments — (a) review-before-confirm, (b) fee disclosure, (c) post-send pending/cancel.
4. **Batched searches:** 3 queries, analyzed incrementally.

## Tool calls

```json
search_screens({ "platform": "ios", "query": "crypto wallet send transaction confirmation screen with recipient address amount fee breakdown and confirm button", "mode": "deep", "limit": 10 })
search_screens({ "platform": "ios", "query": "fintech transfer confirmation screen showing fee breakdown exchange rate delivery estimate and confirm button", "mode": "deep", "limit": 10 })
search_screens({ "platform": "ios", "query": "money transfer pending screen with progress tracker cancel option and recipient details", "mode": "deep", "limit": 10 })
```

## Agent output

# Mobbin Research Summary

## Research Goal

Understand how iOS crypto wallet and fintech apps handle send/transfer confirmation, with emphasis on trust, fee transparency, and recovery from mistakes.

## Searches Used

- iOS — crypto wallet send confirmation with recipient, amount, fee breakdown, confirm
- iOS — fintech transfer confirmation with fee breakdown, exchange rate, delivery estimate
- iOS — money transfer pending screen with progress tracker, cancel, recipient details

## Screens Reviewed

| App              | Pattern                                                           | Notable detail                                            | Link                                                                      |
| ---------------- | ----------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------- |
| Base             | Recipient-first card with truncated address + chain badge         | Network fee shown as a separate row, not buried in total  | [Mobbin](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2) |
| Wise             | Itemized cost breakdown (you send / fee / they receive)           | Locked exchange rate with countdown timer                 | [Mobbin](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589) |
| Revolut Business | Two-line summary (recipient + amount) above a bold confirm        | Edit affordances on every field — easy to back out        | [Mobbin](https://mobbin.com/screens/0770c453-3143-4ee6-af90-ade99c6260da) |
| ANZ Plus         | Pre-confirm screen separates "You're sending" from "They receive" | Plain-language reassurance copy before the CTA            | [Mobbin](https://mobbin.com/screens/9b896824-78ca-4eff-86ca-95001cee0c73) |
| Binance          | Address + memo with full chain warning banner                     | Explicit "Are you sure?" gate for unmatched address books | [Mobbin](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258) |
| Mercury          | Wire transfer review with bank routing details surfaced           | Estimated arrival time displayed prominently              | [Mobbin](https://mobbin.com/screens/4d3c5e36-9671-4244-ba41-c2d830feb68a) |

## Pattern Clusters

### 1. Pre-confirmation summary card

The recipient + amount appear in a visually distinct card above the CTA. Used by [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2), [Revolut Business](https://mobbin.com/screens/0770c453-3143-4ee6-af90-ade99c6260da), [ANZ Plus](https://mobbin.com/screens/9b896824-78ca-4eff-86ca-95001cee0c73). The card itself becomes the "thing you are about to do" — reducing the chance of a misread.

### 2. Itemized cost breakdown

Fees are never hidden in a total. [Wise](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589) and [Mercury](https://mobbin.com/screens/4d3c5e36-9671-4244-ba41-c2d830feb68a) split into "you send" / "fee" / "they receive" rows. Crypto apps like [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2) surface the network fee as a discrete line, not a footnote.

### 3. Reversibility cues before commit

Every reviewed app gives at least one mistake-prevention mechanism: editable fields ([Revolut Business](https://mobbin.com/screens/0770c453-3143-4ee6-af90-ade99c6260da)), warning banners on novel addresses ([Binance](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258)), or a rate-locked timer that forces a re-review ([Wise](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589)).

## Key Observations

- The confirm step is treated as a **review screen**, not just an "are you sure?" modal. The whole transaction is restated.
- **Fee transparency is a trust device, not a regulatory checkbox.** Apps that itemize fees signal "we're not hiding anything" and reduce abandonment.
- **Crypto apps go further on irreversibility cues** because mistakes can't be reversed. Banking apps lean on "estimated arrival" since they can recall a transfer.

## UX Opportunities

- Treat the confirm step as a **document the user could screenshot and send to support** — that's the right level of completeness.
- For any field that could be a typo source (address, amount, recipient), make it **edit-in-place** rather than back-button-only.
- If the destination is novel (first time sent to this address), add a **friction layer** (warning banner, double-tap, or address-book check).

## Recommendations

1. **Use a summary card** above the CTA showing recipient + amount in larger type.
2. **Itemize fees** even when there's only one line — sets the precedent.
3. **Detect novel destinations** and gate them with a warning banner.
4. **Show estimated arrival** post-send and make cancel discoverable for the first ~30 seconds.

## Reusable Patterns

- **Summary Card** — [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2), [ANZ Plus](https://mobbin.com/screens/9b896824-78ca-4eff-86ca-95001cee0c73), [Revolut Business](https://mobbin.com/screens/0770c453-3143-4ee6-af90-ade99c6260da)
- **Itemized Fee Row** — [Wise](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589), [Mercury](https://mobbin.com/screens/4d3c5e36-9671-4244-ba41-c2d830feb68a)
- **Novel-Address Warning Banner** — [Binance](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258)
- **Rate-Lock Timer** — [Wise](https://mobbin.com/screens/676d6d79-fb58-4dff-a517-af056631e589)

---

## Why this is correct

- Generated multiple queries and ran them in batches.
- Led output with the `Screens Reviewed` table.
- Pattern Clusters group apps, not list them flatly.
- Every app reference is linked.
- Recommendations are concrete (do X, with this pattern), not vague advice.
