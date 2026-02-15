---
description: Generate feature specification from PRD with dynamic task tracking and Claude Code integration
argument-hint: <feature-name>
allowed-tools: Read, Write, Edit, Glob, Grep, TaskCreate, TaskUpdate, TaskList
model: sonnet
---

# Generate Feature Tasks

Read the PRD at `docs/PRD.md` and create a comprehensive specification with dynamic task tracking for: $ARGUMENTS

## Overview

This command creates:
1. **Feature Specification** (`docs/tasks/{feature}.md`) - Human-readable documentation
2. **Task Registry Entry** (`docs/tasks/.task-registry.json`) - Machine-readable tracking
3. **Claude Code Tasks** - Session-based task management with dependencies

## Steps

### Step 1: Pre-Flight Validation

1. Verify PRD exists at `docs/PRD.md`
2. Check for existing task file for this feature
3. Load or initialize task registry

### Step 2: Analyze PRD

1. Read and analyze the PRD
2. Extract relevant user stories for this feature
3. Identify acceptance criteria
4. Note dependencies on other features

### Step 3: Design Technical Architecture

1. Define data models
2. Specify API endpoints (if applicable)
3. Outline state management approach
4. Identify external dependencies

### Step 4: Create Task Breakdown

1. Identify all implementation steps
2. Order by dependencies (prerequisites first)
3. Estimate complexity (S/M/L)
4. Generate unique task IDs: `{feature-prefix}-{step}[.{subtask}]`
5. Define subtasks for each step
6. Set clear acceptance criteria

### Step 5: Generate Documentation

Create `docs/tasks/$ARGUMENTS.md` using the enhanced template below.

### Step 6: Register Tasks

1. Update `docs/tasks/.task-registry.json`
2. Create Claude Code tasks via TaskCreate
3. Set up task dependencies via TaskUpdate

### Step 7: Output Summary

Display created tasks and next steps.

---

## Document Structure

Create `docs/tasks/$ARGUMENTS.md`:

```markdown
# Feature: [Feature Name]

**Feature ID**: {feature-prefix}
**Status**: Draft | In Review | Approved | In Progress | Complete
**Priority**: P0 | P1 | P2
**PRD Reference**: Section [X]
**Author**: Claude Code
**Created**: [Date]
**Last Updated**: [Date]

---

## 1. Overview

[Brief description of the feature and its purpose - 2-3 sentences]

---

## 2. User Stories

1. As a [user], I want [action] so that [benefit]
2. As a [user], I want [action] so that [benefit]
3. ...

---

## 3. Acceptance Criteria

- [ ] AC1: [Specific, testable criterion]
- [ ] AC2: [Specific, testable criterion]
- [ ] AC3: [Specific, testable criterion]

---

## 4. Technical Design

### 4.1 Architecture

[How this feature fits into the overall architecture]

### 4.2 Data Models

```[language]
// Model definitions with types
```

### 4.3 API Endpoints (if applicable)

| Method | Endpoint | Description | Request | Response |
|--------|----------|-------------|---------|----------|
| GET | /api/... | ... | ... | ... |
| POST | /api/... | ... | ... | ... |

### 4.4 State Management

[How state is managed for this feature]

### 4.5 Dependencies

**Internal Prerequisites:**
- [ ] [Feature/module that must be complete first]

**External Dependencies:**
- [ ] [External API/service required]

---

## 5. UI/UX Design

- **Design Reference**: [Link if available]
- **Key Screens**: [List of screens]
- **User Flow**: [Description of the user journey]

---

## 6. Edge Cases & Error Handling

### Edge Cases

| Scenario | Expected Behavior |
|----------|-------------------|
| [Edge case 1] | [How to handle] |

### Error Handling

| Error | User Message | Recovery Action |
|-------|--------------|-----------------|
| [Error type] | [User-friendly message] | [Recovery steps] |

---

## 7. Security & Performance

### Security Considerations

- [ ] [Security item 1]
- [ ] [Security item 2]

### Performance Considerations

- [ ] [Performance item 1]
- [ ] [Performance item 2]

---

## 8. Implementation Tasks

### Progress Summary

**Feature ID**: `{feature-prefix}`
**Total Tasks**: N | **Completed**: 0 | **Progress**: 0%

| ID | Task | Size | Status | Depends On | Assignee |
|----|------|------|--------|------------|----------|
| {prefix}-1 | [Task name] | S/M/L | ⬜ | - | - |
| {prefix}-2 | [Task name] | S/M/L | ⬜ | {prefix}-1 | - |
| {prefix}-3 | [Task name] | S/M/L | ⬜ | {prefix}-2 | - |

**Status Legend**: ⬜ Pending | 🔄 In Progress | ✅ Complete | ⏸️ Blocked | 🚫 Cancelled

### Prerequisites

- [ ] [External dependency that must be ready]
- [ ] [Internal prerequisite that must be complete]

---

### Task: {prefix}-1 — [Task Name]

**ID**: `{prefix}-1`
**Size**: S | M | L
**Status**: ⬜ Pending
**Depends On**: None
**Blocks**: {prefix}-2
**Assignee**: -
**Acceptance**: [When is this task done?]

#### Subtasks

- [ ] `{prefix}-1.1` [Subtask 1]
- [ ] `{prefix}-1.2` [Subtask 2]
- [ ] `{prefix}-1.3` [Subtask 3]

#### Implementation Notes

[Detailed guidance for implementation]

#### Files to Create/Modify

| File | Action | Description |
|------|--------|-------------|
| `path/to/file.ext` | Create/Modify | [What to do] |

#### Verification

```bash
# Command to verify this task is complete
```

---

### Task: {prefix}-2 — [Task Name]

**ID**: `{prefix}-2`
**Size**: S | M | L
**Status**: ⬜ Pending
**Depends On**: {prefix}-1
**Blocks**: {prefix}-3
**Assignee**: -
**Acceptance**: [When is this task done?]

#### Subtasks

- [ ] `{prefix}-2.1` [Subtask 1]
- [ ] `{prefix}-2.2` [Subtask 2]

#### Implementation Notes

[Detailed guidance for implementation]

#### Files to Create/Modify

| File | Action | Description |
|------|--------|-------------|
| `path/to/file.ext` | Create/Modify | [What to do] |

---

### Task: {prefix}-N — [Continue as needed...]

---

## 9. Testing Plan

### Unit Tests

| Component | Test Cases | Priority | Task ID |
|-----------|------------|----------|---------|
| [Component 1] | [Test description] | High | {prefix}-N |

### Integration Tests

| Flow | Test Cases | Priority | Task ID |
|------|------------|----------|---------|
| [Flow 1] | [Test description] | High | {prefix}-N |

### E2E Tests

| Scenario | Test Cases | Priority | Task ID |
|----------|------------|----------|---------|
| [Scenario 1] | [Test description] | High | {prefix}-N |

---

## 10. Rollout Plan

- [ ] Feature flag: `feature_{name}_enabled`
- [ ] Metrics to monitor: [List metrics]
- [ ] Rollback plan: [Describe rollback steps]

---

## 11. Open Questions

- [ ] Q1: [Question needing answer]
- [ ] Q2: [Question needing answer]

---

## 12. Change Log

| Date | Author | Changes | Tasks Affected |
|------|--------|---------|----------------|
| [Date] | Claude Code | Initial specification and task breakdown | All |
```

