---
name: hook-development
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", "implement event-driven automation", "block dangerous commands", "add SessionStart hook", or mentions hook events (PreToolUse, PostToolUse, Stop, SubagentStop, SessionStart, SessionEnd, UserPromptSubmit). Provides guidance for creating Claude Code hooks for event-driven automation.
version: 1.0.0
---

# Hook Development for Claude Code

Create event-driven automation scripts that execute in response to Claude Code events.

## Overview

Hooks validate operations, enforce policies, add context, and integrate external tools into workflows.

**Key capabilities:**
- Validate tool calls before execution (PreToolUse)
- React to tool results (PostToolUse)
- Enforce completion standards (Stop, SubagentStop)
- Load project context (SessionStart)

## Hook Types

### Prompt-Based Hooks (Recommended)

Use LLM-driven decision making for context-aware validation:

```json
{
  "type": "prompt",
  "prompt": "Evaluate if this tool use is appropriate: $TOOL_INPUT",
  "timeout": 30
}
```

**Supported events:** Stop, SubagentStop, UserPromptSubmit, PreToolUse

**Benefits:**
- Context-aware decisions
- Flexible evaluation logic
- Better edge case handling

### Command Hooks

Execute bash commands for deterministic checks:

```json
{
  "type": "command",
  "command": "bash .claude/hooks/validate.sh",
  "timeout": 60
}
```

**Use for:**
- Fast deterministic validations
- File system operations
- External tool integrations

## Hook Configuration

### Location

`.claude/hooks/` directory with shell scripts and optional JSON configuration.

### Settings Format

In `.claude/settings.json` or `claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/validate-write.sh"
          }
        ]
      }
    ]
  }
}
```

## Hook Events

### PreToolUse

Execute before any tool runs. Approve, deny, or modify tool calls.

```json
{
  "PreToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [
        {
          "type": "prompt",
          "prompt": "Validate file write safety. Check: system paths, credentials, sensitive content. Return 'approve' or 'deny'."
        }
      ]
    }
  ]
}
```

**Output:**
```json
{
  "hookSpecificOutput": {
    "permissionDecision": "allow|deny|ask"
  },
  "systemMessage": "Explanation for Claude"
}
```

### PostToolUse

Execute after tool completes. React to results, provide feedback.

```json
{
  "PostToolUse": [
    {
      "matcher": "Edit",
      "hooks": [
        {
          "type": "prompt",
          "prompt": "Analyze edit for potential issues: syntax errors, security vulnerabilities."
        }
      ]
    }
  ]
}
```

### Stop

Execute when agent considers stopping. Validate completeness.

```json
{
  "Stop": [
    {
      "matcher": "*",
      "hooks": [
        {
          "type": "prompt",
          "prompt": "Verify task completion: tests run, build succeeded. Return 'approve' or 'block'."
        }
      ]
    }
  ]
}
```

### SessionStart

Execute when session begins. Load context and set environment.

```json
{
  "SessionStart": [
    {
      "matcher": "*",
      "hooks": [
        {
          "type": "command",
          "command": "bash .claude/hooks/load-context.sh"
        }
      ]
    }
  ]
}
```

**Special capability:** Persist environment variables:
```bash
echo "export PROJECT_TYPE=nodejs" >> "$CLAUDE_ENV_FILE"
```

### Other Events

| Event | When | Use For |
|-------|------|---------|
| SubagentStop | Subagent done | Task validation |
| SessionEnd | Session ends | Cleanup, logging |
| UserPromptSubmit | User input | Context, validation |
| PreCompact | Before compact | Preserve context |

## Matchers

### Tool Name Matching

```json
"matcher": "Write"              // Exact match
"matcher": "Read|Write|Edit"    // Multiple tools
"matcher": "*"                  // All tools
"matcher": "mcp__.*"            // Regex (all MCP tools)
```

## Hook Input Format

