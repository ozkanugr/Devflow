---
description: Synchronize design tokens and shared specifications across iOS and Android platforms
argument-hint: "[--colors|--typography|--all] [--force]"
allowed-tools: Read, Write, Edit, Glob, Grep
model: sonnet
---

# Platform Sync

Synchronize design tokens, API contracts, and shared specifications across iOS and Android codebases.

## Purpose

Maintain identical design and functionality by:
1. Generating platform-specific design token files from shared definitions
2. Synchronizing API contracts
3. Detecting and fixing token drift
4. Ensuring consistent theming

## Usage

```bash
/platform-sync                  # Sync all tokens
/platform-sync --colors         # Sync only colors
/platform-sync --typography     # Sync only typography
/platform-sync --force          # Overwrite without confirmation
/platform-sync --check          # Check only, don't modify
```

## Steps

### Step 1: Load Shared Definitions

Read from `docs/design/`:
- `colors.json` — Color tokens
- `typography.json` — Typography scale
- `spacing.json` — Spacing scale
- `components.json` — Component specifications

### Step 2: Generate iOS Design Tokens

Create/Update `ios/Sources/Core/Design/`:

#### Colors+Generated.swift
```swift
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/colors.json
// Generated: {timestamp}

import SwiftUI

extension Color {
    // MARK: - Brand

    /// Primary brand color
    /// Light: #007AFF, Dark: #0A84FF
    static let brandPrimary = Color("BrandPrimary")

    /// Secondary brand color
    /// Light: #5856D6, Dark: #5E5CE6
    static let brandSecondary = Color("BrandSecondary")

    // MARK: - Semantic

    /// Success state color
    static let semanticSuccess = Color("SemanticSuccess")

    /// Warning state color
    static let semanticWarning = Color("SemanticWarning")

    /// Error state color
    static let semanticError = Color("SemanticError")

    // MARK: - Neutral

    /// Primary background
    static let neutralBackground = Color("NeutralBackground")

    /// Surface color for cards
    static let neutralSurface = Color("NeutralSurface")

    /// Primary text color
    static let neutralTextPrimary = Color("NeutralTextPrimary")

    /// Secondary text color
    static let neutralTextSecondary = Color("NeutralTextSecondary")
}
```

#### Typography+Generated.swift
```swift
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/typography.json
// Generated: {timestamp}

import SwiftUI

extension Font {
    // MARK: - Headings

    /// Large heading: 28pt Bold
    static let headingLarge = Font.system(size: 28, weight: .bold)

    /// Medium heading: 22pt Bold
    static let headingMedium = Font.system(size: 22, weight: .bold)

    /// Small heading: 17pt Semibold
    static let headingSmall = Font.system(size: 17, weight: .semibold)

    // MARK: - Body

    /// Large body: 17pt Regular
    static let bodyLarge = Font.system(size: 17, weight: .regular)

    /// Medium body: 15pt Regular
    static let bodyMedium = Font.system(size: 15, weight: .regular)

    /// Small body: 13pt Regular
    static let bodySmall = Font.system(size: 13, weight: .regular)

    // MARK: - Caption

    /// Caption: 12pt Regular
    static let caption = Font.system(size: 12, weight: .regular)
}
```

#### Spacing+Generated.swift
```swift
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/spacing.json
// Generated: {timestamp}

import SwiftUI

enum Spacing {
    // MARK: - Scale

    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48

    // MARK: - Semantic

    static let screenPadding: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let listItemSpacing: CGFloat = 12
    static let sectionSpacing: CGFloat = 24
}
```

#### Asset Catalog Colors (Colors.xcassets)
Generate color set for each token with light/dark variants.

### Step 3: Generate Android Design Tokens

Create/Update `android/app/src/main/java/.../core/design/`:

#### Colors.kt
```kotlin
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/colors.json
// Generated: {timestamp}

package com.example.app.core.design

import androidx.compose.ui.graphics.Color

object AppColors {
    // MARK: - Brand

    /** Primary brand color */
    val BrandPrimary = Color(0xFF007AFF)
    val BrandPrimaryDark = Color(0xFF0A84FF)

    /** Secondary brand color */
    val BrandSecondary = Color(0xFF5856D6)
    val BrandSecondaryDark = Color(0xFF5E5CE6)

    // MARK: - Semantic

    val SemanticSuccess = Color(0xFF34C759)
    val SemanticSuccessDark = Color(0xFF30D158)

    val SemanticWarning = Color(0xFFFF9500)
    val SemanticWarningDark = Color(0xFFFF9F0A)

    val SemanticError = Color(0xFFFF3B30)
    val SemanticErrorDark = Color(0xFFFF453A)

    // MARK: - Neutral

    val NeutralBackground = Color(0xFFFFFFFF)
    val NeutralBackgroundDark = Color(0xFF000000)

    val NeutralSurface = Color(0xFFF2F2F7)
    val NeutralSurfaceDark = Color(0xFF1C1C1E)

    val NeutralTextPrimary = Color(0xFF000000)
    val NeutralTextPrimaryDark = Color(0xFFFFFFFF)

    val NeutralTextSecondary = Color(0xFF3C3C43)
    val NeutralTextSecondaryDark = Color(0xFFEBEBF5)
}
```

