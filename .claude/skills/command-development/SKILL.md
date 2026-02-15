---
name: command-development
description: This skill should be used when the user asks to "create a slash command", "add a command", "write a custom command", "define command arguments", "use command frontmatter", "organize commands", "create command with file references", or needs guidance on slash command structure, YAML frontmatter fields, dynamic arguments, bash execution in commands, or command development best practices for Claude Code.
version: 1.0.0
---

# Command Development for Claude Code

Create and configure slash commands as Markdown files that Claude executes during interactive sessions.

## Overview

Slash commands are reusable prompts defined as Markdown files. Commands provide consistency, sharing, and efficiency for common workflows.

**Key concepts:**
- Markdown file format with optional YAML frontmatter
- Dynamic arguments (`$ARGUMENTS`, `$1`, `$2`)
- File references with `@` syntax
- Bash execution for dynamic context

## Command Locations

| Location | Scope | Use For |
|----------|-------|---------|
| `.claude/commands/` | Project-specific | Team workflows |
| `~/.claude/commands/` | All projects | Personal utilities |

## File Format

### Basic Structure

```markdown
Review this code for security vulnerabilities including:
- SQL injection
- XSS attacks
- Authentication bypass
```

No frontmatter needed for simple commands.

### With YAML Frontmatter

```markdown
---
description: Review code for security issues
allowed-tools: Read, Grep, Bash(git:*)
model: sonnet
argument-hint: [file-path]
---

Review @$1 for security vulnerabilities...
```

## YAML Frontmatter Fields

| Field | Type | Purpose |
|-------|------|---------|
| `description` | String | Brief description for `/help` |
| `allowed-tools` | String/Array | Tools command can use |
| `model` | String | Model for execution (sonnet, opus, haiku) |
| `argument-hint` | String | Document expected arguments |

### allowed-tools Patterns

```yaml
allowed-tools: Read, Write, Edit       # Specific tools
allowed-tools: Bash(git:*)             # Bash with git only
allowed-tools: "*"                     # All tools (rarely needed)
```

### model Options

| Model | Use Case |
|-------|----------|
| `haiku` | Fast, simple commands |
| `sonnet` | Standard workflows |
| `opus` | Complex analysis |

## Dynamic Arguments

### $ARGUMENTS

Capture all arguments as single string:

```markdown
---
argument-hint: [issue-number]
---

Fix issue #$ARGUMENTS following our coding standards.
```

**Usage:** `/fix-issue 123` → `Fix issue #123...`

### Positional Arguments

Use `$1`, `$2`, `$3` for individual arguments:

```markdown
---
argument-hint: [pr-number] [priority] [assignee]
---

Review PR #$1 with priority $2.
Assign to $3 for follow-up.
```

**Usage:** `/review-pr 123 high alice`

## File References

### Using @ Syntax

Include file contents in command:

```markdown
---
argument-hint: [file-path]
---

Review @$1 for:
- Code quality
- Best practices
- Potential bugs
```

**Usage:** `/review-file src/api/users.ts`

### Static File References

```markdown
Review @package.json and @tsconfig.json for consistency.
```

## Bash Execution

Execute bash inline for dynamic context:

```markdown
---
allowed-tools: Bash(git:*)
---

Files changed: !`git diff --name-only`

Review each file for code quality.
```

**Syntax:** `!`backtick command backtick

### Use Cases

- Include git status/diff
- Gather environment info
- Dynamic context building

## Command Organization

### Flat Structure

```
.claude/commands/
├── build.md
├── test.md
├── deploy.md
└── review.md
```

**Use when:** 5-15 commands, no clear categories

### Namespaced Structure

```
.claude/commands/
├── ci/
│   ├── build.md      # /build (project:ci)
│   └── test.md       # /test (project:ci)
├── git/
│   └── commit.md     # /commit (project:git)
└── docs/
    └── generate.md   # /generate (project:docs)
```

**Use when:** 15+ commands, clear categories

## Common Patterns

### Review Pattern

```markdown
---
description: Review code changes
allowed-tools: Read, Bash(git:*)
---

Files changed: !`git diff --name-only`

Review each file for:
1. Code quality and style
2. Potential bugs
3. Test coverage
4. Documentation needs
```

### Testing Pattern

```markdown
---
description: Run tests for specific file
argument-hint: [test-file]
allowed-tools: Bash(npm:*)
---

Run tests: !`npm test $1`

Analyze results and suggest fixes for failures.
```

### Documentation Pattern

```markdown
---
description: Generate documentation for file
argument-hint: [source-file]
---

Generate documentation for @$1 including:
- Function/class descriptions
- Parameter documentation
- Usage examples
```

### Workflow Pattern

```markdown
---
description: Complete PR workflow
argument-hint: [pr-number]
allowed-tools: Bash(gh:*), Read
---

PR #$1 Workflow:
1. Fetch PR: !`gh pr view $1`
2. Review changes
3. Run checks
4. Approve or request changes
```

## Best Practices

### Command Design

1. **Single responsibility**: One command, one task
2. **Clear descriptions**: Self-explanatory in `/help`
3. **Explicit dependencies**: Use `allowed-tools` when needed
4. **Document arguments**: Always provide `argument-hint`
5. **Consistent naming**: Use verb-noun pattern (review-pr, fix-issue)

### Argument Handling

1. Validate arguments in prompt text
2. Provide defaults when appropriate
3. Document expected format
4. Handle edge cases gracefully

### Documentation

```markdown
---
description: Deploy application to environment
argument-hint: [environment] [version]
---

<!--
Usage: /deploy [staging|production] [version]
Requires: AWS credentials configured
Example: /deploy staging v1.2.3
-->

Deploy to $1 using version $2...
```

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Command not appearing | Wrong directory | Check file is in `.claude/commands/` |
| Arguments not working | Wrong syntax | Verify `$1`, `$2` format |
| Bash failing | Missing tools | Add `Bash(...)` to allowed-tools |
| File reference failing | Wrong path | Use project-relative paths |

## Integration with Framework

### Linking to Agents

Commands can invoke agents for complex tasks:

```markdown
---
description: Deep code review
argument-hint: [file-path]
---

Use the reviewer agent to analyze @$1.

The agent will check:
- Code quality
- Security issues
- Performance
- Best practices
```

### Using Skills

Commands can leverage skills:

```markdown
---
description: Document API with standards
argument-hint: [api-file]
---

Document API in @$1 following project standards.

Use the testing skill for test generation.
```

## Quality Checklist

- [ ] Command has clear, focused purpose
- [ ] Description is concise and actionable
- [ ] Arguments are documented with `argument-hint`
- [ ] `allowed-tools` specified if needed
- [ ] File references use correct `@` syntax
- [ ] Bash commands are safe and scoped
- [ ] Command is in correct directory
- [ ] Tested with various inputs
