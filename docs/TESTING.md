# Configuration Framework Testing Guide

This document outlines testing procedures for the Claude Code Configuration Framework.

## Quick Test Commands

```bash
# Validate entire framework
/validate

# Validate specific components
/validate --commands
/validate --agents
/validate --platform
/validate --tasks
```

## Test Categories

### 1. Command Tests

Each command should be tested for:

| Test | Description | Expected Result |
|------|-------------|-----------------|
| Invocation | Command can be invoked | No errors |
| Help text | Shows usage when asked | Displays argument-hint |
| Arguments | Handles valid arguments | Proper execution |
| Edge cases | Handles missing/invalid args | Graceful error message |
| Output | Produces expected output | Matches documented format |

#### Command Test Scenarios

##### /brainstorm

```bash
# Basic invocation
/brainstorm A mobile fitness app

# With preset
/brainstorm full A task management system

# With specific modes
/brainstorm 5w1h,lean-canvas An e-commerce platform

# Resume session
/brainstorm resume

# List sessions
/brainstorm list
```

Expected: Each invocation should produce structured output matching the mode definitions.

##### /create-prd

```bash
# From brainstorm session
/create-prd docs/brainstorm/session-2024-01-15.md

# Without session (guided discovery)
/create-prd
```

Expected: Creates `docs/PRD.md` with proper structure.

##### /create-architecture

```bash
# Standard invocation
/create-architecture

# With specific PRD
/create-architecture docs/PRD.md
```

Expected: Creates `docs/ARCHITECTURE.md` and updates `CLAUDE.md`.

##### /generate-tasks

```bash
# Generate tasks for feature
/generate-tasks authentication
```

Expected: Creates `docs/tasks/authentication.md` and updates `.task-registry.json`.

##### /build

```bash
# Build all platforms
/build

# Build specific platform
/build ios
/build android
```

Expected: Runs appropriate build commands and reports results.

##### /test

```bash
# Run all tests
/test

# Run with pattern
/test authentication

# Run for specific platform
/test --ios
/test --android
```

Expected: Runs tests and provides formatted report.

### 2. Agent Tests

Each agent should be tested for:

| Test | Description | Expected Result |
|------|-------------|-----------------|
| Triggering | Agent activates on relevant prompts | Agent responds appropriately |
| Context loading | Agent reads relevant files | References current project state |
| Output quality | Agent produces useful output | Matches expected format |

#### Agent Test Scenarios

##### architect

```
User: How should I structure the database for user management?
User: Should I use microservices or a monolith?
User: What's the best way to handle authentication?
```

Expected: Provides architectural guidance with trade-offs.

##### reviewer

```
User: Can you review this code? [paste code]
User: Are there any security issues in src/auth/login.ts?
User: How can I refactor this to be cleaner?
```

Expected: Provides code review with specific feedback.

##### researcher

```
User: How do I use the Stripe API for subscriptions?
User: What's the best pagination library for React?
User: I'm getting this error from SwiftUI [paste error]
```

Expected: Researches and provides sourced recommendations.

##### ios-specialist

```
User: Implement the login screen for iOS
User: Add biometric authentication on iOS
User: How do I handle deep links in Swift?
```

Expected: Provides iOS-specific implementation guidance.

##### android-specialist

```
User: Implement the login screen for Android
User: Add biometric authentication on Android
User: How do I handle deep links in Kotlin?
```

Expected: Provides Android-specific implementation guidance.

### 3. Platform Configuration Tests

#### platform.json

```bash
# Check structure
/validate --platform

# Verify iOS configuration
cat docs/platform.json | jq '.platforms.ios'

# Verify Android configuration
cat docs/platform.json | jq '.platforms.android'
```

Expected: Valid JSON with all required fields.

#### Design Tokens

```bash
# Verify design token files exist
ls docs/design/

# Check colors.json
/validate --platform
```

Expected: Design token files exist and are valid JSON.

### 4. Task Tracking Tests

#### Task Registry

```bash
# Verify registry
/validate --tasks

# Check registry structure
cat docs/tasks/.task-registry.json | jq '.features'
```

#### Task Commands

```bash
# Generate tasks
/generate-tasks test-feature

# Check status
/task-status

# Get next task
/next-task

# Update task
/update-task test-1 complete

# Sync tasks
/sync-tasks
```

Expected: Tasks flow through lifecycle correctly.

### 5. Cross-Platform Parity Tests

```bash
# Initialize platform
/platform-init both TestApp

# Sync design tokens
/platform-sync

# Check parity
/platform-parity
```

Expected: Tokens generated for both platforms, parity report accurate.

## Integration Test Workflows

### Workflow 1: Full Feature Development

```bash
# 1. Start brainstorming
/brainstorm A user authentication system with OAuth

# 2. Create PRD
/create-prd

# 3. Create architecture
/create-architecture

# 4. Generate tasks
/generate-tasks authentication

# 5. Check task status
/task-status

# 6. Get next task
/next-task

# 7. (Implement feature)

# 8. Update task
/update-task auth-1 complete

# 9. Build
/build

# 10. Test
/test authentication
```

Expected: Complete flow from ideation to tested implementation.

### Workflow 2: Cross-Platform Feature

```bash
# 1. Initialize platforms
/platform-init both MyApp

# 2. Generate tasks with platform context
/generate-tasks profile

# 3. Implement iOS
/implement-ios profile

# 4. Implement Android
/implement-android profile

# 5. Check parity
/platform-parity profile

# 6. Sync design tokens
/platform-sync
```

Expected: Feature implemented on both platforms with parity.

### Workflow 3: Task Recovery

```bash
# 1. Simulate out-of-sync state (manual edits)

# 2. Sync tasks
/sync-tasks

# 3. Verify registry
/validate --tasks

# 4. Check status
/task-status
```

Expected: Tasks resynchronized across all tracking systems.

## Regression Tests

After framework updates, run these tests:

1. **Configuration Validation**
   ```bash
   /validate
   ```
   Expected: No critical errors.

2. **Command Availability**
   Test each command is callable.

3. **Agent Triggering**
   Test each agent triggers on appropriate prompts.

4. **Task Lifecycle**
   Create, update, and complete a test task.

5. **Platform Sync**
   Generate tokens and verify output.

## Test Data

### Sample Inputs

**Brainstorm Input:**
```
A mobile app for tracking daily habits with reminders and statistics
```

**Feature Name:**
```
habit-tracking
```

**Task Update:**
```
habit-1 complete
```

### Expected Outputs

See individual command documentation for expected output formats.

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Command not found | Not in claude/commands/ | Check file location |
| Agent not triggering | Missing examples | Add <example> blocks |
| Task sync fails | Invalid JSON | Run /validate --tasks |
| Platform sync fails | Missing design/ folder | Run /platform-init |

### Debug Commands

```bash
# Check command frontmatter
head -10 claude/commands/build.md

# Check agent frontmatter
head -15 claude/agents/architect.md

# Validate JSON files
cat docs/platform.json | jq .
cat docs/tasks/.task-registry.json | jq .
```
