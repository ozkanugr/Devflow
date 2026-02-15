---
description: Run automated tests on the Devflow framework components
argument-hint: "[--all|--commands|--agents|--skills|--hooks|--integration]"
allowed-tools: Read, Bash, Glob
model: haiku
---

# Run Framework Tests

Execute the automated test suite to validate framework integrity.

## Purpose

**KEY CONCEPT: Continuous Validation**
Running tests regularly ensures that framework modifications don't introduce regressions. This command wraps the test runner script with additional reporting.

## Usage

```bash
/run-tests                # Run all tests
/run-tests --commands     # Test commands only
/run-tests --agents       # Test agents only
/run-tests --skills       # Test skills only
/run-tests --hooks        # Test hooks only
/run-tests --integration  # Test integrations only
```

## Steps

1. Verify the test runner script exists at `tests/run_tests.sh`
2. Make the script executable if needed
3. Execute the test runner with provided arguments: `$ARGUMENTS`
4. Parse and format the test results
5. Provide summary with recommendations

## Test Categories

### Command Tests
- Frontmatter exists and is valid
- Required fields present (description)
- Recommended fields present (allowed-tools, model)

### Agent Tests
- Frontmatter exists and is valid
- Required fields present (name, description)
- Triggering examples exist (`<example>` blocks)
- Model and tools specified

### Skill Tests
- SKILL.md exists in skill directory
- Frontmatter with name, description, version
- Proper structure and references

### Hook Tests
- Valid shell syntax
- Executable permissions
- Proper error handling

### Integration Tests
- JSON files are valid
- Cross-references resolve
- Configuration consistency

## Output Format

```markdown
# Test Results

**Run Date**: {timestamp}
**Scope**: {test scope}

## Summary

| Category | Passed | Failed | Warnings |
|----------|--------|--------|----------|
| Commands | X | Y | Z |
| Agents | X | Y | Z |
| Skills | X | Y | Z |
| Hooks | X | Y | Z |
| Integration | X | Y | Z |

## Status: [PASS/FAIL]

## Issues Found

[List of any failures or warnings]

## Recommendations

[Suggestions for fixing issues]
```

## Error Handling

If tests fail:
1. List specific failures with file paths
2. Provide guidance on how to fix each issue
3. Suggest running `/validate` for additional checks

## Integration

This command complements `/validate`:
- `/validate` - Quick configuration check
- `/run-tests` - Comprehensive automated testing
