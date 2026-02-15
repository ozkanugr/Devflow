---
description: Manage git workflow with branch strategies, PR templates, and best practices
argument-hint: "[feature|bugfix|release|hotfix] <name> — Create branch with proper naming"
allowed-tools: Read, Write, Bash, Glob
model: sonnet
---

# Git Workflow Command

Structured git workflow management with branch strategies and conventions.

## Purpose

Provide consistent git workflows that:
- Follow established branching strategies (Git Flow / GitHub Flow)
- Create properly named branches
- Generate PR templates
- Enforce commit message conventions
- Manage releases systematically

## Usage

```bash
# Create feature branch
/git-workflow feature user-authentication

# Create bugfix branch
/git-workflow bugfix login-crash

# Create release branch
/git-workflow release 2.0.0

# Create hotfix branch
/git-workflow hotfix critical-security-fix

# Show workflow status
/git-workflow status

# List conventions
/git-workflow conventions
```

## Branch Strategy

### Branch Types

| Type | Pattern | Base | Merge To |
|------|---------|------|----------|
| feature | `feature/<name>` | develop/main | develop/main |
| bugfix | `bugfix/<name>` | develop/main | develop/main |
| release | `release/<version>` | develop | main + develop |
| hotfix | `hotfix/<name>` | main | main + develop |

### Branch Naming Rules

- Use lowercase
- Use hyphens for spaces
- Keep names descriptive but concise
- Include ticket number if applicable

```
feature/user-authentication
feature/TICKET-123-user-authentication
bugfix/fix-login-crash
release/2.0.0
hotfix/security-patch-xss
```

## Steps

### For `feature <name>`

1. Check current branch status
2. Fetch latest from remote
3. Create feature branch from base
4. Set upstream tracking
5. Display next steps

```bash
git fetch origin
git checkout -b feature/<name> origin/main
git push -u origin feature/<name>
```

### For `bugfix <name>`

1. Check for related issues
2. Create bugfix branch
3. Set upstream tracking
4. Provide debugging guidance

```bash
git fetch origin
git checkout -b bugfix/<name> origin/main
git push -u origin bugfix/<name>
```

### For `release <version>`

1. Verify clean working tree
2. Create release branch
3. Update version numbers
4. Generate changelog preview
5. Prepare release checklist

```bash
git fetch origin
git checkout -b release/<version> origin/main
# Update version files
# Generate changelog
git push -u origin release/<version>
```

### For `hotfix <name>`

1. Verify on main branch
2. Create hotfix branch
3. Emphasize urgency and testing
4. Provide merge checklist

```bash
git fetch origin
git checkout -b hotfix/<name> origin/main
git push -u origin hotfix/<name>
```

## PR Template

When creating PRs, use this template:

```markdown
## Summary

[Brief description of changes]

## Type of Change

- [ ] Feature (new functionality)
- [ ] Bugfix (fixes an issue)
- [ ] Refactor (no functional change)
- [ ] Documentation
- [ ] Other: ___________

## Related Issues

Closes #[issue-number]

## Changes Made

- [Change 1]
- [Change 2]
- [Change 3]

## Testing Done

- [ ] Unit tests added/updated
- [ ] Manual testing performed
- [ ] Edge cases considered

## Platform Parity (if applicable)

- [ ] iOS implementation complete
- [ ] Android implementation complete
- [ ] `/platform-parity` check passed

## Screenshots (if UI changes)

| Before | After |
|--------|-------|
| [img]  | [img] |

## Checklist

- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated (if needed)
- [ ] No new warnings introduced
- [ ] Tests pass locally
```

## Commit Message Convention

Follow Conventional Commits:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation only |
| style | Formatting, no code change |
| refactor | Code change, no behavior change |
| perf | Performance improvement |
| test | Adding/updating tests |
| chore | Maintenance tasks |

### Examples

```
feat(auth): add biometric login support

Implement Touch ID and Face ID authentication for iOS,
fingerprint authentication for Android.

Closes #123
```

```
fix(profile): resolve crash on avatar upload

Handle case where user denies photo library permission
after previously granting it.

Fixes #456
```

## Workflow Helpers

### Show Current Status

```bash
/git-workflow status
```

Displays:
- Current branch
- Uncommitted changes
- Unpushed commits
- Related PRs
- Merge status

### Show Conventions

```bash
/git-workflow conventions
```

Displays:
- Branch naming rules
- Commit message format
- PR requirements
- Merge policies

## Integration

### With Task System

Link branches to tasks:
```bash
/git-workflow feature auth-login-screen
# Creates: feature/auth-login-screen
# Links to task: auth-* tasks
```

### With PR Creation

After branch is ready:
```bash
gh pr create --title "feat: add login screen" --body-file .github/PULL_REQUEST_TEMPLATE.md
```

## Guidelines

### Do

- Create branches from up-to-date base
- Use descriptive branch names
- Keep branches focused (single feature/fix)
- Delete branches after merge
- Squash commits when appropriate

### Don't

- Push directly to main/develop
- Create branches from stale commits
- Let branches live too long
- Rebase public branches
- Force push shared branches

## Output

After branch creation:

```markdown
## Branch Created

**Branch**: feature/user-authentication
**Based on**: main (commit abc1234)
**Tracked**: origin/feature/user-authentication

### Next Steps

1. Implement your changes
2. Commit with conventional format:
   ```
   feat(auth): add login screen
   ```
3. Push regularly:
   ```
   git push
   ```
4. Create PR when ready:
   ```
   gh pr create
   ```

### Related

- Task: [auth-1] Create login screen
- PR Template: .github/PULL_REQUEST_TEMPLATE.md
```

## Error Handling

### Dirty Working Tree

```
Your working tree has uncommitted changes.

Options:
1. Commit changes: git add . && git commit -m "WIP"
2. Stash changes: git stash
3. Discard changes: git checkout . (destructive)

Choose an option or resolve manually.
```

### Branch Already Exists

```
Branch 'feature/user-auth' already exists.

Options:
1. Switch to it: git checkout feature/user-auth
2. Delete and recreate: git branch -D feature/user-auth
3. Use different name: /git-workflow feature user-auth-v2

Choose an option.
```