---

## Task Registry Format

Update `docs/tasks/.task-registry.json`:

```json
{
  "version": "1.0",
  "lastUpdated": "[ISO timestamp]",
  "features": {
    "{feature-name}": {
      "file": "docs/tasks/{feature-name}.md",
      "prefix": "{prefix}",
      "status": "pending",
      "priority": "P0|P1|P2",
      "createdAt": "[ISO timestamp]",
      "updatedAt": "[ISO timestamp]",
      "progress": {
        "total": 0,
        "completed": 0,
        "inProgress": 0,
        "blocked": 0,
        "percentage": 0
      },
      "tasks": [
        {
          "id": "{prefix}-1",
          "name": "[Task name]",
          "status": "pending",
          "size": "S|M|L",
          "dependsOn": [],
          "blocks": ["{prefix}-2"],
          "assignee": null,
          "subtasks": [
            {
              "id": "{prefix}-1.1",
              "name": "[Subtask name]",
              "status": "pending"
            }
          ],
          "acceptance": "[Criteria]",
          "files": ["path/to/file.ext"]
        }
      ]
    }
  }
}
```

---

## Claude Code Task Integration

After creating the documentation, register tasks with Claude Code:

### Create Tasks

For each task in the breakdown:

```
TaskCreate:
  subject: "{prefix}-{N}: {Task Name}"
  description: |
    Feature: {feature-name}
    Size: {S/M/L}
    Acceptance: {criteria}

    Subtasks:
    - {subtask list}

    Files to modify:
    - {file list}
  activeForm: "Working on {Task Name}"
```

### Set Dependencies

For tasks with dependencies:

```
TaskUpdate:
  taskId: "{claude-task-id}"
  addBlockedBy: ["{blocking-task-ids}"]
```

---

## Task Sizing Guide

| Size | Description | Typical Scope | Subtasks |
|------|-------------|---------------|----------|
| S | Simple | Single file change, straightforward logic | 1-3 |
| M | Medium | Multiple files, moderate complexity | 3-5 |
| L | Large | Significant changes, consider splitting | 5-8 |

---

## Guidelines

### Task Definition
- Each task should be completable in a single focused session
- Tasks should be independently verifiable
- Include clear acceptance criteria for each step
- Order by dependencies (prerequisites first)
- Split L-sized tasks if they have >8 subtasks

### ID Conventions
- Feature prefix: 3-4 lowercase letters (e.g., `auth`, `prof`, `dash`)
- Task ID: `{prefix}-{sequential-number}` (e.g., `auth-1`, `auth-2`)
- Subtask ID: `{prefix}-{task}.{subtask}` (e.g., `auth-1.1`, `auth-1.2`)

### Status Updates
- Use `/update-task {id} {status}` to change task status
- Use `/task-status` to view current progress
- Use `/next-task` to get the next available task

---

## Output

After generation, display:

1. **Task Summary**
   ```
   ## Feature: {name}

   Created {N} tasks with {M} subtasks

   | ID | Task | Size | Depends On |
   |----|------|------|------------|
   | ... | ... | ... | ... |
   ```

2. **Next Steps**
   ```
   ## Next Steps

   1. Review the specification at `docs/tasks/{feature}.md`
   2. Start implementation with: `/next-task`
   3. Track progress with: `/task-status`
   4. Update tasks with: `/update-task {id} {status}`
   ```

3. **Registry Status**
   ```
   ## Task Registry

   Updated: docs/tasks/.task-registry.json
   Claude Code Tasks: {N} created with dependencies
   ```
