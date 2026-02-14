# Project: [PROJECT_NAME]

## Quick Reference

- **Platform**: [iOS | Android | iOS + Android]
- **Language**: [Swift, Kotlin]
- **Framework**: [SwiftUI, Jetpack Compose]
- **Architecture**: [MVVM | TCA | MVI | Clean Architecture]
- **Package Manager**: [SPM, Gradle]
- **Test Framework**: [XCTest, JUnit]

## Cross-Platform Configuration

**Target Platforms**: iOS, Android (configure in `docs/platform.json`)
**Primary Platform**: [iOS | Android]
**Parity Enforcement**: Strict
**Design System**: [DesignSystemName]

### iOS Configuration
- Min Version: 16.0
- UI Framework: SwiftUI
- Architecture: MVVM
- Package Manager: SPM

### Android Configuration
- Min SDK: 26 (Android 8.0)
- Target SDK: 34
- UI Framework: Jetpack Compose
- Architecture: MVVM

## Project Structure

```
[PROJECT_NAME]/
├── ios/                        # iOS project
│   ├── Sources/
│   │   ├── App/                # App entry point
│   │   ├── Features/           # Feature modules
│   │   └── Core/
│   │       ├── Design/         # Generated design tokens
│   │       ├── Network/        # API client
│   │       └── Utils/          # Helpers
│   └── Tests/
├── android/                    # Android project
│   ├── app/
│   │   └── src/
│   │       ├── main/java/.../
│   │       │   ├── feature/    # Feature modules
│   │       │   ├── core/
│   │       │   │   ├── design/ # Generated design tokens
│   │       │   │   ├── network/
│   │       │   │   └── utils/
│   │       │   └── di/         # Dependency injection
│   │       └── test/
│   └── build.gradle.kts
├── docs/
│   ├── platform.json           # Platform configuration
│   ├── platform-parity.json    # Parity tracking
│   ├── design/                 # Shared design tokens
│   │   ├── colors.json
│   │   ├── typography.json
│   │   ├── spacing.json
│   │   └── components.json
│   ├── api/                    # Shared API contracts
│   ├── PRD.md                  # Product requirements
│   ├── ARCHITECTURE.md         # Architecture decisions
│   ├── brainstorm/             # Brainstorming sessions
│   └── tasks/                  # Task breakdowns + registry
└── .claude/                     # Claude Code configuration
    ├── agents/                 # Autonomous subagents
    ├── commands/               # Slash commands
    ├── skills/                 # Domain knowledge
    └── output-styles/          # Response formatting
```

## Coding Standards

### General
- Follow platform-specific style guides (Swift Style Guide, Kotlin Coding Conventions)
- Use meaningful, descriptive names
- Keep functions focused (single responsibility)
- Write self-documenting code

### Cross-Platform Rules
- **Use design tokens** — Never hardcode colors, typography, or spacing
- **Match behavior** — Same user flows on both platforms
- **Shared contracts** — Same API request/response models
- **Update parity** — Track implementation status in registry

### Error Handling
- Use typed errors (Swift: Error protocol, Kotlin: sealed class)
- Handle errors at appropriate levels
- Provide meaningful error messages
- Match error states across platforms

## Ethical Guidelines

### Core Principles (Constitutional AI Alignment)

- **Harmlessness** — Generate code that is safe, secure, and does not cause harm
- **Honesty** — Provide accurate information; acknowledge limitations and uncertainties
- **Privacy** — Protect user data; never expose or log sensitive information
- **Security First** — Validate inputs, sanitize outputs, prevent injection vulnerabilities
- **Inclusivity** — Consider accessibility (a11y) and internationalization (i18n) in all features

### Code Generation Standards

- **No Harmful Patterns** — Avoid generating code that could be used maliciously
- **Input Validation** — Always validate and sanitize user inputs
- **Data Protection** — Never hardcode secrets, tokens, or personal data
- **Bias Awareness** — Avoid stereotypes in sample data, variable names, or comments
- **Accessible by Default** — Include ARIA labels, semantic markup, and screen reader support

### Content Guidelines

- Avoid offensive, discriminatory, or exclusionary language in code comments and documentation
- Use inclusive terminology (e.g., "allowlist/denylist" not "whitelist/blacklist")
- Consider diverse cultural contexts when creating example data or placeholder content
- Provide meaningful error messages that help users without exposing system internals

### Security Checklist

- [ ] Input validation on all user-provided data
- [ ] Output encoding to prevent XSS
- [ ] Parameterized queries to prevent SQL injection
- [ ] Authentication and authorization checks
- [ ] Sensitive data encrypted at rest and in transit
- [ ] No secrets in source code or logs

## Testing Requirements

| Platform | Framework | Coverage Target |
|----------|-----------|-----------------|
| iOS | XCTest | 80% |
| Android | JUnit + Espresso | 80% |

## DO NOT

