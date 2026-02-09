# Devflow — Claude Code Configuration Framework

> A comprehensive, schema-compliant Claude Code project configuration featuring **cross-platform iOS/Android development**, **dynamic multi-mode brainstorming** (14 modes), **integrated task tracking**, and **design parity enforcement** — all wired into the official `settings.json` schema.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://claude.ai/code)

---

## Overview

Devflow provides a complete cross-platform development workflow from ideation to implementation with guaranteed feature parity:

```
/brainstorm → /create-prd → /create-architecture → /platform-init
                                                          ↓
                                                   /platform-sync
                                                          ↓
                                                   /generate-tasks
                                                          ↓
                              ┌────────────────────────────┴────────────────────────────┐
                              ↓                                                          ↓
                       /implement-ios                                          /implement-android
                              ↓                                                          ↓
                              └────────────────────────────┬────────────────────────────┘
                                                          ↓
                                                   /platform-parity
                                                          ↓
                                                    /build & /test
```

---

## What's New in v4.0

### Cross-Platform Support
- **Platform Configuration** — `docs/platform.json` for iOS, Android, or both
- **Platform Specialist Agents** — Dedicated iOS and Android experts
- **Design Token Sync** — Automatic generation of Swift and Kotlin design code
- **Parity Enforcement** — Track and verify identical functionality across platforms
- **Platform Commands** — `/platform-init`, `/platform-sync`, `/platform-parity`
- **Implementation Commands** — `/implement-ios`, `/implement-android`

### Enhanced Task Tracking
- **Three-layer Synchronization** — Markdown + JSON Registry + Claude Code Tasks
- **Task Management Commands** — `/task-status`, `/next-task`, `/update-task`
- **Hierarchical Task IDs** — `{feature}-{step}[.{subtask}]` format
- **Dependency Tracking** — Automatic blocking/unblocking

---

## Cross-Platform Development

### Platform Options

| Mode | Description | Use Case |
|------|-------------|----------|
| `ios` | iOS only | iOS-exclusive app |
| `android` | Android only | Android-exclusive app |
| `both` | iOS + Android | Cross-platform with parity |

### Initialize Project

```bash
# Cross-platform (recommended)
/platform-init both MyApp

# Single platform
/platform-init ios MyApp
/platform-init android MyApp
```

### Platform Configuration

After initialization, `docs/platform.json` contains:

```json
{
  "platforms": {
    "enabled": ["ios", "android"],
    "primary": "ios",
    "ios": {
      "minVersion": "16.0",
      "uiFramework": "swiftui",
      "architecture": "mvvm"
    },
    "android": {
      "minSdk": 26,
      "uiFramework": "compose",
      "architecture": "mvvm"
    }
  },
  "parity": {
    "enforced": true,
    "checkOnBuild": true
  }
}
```

### Design Token Flow

```
docs/design/colors.json (Single Source of Truth)
        ↓
   /platform-sync
        ↓
┌───────┴───────┐
↓               ↓
iOS (Swift)     Android (Kotlin)
Colors.swift    Colors.kt
```

Example generated code:

**iOS (Swift)**
```swift
extension Color {
    static let brandPrimary = Color("BrandPrimary")  // #007AFF
}
```

**Android (Kotlin)**
```kotlin
object AppColors {
    val BrandPrimary = Color(0xFF007AFF)
}
```

### Parity Verification

```bash
# Check all features
/platform-parity

# Check specific feature
/platform-parity authentication
```

Output:
```
## Parity Score: 85%

| Feature | iOS | Android | Status |
|---------|-----|---------|--------|
| Auth    | ✅  | ✅      | Full   |
| Profile | ✅  | ⚠️      | Partial|
| Settings| ✅  | ✅      | Full   |
```

---

## Dynamic Multi-Mode Brainstorming

The brainstorming engine supports **14 combinable modes** with **intelligent auto-detection**:

```bash
# Auto-detect modes (recommended)
/brainstorm A fitness tracking app for iOS and Android

# Explicit modes
/brainstorm full A cross-platform messaging app
/brainstorm 5w1h,swot,moscow A mobile payment solution
```

### Available Modes

| Core Modes | Extended Modes |
|------------|----------------|
| `5w1h` - WHO, WHAT, WHEN, WHERE, WHY, HOW | `reverse` - Failure mode analysis |
| `design-thinking` - User-centered design | `starburst` - Question explosion |
| `lean-canvas` - Business model | `scamper` - Innovation technique |
| `moscow` - Feature prioritization | `swot` - Strategic analysis |
| `user-stories` - Implementation specs | `competitor`, `jtbd`, `risk`, `assumption`, `six-hats` |

### Presets

| Preset | Expands To | Best For |
|--------|------------|----------|
| `full` | 5w1h → design-thinking → lean-canvas → moscow → user-stories | New projects |
| `quick` | 5w1h → moscow | Quick features |
| `validate` | reverse → swot → risk → assumption | Risk assessment |
| `business` | lean-canvas → swot → competitor → jtbd | Business model |

---

## Complete Command Reference

### Planning Commands

| Command | Description |
|---------|-------------|
| `/brainstorm [modes] <description>` | Multi-mode structured ideation |
| `/create-prd [session]` | Generate PRD from brainstorm |
| `/create-architecture [prd]` | Generate architecture document |

### Platform Commands

| Command | Description |
|---------|-------------|
| `/platform-init <ios\|android\|both>` | Initialize platform configuration |
| `/platform-sync [--colors\|--typography]` | Sync design tokens to platform code |
| `/platform-parity [feature]` | Check cross-platform parity |
| `/implement-ios <feature>` | Implement feature for iOS |
| `/implement-android <feature>` | Implement feature for Android |

### Task Management Commands

