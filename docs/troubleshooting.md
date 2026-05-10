# Troubleshooting

Common failure modes when using the Mobbin skill, with fixes.

---

## "Skill loaded but `search_screens` isn't in my tool list"

**Symptom:** Your agent acknowledges the skill (e.g., Copilot CLI says `Environment loaded: 1 skill, X MCP servers`), but when you ask it to search Mobbin it replies that the tool isn't available.

**Cause:** The skill is loaded as instructions, but the **Mobbin MCP server** isn't connected. The skill is plain markdown — it doesn't bring its own MCP transport.

**Fix:** Wire up Mobbin MCP for that specific client. See [`mcp-setup.md`](mcp-setup.md). Quick checks:

| Client          | Verify with                                                  |
| --------------- | ------------------------------------------------------------ |
| Claude Code     | `claude mcp list` (should show `mobbin`)                     |
| Copilot CLI     | `copilot mcp list` (should show `mobbin`)                    |
| Cursor          | Settings → MCP → server status indicator                     |
| VS Code Copilot | `~/Library/Application Support/Code/User/mcp.json` has entry |

Or run the bundled doctor to check all hosts at once (no API call):

```bash
./validate.sh --doctor
```

After adding the server, restart the agent so it re-loads the MCP config.

---

## VS Code / chat client crashes after a few searches

**Symptom:** Editor freezes, extension host restarts, or the chat panel becomes unresponsive after several `search_screens` calls.

**Cause:** `search_screens` returns inline base64 images. They accumulate in chat history and can exhaust the renderer's memory.

**Fix:**

1. **Default to `mode: "fast"` and `limit: 5–10`** (see [`cost-and-context.md`](cost-and-context.md)).
2. Keep `image_format: "webp"` (the skill's default) — much smaller payload than `jpg`.
3. **Start a new chat** every 2–3 deep searches to drop old images from context.
4. Pass prior result IDs via `exclude_screen_ids` instead of re-running broader queries.

---

## "I'm hitting rate limits / quota errors"

**Symptom:** Mobbin MCP returns 429 / quota exceeded, or fewer results than `limit` requests.

**Cause:** Free-tier Mobbin accounts have daily search quotas and a smaller subset of the screen library. The skill's "deep" mode (Mode B) makes 3–7 calls per research session.

**Fix:**

- Check your plan at [mobbin.com/settings](https://mobbin.com/settings).
- Use Mode A (single fast call, `limit: 5`) for exploratory work and reserve Mode B for one focused topic per session.
- Upgrade to Pro / Team if you do this for work — see the plan-tier callout in [`mcp-setup.md`](mcp-setup.md).

---

## Empty or weak results ("no relevant screens found")

**Symptom:** Skill returns very few results, or pads with screens that don't match the query.

**Cause:** Query was too narrow, used non-Mobbin terminology, or the platform mapping was wrong (e.g., asking for "iOS" when you meant "web").

**Fix:** The skill's **Fallback rule** should kick in automatically — it will broaden the query, swap modes, and report honestly if nothing matches. If you see padding instead, see [`../references/anti-patterns.md`](../references/anti-patterns.md). You can also:

- Rephrase using concrete UI vocabulary (`bottom sheet`, `slide-to-confirm`, `progress indicator`) instead of abstract goals (`great onboarding`).
- Drop platform from the query and let the skill resolve it.
- Use prompt templates from [`../references/prompt-templates.md`](../references/prompt-templates.md).

---

## `/mobbin` slash command shows duplicates

**Symptom:** Typing `/mobbin` in VS Code Copilot Chat shows multiple matching prompts.

**Cause:** You have more than one `mobbin*.prompt.md` in your user prompts folder (`~/Library/Application Support/Code/User/prompts/` on macOS).

**Fix:**

```bash
ls -la "$HOME/Library/Application Support/Code/User/prompts/" | grep mobbin
```

Delete or rename the duplicates so only one starts with `mobbin`. The canonical install is a symlink to `clients/copilot/mobbin.prompt.md`.

---

## `validate.sh` fails

**Symptom:** Running `./validate.sh` reports missing output elements.

**Cause:** Either the skill isn't loaded by the `claude` CLI in your current shell, the MCP server isn't reachable, or Mobbin returned different results today.

**Fix:**

1. Confirm `claude --version` and `claude mcp list | grep mobbin` both succeed.
2. Re-run with verbose output: `bash -x validate.sh`.
3. If only the "table header" check fails but a Mobbin link is present, the skill probably ran in plain-prose mode — that's a skill-behavior issue worth opening as a bug.

---

## Something else?

Open a [bug report](https://github.com/makindajack/mobbin-skill/issues/new?template=bug_report.yml) with:

- Your client + version (e.g., `claude --version`, `copilot --version`).
- The exact prompt you used.
- The output you got and what you expected.
- Whether `mcp list` shows the Mobbin server.