- Hardcode design values (colors, fonts, spacing)
- Create platform-specific behavior without documenting exceptions
- Skip parity verification after implementation
- Commit secrets or API keys
- Use deprecated APIs
- Ignore linter warnings

## Planning Workflow

### Phase 1: Ideation
1. `/brainstorm [modes] <description>` — Multi-mode structured ideation

### Phase 2: Documentation
2. `/create-prd` — Generate formal product requirements
3. `/create-architecture` — Design architecture from PRD

### Phase 3: Platform Setup
4. `/platform-init <ios|android|both>` — Initialize platform configuration
5. `/platform-sync` — Generate design token files

### Phase 4: Task Generation
6. `/generate-tasks <feature>` — Create feature spec with tracked tasks

### Phase 5: Implementation
7. `/implement-ios <feature>` — Build iOS feature
8. `/implement-android <feature>` — Build Android feature

### Phase 6: Parity Verification
9. `/platform-parity` — Verify cross-platform parity

### Phase 7: Quality
10. `/task-status` — Check overall progress
11. `/build` and `/test` — Build and test

## Available Commands

### Planning Commands

| Command | Description |
|---------|-------------|
| `/brainstorm [modes] <description>` | Structured ideation (14 modes) |
| `/create-prd [session]` | Generate PRD from brainstorm |
| `/create-architecture [prd]` | Generate architecture document |
| `/generate-tasks <feature>` | Generate feature spec with tasks |

### Platform Commands

| Command | Description |
|---------|-------------|
| `/platform-init <ios\|android\|both>` | Initialize cross-platform project |
| `/platform-sync [--colors\|--typography]` | Sync design tokens to platform code |
| `/platform-parity [feature]` | Check cross-platform parity |
| `/implement-ios <feature>` | Implement feature for iOS |
| `/implement-android <feature>` | Implement feature for Android |

### Task Management Commands

| Command | Description |
|---------|-------------|
| `/task-status [feature]` | View task progress |
| `/next-task [feature]` | Get next available task |
| `/update-task <id> <status>` | Update task status |
| `/sync-tasks [feature]` | Synchronize task registry |

### Development Commands

| Command | Description |
|---------|-------------|
| `/build [ios\|android\|all]` | Build project |
| `/test [pattern] [--ios\|--android]` | Run tests |
| `/create-feature <name> [--ios\|--android\|--both]` | Scaffold new feature |
| `/validate [--commands\|--agents\|--platform\|--tasks]` | Validate configuration framework |

## Available Agents

| Agent | Purpose | Model |
|-------|---------|-------|
| `architect` | System design & architecture | Opus |
| `brainstorm` | Guided brainstorming facilitator | Opus |
| `ios-specialist` | iOS/Swift/SwiftUI expert | Sonnet |
| `android-specialist` | Android/Kotlin/Compose expert | Sonnet |
| `task-manager` | Task lifecycle management | Sonnet |
| `reviewer` | Code review & quality | Sonnet |
| `researcher` | API research & docs | Sonnet |

## Cross-Platform Parity

### Parity Score Calculation

```
Score = (Features × 40%) + (Screens × 30%) + (Components × 20%) + (Tokens × 10%)
```

### Status Legend

| Symbol | Status |
|--------|--------|
| ✅ | Implemented on both platforms |
| ⚠️ | Partial parity (missing on one platform) |
| ⬜ | Not started |

### Exception Handling

Platform-specific features must be documented:
```json
{
  "exceptions": [
    { "feature": "widgets", "platform": "ios", "reason": "WidgetKit specific" }
  ]
}
```

## Design Token Flow

```
docs/design/*.json (Source of Truth)
        ↓
   /platform-sync
        ↓
┌───────┴───────┐
↓               ↓
ios/Core/Design/ android/core/design/
(Swift)          (Kotlin)
```

## Task ID Format

```
{feature-prefix}-{step}[.{subtask}]

Examples:
- auth-1      → Authentication, Step 1
- auth-1.2    → Step 1, Subtask 2
```

## Task Tracking

Three-layer synchronization:
1. **Documentation** (`docs/tasks/*.md`) — Human-readable
2. **Registry** (`docs/tasks/.task-registry.json`) — Machine-readable
3. **Claude Code Tasks** — Session-based with dependencies

## Testing

Run `/validate` for quick configuration checks:
- Command validation tests
- Agent triggering tests
- Platform configuration tests
- Cross-platform parity tests

## Available Skills

| Skill | Purpose |
|-------|---------|
| `brainstorming` | Multi-mode structured ideation (14 modes) |
| `cross-platform` | iOS/Android parity and design tokens |
| `testing` | Platform-specific test patterns |
| `components` | Reusable UI component development |
| `command-development` | Slash command creation |
| `agent-development` | Autonomous agent design |
| `hook-development` | Event-driven automation |

## Memory Imports

@import docs/PRD.md
@import docs/ARCHITECTURE.md
@import docs/platform.json
