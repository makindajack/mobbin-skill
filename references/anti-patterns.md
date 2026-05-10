# Behavior anti-patterns

Failure modes I've observed when the skill is invoked in real sessions. Different from `query-patterns.md` (which covers query writing). This file catalogs how the **agent** can misuse the skill, and how to course-correct.

## 1. Padding weak results to look thorough

**Symptom:** Skill returns 5 loosely-related screens and writes confident pattern analysis on top, even though only 1–2 results actually match the user's intent.

**Why it happens:** Default LLM bias to be helpful — admitting "no matches" feels like failure.

**Fix:** Honor the [fallback rule](../SKILL.md#fallback-rule-for-weak-results). If <3 results are clearly relevant: auto-broaden once → swap mode → stop and report honestly with rephrasings. Three strong references beat ten loose ones.

## 2. Asking for platform on every call

**Symptom:** First reply is "Did you mean iOS or web?" instead of running the search.

**Why it happens:** Skill instructions previously _required_ an explicit platform.

**Fix:** Use the [Platform Resolution](../SKILL.md#platform-resolution) defaults. Infer + disclose in one line (`Searching iOS (say "web" if you meant web apps)`), then run the search. Only block on truly ambiguous input.

## 3. Stacking everything into one Mode B call

**Symptom:** Single `mode: "deep"`, `limit: 30` call returns 30 base64 images at once. Context fills, agent can't analyze, output is shallow.

**Why it happens:** Treating "do research" as "fetch everything first, then think."

**Fix:** Mode B's workflow is **batched analysis**. Run 2–3 queries at a time, write text observations between batches so older images can drop out of context. Pass result IDs through `exclude_screen_ids` on the next batch.

## 4. Ignoring `exclude_screen_ids` on follow-ups

**Symptom:** User says "show me more like that" → agent re-runs the same query and returns the same 5 screens with new commentary.

**Why it happens:** The parameter isn't always surfaced clearly; agent forgets it exists.

**Fix:** On any "more / different / variations" follow-up, pass the previous response's screen IDs in `exclude_screen_ids`. Documented in [Mode B Workflow → Cost-saver parameters](../SKILL.md#mode-b--full-research-multi-batch-synthesis).

## 5. Treating `search_screens` as a generic image search

**Symptom:** Queries like `"submarine periscope dashboard"`, `"medieval blacksmith inventory"`, or `"underwater scene"` — Mobbin returns the closest indexed digital-product UI, agent presents it as a real match.

**Why it happens:** Forgetting that Mobbin's corpus is **shipped digital products**, not concept art or themed dashboards.

**Fix:** When the user's domain is fictional, themed, or otherwise outside shipped product UI, recognize the gap up front. Don't search; tell the user Mobbin won't have it and suggest a real-product analogue (e.g., "factory monitoring dashboard with gauges" instead of "blacksmith forge").

## 6. Summarizing screens without linking them

**Symptom:** Output mentions "Chime does X, Revolut does Y" with no Mobbin URLs.

**Why it happens:** Agent treats the screenshot as authoritative and forgets the metadata.

**Fix:** Skill rule: **every** referenced app/screen must include the `mobbin.com/screens/<id>` link as a markdown link. No exceptions. The `validate.sh` sanity script greps for this on every PR.

---

When you spot a new failure mode, add it here with the same shape: Symptom · Why · Fix.
