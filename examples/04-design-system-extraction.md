# Example 4 — Design System Extraction

**Mode:** B, Design System Component Mode (atomic primitives, not screen patterns).

---

## User prompt

```
What design system primitives do iOS crypto wallet apps share? Decompose into atomic components, not screen patterns.
```

## Agent behavior

1. **Platform resolution:** "iOS" is explicit → `ios`.
2. **Mode detection:** "design system primitives" + "atomic components" → **Design System Mode**.
3. **Searches:** broad coverage across send, receive, swap, portfolio, settings.

## Tool calls

```json
search_screens({ "platform": "ios", "query": "crypto wallet send transaction confirmation screen with recipient address amount fee breakdown and confirm button", "mode": "deep", "limit": 10 })
search_screens({ "platform": "ios", "query": "crypto wallet portfolio dashboard with token balances price charts and send receive buttons", "mode": "deep", "limit": 10 })
search_screens({ "platform": "ios", "query": "crypto wallet receive screen with QR code address copy button and network selector", "mode": "deep", "limit": 10 })
```

## Agent output

# Design System Components: iOS Crypto Wallets

## Screens Reviewed

| App | Screens contributed | Link |
|-----|---------------------|------|
| Base | Send confirmation, portfolio | [Mobbin](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2) |
| Binance | Send with chain warning, receive QR | [Mobbin](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258) |

## Primitives

### Truncated Address
Wallet address shortened with ellipsis in the middle (e.g., `0x1a2b…f9c0`) with copy and QR affordances.
- **Variants**: short (12 chars), medium (16 chars), full (tap-to-expand)
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2), [Binance](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258)

### Token Icon + Symbol Pair
Circular token logo paired with ticker (`ETH`, `USDC`). Often with a small chain badge overlaid.
- **Variants**: 24px (list rows), 40px (cards), 64px (detail headers)
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2)

### Chain Badge
Small overlay pill identifying the network (Ethereum, Base, Solana, BNB Chain).
- **Variants**: corner overlay on token icon, standalone pill in lists
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2), [Binance](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258)

### Currency Display
Large amount with smaller fiat conversion below, or vice versa. Always paired.
- **Variants**: crypto-primary (large) + fiat-secondary, or fiat-primary + crypto-secondary
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2)

### Fee Breakdown Row
Itemized line item with label on left, amount + fiat conversion on right.
- **Variants**: single-row (network fee only), multi-row (network + service + total)
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2)

### Send / Receive / Swap Action Set
Triplet of icon buttons that anchors every portfolio screen.
- **Variants**: 3-up, 4-up (adds Buy), 5-up (adds Stake)
- **Seen in**: [Base](https://mobbin.com/screens/729b8463-bbc5-4ef0-a58c-b833985dfcb2)

### Novel-Address Warning Banner
Dismissible alert appearing when sending to a never-before-used address.
- **Variants**: warning (yellow), critical (red, with explicit confirmation)
- **Seen in**: [Binance](https://mobbin.com/screens/5f99db5f-92dd-4d01-b841-b1dbc6fd7258)

## Domain-Specific Components
These do not exist in a generic design system and need to be designed from scratch:

- **Truncated Address** — no equivalent in standard kits
- **Chain Badge** — crypto-specific identity primitive
- **Token Icon + Symbol Pair** — domain-specific composite
- **Novel-Address Warning Banner** — exists only in transactional crypto contexts

## Standard Components with Domain Variants
These exist in any design system but need crypto-specific adaptations:

- **Currency Display** — extends a numeric input with a paired fiat conversion
- **Fee Breakdown Row** — extends a generic list row with right-aligned dual-value rendering
- **Action Set** — extends a button group with crypto action labels
- **Bottom Sheet** — used for chain selection, token selection, address book

---

## Why this is correct

- Output is organized by **primitive**, not by screen.
- Every primitive names variants, not just one example.
- Explicitly separates **domain-specific** primitives from **standard-with-variants**.
- No "Send Screen" / "Portfolio Screen" patterns appear — those are compositions, not primitives.
