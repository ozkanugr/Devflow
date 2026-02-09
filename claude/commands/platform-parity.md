---
description: Check and report cross-platform feature parity between iOS and Android
argument-hint: "[feature] — Optional: check specific feature only"
allowed-tools: Read, Write, Edit, Glob, Grep
model: sonnet
---

# Platform Parity

Analyze and report the parity status between iOS and Android implementations.

## Purpose

Ensure identical design and functionality across platforms by:
1. Comparing implemented features
2. Detecting design token drift
3. Identifying missing implementations
4. Tracking platform-specific exceptions

## Usage

```bash
/platform-parity                    # Full parity report
/platform-parity authentication     # Check specific feature
/platform-parity --fix              # Auto-fix detected issues
```

## Steps

### Step 1: Load Configuration

```
1. Read docs/platform.json
2. Read docs/platform-parity.json
3. Scan docs/tasks/*.md for feature specs
```

### Step 2: Analyze Features

For each feature in the registry:

```
1. Check iOS implementation status
2. Check Android implementation status
3. Compare screens, components, and APIs
4. Identify discrepancies
```

### Step 3: Check Design Tokens

Compare design token usage:

```
1. Scan iOS source files for color/typography usage
2. Scan Android source files for color/typography usage
3. Verify all tokens match shared definitions
4. Flag hardcoded values
```

### Step 4: Verify Functional Parity

Check behavior consistency:

| Aspect | Verification |
|--------|-------------|
| Navigation | Same flow structure |
| API Calls | Same endpoints and payloads |
| Error Handling | Same error states |
| Loading States | Same loading indicators |
| Empty States | Same empty state designs |
| Animations | Similar timing and effects |

### Step 5: Generate Report

## Output Format

### Full Parity Report

```markdown
# Platform Parity Report

**Generated**: {timestamp}
**Parity Score**: {score}%

---

## Summary

| Metric | Count |
|--------|-------|
| Total Features | 8 |
| Fully Implemented (Both) | 5 |
| iOS Only | 2 |
| Android Only | 0 |
| In Progress | 1 |

---

## Parity Score Breakdown

```
Overall: ████████░░ 80%

Features:    ██████████ 100% (5/5 complete on both)
Screens:     ████████░░ 80% (16/20 screens)
Components:  █████████░ 90% (18/20 components)
Design Sync: ██████████ 100% (all tokens synced)
```

---

## Feature Status

### ✅ Full Parity

| Feature | iOS | Android | Screens | Components |
|---------|-----|---------|---------|------------|
| Authentication | ✅ 1.0.0 | ✅ 1.0.0 | 3/3 | 5/5 |
| User Profile | ✅ 1.0.0 | ✅ 1.0.0 | 2/2 | 4/4 |
| Settings | ✅ 1.0.0 | ✅ 1.0.0 | 4/4 | 3/3 |
| Dashboard | ✅ 1.0.0 | ✅ 1.0.0 | 1/1 | 6/6 |
| Notifications | ✅ 1.0.0 | ✅ 1.0.0 | 2/2 | 2/2 |

### ⚠️ Partial Parity

| Feature | iOS | Android | Gap |
|---------|-----|---------|-----|
| Payments | ✅ 1.0.0 | 🔄 0.8.0 | Missing: Receipt screen |
| Social | ✅ 1.0.0 | ⬜ — | Android not started |

### 🔄 In Progress

| Feature | iOS Status | Android Status |
|---------|------------|----------------|
| Chat | 🔄 60% | 🔄 40% |

---

## Screen Parity

### Missing on Android

| Screen | Feature | iOS File | Priority |
|--------|---------|----------|----------|
| ReceiptView | Payments | ios/.../ReceiptView.swift | P1 |
| ShareSheet | Social | ios/.../ShareSheet.swift | P2 |
| FriendsList | Social | ios/.../FriendsListView.swift | P2 |

### Missing on iOS

(None)

---

## Component Parity

### Synced Components

| Component | iOS | Android | Design Token |
|-----------|-----|---------|--------------|
| PrimaryButton | ✅ | ✅ | button.primary |
| TextField | ✅ | ✅ | input.default |
| Avatar | ✅ | ✅ | avatar.default |
| Card | ✅ | ✅ | card.default |

### Missing Components

| Component | Platform Missing | Used In |
|-----------|-----------------|---------|
| PaymentCard | Android | Payments |
| FriendCell | Android | Social |

---

## Design Token Drift

### Colors

| Token | Expected | iOS | Android | Status |
|-------|----------|-----|---------|--------|
| brand.primary | #007AFF | ✅ | ✅ | Synced |
| brand.secondary | #5856D6 | ✅ | ✅ | Synced |
| semantic.error | #FF3B30 | ✅ | ⚠️ #FF0000 | DRIFT |

### Typography

| Token | Expected | iOS | Android | Status |
|-------|----------|-----|---------|--------|
| heading.large | 28/bold | ✅ | ✅ | Synced |
| body.medium | 15/regular | ✅ | ✅ | Synced |

---

## Exceptions (Approved)

| Feature | Platform | Reason | Approved By |
|---------|----------|--------|-------------|
| Widget | iOS Only | No Android equivalent | Tech Lead |
| App Clip | iOS Only | Platform-specific | Product |

---

## Recommended Actions

### High Priority

1. **Implement ReceiptView on Android**
   - Feature: Payments
   - Spec: docs/tasks/payments.md#receipt
   - Command: `/implement-android payments`

2. **Fix color token drift**
   - Token: semantic.error
   - File: android/.../Colors.kt
   - Expected: #FF3B30

### Medium Priority

3. **Start Social feature on Android**
   - Feature: Social
   - Spec: docs/tasks/social.md
   - Run: `/generate-tasks social` then `/implement-android social`

---

## Quick Commands

```bash
# Implement missing Android features
/implement-android payments

