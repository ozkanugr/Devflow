---
description: Display current task status and progress across all features
argument-hint: "[feature] - Optional: show status for specific feature only"
allowed-tools: Read, Glob, TaskList, TaskGet
model: haiku
---

# Task Status

Display comprehensive progress tracking for all features or a specific feature.

## Behavior

### When No Arguments

Show overall project task status:

1. Load task registry from `docs/tasks/.task-registry.json`
2. Calculate progress for each feature
3. Aggregate total project progress
4. Show current in-progress and blocked tasks
5. Recommend next actions

### When Feature Specified ($ARGUMENTS)

Show detailed status for that feature:

1. Load feature from registry
2. Show all tasks with current status
3. Show subtask completion
4. Identify blockers and dependencies

## Steps

1. **Load Registry**
   - Read `docs/tasks/.task-registry.json`
   - If missing, scan `docs/tasks/*.md` for task files

2. **Calculate Progress**
   - For each feature: count completed/total tasks
   - Calculate percentage: (completed / total) * 100

3. **Generate Report**

## Output Format

### Project Overview (No Arguments)

```markdown
# Project Task Status

**Last Updated**: [timestamp]

## Overall Progress

| Feature | Priority | Tasks | Progress | Status |
|---------|----------|-------|----------|--------|
| Authentication | P0 | 3/5 | 60% | 🔄 |
| User Profile | P1 | 0/4 | 0% | ⬜ |
| Dashboard | P1 | 0/6 | 0% | ⬜ |
| **Total** | - | **3/15** | **20%** | - |

## Currently Active

### 🔄 In Progress
- `auth-4`: Implement JWT token refresh (M) — @claude
- `auth-3`: Add password hashing (S) — unassigned

### ⏸️ Blocked
- `auth-5`: Write authentication tests — blocked by auth-4

## Recommended Actions

1. Complete `auth-4` to unblock `auth-5`
2. Assign `auth-3` to continue progress
3. Run `/next-task` to see what's available

## Quick Commands

- `/task-status authentication` — Details for auth feature
- `/next-task` — Get next available task
- `/update-task auth-4 complete` — Mark task as complete
```

### Feature Detail ($ARGUMENTS provided)

```markdown
# Feature: Authentication

**ID**: `auth`
**Priority**: P0
**Status**: 🔄 In Progress
**Progress**: 60% (3/5 tasks complete)

## Task Breakdown

| ID | Task | Size | Status | Subtasks | Assignee |
|----|------|------|--------|----------|----------|
| auth-1 | Create user model | S | ✅ | 3/3 | - |
| auth-2 | Setup auth routes | S | ✅ | 2/2 | - |
| auth-3 | Add password hashing | S | ✅ | 2/2 | - |
| auth-4 | Implement JWT tokens | M | 🔄 | 2/4 | claude |
| auth-5 | Write auth tests | L | ⏸️ | 0/6 | - |

## Detailed Status

### ✅ Completed Tasks

**auth-1**: Create user model
- [x] Define user schema
- [x] Add validation rules
- [x] Create database migration

**auth-2**: Setup auth routes
- [x] Create login endpoint
- [x] Create register endpoint

**auth-3**: Add password hashing
- [x] Integrate bcrypt
- [x] Add salt rounds config

### 🔄 In Progress

**auth-4**: Implement JWT tokens (2/4 subtasks)
- [x] Generate access token
- [x] Generate refresh token
- [ ] Add token validation middleware
- [ ] Implement token refresh endpoint

**Blocked By**: None
**Blocks**: auth-5

### ⏸️ Blocked

**auth-5**: Write authentication tests
- Blocked by: auth-4 (Implement JWT tokens)
- Will be available when auth-4 completes

## Next Steps

1. Complete remaining subtasks for auth-4
2. Once auth-4 complete, start auth-5
3. Feature will be complete after auth-5

## Quick Commands

- `/update-task auth-4 complete` — Mark JWT task complete
- `/next-task` — Get next available task
```

## Status Mapping

| Registry Status | Display | Meaning |
|-----------------|---------|---------|
| `pending` | ⬜ | Not started |
| `in_progress` | 🔄 | Currently being worked on |
| `completed` | ✅ | Done and verified |
| `blocked` | ⏸️ | Waiting on dependencies |
| `cancelled` | 🚫 | No longer needed |

## Progress Calculation

```
Feature Progress = (completed_tasks / total_tasks) * 100

Subtask Progress = (checked_subtasks / total_subtasks)

Project Progress = sum(feature_progress * feature_weight) / total_weight
  where weight = P0:3, P1:2, P2:1
```

## Integration

This command reads from:
- `docs/tasks/.task-registry.json` — Primary source
- `docs/tasks/*.md` — Fallback if registry missing
- Claude Code TaskList — Session-based tasks

## Notes

- Run after `/generate-tasks` to see new tasks
- Run regularly during implementation to track progress
- Use with `/next-task` and `/update-task` for workflow
