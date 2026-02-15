# Devflow Framework Tests

> Automated test suite for validating the Devflow configuration framework.

## Overview

This directory contains tests that validate the integrity and correctness of all framework components:

- **Commands** - Slash command definitions
- **Agents** - AI specialist definitions
- **Skills** - Context-activated capabilities
- **Hooks** - Event-driven automation scripts
- **Integration** - Cross-component validation

## Quick Start

```bash
# Run all tests
./tests/run_tests.sh

# Run specific test category
./tests/run_tests.sh --commands
./tests/run_tests.sh --agents
./tests/run_tests.sh --skills
./tests/run_tests.sh --hooks
./tests/run_tests.sh --integration

# Use the command
/run-tests
```

## Test Categories

### Command Tests

Validates each file in `.claude/commands/*.md`:

| Test | Severity | Description |
|------|----------|-------------|
| Frontmatter exists | Critical | YAML frontmatter block required |
| `description` field | Critical | Command description required |
| `allowed-tools` field | Warning | Tool permissions recommended |
| `model` field | Warning | Model selection recommended |

### Agent Tests

Validates each file in `.claude/agents/*.md`:

| Test | Severity | Description |
|------|----------|-------------|
| Frontmatter exists | Critical | YAML frontmatter block required |
| `name` field | Critical | Agent name required |
| `description` field | Critical | Agent description required |
| `model` field | Warning | Model selection recommended |
| `<example>` blocks | Warning | Triggering examples recommended |

### Skill Tests

Validates each `SKILL.md` in `.claude/skills/*/`:

| Test | Severity | Description |
|------|----------|-------------|
| SKILL.md exists | Critical | Main skill file required |
| `name` field | Critical | Skill name required |
| `description` field | Critical | Skill description required |
| `version` field | Warning | Semantic version recommended |

### Hook Tests

Validates each file in `.claude/hooks/*.sh`:

| Test | Severity | Description |
|------|----------|-------------|
| Valid shell syntax | Critical | Must pass `bash -n` |
| Executable permission | Warning | Should have +x permission |

### Integration Tests

Cross-component validation:

| Test | Severity | Description |
|------|----------|-------------|
| JSON validity | Critical | All JSON files must parse |
| CLAUDE.md exists | Critical | Project instructions required |
| Cross-references | Warning | Referenced files should exist |

## Test Results

Results are written to `/tmp/claude/devflow-test-results.json`:

```json
{
  "timestamp": "2026-02-15T10:30:00Z",
  "passed": 45,
  "failed": 0,
  "warnings": 3,
  "total": 45,
  "status": "success"
}
```

## Adding New Tests

### Test Functions

```bash
# Test file exists
test_file_exists "/path/to/file" "File Name"

# Test directory exists
test_dir_exists "/path/to/dir" "Directory Name"

# Test has frontmatter
test_has_frontmatter "/path/to/file.md" "File Name"

# Test frontmatter field
test_frontmatter_field "/path/to/file.md" "field-name" "File Name"

# Test valid JSON
test_valid_json "/path/to/file.json" "File Name"

# Test shell syntax
test_shell_syntax "/path/to/script.sh" "Script Name"

# Test executable
test_executable "/path/to/script.sh" "Script Name"
```

### Adding a Test Category

1. Create a new function: `run_[category]_tests()`
2. Add to the argument parser in `main()`
3. Include in the `run_all` block
4. Update this documentation

## CI Integration

Example GitHub Actions workflow:

```yaml
name: Framework Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: ./tests/run_tests.sh
```

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Permission denied" | Script not executable | `chmod +x tests/run_tests.sh` |
| "jq: command not found" | jq not installed | `brew install jq` (macOS) |
| Tests hang | Infinite loop in script | Check for missing `fi` statements |

## Related

- `/validate` - Quick configuration validation
- `/run-tests` - This test suite via command
- `docs/DEVFLOW-ANALYSIS.md` - Framework analysis
