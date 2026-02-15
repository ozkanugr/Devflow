# Workflow History

> Successful workflow patterns and approaches that work well.

## Feature Development

### Pattern: Full Feature Workflow

**Steps**:
1. `/brainstorm [feature description]` - Clarify requirements
2. `/create-prd` - Document requirements
3. `/generate-tasks [feature]` - Create task breakdown
4. `/next-task` - Get first task
5. Implement on primary platform
6. `/update-task [id] complete` - Mark done
7. Repeat 4-6 for remaining tasks
8. `/implement-[other-platform] [feature]` - Second platform
9. `/platform-parity [feature]` - Verify consistency
10. `/test` - Run tests

**Why it works**:
- Structured approach prevents missing requirements
- Task tracking ensures nothing is forgotten
- Parity check catches inconsistencies early

**When to use**: New feature implementation

---

### Pattern: Quick Fix Workflow

**Steps**:
1. Read the relevant code
2. Identify the issue
3. Make minimal fix
4. Test the specific case
5. Check for side effects
6. Commit with clear message

**Why it works**:
- Minimal changes = minimal risk
- Quick turnaround

**When to use**: Bug fixes, small changes

---

## Cross-Platform Development

### Pattern: Primary Platform First

**Steps**:
1. Implement fully on primary platform (usually iOS)
2. Verify behavior and edge cases
3. Document any platform-specific decisions
4. Port to secondary platform
5. Run parity check

**Why it works**:
- One source of truth for behavior
- Easier to port than co-develop
- Catches platform differences explicitly

**When to use**: New features with complex logic

---

### Pattern: Alternating Implementation

**Steps**:
1. Implement feature component on iOS
2. Immediately implement same component on Android
3. Repeat for next component
4. Run parity check after each pair

**Why it works**:
- Catches drift immediately
- Better mental context switching
- Smaller parity reviews

**When to use**: UI-focused features

---

## Debugging

### Pattern: Systematic Isolation

**Steps**:
1. Reproduce the issue reliably
2. Create minimal test case
3. Binary search to find cause
4. Fix at root cause level
5. Add regression test

**Why it works**:
- Finds actual cause, not symptoms
- Regression test prevents recurrence

**When to use**: Complex bugs

---

## Code Review

### Pattern: Layered Review

**Steps**:
1. Check functionality (does it work?)
2. Check security (any vulnerabilities?)
3. Check performance (any concerns?)
4. Check maintainability (readable, documented?)
5. Check tests (adequate coverage?)

**Why it works**:
- Comprehensive coverage
- Catches different issue types

**When to use**: All code reviews

---

## Anti-Patterns to Avoid

### Anti-Pattern: Implement Both Platforms Simultaneously

**Problem**: Leads to drift, confusion, merge conflicts

**Better approach**: Primary platform first, then port

---

### Anti-Pattern: Skip Task Generation

**Problem**: Easy to miss requirements, no progress tracking

**Better approach**: Always use `/generate-tasks` for features

---

### Anti-Pattern: Fix Without Understanding

**Problem**: May fix symptom, not cause; may break other things

**Better approach**: Use debug agent, understand root cause

---

*Add successful patterns as they are discovered.*

*Last Updated: [Date]*