| Command | Description |
|---------|-------------|
| `/generate-tasks <feature>` | Create feature spec with tracked tasks |
| `/task-status [feature]` | View progress across all features |
| `/next-task [feature]` | Get next available task |
| `/update-task <id> <status>` | Update task status |
| `/sync-tasks [feature]` | Synchronize all tracking systems |

### Development Commands

| Command | Description |
|---------|-------------|
| `/build` | Build project |
| `/test [pattern]` | Run tests |
| `/create-feature <name>` | Scaffold new feature |

---

## Available Agents

| Agent | Purpose | Model |
|-------|---------|-------|
| `architect` | System design & architecture | Opus |
| `brainstorm` | Guided brainstorming facilitator | Opus |
| `ios-specialist` | iOS/Swift/SwiftUI expert | Sonnet |
| `android-specialist` | Android/Kotlin/Compose expert | Sonnet |
| `task-manager` | Task lifecycle management | Sonnet |
| `reviewer` | Code review & quality | Sonnet |
| `researcher` | API research & documentation | Sonnet |

---

## Directory Structure

```
project-root/
├── ios/                            # iOS project
│   ├── Sources/
│   │   ├── App/
│   │   ├── Features/
│   │   └── Core/
│   │       ├── Design/             # Generated design tokens
│   │       ├── Network/
│   │       └── Utils/
│   └── Tests/
├── android/                        # Android project
│   ├── app/src/
│   │   ├── main/java/.../
│   │   │   ├── feature/
│   │   │   ├── core/
│   │   │   │   ├── design/         # Generated design tokens
│   │   │   │   └── network/
│   │   │   └── di/
│   │   └── test/
│   └── build.gradle.kts
├── docs/
│   ├── platform.json               # Platform configuration
│   ├── platform-parity.json        # Parity tracking
│   ├── design/                     # Shared design tokens
│   │   ├── colors.json
│   │   ├── typography.json
│   │   └── spacing.json
│   ├── api/                        # Shared API contracts
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   ├── brainstorm/
│   └── tasks/
│       ├── .task-registry.json
│       └── {feature}.md
├── .claude/
│   ├── settings.json
│   ├── agents/
│   │   ├── ios-specialist.md
│   │   ├── android-specialist.md
│   │   └── ...
│   ├── commands/
│   │   ├── platform-init.md
│   │   ├── platform-sync.md
│   │   ├── platform-parity.md
│   │   ├── implement-ios.md
│   │   ├── implement-android.md
│   │   └── ...
│   └── skills/
│       ├── brainstorming/
│       └── cross-platform/
├── CLAUDE.md
└── README.md
```

---

## Cross-Platform Workflow

### Full Workflow Example

```bash
# 1. Brainstorm the app
/brainstorm full A task management app for iOS and Android

# 2. Generate PRD
/create-prd

# 3. Generate Architecture
/create-architecture

# 4. Initialize platforms
/platform-init both TaskApp

# 5. Sync design tokens
/platform-sync

# 6. Generate tasks for a feature
/generate-tasks authentication

# 7. View tasks
/task-status authentication

# 8. Implement iOS
/implement-ios authentication

# 9. Implement Android
/implement-android authentication

# 10. Verify parity
/platform-parity authentication

# 11. Build and test
/build
/test
```

### Parity Enforcement

The framework enforces identical design and functionality through:

1. **Shared Design Tokens** — Colors, typography, spacing defined once
2. **Generated Platform Code** — Swift and Kotlin code auto-generated
3. **Parity Registry** — Track implementation status per platform
4. **Parity Checks** — Automated verification of feature completeness
5. **Exception Handling** — Document platform-specific features

---

## Parity Score Calculation

```
Score = (Features × 40%) + (Screens × 30%) + (Components × 20%) + (Tokens × 10%)
```

| Score | Status |
|-------|--------|
| 100% | Full parity |
| 80-99% | Minor gaps |
| 50-79% | Significant gaps |
| <50% | Major discrepancies |

---

## Quick Start

```bash
# 1. Copy to your project
cp -r .claude/ your-project/
cp -r docs/ your-project/
cp CLAUDE.md README.md your-project/

# 2. Make hooks executable
chmod +x your-project/.claude/hooks/*.sh

# 3. Start Claude Code
cd your-project
claude

# 4. Initialize cross-platform project
/platform-init both MyApp

# 5. Start brainstorming
/brainstorm full A mobile app for ...
```

---

## Key Files

| File | Purpose |
|------|---------|
| `docs/platform.json` | Platform configuration |
| `docs/platform-parity.json` | Parity tracking |
| `docs/design/*.json` | Shared design tokens |
| `.claude/agents/ios-specialist.md` | iOS expert agent |
| `.claude/agents/android-specialist.md` | Android expert agent |
| `.claude/commands/platform-*.md` | Platform commands |
| `.claude/skills/cross-platform/` | Cross-platform skill |

---

## Validation & Testing

Validate framework integrity and test configurations:

```bash
# Full validation
/validate

# Component-specific validation
/validate --commands    # Validate all commands
/validate --agents      # Validate all agents
/validate --platform    # Validate platform configuration
/validate --tasks       # Validate task registry
```

---

## Documentation

| Document | Description |
|----------|-------------|
| `CLAUDE.md` | Project-level Claude Code instructions |
| `docs/TESTING.md` | Testing procedures and test scenarios |
| `docs/INTEGRATION-MATRIX.md` | Command-agent integration reference |
| `docs/PRD.md` | Product requirements (generated) |
| `docs/ARCHITECTURE.md` | Architecture decisions (generated) |

---

## References

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Swift Style Guide](https://google.github.io/swift/)
- [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Material Design](https://m3.material.io/)

---

*Framework Version: 4.1.0 — Cross-Platform Edition (Audited)*
*Compatible with Claude Code*
