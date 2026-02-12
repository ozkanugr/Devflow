# Claude Code Hooks

> Event-driven automation scripts for Claude Code sessions.

## Overview

Hooks are bash scripts that execute in response to Claude Code events. They enable validation, context loading, logging, and automation without modifying the core workflow.

## Directory Structure

```
.claude/
├── hooks/
│   ├── README.md              # This file
│   ├── session-start.sh       # Session initialization
│   ├── file-protection.sh     # Pre-edit file validation
│   └── post-edit.sh           # Post-edit processing
├── logs/                      # Auto-created log directory
│   ├── audit.log              # Session activity log
│   └── errors.log             # Error tracking
└── settings.json              # Hook configuration
```

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
| `Setup` | Initial setup | Make hooks executable, create directories |

## Configuration

Hooks are configured in `.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f .claude/hooks/session-start.sh ]; then bash .claude/hooks/session-start.sh; fi",
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
            "command": "if [ -f .claude/hooks/file-protection.sh ]; then bash .claude/hooks/file-protection.sh; fi",
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
| `TOOL_NAME` | Name of the tool being executed |
| `TOOL_EXIT_CODE` | Exit code from tool (PostToolUse only) |

## Logging

Logs are written to `.claude/logs/`:

- `audit.log` — All session activity
- `errors.log` — Failed operations

### Log Format

```
[EVENT_TYPE] YYYY-MM-DD HH:MM:SS [additional info]
```

### Example Log Entries

```
[PROMPT] 2026-02-12 10:30:00
[PRE-BASH] 2026-02-12 10:30:01
[POST-BASH] 2026-02-12 10:30:02 exit=0
[STOP] 2026-02-12 10:35:00
```

## Creating New Hooks

### Template

```bash
#!/bin/bash
# Hook: [EventName]
# Matcher: [pattern] (for PreToolUse/PostToolUse)
# Purpose: [Brief description]

set -euo pipefail

# Read input from stdin
INPUT=$(cat)

# Extract relevant fields using jq
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
7. **Use conditional execution**: Check if hook file exists before running

### Security Checklist

- [ ] Validate all input from stdin
- [ ] Quote all variables
- [ ] Avoid command injection (don't use `eval`)
- [ ] Set appropriate file permissions (755)
- [ ] Handle edge cases gracefully

## Testing Hooks

### Manual Testing

```bash
# Test file protection hook
echo '{"tool_name":"Write","tool_input":{"file_path":"test.txt"}}' | \
  bash .claude/hooks/file-protection.sh
echo "Exit code: $?"

# Test with protected file
echo '{"tool_name":"Write","tool_input":{"file_path":".env"}}' | \
  bash .claude/hooks/file-protection.sh
echo "Exit code: $?"
```

### Make Hooks Executable

```bash
chmod +x .claude/hooks/*.sh
```

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Hook not running | Not in settings.json | Add hook configuration |
| Permission denied | Wrong file mode | `chmod +x .claude/hooks/*.sh` |
| JSON parse error | Invalid input | Check jq syntax |
| Timeout | Slow operation | Increase timeout or optimize |
| Wrong matcher | Pattern mismatch | Check regex pattern |
| Hook file not found | Path incorrect | Use `.claude/hooks/` path |

## Related Resources

- `.claude/settings.json` — Hook configuration
- `.claude/skills/hook-development/SKILL.md` — Hook development skill
