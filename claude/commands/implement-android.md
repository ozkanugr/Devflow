---
description: Implement a feature for Android platform following the shared specification
argument-hint: "<feature-name>"
allowed-tools: Read, Write, Edit, Glob, Grep, TaskCreate, TaskUpdate, TaskList
model: sonnet
---

# Implement Android

Implement a feature for Android following the shared specification and design tokens.

## Purpose

Guide Android implementation that:
1. Matches the shared feature specification exactly
2. Uses generated design tokens
3. Follows Jetpack Compose/Android best practices
4. Updates parity registry upon completion

## Usage

```bash
/implement-android authentication      # Implement auth feature for Android
/implement-android authentication#login # Implement specific screen
```

## Steps

### Step 1: Load Context

```
1. Read docs/platform.json for Android configuration
2. Read docs/tasks/{feature}.md for feature specification
3. Read docs/platform-parity.json for current status
4. Load design tokens from android/.../core/design/
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
## Android Implementation: {Feature}

### Screens to Implement
1. {ScreenName}Screen.kt — {description}
2. {ScreenName}Screen.kt — {description}

### ViewModels to Create
1. {ScreenName}ViewModel.kt

### Models to Define
1. {ModelName}.kt

### Repository/Services
1. {Service}Repository.kt
```

### Step 4: Generate Code

Use Android-specific templates:

#### Screen Template
```kotlin
package com.example.app.feature.{feature}

import androidx.compose.runtime.*
import androidx.hilt.navigation.compose.hiltViewModel

/**
 * {FeatureName} - {ScreenName}
 * Spec: docs/tasks/{feature}.md#{section}
 * Parity: Must match iOS {ScreenName}View.swift
 */
@Composable
fun {ScreenName}Screen(
    viewModel: {ScreenName}ViewModel = hiltViewModel(),
    onNavigate: (String) -> Unit = {}
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()

    {ScreenName}Content(
        uiState = uiState,
        onAction = viewModel::onAction,
        onNavigate = onNavigate
    )
}

@Composable
private fun {ScreenName}Content(
    uiState: {ScreenName}UiState,
    onAction: ({ScreenName}Action) -> Unit,
    onNavigate: (String) -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("{Title}") }
            )
        }
    ) { padding ->
        when {
            uiState.isLoading -> {
                Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            }
            uiState.error != null -> {
                ErrorContent(
                    error = uiState.error,
                    onRetry = { onAction({ScreenName}Action.Retry) }
                )
            }
            else -> {
                MainContent(
                    items = uiState.items,
                    modifier = Modifier.padding(padding)
                )
            }
        }
    }
}

@Composable
private fun MainContent(
    items: List<Item>,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier = modifier.fillMaxSize(),
        contentPadding = PaddingValues(Spacing.screenPadding),
        verticalArrangement = Arrangement.spacedBy(Spacing.listItemSpacing)
    ) {
        items(items) { item ->
            ItemRow(item = item)
        }
    }
}

@Preview
@Composable
private fun {ScreenName}ScreenPreview() {
    AppTheme {
        {ScreenName}Content(
            uiState = {ScreenName}UiState(
                items = listOf(/* preview data */)
            ),
            onAction = {},
            onNavigate = {}
        )
    }
}
```

### Step 5: Implement with Design Tokens

Ensure all styling uses generated tokens:

```kotlin
// ✅ Correct - Using design tokens
Text(
    text = "Title",
    style = AppTypography.HeadingLarge,
    color = AppColors.NeutralTextPrimary
)

Button(
    onClick = { },
    modifier = Modifier.padding(Spacing.md)
) {
    Text("Submit")
}

// ❌ Incorrect - Hardcoded values
Text(
    text = "Title",
    fontSize = 28.sp,                    // Should use AppTypography.HeadingLarge
    color = Color(0xFF007AFF)            // Should use AppColors.BrandPrimary
)
```

### Step 6: Write Tests

```kotlin
import org.junit.Test
import org.junit.Assert.*

class {ScreenName}ViewModelTest {

    @Test
    fun `onAppear loads data successfully`() = runTest {
        // Given
        val repository = FakeRepository()
        val viewModel = {ScreenName}ViewModel(repository)

        // When
        viewModel.onAction({ScreenName}Action.Load)
        advanceUntilIdle()

        // Then
        assertFalse(viewModel.uiState.value.isLoading)
        assertEquals(3, viewModel.uiState.value.items.size)
    }
}
```

### Step 7: Update Parity Registry

After implementation, update `docs/platform-parity.json`:

```json
{
  "features": {
    "{feature}": {
      "android": {
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
# Android Implementation: {Feature}

## Created Files

| File | Type | Lines |
|------|------|-------|
| {ScreenName}Screen.kt | Composable | 95 |
| {ScreenName}ViewModel.kt | ViewModel | 68 |
| {ScreenName}UiState.kt | State | 18 |
| {Model}.kt | Model | 24 |
| {ScreenName}ViewModelTest.kt | Tests | 52 |

## Design Token Usage

- Colors: 5 tokens used
- Typography: 3 tokens used
- Spacing: 4 tokens used
- ✅ No hardcoded values

## Parity Status

| Screen | iOS | Android |
|--------|-----|---------|
| {Screen1} | ✅ | ✅ |
| {Screen2} | ✅ | ✅ |

## Next Steps

1. Run tests: `./gradlew testDebugUnitTest`
2. Check parity: `/platform-parity {feature}`
3. View full status: `/task-status`
```
