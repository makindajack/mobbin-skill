# Pre-configured client files

Drop-in copies of `SKILL.md` formatted for specific clients. Saves you the file-conversion step in the README install table.

| Client      | File / location                                                                               | Install                                                                                                            |
| ----------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Claude Code | [`claude/skills/mobbin/SKILL.md`](claude/skills/mobbin/SKILL.md) (symlink to root `SKILL.md`) | `cp -R clients/claude/skills/mobbin ~/.claude/skills/` (or symlink the whole `claude/skills/mobbin/` directory)    |
| Cursor      | [`cursor/mobbin.mdc`](cursor/mobbin.mdc)                                                      | Project: `cp clients/cursor/mobbin.mdc .cursor/rules/` <br>Global: `cp clients/cursor/mobbin.mdc ~/.cursor/rules/` |

These files are kept in sync with the root `SKILL.md` — the Claude Code copy is a symlink, the Cursor copy adds the required `.mdc` frontmatter on top of the same content.
