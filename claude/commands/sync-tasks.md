---
description: Synchronize task registry with markdown files and Claude Code tasks
argument-hint: "[feature] - Optional: sync specific feature only"
allowed-tools: Read, Write, Edit, Glob, Grep, TaskCreate, TaskUpdate, TaskList, TaskGet
model: sonnet
---

# Sync Tasks

Synchronize task status across all tracking systems: markdown files, JSON registry, and Claude Code tasks.

## Purpose

Ensures consistency when:
- Markdown files are manually edited
- Registry gets out of sync
- Starting a new Claude Code session
- Recovering from interrupted work

## Sync Direction

```
┌─────────────────┐
│  Markdown Files │ ──┐
│  (docs/tasks/)  │   │
└─────────────────┘   │    ┌──────────────────┐
                      ├──→ │  Task Registry   │
┌─────────────────┐   │    │  (.json)         │
│  Claude Code    │ ──┘    └──────────────────┘
│  Task System    │              │
└─────────────────┘              ↓
        ↑              ┌──────────────────┐
        └───────────── │  Sync Report     │
                       └──────────────────┘
```

## Steps

### 1. Scan Task Files

```
1. Glob for docs/tasks/*.md (exclude template.md)
2. For each file:
   a. Extract feature ID from filename
   b. Parse Progress Summary table
   c. Parse each Task section
   d. Extract subtask checkboxes
```

### 2. Load Registry

```
1. Read docs/tasks/.task-registry.json
2. If missing, initialize empty registry
3. Compare with parsed markdown data
```

### 3. Detect Discrepancies

For each feature and task, compare:
- Status in markdown vs registry
- Subtask completion states
- Missing tasks in either source

### 4. Resolve Conflicts

**Resolution Priority** (most recent wins):
1. If markdown has later timestamp → use markdown
2. If registry has later timestamp → use registry
3. If unclear → use more complete status (completed > in_progress > pending)

### 5. Update All Systems

```
For each discrepancy:
  1. Update registry with resolved value
  2. Update markdown with resolved value
  3. Update Claude Code tasks
```

### 6. Recalculate Progress

```
For each feature:
  1. Count completed tasks
  2. Calculate percentage
  3. Update progress in registry
```

## Output Format

### Sync Report

```markdown
# Task Sync Report

**Synced At**: {timestamp}
**Features Scanned**: {N}
**Tasks Processed**: {M}

---

## Changes Applied

### Registry Updates

| Feature | Task | Change |
|---------|------|--------|
| auth | auth-3 | Status: pending → completed |
| auth | auth-4.2 | Subtask marked complete |

### Markdown Updates

| File | Line | Change |
|------|------|--------|
| authentication.md | 45 | ⬜ → ✅ |
| authentication.md | 67 | - [ ] → - [x] |

### Claude Code Tasks

| Task | Action |
|------|--------|
| auth-3 | Status updated to completed |
| auth-5 | Created (was missing) |

---

## Progress Summary

| Feature | Before | After | Delta |
|---------|--------|-------|-------|
| Authentication | 40% | 60% | +20% |
| User Profile | 0% | 0% | - |

---

## Issues Found

### Orphaned Tasks

Tasks in registry but not in markdown:
- `auth-6` — Removed from registry

### Missing Dependencies

Tasks with invalid dependsOn references:
- `prof-3` depends on `auth-99` (not found) — Dependency removed

---

## Next Steps

1. Review changes above
2. Run `/task-status` to verify
3. Continue with `/next-task`
```

### No Changes Needed

```markdown
# Task Sync Report

**Synced At**: {timestamp}

✅ All systems in sync. No changes needed.

| Feature | Tasks | Progress |
|---------|-------|----------|
| Authentication | 5 | 60% |
| User Profile | 4 | 0% |

Run `/task-status` for detailed view.
```

## Registry Initialization

When no registry exists:

```markdown
# Task Registry Initialized

Created: `docs/tasks/.task-registry.json`

## Features Registered

| Feature | File | Tasks | Priority |
|---------|------|-------|----------|
| Authentication | authentication.md | 5 | P0 |
| User Profile | user-profile.md | 4 | P1 |

## Claude Code Tasks Created

Created {N} tasks with dependencies:
- auth-1, auth-2, auth-3, auth-4, auth-5
- prof-1, prof-2, prof-3, prof-4

Run `/next-task` to start working.
```

## Markdown Parsing

### Progress Summary Table

Regex pattern:
```
\| ([\w-]+) \| ([^|]+) \| ([SML]) \| ([⬜🔄✅⏸️🚫]) \| ([^|]*) \|
```

Captures:
1. Task ID
2. Task name
3. Size
4. Status emoji
5. Dependencies

### Subtask Checkboxes

Regex pattern:
```
- \[([ x])\] `([\w.-]+)` (.+)
```

Captures:
1. Checked state (space or x)
2. Subtask ID
3. Subtask description

### Task Metadata

Regex pattern:
```
\*\*Status\*\*: ([⬜🔄✅⏸️🚫]) (\w+)
```

## Integration

Use after:
- Manual markdown edits
- Starting new session
- Recovering from errors
- Before `/task-status` if unsure

Automatically called by:
- `/generate-tasks` (after creating new tasks)
- `/update-task` (after each update)

## Notes

- Run with feature argument to sync only one feature
- Backs up registry before making changes
- Creates `.task-registry.backup.json` before sync
- Safe to run multiple times (idempotent)
