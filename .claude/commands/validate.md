---
description: Validate configuration framework integrity, check for inconsistencies, and verify cross-references
argument-hint: "[--all|--commands|--agents|--platform|--tasks] — Component to validate"
allowed-tools: Read, Glob, Grep
model: haiku
---

# Validate Configuration Framework

Run comprehensive validation checks on the Claude Code configuration framework to ensure integrity and consistency.

## Usage

```bash
/validate                # Full validation
/validate --commands     # Validate commands only
/validate --agents       # Validate agents only
/validate --platform     # Validate platform configuration
/validate --tasks        # Validate task files and registry
```

## Validation Checks

### 1. Command Validation

For each file in `.claude/commands/*.md`:

| Check | Rule | Severity |
|-------|------|----------|
| Frontmatter exists | Must have YAML frontmatter | Critical |
| Description field | Must have `description` | Critical |
| Allowed-tools field | Should have `allowed-tools` | Warning |
| Model field | Should have `model` | Warning |
| Valid model value | Must be `opus`, `sonnet`, or `haiku` | Error |
| Valid tools | All tools must be recognized | Error |

```markdown
## Command Validation

| Command | Status | Issues |
|---------|--------|--------|
| /brainstorm | ✅ | - |
| /build | ✅ | - |
| /test | ✅ | - |
```

### 2. Agent Validation

For each file in `.claude/agents/*.md`:

| Check | Rule | Severity |
|-------|------|----------|
| Frontmatter exists | Must have YAML frontmatter | Critical |
| Name field | Must have `name` | Critical |
| Description field | Must have `description` | Critical |
| Tools field | Must have `tools` | Warning |
| Model field | Should have `model` | Warning |
| Triggering conditions | Should have `<example>` blocks | Warning |

```markdown
## Agent Validation

| Agent | Status | Issues |
|-------|--------|--------|
| architect | ✅ | - |
| brainstorm | ✅ | - |
| reviewer | ✅ | - |
```

### 3. Platform Configuration Validation

For `docs/platform.json`:

| Check | Rule | Severity |
|-------|------|----------|
| Valid JSON | Must parse without errors | Critical |
| Required fields | Must have project, platforms | Critical |
| Platform config | At least one platform enabled | Error |
| iOS config valid | If iOS enabled, must have required fields | Error |
| Android config valid | If Android enabled, must have required fields | Error |

For `docs/platform-parity.json`:

| Check | Rule | Severity |
|-------|------|----------|
| Valid JSON | Must parse without errors | Critical |
| Version field | Must have version | Warning |
| Features registered | Should have feature entries | Warning |

### 4. Design Token Validation

For files in `docs/design/`:

| Check | Rule | Severity |
|-------|------|----------|
| colors.json exists | If platform enabled | Warning |
| typography.json exists | If platform enabled | Warning |
| spacing.json exists | If platform enabled | Warning |
| Valid token structure | Proper JSON format | Error |

### 5. Task Registry Validation

For `docs/tasks/.task-registry.json`:

| Check | Rule | Severity |
|-------|------|----------|
| Valid JSON | Must parse without errors | Critical |
| Version field | Must have version | Warning |
| Feature consistency | All features must have task files | Error |
| Task IDs unique | No duplicate task IDs | Error |
| Dependencies valid | All dependsOn references exist | Error |

For each `docs/tasks/*.md`:

| Check | Rule | Severity |
|-------|------|----------|
| Feature ID | Must have Feature ID in header | Warning |
| Progress table | Must have progress summary table | Warning |
| Task sections | Must have step sections | Warning |
| Subtask format | Subtasks must have valid IDs | Warning |

### 6. Cross-Reference Validation

| Check | Rule | Severity |
|-------|------|----------|
| CLAUDE.md imports | @import files must exist | Error |
| Command references | Commands in tables must exist | Warning |
| Agent references | Agents in tables must exist | Warning |
| Skill references | Skill files must exist | Warning |

## Output Format

```markdown
# Configuration Validation Report

**Validated At**: {timestamp}
**Scope**: Full / Commands / Agents / Platform / Tasks

---

## Summary

| Component | Passed | Warnings | Errors | Critical |
|-----------|--------|----------|--------|----------|
| Commands | 15 | 0 | 0 | 0 |
| Agents | 7 | 0 | 0 | 0 |
| Platform | 4 | 1 | 0 | 0 |
| Tasks | 12 | 2 | 0 | 0 |
| **Total** | **38** | **3** | **0** | **0** |

---

## Status: ✅ VALID (with warnings)

---

## Detailed Results

### Commands (15/15 Passed)

✅ All commands validated successfully.

### Agents (7/7 Passed)

✅ All agents validated successfully.

### Platform Configuration

✅ platform.json: Valid
⚠️ platform-parity.json: No features registered yet

### Tasks

✅ Task registry: Valid
⚠️ authentication.md: Missing acceptance criteria for auth-5

---

## Warnings (3)

| Component | File | Issue | Fix |
|-----------|------|-------|-----|
| Platform | platform-parity.json | No features registered | Run /generate-tasks |
| Tasks | authentication.md | Missing acceptance criteria | Add criteria to auth-5 |
| Tasks | user-profile.md | Orphaned subtask reference | Remove prof-2.5 reference |

---

## Recommendations

1. Register features using `/generate-tasks <feature>`
2. Complete missing acceptance criteria in task files
3. Run `/sync-tasks` to align registry with task files

---

## Quick Commands

- `/validate --commands` — Re-validate commands only
- `/sync-tasks` — Synchronize task registry
- `/platform-parity` — Check platform status
```

## Validation Rules Reference

### Severity Levels

| Level | Description | Action Required |
|-------|-------------|-----------------|
| Critical | Prevents framework operation | Must fix immediately |
| Error | Causes incorrect behavior | Should fix before use |
| Warning | Best practice violation | Fix when convenient |
| Info | Suggestion for improvement | Optional |

### Valid Tool Names

```
Read, Write, Edit, Glob, Grep, Bash, Task, TaskCreate,
TaskUpdate, TaskList, TaskGet, AskUserQuestion, WebFetch,
WebSearch, Skill
```

### Valid Model Names

```
opus, sonnet, haiku
```

## Integration

Use this command:
- After modifying configuration files
- Before starting new features
- During framework audits
- After framework updates
