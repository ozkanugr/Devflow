---
description: Run tests and report results
argument-hint: "[pattern] [--ios|--android|--all] — Optional: test pattern and platform"
allowed-tools: Read, Bash, Glob
model: sonnet
---

# Run Tests

Execute tests and provide a comprehensive report.

## Steps

1. Check `docs/platform.json` for platform configuration
2. Detect the test framework in use
3. Run tests (all or matching `$ARGUMENTS` pattern)
4. Capture test output
5. Parse and report results:
   - Total tests run
   - Passed/failed/skipped counts
   - Details of any failures

## Platform-Specific Tests

### iOS
```bash
xcodebuild test -scheme ${APP_SCHEME} -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

### Android
```bash
./gradlew testDebugUnitTest
./gradlew connectedDebugAndroidTest  # For instrumented tests
```

## Test Framework Detection

Look for:
1. Platform config (`docs/platform.json`)
2. Test configuration files
3. Test directories (tests/, __tests__/, *Tests/, src/test/)
4. Test runner commands in package configs

## Pattern Matching

If pattern provided in `$ARGUMENTS`:
- iOS: Filter by test class or method name
- Android: Use `--tests` filter
- Generic: Pass to test runner's filter option

## Failure Reporting

For each failure:
- Test name and file location
- Expected vs actual values
- Stack trace or relevant context
- Suggested investigation steps

## Output

```markdown
# Test Report

**Platform**: iOS / Android / Both
**Pattern**: [if specified]

## Summary

| Metric | iOS | Android | Total |
|--------|-----|---------|-------|
| Passed | X | X | X |
| Failed | X | X | X |
| Skipped | X | X | X |
| Duration | Xs | Xs | Xs |

## Failures (if any)

### iOS Failures

1. **TestClassName.testMethodName**
   - File: `path/to/TestFile.swift:42`
   - Expected: `value1`
   - Actual: `value2`
   - Suggestion: [investigation steps]

### Android Failures

1. **TestClassName.testMethodName**
   - File: `path/to/TestFile.kt:42`
   - Expected: `value1`
   - Actual: `value2`
   - Suggestion: [investigation steps]

## Next Steps

- Fix failing tests
- Re-run with `/test`
- Check coverage with platform tools
```

## Next Steps

After all tests pass:
- Run `/build` for production build
- Run `/platform-parity` to verify cross-platform status
- Use `/task-status` to review progress

After test failures:
- Review failure details above
- Fix failing tests
- Re-run `/test` to verify fixes
- Consider adding regression tests
