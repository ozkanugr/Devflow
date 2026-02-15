# Error Patterns

> Common errors encountered and their solutions.

## Format

```markdown
## Error: "[Error Message]"
**Category**: [Build/Runtime/Test/Config]
**Platform**: [iOS/Android/Both]
**Frequency**: [Common/Occasional/Rare]

### Symptoms
- What the user sees
- Log messages

### Root Cause
What actually causes this error

### Solution
Step-by-step fix

### Prevention
How to avoid this in the future
```

---

## Build Errors

### Error: "Module 'XYZ' not found"

**Category**: Build
**Platform**: iOS
**Frequency**: Common

#### Symptoms
- Build fails immediately
- Red error in Xcode

#### Root Cause
Missing dependency, usually after:
- Fresh clone
- Branch switch
- Package update

#### Solution
```bash
# SPM
swift package resolve

# CocoaPods
pod install
```

#### Prevention
- Add to project setup checklist
- Document in README

---

### Error: "Could not resolve dependencies"

**Category**: Build
**Platform**: Android
**Frequency**: Common

#### Symptoms
- Gradle sync fails
- Build cannot start

#### Root Cause
- Version conflicts
- Missing repositories
- Network issues

#### Solution
```bash
./gradlew --refresh-dependencies
# or
./gradlew clean build --refresh-dependencies
```

#### Prevention
- Pin dependency versions
- Use version catalogs

---

## Runtime Errors

### Error: "Fatal error: Unexpectedly found nil"

**Category**: Runtime
**Platform**: iOS
**Frequency**: Common

#### Symptoms
- App crashes
- EXC_BAD_INSTRUCTION

#### Root Cause
Force unwrapping optional that is nil

#### Solution
1. Find the force unwrap (`!`)
2. Replace with safe unwrapping:
   - `if let`
   - `guard let`
   - `??` with default

#### Prevention
- Use SwiftLint rule `force_unwrapping`
- Code review for `!` usage

---

### Error: "NullPointerException"

**Category**: Runtime
**Platform**: Android
**Frequency**: Common

#### Symptoms
- App crashes
- Stack trace shows NPE

#### Root Cause
- Non-null assertion (`!!`) on null value
- Late initialization not completed
- Lifecycle issue

#### Solution
1. Find the `!!` or nullable access
2. Replace with safe access:
   - `?.` safe call
   - `?:` elvis operator
   - `let { }` scope function

#### Prevention
- Avoid `!!` in production code
- Use nullable types properly

---

## Configuration Errors

### Error: "Design tokens not syncing"

**Category**: Config
**Platform**: Both
**Frequency**: Occasional

#### Symptoms
- /platform-sync completes but no files generated
- Styles don't match tokens

#### Root Cause
- Missing `docs/platform.json`
- Platform not enabled
- Invalid token JSON

#### Solution
```bash
/platform-init both
/platform-sync --force
```

#### Prevention
- Run /validate before syncing
- Check JSON validity

---

## Test Errors

### Error: "Test flaky - passes sometimes"

**Category**: Test
**Platform**: Both
**Frequency**: Occasional

#### Symptoms
- Test passes locally, fails in CI
- Random failures

#### Root Cause
- Timing dependencies
- Shared state
- External dependencies

#### Solution
1. Identify shared state
2. Add proper setup/teardown
3. Mock external dependencies
4. Add explicit waits if needed

#### Prevention
- Design tests for isolation
- Avoid sleep(), use expectations

---

*Add new errors as they are encountered and solved.*

*Last Updated: [Date]*