#### Typography.kt
```kotlin
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/typography.json
// Generated: {timestamp}

package com.example.app.core.design

import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

object AppTypography {
    // MARK: - Headings

    val HeadingLarge = TextStyle(
        fontSize = 28.sp,
        fontWeight = FontWeight.Bold,
        lineHeight = 34.sp
    )

    val HeadingMedium = TextStyle(
        fontSize = 22.sp,
        fontWeight = FontWeight.Bold,
        lineHeight = 28.sp
    )

    val HeadingSmall = TextStyle(
        fontSize = 17.sp,
        fontWeight = FontWeight.SemiBold,
        lineHeight = 22.sp
    )

    // MARK: - Body

    val BodyLarge = TextStyle(
        fontSize = 17.sp,
        fontWeight = FontWeight.Normal,
        lineHeight = 22.sp
    )

    val BodyMedium = TextStyle(
        fontSize = 15.sp,
        fontWeight = FontWeight.Normal,
        lineHeight = 20.sp
    )

    val BodySmall = TextStyle(
        fontSize = 13.sp,
        fontWeight = FontWeight.Normal,
        lineHeight = 18.sp
    )

    // MARK: - Caption

    val Caption = TextStyle(
        fontSize = 12.sp,
        fontWeight = FontWeight.Normal,
        lineHeight = 16.sp
    )
}
```

#### Spacing.kt
```kotlin
// AUTO-GENERATED — DO NOT EDIT
// Source: docs/design/spacing.json
// Generated: {timestamp}

package com.example.app.core.design

import androidx.compose.ui.unit.dp

object Spacing {
    // MARK: - Scale

    val xxs = 2.dp
    val xs = 4.dp
    val sm = 8.dp
    val md = 16.dp
    val lg = 24.dp
    val xl = 32.dp
    val xxl = 48.dp

    // MARK: - Semantic

    val screenPadding = 16.dp
    val cardPadding = 16.dp
    val listItemSpacing = 12.dp
    val sectionSpacing = 24.dp
}
```

#### Theme.kt
```kotlin
// AUTO-GENERATED — DO NOT EDIT
// Generated: {timestamp}

package com.example.app.core.design

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable

private val LightColorScheme = lightColorScheme(
    primary = AppColors.BrandPrimary,
    secondary = AppColors.BrandSecondary,
    background = AppColors.NeutralBackground,
    surface = AppColors.NeutralSurface,
    error = AppColors.SemanticError,
    onPrimary = Color.White,
    onBackground = AppColors.NeutralTextPrimary,
    onSurface = AppColors.NeutralTextPrimary
)

private val DarkColorScheme = darkColorScheme(
    primary = AppColors.BrandPrimaryDark,
    secondary = AppColors.BrandSecondaryDark,
    background = AppColors.NeutralBackgroundDark,
    surface = AppColors.NeutralSurfaceDark,
    error = AppColors.SemanticErrorDark,
    onPrimary = Color.White,
    onBackground = AppColors.NeutralTextPrimaryDark,
    onSurface = AppColors.NeutralTextPrimaryDark
)

@Composable
fun AppTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme,
        typography = Typography(/* Map AppTypography */),
        content = content
    )
}
```

### Step 4: Detect Token Drift

Compare generated tokens with existing code:

```
1. Search for hardcoded color values (#RRGGBB, 0xFF...)
2. Search for hardcoded font sizes
3. Search for hardcoded spacing values
4. Report violations
```

### Step 5: Update Parity Registry

Update `docs/platform-parity.json`:

```json
{
  "designTokens": {
    "colors": { "synced": true, "lastSync": "{timestamp}" },
    "typography": { "synced": true, "lastSync": "{timestamp}" },
    "spacing": { "synced": true, "lastSync": "{timestamp}" }
  }
}
```

## Output Format

```markdown
# Platform Sync Report

**Synced At**: {timestamp}

## Files Generated

### iOS

| File | Tokens | Status |
|------|--------|--------|
| Colors+Generated.swift | 12 colors | ✅ Created |
| Typography+Generated.swift | 7 styles | ✅ Created |
| Spacing+Generated.swift | 11 values | ✅ Created |
| Colors.xcassets | 12 color sets | ✅ Created |

### Android

| File | Tokens | Status |
|------|--------|--------|
| Colors.kt | 12 colors | ✅ Created |
| Typography.kt | 7 styles | ✅ Created |
| Spacing.kt | 11 values | ✅ Created |
| Theme.kt | Light + Dark | ✅ Created |

## Token Drift Detected

### Hardcoded Values Found

| File | Line | Value | Should Use |
|------|------|-------|------------|
| ProfileView.swift | 45 | Color(#007AFF) | Color.brandPrimary |
| LoginScreen.kt | 78 | 16.dp | Spacing.md |

### Recommended Fixes

Run `/platform-sync --fix` to automatically replace hardcoded values.

## Summary

- ✅ Colors synced (12 tokens)
- ✅ Typography synced (7 tokens)
- ✅ Spacing synced (11 tokens)
- ⚠️ 2 hardcoded values detected

---

All platforms now use identical design tokens.
```
