---
description: Update task status and sync across all tracking systems
argument-hint: <task-id> <status> — e.g., "auth-3 complete" or "auth-3.2 done"
allowed-tools: Read, Write, Edit, Glob, TaskList, TaskGet, TaskUpdate
model: haiku
---

# Update Task

Update task or subtask status and synchronize across documentation, registry, and Claude Code.

## Usage

```
/update-task <task-id> <status>
/update-task <task-id>.<subtask> <status>
```

## Examples

```
/update-task auth-3 complete      # Complete a task
/update-task auth-3.2 done        # Complete a subtask
/update-task auth-4 in-progress   # Start a task
/update-task auth-5 blocked       # Mark as blocked
/update-task auth-2 pending       # Reset to pending
```

## Arguments

**task-id**: Task identifier in format `{prefix}-{number}` or `{prefix}-{number}.{subtask}`

**status**: One of:
| Input | Maps To | Emoji |
|-------|---------|-------|
| `complete`, `done`, `finished` | `completed` | ✅ |
| `in-progress`, `start`, `working` | `in_progress` | 🔄 |
| `pending`, `todo`, `reset` | `pending` | ⬜ |
| `blocked`, `waiting` | `blocked` | ⏸️ |
| `cancelled`, `skip` | `cancelled` | 🚫 |

## Steps

### 1. Parse Arguments

Extract from $ARGUMENTS:
- Task/subtask ID
- Target status
- Validate format

### 2. Locate Task

1. Parse feature prefix from ID (e.g., `auth` from `auth-3`)
2. Load registry: `docs/tasks/.task-registry.json`
3. Find task in feature
4. If subtask, find within parent task

### 3. Validate Transition

Check status transition is valid:

```
pending → in_progress ✓
pending → blocked ✓
in_progress → completed ✓
in_progress → blocked ✓
in_progress → pending ✓ (reset)
blocked → pending ✓
blocked → in_progress ✓
completed → pending ✓ (reopen)
cancelled → pending ✓ (restore)
```

### 4. Update Registry

```json
{
  "tasks": [{
    "id": "auth-3",
    "status": "completed",  // Updated
    "completedAt": "2024-01-15T10:30:00Z"  // Added
  }]
}
```

For subtasks:
```json
{
  "subtasks": [{
    "id": "auth-3.2",
    "status": "completed"  // Updated
  }]
}
```

### 5. Update Markdown File

Find and update in `docs/tasks/{feature}.md`:

**Progress Summary Table:**
```markdown
| auth-3 | Add password hashing | S | ✅ | auth-2 | - |
```

**Task Section:**
```markdown
### Task: auth-3 — Add password hashing

**Status**: ✅ Complete
```

**Subtask Checkbox:**
```markdown
- [x] `auth-3.2` Implement salt generation
```

### 6. Update Claude Code Tasks

```
TaskUpdate:
  taskId: {claude-task-id}
  status: completed
```

### 7. Cascade Updates

After completing a task:

1. **Check Parent Completion** (for subtasks)
   - If all subtasks complete, mark parent complete

2. **Unblock Dependents**
   - Find tasks with this task in `dependsOn`
   - If all dependencies now complete, change from `blocked` to `pending`

3. **Update Feature Progress**
   - Recalculate completed/total
   - Update percentage

### 8. Output Result

## Output Format

### Successful Update

```markdown
# Task Updated

## {prefix}-{N}: {Task Name}

**Previous Status**: ⬜ Pending
**New Status**: ✅ Complete
**Updated At**: {timestamp}

---

### Changes Applied

- ✅ Registry updated: `docs/tasks/.task-registry.json`
- ✅ Markdown updated: `docs/tasks/{feature}.md`
- ✅ Claude Code task updated

### Cascade Effects

**Unblocked Tasks:**
- `{prefix}-{N+1}`: {Next task name} — now available

**Feature Progress:**
- {Feature}: {X}/{Y} tasks complete ({Z}%)

---

## Next Steps

1. Start next task: `/next-task`
2. View progress: `/task-status`
```

### Subtask Update

```markdown
# Subtask Updated

## {prefix}-{N}.{M}: {Subtask Name}

**Parent Task**: {prefix}-{N} — {Parent Name}
**Previous Status**: ⬜ Pending
**New Status**: ✅ Complete

---

### Parent Task Progress

- [x] `{prefix}-{N}.1` {Subtask 1}
- [x] `{prefix}-{N}.2` {Subtask 2}  ← Updated
- [ ] `{prefix}-{N}.3` {Subtask 3}

**Subtask Progress**: 2/3 (67%)

---

### Next Subtask

`{prefix}-{N}.3`: {Next subtask description}
```

### Task Not Found

```markdown
# Task Not Found

Could not find task: `{task-id}`

## Did you mean?

| ID | Task | Feature |
|----|------|---------|
| auth-3 | Add password hashing | Authentication |
| auth-4 | Implement JWT tokens | Authentication |

## Available Features

- `auth` — Authentication (5 tasks)
- `prof` — User Profile (4 tasks)

Run `/task-status` to see all tasks.
```

### Invalid Transition

```markdown
# Invalid Status Transition

Cannot change `{prefix}-{N}` from **{current}** to **{target}**.

## Current State

**Task**: {prefix}-{N} — {Task Name}
**Status**: ⏸️ Blocked
**Blocked By**: {prefix}-{M} (in progress)

## Resolution

Complete blocking task first:
```
/update-task {prefix}-{M} complete
```

Then this task will automatically become available.
```

## Batch Updates

For multiple updates, call multiple times:

```
/update-task auth-3.1 done
/update-task auth-3.2 done
/update-task auth-3.3 done
/update-task auth-3 complete
```

Or mark parent complete to auto-complete remaining subtasks:

```
/update-task auth-3 complete
# All incomplete subtasks marked complete
```

## Integration

- Updates flow to all three systems: Registry, Markdown, Claude Code
- Triggers cascade updates for dependencies
- Recalculates progress automatically
- Works with `/task-status` and `/next-task`
