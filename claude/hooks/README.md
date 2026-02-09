# Claude Code Hooks

> Event-driven automation scripts for Claude Code sessions.

## Overview

Hooks are bash scripts that execute in response to Claude Code events. They enable validation, context loading, logging, and automation without modifying the core workflow.

## Available Hooks

| Hook | Event | Purpose |
|------|-------|---------|
| `session-start.sh` | SessionStart | Initialize environment, display project info |
| `file-protection.sh` | PreToolUse (Write\|Edit) | Block edits to sensitive files |
| `post-edit.sh` | PostToolUse (Write\|Edit) | Post-edit processing |

## Hook Events

| Event | When Triggered | Use Cases |
|-------|----------------|-----------|
| `SessionStart` | Session begins | Load context, set env vars, display info |
| `SessionEnd` | Session ends | Cleanup, logging, save state |
| `PreToolUse` | Before tool runs | Validation, approval, modification |
| `PostToolUse` | After tool completes | Logging, reactions, follow-up |
| `PostToolUseFailure` | Tool fails | Error handling, recovery |
| `UserPromptSubmit` | User sends input | Input validation, context injection |
| `Stop` | Agent stops | Completion validation |
| `SubagentStop` | Subagent stops | Task validation |
| `PreCompact` | Before compaction | Preserve important context |

## Configuration

Hooks are configured in `claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "bash claude/hooks/session-start.sh",
            "timeout": 10
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash claude/hooks/file-protection.sh",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
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
  "tool_input": {
    "file_path": "/path/to/file",
    "content": "..."
  }
}
```

## Exit Codes

| Code | Meaning | Behavior |
|------|---------|----------|
| `0` | Success | Continue, stdout shown in transcript |
| `2` | Block | Stop operation, stderr fed to Claude |
| Other | Error | Non-blocking error, logged |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `CLAUDE_PROJECT_DIR` | Project root path |
| `CLAUDE_ENV_FILE` | SessionStart only: persist env vars |

## Logging Pattern

Standard log format for hooks:

```bash
# Info logging (visible in transcript)
echo "[INFO] Message here" >&2

# Structured logging (to file)
log_event() {
    local level="$1"
    local message="$2"
    echo "[$level] $(date '+%Y-%m-%d %H:%M:%S') $message" >> .claude/audit.log
}

log_event "INFO" "Hook executed successfully"
log_event "WARN" "Potential issue detected"
log_event "ERROR" "Operation blocked"
```

## Creating New Hooks

### Template

```bash
#!/bin/bash
# Hook: [EventName]
# Matcher: [pattern] (for PreToolUse/PostToolUse)
# Purpose: [Brief description]
# Usage: Add to settings.json under hooks.[EventName]

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Extract relevant fields
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Your logic here
# ...

# Exit 0 to allow, 2 to block
exit 0
```

### Best Practices

1. **Always quote variables**: `"$FILE_PATH"` not `$FILE_PATH`
2. **Set strict mode**: `set -euo pipefail`
3. **Handle empty input**: Check for null/empty values
4. **Use stderr for messages**: `echo "message" >&2`
5. **Set appropriate timeouts**: Default is 60s for commands
6. **Keep hooks fast**: Avoid slow operations

### Security Checklist

- [ ] Validate all input from stdin
- [ ] Quote all variables
- [ ] Avoid command injection (don't use `eval`)
- [ ] Set appropriate file permissions (755)
- [ ] Handle edge cases gracefully

## Testing Hooks

### Manual Testing

```bash
# Test with sample input
echo '{"tool_name":"Write","tool_input":{"file_path":"/test/file.txt"}}' | \
  bash claude/hooks/file-protection.sh
echo "Exit code: $?"
```

### Validation Script

```bash
# Run the hook linter
bash improvements/hook-development/scripts/hook-linter.sh claude/hooks/
```

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Hook not running | Not in settings.json | Add hook configuration |
| Permission denied | Wrong file mode | `chmod +x hook.sh` |
| JSON parse error | Invalid input | Check jq syntax |
| Timeout | Slow operation | Increase timeout or optimize |
| Wrong matcher | Pattern mismatch | Check regex pattern |

## Related Resources

- `improvements/hook-development/` - Advanced hook patterns
- `claude/settings.json` - Hook configuration
- `claude/skills/hook-development/SKILL.md` - Hook development skill
