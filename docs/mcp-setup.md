# Setup the Mobbin MCP server

1. Sign up at [mobbin.com](https://mobbin.com)
2. Go to [**Settings → MCP**](https://mobbin.com/settings/mcp) (or click your profile icon top right → **Settings** → **MCP**)
3. Select your tool and follow the instructions, or use one of the snippets below.

> **Mobbin account & plan tiers**
>
> - You need a **Mobbin account** to use the MCP server (free signup at [mobbin.com](https://mobbin.com)).
> - **Free tier:** limited daily searches and a smaller subset of the screen library. Fine for trying the skill out.
> - **Paid plans (Pro / Team):** higher search quotas, full library access, and the depth needed for serious research workflows like Mode B (Full Research) or design system extraction.
> - Mobbin sets and changes these limits — check your plan page in Settings for current quotas. This skill makes no guarantees about Mobbin's pricing or quotas.
> - **One account per person.** Mobbin's [Terms](https://mobbin.com/terms) (§4.1.b) prohibit account sharing — don't paste your MCP credentials into a shared repo, team `.env`, or chat. Team / Enterprise plans use seats; assign one per user.

## Claude Code

```bash
claude mcp add mobbin \
  --transport http https://api.mobbin.com/mcp
```

## Cursor

```json
{
  "mcpServers": {
    "mobbin": {
      "serverUrl": "https://api.mobbin.com/mcp"
    }
  }
}
```

## Codex CLI

```bash
codex mcp add mobbin --url https://api.mobbin.com/mcp
```

## GitHub Copilot CLI

```bash
copilot mcp add --transport http mobbin https://api.mobbin.com/mcp
```

## VS Code (Copilot Chat)

Add to `~/Library/Application Support/Code/User/mcp.json` (macOS):

```json
{
  "servers": {
    "mobbin": {
      "type": "http",
      "url": "https://api.mobbin.com/mcp"
    }
  }
}
```

## Lovable

Paste the URL into Lovable's MCP settings:

```
https://api.mobbin.com/mcp
```

For other clients, follow their MCP setup docs and point them at `https://api.mobbin.com/mcp` (HTTP transport).
