---
name: cross-platform
description: This skill should be used when the user asks to "implement for both platforms", "ensure iOS and Android parity", "sync design tokens", "check platform parity", "create cross-platform feature", "use shared design tokens", "implement feature on iOS", "implement feature on Android", or needs guidance on maintaining identical design and functionality across iOS and Android platforms through design token synchronization, parity enforcement, and unified specifications.
version: 1.0.0
---

# Cross-Platform Development Skill

Ensure identical design and functionality across iOS and Android platforms through systematic parity enforcement, shared design tokens, and unified specifications.

## Activation Context

This skill activates when:
- Platform configuration exists (`docs/platform.json`)
- Working on mobile features targeting multiple platforms
- Design tokens need synchronization
- Feature parity needs verification

## Core Principles

### 1. Single Source of Truth

All design decisions and feature specifications exist in shared documentation:

```
docs/
├── platform.json           # Platform configuration
├── platform-parity.json    # Parity tracking
├── design/                 # Shared design tokens
│   ├── colors.json
│   ├── typography.json
│   ├── spacing.json
│   └── components.json
├── api/                    # Shared API contracts
│   └── contracts.json
└── tasks/                  # Shared feature specs
    └── {feature}.md
```

### 2. Design Token Flow

```
Shared Definition (JSON)
        ↓
   /platform-sync
        ↓
┌───────┴───────┐
↓               ↓
iOS Generated   Android Generated
(Swift)         (Kotlin)
```

### 3. Parity Verification

Every feature implementation must:
1. Reference the shared specification
2. Use generated design tokens
3. Match the defined behavior exactly
4. Update the parity registry

## Platform-Specific Mapping

### UI Framework Mapping

| Concept | iOS (SwiftUI) | Android (Compose) |
|---------|---------------|-------------------|
| Screen | View struct | @Composable fun |
| State | @State, @StateObject | State, StateFlow |
| List | List, LazyVStack | LazyColumn |
| Grid | LazyVGrid | LazyVerticalGrid |
| Navigation | NavigationStack | NavHost |
| Sheet | .sheet modifier | ModalBottomSheet |
| Alert | .alert modifier | AlertDialog |
| Loading | ProgressView | CircularProgressIndicator |

### Architecture Mapping

| Pattern | iOS | Android |
|---------|-----|---------|
| ViewModel | @Observable class | @HiltViewModel class |
| State Flow | @Published / Combine | StateFlow / SharedFlow |
| DI | Manual / Swinject | Hilt |
| Persistence | SwiftData / Core Data | Room |
| Networking | URLSession / Alamofire | Retrofit / Ktor |
| Image Loading | AsyncImage / Kingfisher | Coil |

### Design Token Mapping

| Token Type | iOS | Android |
|------------|-----|---------|
| Colors | Color.{name} extension | AppColors.{Name} object |
| Typography | Font.{name} extension | AppTypography.{Name} object |
| Spacing | Spacing.{name} enum | Spacing.{name} object |
| Shadows | Built-in modifiers | Custom Modifier |
| Corners | RoundedRectangle | RoundedCornerShape |

## Parity Enforcement Levels

### Level 1: Visual Parity (Required)

- Same layout structure
- Same colors (from tokens)
- Same typography (from tokens)
- Same spacing (from tokens)
- Same iconography

### Level 2: Behavioral Parity (Required)

- Same user flows
- Same error states
- Same loading states
- Same empty states
- Same validation rules

### Level 3: API Parity (Required)

- Same API endpoints
- Same request/response models
- Same error handling
- Same retry logic
- Same caching strategy

### Level 4: Platform Optimization (Allowed)

Platform-specific enhancements that don't affect parity:

| iOS Optimization | Android Equivalent | Parity Status |
|------------------|-------------------|---------------|
| SF Symbols | Material Icons | ✅ Allowed |
| Haptic Feedback | Haptic Feedback | ✅ Allowed |
| Dynamic Island | Edge-to-edge | ✅ Allowed |
| Apple Pay | Google Pay | ✅ Allowed |
| Sign in with Apple | Google Sign-In | ✅ Allowed |

## Parity Score Calculation

```
Parity Score =
  (Feature Parity × 0.40) +
  (Screen Parity × 0.30) +
  (Component Parity × 0.20) +
  (Token Sync × 0.10)

Where:
- Feature Parity = implemented_both / total_features
- Screen Parity = screens_both / total_screens
- Component Parity = components_both / total_components
- Token Sync = 1.0 if all synced, 0.0 if drift detected
```

## Implementation Workflow

### For New Features

```bash
# 1. Generate feature spec
/generate-tasks {feature}

# 2. Sync design tokens
/platform-sync

# 3. Implement primary platform
/implement-ios {feature}    # or /implement-android

# 4. Implement secondary platform
/implement-android {feature}  # or /implement-ios

# 5. Verify parity
/platform-parity {feature}
```

### For Existing Features

```bash
# 1. Check current parity
/platform-parity

# 2. Identify gaps (command shows missing screens/components)

# 3. Implement missing pieces
/implement-android {feature}#{missing-screen}

# 4. Re-verify parity
/platform-parity {feature}
```

## Common Parity Issues

### Issue: Hardcoded Values

**iOS - Incorrect:**
```swift
Text("Title").foregroundStyle(Color(#007AFF))
```

**iOS - Correct:**
```swift
Text("Title").foregroundStyle(.brandPrimary)
```

**Android - Incorrect:**
```kotlin
Text("Title", color = Color(0xFF007AFF))
```

**Android - Correct:**
```kotlin
Text("Title", color = AppColors.BrandPrimary)
```

### Issue: Different State Handling

**iOS State:**
```swift
@State private var isLoading = false
@State private var items: [Item] = []
@State private var error: Error?
```

**Android State - Must match iOS:**
```kotlin
data class UiState(
    val isLoading: Boolean = false,
    val items: List<Item> = emptyList(),
    val error: String? = null
)
```

## Exceptions Registry

Document intentional differences:

```json
{
  "exceptions": [
    {
      "feature": "widgets",
      "platform": "ios",
      "reason": "WidgetKit has no direct Android equivalent",
      "approved_by": "Tech Lead",
      "approved_at": "2024-01-15"
    }
  ]
}
```

## Quick Reference Commands

| Command | Purpose |
|---------|---------|
| `/platform-init` | Initialize cross-platform project |
| `/platform-sync` | Sync design tokens |
| `/platform-parity` | Check parity status |
| `/implement-ios` | iOS implementation |
| `/implement-android` | Android implementation |

## Integration with Task System

When generating tasks for cross-platform features:

| ID | Task | Platform | Depends On |
|----|------|----------|------------|
| auth-1 | Create shared models | Both | - |
| auth-2 | Implement iOS login | iOS | auth-1 |
| auth-3 | Implement Android login | Android | auth-1 |
| auth-4 | Verify parity | Both | auth-2, auth-3 |

Tasks are automatically created for both platforms with dependencies.
