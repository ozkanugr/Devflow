---
description: Get the next available task to work on based on priority and dependencies
argument-hint: "[feature] - Optional: get next task for specific feature only"
allowed-tools: Read, Glob, TaskList, TaskGet, TaskUpdate, AskUserQuestion
model: haiku
---

# Next Task

Find and present the next available task to work on, respecting priorities and dependencies.

## Behavior

1. Load task registry
2. Filter available tasks (not blocked, not complete)
3. Sort by priority and order
4. Present the best candidate
5. Optionally start the task

## Selection Algorithm

```
1. Get all tasks from registry
2. Filter: status == 'pending'
3. Filter: all dependencies completed
4. Sort by:
   a. Feature priority (P0 > P1 > P2)
   b. Task order within feature (1, 2, 3...)
5. Return first match
```

## Steps

1. **Load Registry**
   - Read `docs/tasks/.task-registry.json`
   - Parse all features and tasks

2. **Find Available Tasks**
   - Exclude completed tasks
   - Exclude in-progress tasks (unless reassigning)
   - Exclude blocked tasks

3. **Check Dependencies**
   - For each candidate, verify all `dependsOn` tasks are completed
   - Skip tasks with incomplete dependencies

4. **Apply Filters** (if $ARGUMENTS provided)
   - Filter to specified feature only

5. **Sort and Select**
   - Apply priority ordering
   - Select highest priority unblocked task

6. **Present Task**
   - Show full task details
   - Offer to start

## Output Format

### When Task Available

```markdown
# Next Available Task

## Task: {prefix}-{N} — {Task Name}

**Feature**: {Feature Name}
**Priority**: P{0|1|2}
**Size**: {S|M|L}
**Estimated Effort**: {size description}

---

### Prerequisites (Completed)

- ✅ `{prefix}-1`: {Previous task 1}
- ✅ `{prefix}-2`: {Previous task 2}

### This Task Blocks

- `{prefix}-{N+1}`: {Next task}

---

### Acceptance Criteria

{When is this task done?}

---

### Subtasks

- [ ] `{prefix}-{N}.1` {Subtask 1}
- [ ] `{prefix}-{N}.2` {Subtask 2}
- [ ] `{prefix}-{N}.3` {Subtask 3}

---

### Files to Modify

| File | Action | Description |
|------|--------|-------------|
| `path/to/file1.ext` | Create | {What to create} |
| `path/to/file2.ext` | Modify | {What to change} |

---

### Implementation Notes

{Detailed guidance from the task specification}

---

### Verification

```bash
{Command to verify task completion}
```

---

## Actions

Would you like me to:
1. **Start this task** — Mark as in-progress and begin implementation
2. **Skip to next** — See the following available task
3. **View feature status** — See all tasks for this feature
```

### When No Tasks Available

```markdown
# No Tasks Available

All current tasks are either:
- ✅ Complete
- 🔄 In progress
- ⏸️ Blocked

## Current Status

| Feature | Progress | Blocking Task |
|---------|----------|---------------|
| Auth | 80% | auth-5 blocked by auth-4 (in progress) |

## Recommendations

1. Complete `auth-4` (currently in progress) to unblock `auth-5`
2. Generate tasks for a new feature: `/generate-tasks <feature>`
3. Review completed work: `/task-status`
```

### When All Tasks Complete

```markdown
# All Tasks Complete!

Congratulations! All tracked tasks have been completed.

## Summary

| Feature | Tasks | Status |
|---------|-------|--------|
| Authentication | 5/5 | ✅ Complete |
| User Profile | 4/4 | ✅ Complete |
| **Total** | **9/9** | **100%** |

## Next Steps

1. Run final tests: `/test`
2. Build the project: `/build`
3. Generate tasks for new features
4. Consider code review: Use Reviewer agent
```

## Starting a Task

When user chooses to start:

1. Update registry: set task status to `in_progress`
2. Update Claude Code task: `TaskUpdate` with status
3. Update markdown file: change ⬜ to 🔄
4. Set assignee to current session
5. Display implementation guidance

```
## Task Started: {prefix}-{N}

Status updated to 🔄 In Progress

### Quick Reference

**File**: `docs/tasks/{feature}.md`
**Section**: Task {N}

### First Subtask

Start with: `{prefix}-{N}.1` — {Subtask description}

### When Complete

Run: `/update-task {prefix}-{N} complete`
```

## Integration

Works with:
- `/task-status` — View overall progress
- `/update-task` — Change task status
- `/generate-tasks` — Create new tasks

## Notes

- Tasks are assigned to the current session when started
- Use `/update-task {id} pending` to unassign and make available again
- L-sized tasks should be reviewed before starting — consider splitting
