# Cost & context use

`search_screens` returns inline images (base64) alongside metadata. **Image payload dominates token cost** — picking the right `mode` and `limit` is the single biggest lever you have.

| Mode   | Limit | Approx. images | Approx. payload | When to use                                                                        |
| ------ | ----- | -------------- | --------------- | ---------------------------------------------------------------------------------- |
| `fast` | 5     | 5              | ~1–2 MB         | Quick lookup, exploratory "show me" prompts                                        |
| `fast` | 10    | 10             | ~2–4 MB         | Slightly broader scan, still cheap                                                 |
| `deep` | 10–15 | 10–15          | ~4–6 MB         | Focused research on one screen moment                                              |
| `deep` | 20–30 | 20–30          | ~8–12 MB        | Broad pattern research — may push smaller agents toward their context window limit |

## Tips to keep cost down

- **Default to `mode: "fast"` and `limit: 5–10`** unless the user explicitly asks for deep research.
- **Pass prior result IDs via `exclude_screen_ids`** on follow-up calls instead of re-running broader queries:

  ```json
  search_screens({
    "platform": "ios",
    "query": "crypto wallet send confirmation with address and fee",
    "mode": "deep",
    "limit": 10,
    "image_format": "webp",
    "exclude_screen_ids": ["ed7a0522-...", "18700191-..."]
  })
  ```

- **`image_format` defaults to `webp`** (smaller payload). Only pass `"jpg"` if your client doesn't render webp.
- **Analyze each batch as text immediately** so older base64 images can drop out of context.

See [`references/anti-patterns.md`](../references/anti-patterns.md) for failure modes that quietly inflate cost (padding weak results, stacking everything into one Mode B call, ignoring `exclude_screen_ids`).
