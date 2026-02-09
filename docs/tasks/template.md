# Feature: [Feature Name]

**Feature ID**: `{prefix}`
**Status**: Draft | In Review | Approved | In Progress | Complete
**Priority**: P0 | P1 | P2
**PRD Reference**: Section [X]
**Author**: Claude Code
**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]

---

## 1. Overview

[Brief description of the feature and its purpose - 2-3 sentences explaining the value delivered]

---

## 2. User Stories

1. As a [user type], I want [action] so that [benefit]
2. As a [user type], I want [action] so that [benefit]
3. As a [user type], I want [action] so that [benefit]

---

## 3. Acceptance Criteria

- [ ] AC1: [Specific, testable criterion]
- [ ] AC2: [Specific, testable criterion]
- [ ] AC3: [Specific, testable criterion]

---

## 4. Technical Design

### 4.1 Architecture

[How this feature fits into the overall architecture]

```
[Component diagram or data flow]
```

### 4.2 Data Models

```[language]
// Define data structures with types
interface FeatureModel {
  id: string;
  // ... properties
}
```

### 4.3 API Endpoints (if applicable)

| Method | Endpoint | Description | Request | Response |
|--------|----------|-------------|---------|----------|
| GET | `/api/v1/...` | ... | - | `{ ... }` |
| POST | `/api/v1/...` | ... | `{ ... }` | `{ ... }` |

### 4.4 State Management

[How state is managed for this feature]

### 4.5 Dependencies

**Internal Prerequisites:**
- [ ] [Feature/module that must be complete first]

**External Dependencies:**
- [ ] [External API/service required]

---

## 5. UI/UX Design

- **Design Reference**: [Figma/Design Link if available]
- **Key Screens**: [List of screens]
- **User Flow**: [Description of the user journey]

### User Flow Diagram

```
[Start] → [Step 1] → [Step 2] → [Decision]
                                   ↓
                          [Yes] → [Step 3] → [End]
                          [No]  → [Step 4] → [End]
```

---

## 6. Edge Cases & Error Handling

### Edge Cases

| Scenario | Expected Behavior |
|----------|-------------------|
| [Edge case 1] | [How to handle] |
| [Edge case 2] | [How to handle] |

### Error Handling

| Error Condition | User Message | Technical Handling |
|-----------------|--------------|-------------------|
| [Error 1] | [User-friendly message] | [Log, retry, etc.] |
| [Error 2] | [User-friendly message] | [Log, retry, etc.] |

---

## 7. Security & Performance

### Security Considerations

- [ ] [Security item - e.g., input validation]
- [ ] [Security item - e.g., authorization checks]

### Performance Considerations

- [ ] [Performance item - e.g., lazy loading]
- [ ] [Performance item - e.g., caching]

---

## 8. Implementation Tasks

### Progress Summary

**Feature ID**: `{prefix}`
**Total Tasks**: N | **Completed**: 0 | **Progress**: 0%

| ID | Task | Size | Status | Depends On | Assignee |
|----|------|------|--------|------------|----------|
| {prefix}-1 | [Task name] | S/M/L | ⬜ | - | - |
| {prefix}-2 | [Task name] | S/M/L | ⬜ | {prefix}-1 | - |
| {prefix}-3 | [Task name] | S/M/L | ⬜ | {prefix}-2 | - |

**Status Legend**: ⬜ Pending | 🔄 In Progress | ✅ Complete | ⏸️ Blocked | 🚫 Cancelled

### Prerequisites

- [ ] [Prerequisite 1 - e.g., API endpoint available]
- [ ] [Prerequisite 2 - e.g., design approved]

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
| [Component 1] | [Test description] | High/Medium/Low | {prefix}-N |
| [Component 2] | [Test description] | High/Medium/Low | {prefix}-N |

### Integration Tests

| Flow | Test Cases | Priority | Task ID |
|------|------------|----------|---------|
| [Flow 1] | [Test description] | High/Medium/Low | {prefix}-N |

### E2E Tests

| Scenario | Test Cases | Priority | Task ID |
|----------|------------|----------|---------|
| [Scenario 1] | [Test description] | High/Medium/Low | {prefix}-N |

### Manual Testing

- [ ] [Manual verification 1]
- [ ] [Manual verification 2]

---

## 10. Rollout Plan

- [ ] Feature flag: `feature_{name}_enabled`
- [ ] Metrics to monitor: [List metrics]
- [ ] Rollback plan: [Describe rollback steps]

---

## 11. Open Questions

- [ ] [Question needing answer]
- [ ] [Question needing answer]

---

## 12. Change Log

| Date | Author | Changes | Tasks Affected |
|------|--------|---------|----------------|
| [Date] | [Name] | Initial specification and task breakdown | All |

---

## Quick Reference

### Task Sizing Guide

| Size | Description | Typical Scope | Subtasks |
|------|-------------|---------------|----------|
| S | Simple | Single file change, straightforward logic | 1-3 |
| M | Medium | Multiple files, moderate complexity | 3-5 |
| L | Large | Significant changes, consider splitting | 5-8 |

### Task Commands

```bash
# View current status
/task-status {feature}

# Get next available task
/next-task

# Update task status
/update-task {id} complete
/update-task {id} in-progress
/update-task {id} blocked

# Sync all tasks
/sync-tasks
```
