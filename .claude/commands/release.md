---
description: Manage releases with semantic versioning, changelog generation, and release checklists
argument-hint: "[major|minor|patch|<version>] [--dry-run] — Create a new release"
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

# Release Management

Structured release process with semantic versioning and automated changelog generation.

## Purpose

Provide consistent, reliable releases that:
- Follow semantic versioning
- Generate changelogs automatically
- Verify release readiness
- Create proper git tags
- Document release notes

## Usage

```bash
# Bump version
/release patch          # 1.0.0 → 1.0.1
/release minor          # 1.0.0 → 1.1.0
/release major          # 1.0.0 → 2.0.0

# Specific version
/release 2.0.0-beta.1

# Preview without changes
/release minor --dry-run

# Show release status
/release status

# List recent releases
/release list
```

## Semantic Versioning

### Version Format

```
MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]

Examples:
1.0.0
2.1.3
3.0.0-beta.1
1.2.0-rc.2+build.123
```

### When to Bump

| Type | When | Example Changes |
|------|------|-----------------|
| MAJOR | Breaking changes | API changes, removed features |
| MINOR | New features (backward compatible) | New endpoints, new screens |
| PATCH | Bug fixes (backward compatible) | Fixes, performance improvements |

### Pre-release Tags

| Tag | Use Case |
|-----|----------|
| alpha | Early development, unstable |
| beta | Feature complete, testing |
| rc | Release candidate, final testing |

## Release Steps

### Step 1: Pre-flight Checks

Verify release readiness:

```markdown
## Pre-flight Checklist

- [ ] All tests passing
- [ ] No critical bugs open
- [ ] Platform parity verified
- [ ] Documentation up to date
- [ ] Dependencies up to date
- [ ] Security audit passed
- [ ] Performance acceptable
```

Commands to run:
```bash
/run-tests
/platform-parity
/validate
```

### Step 2: Version Bump

Update version in relevant files:

**iOS:**
- `Info.plist` (CFBundleShortVersionString)
- `Info.plist` (CFBundleVersion)

**Android:**
- `build.gradle` (versionName)
- `build.gradle` (versionCode)

**Shared:**
- `package.json` (if applicable)
- `docs/platform.json`

### Step 3: Generate Changelog

Create changelog from:
- Completed tasks since last release
- Merged PRs
- Closed issues
- Commit history

Format:
```markdown
# Changelog

## [2.0.0] - 2024-01-20

### Added
- User authentication with biometrics (#123)
- Dark mode support (#145)
- Offline data sync (#156)

### Changed
- Improved loading performance by 40%
- Updated design tokens for accessibility

### Fixed
- Login crash on iOS 16 (#167)
- Memory leak in profile screen (#172)

### Security
- Updated dependencies for CVE-2024-1234

### Breaking Changes
- Minimum iOS version now 16.0
- API v1 deprecated, use v2
```

### Step 4: Create Release

Execute release:

```bash
# Create release branch
git checkout -b release/2.0.0

# Commit version changes
git add .
git commit -m "chore(release): prepare 2.0.0"

# Tag the release
git tag -a v2.0.0 -m "Release 2.0.0"

# Push
git push origin release/2.0.0
git push origin v2.0.0
```

### Step 5: Generate Release Notes

Create GitHub release:

```markdown
# Release v2.0.0

## Highlights

- **Biometric Login**: Touch ID and Face ID support
- **Dark Mode**: Full theme support
- **Offline Mode**: Work without connectivity

## What's Changed

[Changelog content]

## Upgrade Guide

[Migration instructions if breaking changes]

## Contributors

- @user1
- @user2
```

## Output Format

### Release Preview (--dry-run)

