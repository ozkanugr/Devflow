---
description: Build the project and report any errors
argument-hint: "[ios|android|all] — Optional: specify platform to build"
allowed-tools: Read, Bash, Glob
model: sonnet
---

# Build Project

Build the project and provide a clear report of results.

## Steps

1. Check `docs/platform.json` for platform configuration
2. Detect the project type and build system
3. Run the appropriate build command
4. Capture and analyze any errors or warnings
5. Report results with:
   - Build status (success/failure)
   - Error details with file locations
   - Suggested fixes for common errors

## Platform-Specific Builds

### iOS
```bash
xcodebuild -scheme ${APP_SCHEME} -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build
```

### Android
```bash
./gradlew assembleDebug
```

### Both (Cross-Platform)
Run both builds and aggregate results.

## Build System Detection

Check for these in order:
1. Platform config (`docs/platform.json`)
2. Package manager configs (package.json, Cargo.toml, etc.)
3. Build tool configs (Makefile, CMakeLists.txt, etc.)
4. IDE project files (.xcodeproj, build.gradle.kts, etc.)

## Error Reporting

For each error:
- File path and line number
- Error message
- Suggested fix if obvious

## Output

```markdown
# Build Report

**Platform**: iOS / Android / Both
**Status**: ✅ Success / ❌ Failed
**Duration**: Xs

## Results

[Build output summary]

## Errors (if any)

| File | Line | Error | Suggested Fix |
|------|------|-------|---------------|
| ... | ... | ... | ... |

## Next Steps

- `/test` — Run tests to verify build
- `/platform-parity` — Check cross-platform status
```

## Next Steps

After successful build:
- Run `/test` to execute tests
- Run `/platform-parity` to verify cross-platform status
- Use `/task-status` to check remaining tasks

After failed build:
- Review error messages and file locations
- Fix reported issues
- Re-run `/build` to verify fixes
