# Security policy

This skill is **plain markdown** — there is no executable code shipped at runtime, no network calls beyond the MCP server you configure yourself, and no telemetry. The most realistic risks are:

1. **Secret leakage** — accidentally committing any credential (GitHub PAT, OAuth token, API key) into a `clients/` file or example.
2. **Prompt-injection content** — malicious text inside an example transcript that tries to override your agent's behavior.
3. **Mobbin Terms-of-Service violations** caused by patterns in the skill text (bulk caching, building competing products, etc.).

## Reporting a vulnerability

Open a private report via GitHub's [Security Advisories](https://github.com/makindajack/mobbin-skill/security/advisories/new) tab on this repository.

If the issue is a Mobbin Terms-of-Service concern (not a vulnerability in this skill), please:

- Open a **public** issue using the [Bug report](https://github.com/makindajack/mobbin-skill/issues/new) template, **and**
- Independently report any abuse of the Mobbin service to [Mobbin support](https://mobbin.com/support).

Please do not file public GitHub issues for credential leaks or other secrets you spot in the repo — message the maintainer directly via a Security Advisory so the secret can be revoked first.

## Triage expectations

This is a community-maintained, single-maintainer fork. Best-effort response within ~7 days. There are no SLAs.

## Supported versions

Only the latest tagged release on `master` receives fixes. There are no LTS branches.

## What's out of scope

- Vulnerabilities in the **Mobbin MCP server itself** — report to [Mobbin support](https://mobbin.com/support).
- Vulnerabilities in **third-party clients** (Claude Code, Cursor, Copilot, etc.) — report to the respective vendors.
- Vulnerabilities in the **Model Context Protocol** spec — report to the [MCP project](https://github.com/modelcontextprotocol).