All hooks receive JSON via stdin:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.txt",
  "cwd": "/current/working/dir",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": { "file_path": "/path/to/file" }
}
```

**Event-specific fields:**
- **PreToolUse/PostToolUse:** `tool_name`, `tool_input`, `tool_result`
- **UserPromptSubmit:** `user_prompt`
- **Stop/SubagentStop:** `reason`

## Environment Variables

| Variable | Description |
|----------|-------------|
| `$CLAUDE_PROJECT_DIR` | Project root path |
| `$CLAUDE_ENV_FILE` | SessionStart only: persist env vars |

## Example: Write Validation Hook

```bash
#!/bin/bash
# .claude/hooks/validate-write.sh
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path')

# Deny path traversal
if [[ "$file_path" == *".."* ]]; then
  echo '{"hookSpecificOutput":{"permissionDecision":"deny"},"systemMessage":"Path traversal detected"}' >&2
  exit 2
fi

# Deny sensitive files
if [[ "$file_path" == *".env"* ]] || [[ "$file_path" == *"credentials"* ]]; then
  echo '{"hookSpecificOutput":{"permissionDecision":"deny"},"systemMessage":"Sensitive file modification blocked"}' >&2
  exit 2
fi

# Allow the write
exit 0
```

## Example: Session Start Hook

```bash
#!/bin/bash
# .claude/hooks/session-start.sh

# Detect project type
if [ -f "package.json" ]; then
  echo "export PROJECT_TYPE=nodejs" >> "$CLAUDE_ENV_FILE"
elif [ -f "Package.swift" ]; then
  echo "export PROJECT_TYPE=swift" >> "$CLAUDE_ENV_FILE"
elif [ -f "build.gradle.kts" ]; then
  echo "export PROJECT_TYPE=android" >> "$CLAUDE_ENV_FILE"
fi

# Output context for Claude
echo "Project initialized. Type: $PROJECT_TYPE"
```

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success (stdout shown in transcript) |
| `2` | Blocking error (stderr fed back to Claude) |
| Other | Non-blocking error |

## Security Best Practices

### Input Validation

```bash
tool_name=$(echo "$input" | jq -r '.tool_name')

# Validate format
if [[ ! "$tool_name" =~ ^[a-zA-Z0-9_]+$ ]]; then
  echo '{"decision":"deny","reason":"Invalid tool name"}' >&2
  exit 2
fi
```

### Quote All Variables

```bash
# GOOD
echo "$file_path"
cd "$CLAUDE_PROJECT_DIR"

# BAD (injection risk)
echo $file_path
```

### Set Appropriate Timeouts

```json
{
  "type": "command",
  "command": "bash script.sh",
  "timeout": 10
}
```

**Defaults:** Command hooks (60s), Prompt hooks (30s)

## Performance Considerations

### Parallel Execution

All matching hooks run in parallel:
- Hooks don't see each other's output
- Non-deterministic ordering
- Design for independence

### Optimization

1. Use command hooks for quick deterministic checks
2. Use prompt hooks for complex reasoning
3. Cache results in temp files
4. Minimize I/O in hot paths

## Debugging

### Enable Debug Mode

```bash
claude --debug
```

### Test Hook Scripts

```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"/test"}}' | \
  bash .claude/hooks/validate-write.sh
echo "Exit code: $?"
```

## Quick Reference

### Hook Events Summary

| Event | When | Use For |
|-------|------|---------|
| PreToolUse | Before tool | Validation |
| PostToolUse | After tool | Feedback |
| Stop | Agent stopping | Completeness |
| SessionStart | Session begins | Context loading |
| SessionEnd | Session ends | Cleanup |

### Best Practices Checklist

- [ ] Use prompt-based hooks for complex logic
- [ ] Validate all inputs in command hooks
- [ ] Quote all bash variables
- [ ] Set appropriate timeouts
- [ ] Return structured JSON output
- [ ] Test hooks thoroughly

## Lifecycle Note

Hooks load at session start. Changes require restarting Claude Code.