```markdown
# Release Preview

**Current Version**: 1.2.3
**New Version**: 1.3.0
**Type**: Minor

## Files to Update

| File | Current | New |
|------|---------|-----|
| ios/Info.plist | 1.2.3 | 1.3.0 |
| android/build.gradle | 1.2.3 | 1.3.0 |
| docs/platform.json | 1.2.3 | 1.3.0 |

## Changelog Preview

### Added
- Feature 1
- Feature 2

### Fixed
- Bug fix 1

## Pre-flight Status

- ✅ Tests passing
- ✅ Parity verified
- ⚠️ 2 open warnings (non-blocking)

---

Run `/release minor` to execute this release.
```

### Release Completion

```markdown
# Release Complete

**Version**: 2.0.0
**Tagged**: v2.0.0
**Branch**: release/2.0.0

## Actions Taken

1. ✅ Version bumped in 3 files
2. ✅ Changelog generated
3. ✅ Release branch created
4. ✅ Git tag created
5. ✅ Pushed to remote

## Generated Files

- CHANGELOG.md (updated)
- docs/releases/v2.0.0.md (created)

## Next Steps

1. Create PR: release/2.0.0 → main
2. After merge, create GitHub Release
3. Deploy to app stores
4. Announce to users

## Quick Links

- PR: [Create PR](command: gh pr create)
- Release: [Create Release](command: gh release create v2.0.0)
```

### Release Status

```markdown
# Release Status

**Current Version**: 1.2.3
**Last Release**: 2024-01-15 (v1.2.3)

## Since Last Release

- **Commits**: 47
- **PRs Merged**: 12
- **Issues Closed**: 8
- **Contributors**: 3

## Pending Changes

### Features (5)
- User authentication (#123)
- Profile editing (#134)
- Settings sync (#145)
- Notifications (#156)
- Analytics (#167)

### Fixes (3)
- Login crash fix (#172)
- Memory optimization (#178)
- UI alignment (#183)

## Recommendation

Based on changes, suggest: **MINOR** release (1.3.0)

Reasoning:
- New features added
- No breaking changes
- Backward compatible
```

## Version File Patterns

### iOS (Info.plist)

```xml
<key>CFBundleShortVersionString</key>
<string>1.2.3</string>
<key>CFBundleVersion</key>
<string>123</string>
```

### Android (build.gradle)

```kotlin
android {
    defaultConfig {
        versionCode = 123
        versionName = "1.2.3"
    }
}
```

### Package.json

```json
{
  "version": "1.2.3"
}
```

## Changelog Sources

### From Task Registry

```bash
# Get completed tasks since last release
grep -A5 '"status": "completed"' docs/tasks/.task-registry.json
```

### From Git Log

```bash
# Conventional commits since last tag
git log v1.2.3..HEAD --pretty=format:"%s" | grep -E "^(feat|fix|docs|refactor):"
```

### From GitHub

```bash
# Merged PRs
gh pr list --state merged --search "merged:>2024-01-15"

# Closed issues
gh issue list --state closed --search "closed:>2024-01-15"
```

## Error Handling

### Uncommitted Changes

```
Error: Working tree has uncommitted changes.

Please commit or stash changes before releasing:
  git stash
  # or
  git add . && git commit -m "WIP"
```

### Tests Failing

```
Error: Tests are failing.

Cannot proceed with release. Please fix:
  /run-tests

Or force (not recommended):
  /release minor --force
```

### Existing Tag

```
Error: Tag v2.0.0 already exists.

Options:
1. Use different version
2. Delete existing tag: git tag -d v2.0.0
3. Force update (dangerous): git tag -f v2.0.0
```

## Integration

### With CI/CD

Release triggers:
- Build and test
- Generate artifacts
- Deploy to staging
- Wait for approval
- Deploy to production

### With App Stores

After release:
- iOS: Upload to App Store Connect
- Android: Upload to Google Play Console
- Submit for review
- Monitor rollout

## Guidelines

### Do

- Always run pre-flight checks
- Write meaningful changelog entries
- Test on both platforms before release
- Keep release notes user-focused
- Tag releases consistently

### Don't

- Release on Fridays
- Skip testing
- Force push release branches
- Delete release tags
- Release without changelog
