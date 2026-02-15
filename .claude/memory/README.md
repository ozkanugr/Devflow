# Project Memory System

> Persistent learning and context for Claude Code sessions.

## Overview

The memory system provides persistent storage for:
- **Project context** — Technical details, conventions, patterns
- **User preferences** — Preferred approaches, communication style
- **Error patterns** — Common issues and their solutions
- **Workflow history** — Successful patterns to repeat
- **Decisions** — Key architectural and design decisions

## Directory Structure

```
.claude/memory/
├── README.md           # This file
├── project-context.md  # Project-specific knowledge
├── user-preferences.md # Learned user preferences
├── error-patterns.md   # Common errors and solutions
├── workflow-history.md # Successful workflow patterns
└── decisions.md        # Key decisions and rationale
```

## How It Works

### Automatic Updates

Agents consult and update memory files during work:

1. **Before starting work** — Read relevant memory files
2. **During work** — Note important learnings
3. **After completion** — Update memory with new knowledge

### Memory Consultation

```markdown
## Before starting a task, check:

1. `project-context.md` - Project conventions and patterns
2. `user-preferences.md` - User's preferred approaches
3. `error-patterns.md` - Known issues to avoid
4. `decisions.md` - Past decisions that apply
```

### Memory Updates

```markdown
## After completing a task, update if:

1. Learned a new project pattern
2. User expressed a preference
3. Encountered and solved an error
4. Made an important decision
5. Found a workflow that works well
```

## Memory File Guidelines

### project-context.md

Store:
- Naming conventions
- Architecture patterns
- Key dependencies
- Important file locations
- Integration details

Don't store:
- Session-specific details
- Temporary workarounds
- Sensitive information

### user-preferences.md

Store:
- Communication style preferences
- Code style preferences
- Workflow preferences
- Tool preferences

Format:
```markdown
## Communication
- Prefers concise responses
- Likes code examples

## Code Style
- Uses trailing commas
- Prefers async/await over promises
```

### error-patterns.md

Store:
- Error message → Root cause → Solution
- Common gotchas
- Environment-specific issues

Format:
```markdown
## Error: "Module not found: XYZ"
**Cause**: Missing dependency after clone
**Solution**: Run `npm install` / `pod install`
**Prevention**: Add to setup checklist
```

### workflow-history.md

Store:
- Successful command sequences
- Efficient approaches
- Time-saving patterns

Format:
```markdown
## Feature Implementation Flow
1. Generate tasks first (/generate-tasks)
2. Check dependencies (/next-task)
3. Implement platform by platform
4. Verify parity (/platform-parity)

**Why this works**: Ensures nothing is missed
```

### decisions.md

Store:
- Architectural decisions
- Technology choices
- Pattern decisions

Format:
```markdown
## Decision: Use MVVM Architecture
**Date**: 2024-01-15
**Context**: Needed consistent pattern across iOS/Android
**Decision**: MVVM with repository pattern
**Rationale**: Testable, familiar to team, good separation
**Consequences**: More boilerplate, but clearer structure
```

## Best Practices

### DO
- Keep entries concise
- Include rationale
- Date significant entries
- Link to relevant files
- Update when things change

### DON'T
- Store sensitive data
- Include temporary fixes
- Duplicate CLAUDE.md content
- Store session-specific state
- Include unverified information

## Integration

The memory system integrates with:
- **Agents** — Read context before acting
- **Commands** — May update memory after completion
- **Skills** — Reference patterns and preferences

## Cleanup

Periodically review memory files:
- Remove outdated entries
- Consolidate similar patterns
- Verify accuracy against current code
- Archive old decisions if needed

## Example Usage

### Checking Memory

```markdown
Before implementing a new feature:
1. Read project-context.md for conventions
2. Check decisions.md for related past decisions
3. Review error-patterns.md for known issues
```

### Updating Memory

```markdown
After solving a tricky bug:
1. Document in error-patterns.md
2. If it revealed a pattern, add to project-context.md
3. If user had preference, note in user-preferences.md
```
