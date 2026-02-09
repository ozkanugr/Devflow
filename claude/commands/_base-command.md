---
description: [Short description of what this command does]
argument-hint: <optional-argument>
allowed-tools: Read, Write, Edit
model: sonnet
---

<!--
TEMPLATE INSTRUCTIONS:
1. Update description (shown in /command menu)
2. Add argument-hint if command takes arguments
3. Configure allowed-tools:
   - Read-only: Read, Grep, Glob
   - Writing: Read, Write, Edit
   - Full: Read, Write, Edit, Bash
   - With MCP: mcp__[server]__*
4. Set model (optional, inherits from session if omitted):
   - opus: Complex reasoning
   - sonnet: Most tasks (default)
   - haiku: Simple tasks
5. Delete these instructions before use
-->

# [Command Name]

[Brief description of what this command accomplishes]

## Steps

1. [First action to take]
2. [Second action]
3. [Third action]
4. [Fourth action]
5. [Final action/verification]

## Guidelines

- [Important guideline 1]
- [Important guideline 2]
- [Important guideline 3]

## Arguments

If called with `$ARGUMENTS`:
- Use the provided value for [purpose]
- Default to [fallback] if not provided

## Output

[Describe what the command produces or modifies]
