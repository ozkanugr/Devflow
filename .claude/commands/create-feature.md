---
description: Create a new feature with standard structure for iOS and/or Android
argument-hint: "<FeatureName> [--ios|--android|--both]"
allowed-tools: Read, Write, Edit, Glob
model: sonnet
---

# Create Feature: $ARGUMENTS

Scaffold a new feature following project conventions and platform configuration.

## Steps

1. Check `docs/platform.json` for enabled platforms
2. Read existing features to understand project patterns
3. Create feature directory structure for each platform
4. Generate base files:
   - Main component/view
   - ViewModel/Controller
   - Model types
   - Tests
5. Update any routing/navigation configuration
6. Add feature to relevant indexes/exports
7. Update task registry if applicable

## Platform Detection

Parse `$ARGUMENTS` for platform flag:
- `--ios` — iOS only
- `--android` — Android only
- `--both` or no flag — Both platforms (default if cross-platform project)

## Directory Structure

### iOS (SwiftUI)

```
ios/Sources/Features/
└── {FeatureName}/
    ├── {FeatureName}View.swift
    ├── {FeatureName}ViewModel.swift
    ├── {FeatureName}Model.swift
    └── Components/
        └── {FeatureName}Components.swift

ios/Tests/Features/
└── {FeatureName}Tests/
    └── {FeatureName}ViewModelTests.swift
```

### Android (Compose)

```
android/app/src/main/java/.../feature/{featurename}/
├── {FeatureName}Screen.kt
├── {FeatureName}ViewModel.kt
├── {FeatureName}UiState.kt
├── {FeatureName}Model.kt
└── components/
    └── {FeatureName}Components.kt

android/app/src/test/java/.../feature/{featurename}/
└── {FeatureName}ViewModelTest.kt
```

## Generated File Templates

### iOS View
```swift
import SwiftUI

/// {FeatureName} main view
/// Spec: docs/tasks/{feature-name}.md
struct {FeatureName}View: View {
    @StateObject private var viewModel = {FeatureName}ViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("{Feature Name}")
        }
        .task { await viewModel.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        Text("TODO: Implement {FeatureName}")
    }
}

#Preview {
    {FeatureName}View()
}
```

### Android Screen
```kotlin
package com.example.app.feature.{featurename}

import androidx.compose.runtime.*
import androidx.hilt.navigation.compose.hiltViewModel

/**
 * {FeatureName} main screen
 * Spec: docs/tasks/{feature-name}.md
 */
@Composable
fun {FeatureName}Screen(
    viewModel: {FeatureName}ViewModel = hiltViewModel(),
    onNavigate: (String) -> Unit = {}
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    {FeatureName}Content(
        uiState = uiState,
        onAction = viewModel::onAction
    )
}

@Composable
private fun {FeatureName}Content(
    uiState: {FeatureName}UiState,
    onAction: ({FeatureName}Action) -> Unit
) {
    Text("TODO: Implement {FeatureName}")
}
```

## Guidelines

- Follow existing naming conventions in the project
- Use the project's established architectural pattern
- Include proper documentation headers referencing specs
- Add basic unit test scaffolding
- Follow the project's import organization
- Use design tokens from generated design files

## Output

```markdown
# Feature Created: {FeatureName}

## Files Created

### iOS
| File | Purpose |
|------|---------|
| `ios/.../Views/{FeatureName}View.swift` | Main view |
| `ios/.../ViewModels/{FeatureName}ViewModel.swift` | View model |
| `ios/.../Models/{FeatureName}Model.swift` | Data model |
| `ios/.../Tests/{FeatureName}ViewModelTests.swift` | Unit tests |

### Android
| File | Purpose |
|------|---------|
| `android/.../feature/{featurename}/{FeatureName}Screen.kt` | Main composable |
| `android/.../feature/{featurename}/{FeatureName}ViewModel.kt` | View model |
| `android/.../feature/{featurename}/{FeatureName}UiState.kt` | State |
| `android/.../feature/{featurename}/{FeatureName}ViewModelTest.kt` | Unit tests |

## Next Steps

1. Generate feature spec: `/generate-tasks {feature-name}`
2. Implement iOS: `/implement-ios {feature-name}`
3. Implement Android: `/implement-android {feature-name}`
4. Check parity: `/platform-parity {feature-name}`
```

## Next Steps

After scaffolding:
- Run `/generate-tasks {feature}` to create detailed implementation tasks
- Use `/implement-ios {feature}` for iOS implementation guidance
- Use `/implement-android {feature}` for Android implementation guidance
- Run `/platform-parity {feature}` to track implementation status
