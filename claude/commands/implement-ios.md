---
description: Implement a feature for iOS platform following the shared specification
argument-hint: "<feature-name>"
allowed-tools: Read, Write, Edit, Glob, Grep, TaskCreate, TaskUpdate, TaskList
model: sonnet
---

# Implement iOS

Implement a feature for iOS following the shared specification and design tokens.

## Purpose

Guide iOS implementation that:
1. Matches the shared feature specification exactly
2. Uses generated design tokens
3. Follows SwiftUI/iOS best practices
4. Updates parity registry upon completion

## Usage

```bash
/implement-ios authentication      # Implement auth feature for iOS
/implement-ios authentication#login # Implement specific screen
```

## Steps

### Step 1: Load Context

```
1. Read docs/platform.json for iOS configuration
2. Read docs/tasks/{feature}.md for feature specification
3. Read docs/platform-parity.json for current status
4. Load design tokens from ios/Sources/Core/Design/
```

### Step 2: Verify Prerequisites

Check that:
- [ ] Feature spec exists and is approved
- [ ] Design tokens are synced (`/platform-sync`)
- [ ] Dependencies are implemented
- [ ] No blocking tasks

### Step 3: Plan Implementation

Create implementation tasks:

```markdown
## iOS Implementation: {Feature}

### Screens to Implement
1. {ScreenName}View.swift — {description}
2. {ScreenName}View.swift — {description}

### ViewModels to Create
1. {ScreenName}ViewModel.swift

### Models to Define
1. {ModelName}.swift

### Repository/Services
1. {Service}Repository.swift
```

### Step 4: Generate Code

Use iOS-specific templates:

#### Screen Template
```swift
import SwiftUI

/// {FeatureName} - {ScreenName}
/// Spec: docs/tasks/{feature}.md#{section}
/// Parity: Must match Android {ScreenName}Screen.kt
struct {ScreenName}View: View {
    @StateObject private var viewModel = {ScreenName}ViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("{Title}")
                .toolbar { toolbarContent }
        }
        .task { await viewModel.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.error {
            ErrorView(error: error, onRetry: viewModel.retry)
        } else {
            mainContent
        }
    }

    private var mainContent: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.listItemSpacing) {
                ForEach(viewModel.items) { item in
                    ItemRow(item: item)
                }
            }
            .padding(Spacing.screenPadding)
        }
    }
}
```

### Step 5: Implement with Design Tokens

Ensure all styling uses generated tokens:

```swift
// ✅ Correct - Using design tokens
Text("Title")
    .font(.headingLarge)
    .foregroundStyle(Color.neutralTextPrimary)

Button("Submit") { }
    .buttonStyle(.primary)
    .padding(Spacing.md)

// ❌ Incorrect - Hardcoded values
Text("Title")
    .font(.system(size: 28, weight: .bold))  // Should use .headingLarge
    .foregroundStyle(Color(#007AFF))          // Should use .brandPrimary
```

### Step 6: Write Tests

```swift
import XCTest
@testable import {ProjectName}

final class {ScreenName}ViewModelTests: XCTestCase {

    func test_onAppear_loadsData() async throws {
        // Given
        let sut = {ScreenName}ViewModel(repository: MockRepository())

        // When
        await sut.onAppear()

        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.items.count, 3)
    }
}
```

### Step 7: Update Parity Registry

After implementation, update `docs/platform-parity.json`:

```json
{
  "features": {
    "{feature}": {
      "ios": {
        "status": "implemented",
        "version": "1.0.0",
        "implementedAt": "{timestamp}",
        "screens": ["{screen1}", "{screen2}"],
        "components": ["{comp1}", "{comp2}"]
      }
    }
  }
}
```

## Output

```markdown
# iOS Implementation: {Feature}

## Created Files

| File | Type | Lines |
|------|------|-------|
| {ScreenName}View.swift | View | 85 |
| {ScreenName}ViewModel.swift | ViewModel | 62 |
| {Model}.swift | Model | 24 |
| {ScreenName}ViewModelTests.swift | Tests | 48 |

## Design Token Usage

- Colors: 5 tokens used
- Typography: 3 tokens used
- Spacing: 4 tokens used
- ✅ No hardcoded values

## Parity Status

| Screen | iOS | Android |
|--------|-----|---------|
| {Screen1} | ✅ | ⬜ |
| {Screen2} | ✅ | ⬜ |

## Next Steps

1. Run tests: `xcodebuild test -scheme {Scheme}`
2. Implement Android: `/implement-android {feature}`
3. Check parity: `/platform-parity {feature}`
```
