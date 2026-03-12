---
name: jj-vcs
description: Use jj (Jujutsu) as the version control system instead of git. Use when the user mentions jj, jujutsu, or wants VCS operations. Provides jj equivalents for git commands and handles key differences.
compatibility: opencode
---

# jj-vcs Skill

This skill ensures jj (Jujutsu) is used instead of git for all version control operations.

## Context

The user uses **jj (Jujutsu)** as their VCS, not git. Key differences:

- **No staging area**: Working copy is automatically committed
- **No index**: Use `jj split` or `jj squash` instead of `git add -p`
- **Bookmarks**: Equivalent to git branches (not "current branch")
- **Operation log**: Replaces reflogs (`jj op log`, `jj undo`)
- **Conflicts can be committed**: No failed commands due to merge conflicts

## Git to jj Command Translations

| Git | jj | Notes |
|-----|-----|-------|
| `git init` | `jj git init [--no-colocate]` | |
| `git clone` | `jj git clone` | |
| `git fetch` | `jj git fetch` | |
| `git push` | `jj git push --all` or `jj git push --bookmark` | |
| `git status` | `jj st` | |
| `git diff HEAD` | `jj diff` | |
| `git diff <rev>^ <rev>` | `jj diff -r <revision>` | |
| `git show <rev>` | `jj show <revision>` | |
| `git add <file>` | (not needed) | Files auto-tracked |
| `git rm <file>` | `rm <file>` | |
| `git rm --cached <file>` | `jj file untrack <file>` | |
| `git commit -a` | `jj commit` | |
| `git log --oneline --graph` | `jj log -r ::@` | |
| `git log --all` | `jj log -r 'all()'` | |
| `git grep` | `grep foo $(jj file list)` | |
| `git reset --hard` | `jj abandon` | |
| `git reset --soft HEAD~` | `jj squash --from @-` | |
| `git restore <paths>` | `jj restore <paths>` | |
| `git commit --amend` | `jj describe` | Edit commit message |
| `git stash` | `jj new @-` | |
| `git switch -c <branch>` | `jj new <base>` | |
| `git merge` | `jj new @ <branch>` | |
| `git rebase` | `jj rebase` | Auto-rebases descendants |
| `git cherry-pick` | `jj duplicate` | |
| `git branch` | `jj bookmark list` | |
| `git branch -d` | `jj bookmark delete` | |
| `git reflog` | `jj op log` | |
| `git revert` | `jj revert -r <rev> -B @` | |
| `git blame` | `jj file annotate` | |

## jj-Specific Commands

- `jj st` - Status (shorthand)
- `jj log -r ::@` - Log of current changes
- `jj log -r 'all()'` - All commits
- `jj squash` - Move diff into parent
- `jj squash -i` - Interactive squash
- `jj split` - Split working copy into commits
- `jj describe` - Edit commit message
- `jj op log` - Operation log
- `jj undo` / `jj redo` - Undo/redo operations
- `jj new <rev>` - Create new change on top of revision
- `jj edit <rev>` - Check out revision to edit

## Incompatible Git Behaviors

These git patterns will NOT work with jj:

1. **No detached HEAD concept** - jj always works on commits
2. **No staging area** - Can't partially stage files with `git add`
3. **No current branch** - Bookmarks are moved manually
4. **No evil merges** - jj handles merge commits differently
5. **No `git rebase -i`** - Use `jj rebase -r` or `jj arrange`
6. **No `git stash`** - Use `jj new @-` to "put away" changes
7. **No partial commits via staging** - Use `jj split` instead

## Instructions

1. When user asks for VCS operations, use jj commands from the table above
2. If user mentions git commands, translate to jj equivalent
3. Explain jj-specific concepts when relevant (bookmarks, operation log, squash)
4. Reference https://docs.jj-vcs.dev/latest/ for detailed documentation

## References

- [Git comparison](https://docs.jj-vcs.dev/latest/git-comparison/)
- [Git command table](https://docs.jj-vcs.dev/latest/git-command-table/)
- [CLI reference](https://docs.jj-vcs.dev/latest/cli-reference/)
