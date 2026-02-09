---
name: agent-development
description: This skill should be used when the user asks to "create an agent", "add an agent", "write a subagent", "define agent frontmatter", "configure agent triggering", "design system prompts", or needs guidance on agent structure, system prompts, triggering conditions, or agent development best practices for Claude Code.
version: 1.0.0
---

# Agent Development for Claude Code

Create autonomous subprocesses that handle complex, multi-step tasks independently.

## Overview

Agents are specialized AI assistants that trigger based on context and handle domain-specific tasks. Understanding agent structure, triggering conditions, and system prompt design enables creating powerful autonomous capabilities.

**Key concepts:**
- Markdown file format with YAML frontmatter
- Description field with triggering examples
- System prompt defines agent behavior
- Model and color customization

## Agent File Structure

```markdown
---
name: agent-identifier
description: Use this agent when [conditions]. Examples:

<example>
Context: [Situation]
user: "[User request]"
assistant: "[How to respond]"
<commentary>[Why this agent triggers]</commentary>
</example>

model: inherit
color: blue
tools: ["Read", "Write", "Grep"]
---

You are [agent role description]...

**Your Core Responsibilities:**
1. [Responsibility 1]
2. [Responsibility 2]

**Analysis Process:**
[Step-by-step workflow]

**Output Format:**
[What to return]
```

## Frontmatter Fields

### name (required)

Agent identifier for namespacing and invocation.

**Format:** lowercase, numbers, hyphens only (3-50 chars)

| Good | Bad |
|------|-----|
| `code-reviewer` | `helper` (too generic) |
| `test-generator` | `-agent-` (starts with hyphen) |
| `api-docs-writer` | `my_agent` (underscores) |

### description (required)

**Most critical field** - defines when Claude triggers this agent.

**Must include:**
1. Triggering conditions ("Use this agent when...")
2. Multiple `<example>` blocks (2-4)
3. Context, user request, assistant response
4. `<commentary>` explaining why agent triggers

**Format:**
```
Use this agent when [conditions]. Examples:

<example>
Context: [Scenario]
user: "[What user says]"
assistant: "[How Claude responds]"
<commentary>[Why this agent]</commentary>
</example>
```

### model (required)

| Option | Use Case |
|--------|----------|
| `inherit` | Same as parent (recommended) |
| `sonnet` | Balanced capability |
| `opus` | Complex analysis |
| `haiku` | Fast, simple tasks |

### color (required)

Visual identifier in UI: `blue`, `cyan`, `green`, `yellow`, `magenta`, `red`

**Guidelines:**
- Blue/cyan: Analysis, review
- Green: Success-oriented tasks
- Yellow: Caution, validation
- Red: Critical, security
- Magenta: Creative, generation

### tools (optional)

Restrict agent to specific tools:

```yaml
tools: ["Read", "Write", "Grep", "Bash"]
```

**Default:** If omitted, agent has access to all tools

**Common tool sets:**
| Purpose | Tools |
|---------|-------|
| Read-only | `["Read", "Grep", "Glob"]` |
| Code generation | `["Read", "Write", "Grep"]` |
| Testing | `["Read", "Bash", "Grep"]` |

## System Prompt Design

The markdown body becomes the agent's system prompt. Write in second person, addressing the agent directly.

### Structure Template

```markdown
You are [role] specializing in [domain].

**Your Core Responsibilities:**
1. [Primary responsibility]
2. [Secondary responsibility]

**Analysis Process:**
1. [Step one]
2. [Step two]
3. [Step three]

**Quality Standards:**
- [Standard 1]
- [Standard 2]

**Output Format:**
Provide results in this format:
- [What to include]
- [How to structure]

**Edge Cases:**
Handle these situations:
- [Edge case 1]: [How to handle]
- [Edge case 2]: [How to handle]
```

### Best Practices

✅ **DO:**
- Write in second person ("You are...", "You will...")
- Be specific about responsibilities
- Provide step-by-step process
- Define output format
- Include quality standards
- Address edge cases
- Keep under 10,000 characters

❌ **DON'T:**
- Write in first person ("I am...")
- Be vague or generic
- Omit process steps
- Leave output format undefined
- Skip quality guidance

## Example: Code Reviewer Agent

```markdown
---
name: code-reviewer
description: Use this agent for code reviews, quality checks, and best practices validation. Examples:

<example>
Context: User has written new code
user: "Review this code for issues"
assistant: "I'll launch the code-reviewer agent to analyze your code."
<commentary>Explicit code review request triggers agent</commentary>
</example>

<example>
Context: After implementing a feature
user: "Is this implementation good?"
assistant: "Let me have the code-reviewer agent assess your implementation."
<commentary>Quality assessment triggers agent</commentary>
</example>

model: sonnet
color: cyan
tools: ["Read", "Grep", "Glob"]
---

You are a senior code reviewer specializing in Swift and Kotlin.

**Your Core Responsibilities:**
1. Identify bugs, security issues, and code smells
2. Verify adherence to project coding standards
3. Suggest improvements with specific code examples
4. Check test coverage adequacy

**Analysis Process:**
1. Read the file(s) to review
2. Check for syntax and logic errors
3. Verify coding standards compliance
4. Identify security vulnerabilities
5. Assess test coverage
6. Provide actionable feedback

**Quality Standards:**
- All feedback must include line numbers
- Suggestions must include corrected code
- Severity: Critical, Warning, Info
- Focus on impact, not style nitpicks

**Output Format:**
## Review Summary
- Files reviewed: [list]
- Issues found: [count by severity]

## Critical Issues
[Issue with line number and fix]

## Warnings
[Warning with line number and suggestion]

## Recommendations
[General improvements]
```

## Validation Rules

### Identifier Validation

| Rule | Valid | Invalid |
|------|-------|---------|
| 3-50 chars | `code-reviewer` | `ag` |
| Lowercase + hyphens | `test-gen` | `Test_Gen` |
| Alphanumeric ends | `api-v2` | `-start-` |

### Description Validation

- Length: 10-5,000 characters
- Must include triggering conditions
- Include 2-4 `<example>` blocks
- Best: 200-1,000 characters

### System Prompt Validation

- Length: 20-10,000 characters
- Best: 500-3,000 characters
- Clear responsibilities, process, output format

## Agent Organization

### Location

```
.claude/agents/
├── architect.md
├── reviewer.md
├── task-manager.md
└── researcher.md
```

All `.md` files in `agents/` are auto-discovered.

## Testing Agents

### Test Triggering

1. Write agent with specific triggering examples
2. Use similar phrasing in test
3. Verify Claude loads the agent
4. Check agent provides expected functionality

### Test System Prompt

1. Give agent typical task
2. Verify it follows process steps
3. Check output format is correct
4. Test edge cases mentioned in prompt

## Quick Reference

### Frontmatter Summary

| Field | Required | Format |
|-------|----------|--------|
| name | Yes | lowercase-hyphens |
| description | Yes | Text + `<example>` blocks |
| model | Yes | inherit/sonnet/opus/haiku |
| color | Yes | Color name |
| tools | No | Array of tool names |

### Best Practices Checklist

- [ ] 2-4 concrete examples in description
- [ ] Specific triggering conditions
- [ ] `inherit` for model unless specific need
- [ ] Appropriate tools (least privilege)
- [ ] Clear, structured system prompt
- [ ] Agent tested with real scenarios

## Integration with Framework

Agents integrate with commands and skills:

```markdown
# In a command
Use the reviewer agent to analyze @$1.
```

Agents can also invoke other agents through the Task tool for complex workflows.