# Fix design token drift
/platform-sync --force

# View specific feature parity
/platform-parity social
```
```

### Feature-Specific Report ($ARGUMENTS provided)

```markdown
# Parity Report: Authentication

**Parity Score**: 100%

## Implementation Status

| Platform | Version | Status | Screens | Components |
|----------|---------|--------|---------|------------|
| iOS | 1.0.0 | ✅ Complete | 3/3 | 5/5 |
| Android | 1.0.0 | ✅ Complete | 3/3 | 5/5 |

## Screens

| Screen | iOS | Android | Spec |
|--------|-----|---------|------|
| Login | ✅ LoginView.swift | ✅ LoginScreen.kt | #login |
| Register | ✅ RegisterView.swift | ✅ RegisterScreen.kt | #register |
| Forgot Password | ✅ ForgotPasswordView.swift | ✅ ForgotPasswordScreen.kt | #forgot |

## Components

| Component | iOS | Android |
|-----------|-----|---------|
| AuthButton | ✅ | ✅ |
| EmailField | ✅ | ✅ |
| PasswordField | ✅ | ✅ |
| SocialLoginButton | ✅ | ✅ |
| AuthHeader | ✅ | ✅ |

## API Parity

| Endpoint | iOS | Android |
|----------|-----|---------|
| POST /auth/login | ✅ | ✅ |
| POST /auth/register | ✅ | ✅ |
| POST /auth/forgot-password | ✅ | ✅ |

## Design Token Usage

All tokens synced. No hardcoded values detected.

## Conclusion

✅ **Full Parity Achieved**

This feature has identical implementation across both platforms.
```

## Parity Score Calculation

```
Feature Score = (common_features / total_features) * 40%
              + (common_screens / total_screens) * 30%
              + (common_components / total_components) * 20%
              + (synced_tokens / total_tokens) * 10%
```

## Update Parity Registry

After analysis, update `docs/platform-parity.json`:

```json
{
  "lastUpdated": "{timestamp}",
  "summary": {
    "totalFeatures": 8,
    "fullyImplemented": 5,
    "iosOnly": 2,
    "androidOnly": 0,
    "inProgress": 1,
    "parityScore": 80
  }
}
```
