---
description: Initialize cross-platform mobile project configuration for iOS, Android, or both
argument-hint: "<ios|android|both> [project-name]"
allowed-tools: Read, Write, Edit, Glob, AskUserQuestion
model: sonnet
---

# Platform Init

Initialize or update the platform configuration for cross-platform mobile development.

## Usage

```bash
/platform-init ios MyApp           # iOS only
/platform-init android MyApp       # Android only
/platform-init both MyApp          # Cross-platform (iOS + Android)
/platform-init                     # Interactive mode
```

## Behavior

### Interactive Mode (No Arguments)

When run without arguments, prompt for configuration:

1. **Project Name**
2. **Target Platforms** (iOS only, Android only, Both)
3. **Primary Platform** (if both selected)
4. **Architecture Pattern** (MVVM, Clean, TCA/MVI)
5. **Design System** (New or existing)

### With Arguments

Parse `$ARGUMENTS` for:
- Platform selection: `ios`, `android`, or `both`
- Project name: Second argument

## Steps

### Step 1: Validate Current State

```
1. Check if docs/platform.json exists
2. If exists, confirm overwrite or merge
3. Check for existing project structure
```

### Step 2: Gather Configuration

For iOS:
```
- Minimum iOS version (default: 16.0)
- UI Framework: SwiftUI (default) or UIKit
- Package Manager: SPM (default) or CocoaPods
- Bundle ID pattern
```

For Android:
```
- Minimum SDK (default: 26)
- Target SDK (default: 34)
- UI Framework: Compose (default) or Views
- Application ID pattern
```

For Both:
```
- Primary platform for development
- Shared design system name
- Feature parity enforcement level
```

### Step 3: Generate Configuration Files

Create/Update:

1. `docs/platform.json` — Platform configuration
2. `docs/platform-parity.json` — Parity tracking registry
3. `docs/design/colors.json` — Color token definitions
4. `docs/design/typography.json` — Typography definitions
5. `docs/design/spacing.json` — Spacing scale
6. `docs/design/components.json` — Component specifications

### Step 4: Create Directory Structure

#### iOS Only
```
ios/
├── Sources/
│   ├── App/
│   │   └── {ProjectName}App.swift
│   ├── Features/
│   ├── Core/
│   │   ├── Design/
│   │   ├── Network/
│   │   └── Utils/
│   └── Resources/
├── Tests/
└── {ProjectName}.xcodeproj/ (or Package.swift)
```

#### Android Only
```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/{package}/
│   │   │   │   ├── MainActivity.kt
│   │   │   │   ├── feature/
│   │   │   │   ├── core/
│   │   │   │   │   ├── design/
│   │   │   │   │   ├── network/
│   │   │   │   │   └── utils/
│   │   │   │   └── di/
│   │   │   └── res/
│   │   └── test/
│   └── build.gradle.kts
├── build.gradle.kts
└── settings.gradle.kts
```

#### Cross-Platform (Both)
```
project/
├── ios/                    # iOS project
│   └── [iOS structure]
├── android/                # Android project
│   └── [Android structure]
├── docs/
│   ├── platform.json       # Platform configuration
│   ├── platform-parity.json # Parity tracking
│   ├── design/             # Shared design system
│   │   ├── colors.json
│   │   ├── typography.json
│   │   ├── spacing.json
│   │   └── components.json
│   ├── api/                # Shared API contracts
│   │   └── contracts.json
│   └── specs/              # Shared specifications
└── CLAUDE.md               # Updated with platform config
```

### Step 5: Generate Design Tokens

#### colors.json
```json
{
  "version": "1.0",
  "tokens": {
    "brand": {
      "primary": { "light": "#007AFF", "dark": "#0A84FF" },
      "secondary": { "light": "#5856D6", "dark": "#5E5CE6" }
    },
    "semantic": {
      "success": { "light": "#34C759", "dark": "#30D158" },
      "warning": { "light": "#FF9500", "dark": "#FF9F0A" },
      "error": { "light": "#FF3B30", "dark": "#FF453A" }
    },
    "neutral": {
      "background": { "light": "#FFFFFF", "dark": "#000000" },
      "surface": { "light": "#F2F2F7", "dark": "#1C1C1E" },
      "text": {
        "primary": { "light": "#000000", "dark": "#FFFFFF" },
        "secondary": { "light": "#3C3C43", "dark": "#EBEBF5" }
      }
    }
  }
}
```

#### typography.json
```json
{
  "version": "1.0",
  "tokens": {
    "heading": {
      "large": { "size": 28, "weight": "bold", "lineHeight": 34 },
      "medium": { "size": 22, "weight": "bold", "lineHeight": 28 },
      "small": { "size": 17, "weight": "semibold", "lineHeight": 22 }
    },
    "body": {
      "large": { "size": 17, "weight": "regular", "lineHeight": 22 },
      "medium": { "size": 15, "weight": "regular", "lineHeight": 20 },
      "small": { "size": 13, "weight": "regular", "lineHeight": 18 }
    },
    "caption": {
      "regular": { "size": 12, "weight": "regular", "lineHeight": 16 }
    }
  }
}
```

#### spacing.json
```json
{
  "version": "1.0",
  "scale": {
    "xxs": 2,
    "xs": 4,
    "sm": 8,
    "md": 16,
    "lg": 24,
    "xl": 32,
    "xxl": 48
  },
  "semantic": {
    "screenPadding": 16,
    "cardPadding": 16,
    "listItemSpacing": 12,
    "sectionSpacing": 24
  }
}
```

### Step 6: Update CLAUDE.md

Add platform-specific configuration:

```markdown
## Platform Configuration

**Target Platforms**: iOS, Android
**Primary Platform**: iOS
**Design System**: {DesignSystemName}
**Parity Enforcement**: Strict

### iOS
- Min Version: 16.0
- Framework: SwiftUI
- Architecture: MVVM
- Package Manager: SPM

### Android
- Min SDK: 26
- Framework: Compose
- Architecture: MVVM
- Package Manager: Gradle

### Cross-Platform Commands
- `/platform-parity` — Check feature parity
- `/platform-sync` — Sync design tokens
- `/implement-ios <feature>` — iOS implementation
- `/implement-android <feature>` — Android implementation
```

## Output

```markdown
# Platform Initialized

**Project**: {ProjectName}
**Platforms**: {iOS | Android | iOS + Android}
**Primary**: {PrimaryPlatform}

## Created Files

| File | Purpose |
|------|---------|
| docs/platform.json | Platform configuration |
| docs/platform-parity.json | Parity tracking |
| docs/design/colors.json | Color tokens |
| docs/design/typography.json | Typography tokens |
| docs/design/spacing.json | Spacing scale |

## Directory Structure

{Generated structure tree}

## Next Steps

1. Review and customize design tokens in `docs/design/`
2. Run `/brainstorm` to define your first feature
3. Run `/generate-tasks <feature>` to create implementation tasks
4. Use `/implement-ios` or `/implement-android` to build features

## Platform Commands

| Command | Description |
|---------|-------------|
| `/platform-parity` | Check cross-platform feature parity |
| `/platform-sync` | Sync design tokens across platforms |
| `/implement-ios <feature>` | Implement feature for iOS |
| `/implement-android <feature>` | Implement feature for Android |
```
