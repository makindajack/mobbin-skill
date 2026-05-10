# Example 5 — Recovery from a Bad Query

**Demonstrates:** the fallback rule from `SKILL.md` — auto-broaden once, swap mode, then report honestly with rephrasings instead of padding.

---

## User prompt

```
Show me iOS lending app rejection screens with personalized counter-offers and a soft-credit-pull explainer.
```

This query is **too specific**: it stacks "rejection", "counter-offer", and "soft-credit-pull explainer" all in one screen — a combination that may not exist in the corpus.

## Agent behavior

1. **Platform resolution:** "iOS" is explicit → `ios`.
2. **Mode detection:** "Show me…" → **Mode A**, single fast call.

### Attempt 1 — initial query

```json
search_screens({
  "platform": "ios",
  "query": "iOS lending app rejection screen with personalized counter offer and soft credit pull explainer",
  "mode": "fast",
  "limit": 10
})
```

Returns 2 results, both off-topic (a generic "application received" screen and an unrelated KYC step). **<3 relevant** → trigger fallback.

### Attempt 2 — auto-broaden (drop most specific term)

The agent strips `"soft credit pull explainer"` (the most specific clause) and retries:

```json
search_screens({
  "platform": "ios",
  "query": "iOS lending app rejection screen with personalized counter offer",
  "mode": "fast",
  "limit": 10
})
```

Returns 1 relevant result. Still <3 → next fallback step.

### Attempt 3 — switch mode `fast` → `deep`

```json
search_screens({
  "platform": "ios",
  "query": "iOS lending app rejection screen with personalized counter offer",
  "mode": "deep",
  "limit": 10
})
```

Returns 2 relevant results. **Still <3 strong matches**. Stop and report honestly.

## Agent output

> I tried three variations of your query and only found a handful of loosely matching screens — the combination of "rejection + counter-offer + soft-credit-pull explainer" is rare enough that the corpus doesn't have a strong cluster.
>
> Here's what I did find:
>
> | App                | Pattern                                           | Notable detail                                                    | Link                      |
> | ------------------ | ------------------------------------------------- | ----------------------------------------------------------------- | ------------------------- |
> | _(example)_ Affirm | Rejection with line-of-credit counter-offer       | Counter-offer shown as a separate card below the rejection notice | _(real link if returned)_ |
> | _(example)_ Klarna | Soft-decline with "you may qualify for X" message | Counter-offer is a button, not a card                             | _(real link if returned)_ |
>
> ### Suggestions to find more
>
> Your query stacked three specific concepts. Try splitting it:
>
> 1. **Just rejection screens:**
>    `Show me 8 iOS lending or credit app screens that show a denied application with reasons.`
> 2. **Just counter-offers:**
>    `Show me 6 iOS fintech screens that present an alternative offer (lower amount, different product) after a rejection.`
> 3. **Just soft-credit-pull explainers:**
>    `Show me 5 iOS lending app screens that explain a soft credit pull won't affect the user's credit score.`
>
> Once we find solid examples in each, I can synthesize the combined pattern.

---

## Why this is correct

- Did **not** pad the answer with the 2 off-topic results from attempt 1 to look thorough.
- Followed the fallback steps in order: auto-broaden → swap mode → stop and report.
- Reported the failure **honestly** ("the corpus doesn't have a strong cluster").
- Offered **3 concrete rephrasings** drawn from the prompt-template structure, not vague "try a different query".
