# Brainstorming Template: Mobile Application

**Project Name:** {name}
**Date:** {date}
**Team:** {members}
**Status:** phase-1

---

## Platform Configuration

### Target Platforms

| Platform | Enabled | Primary | Min Version |
|----------|---------|---------|-------------|
| iOS | ☐ Yes / ☐ No | ☐ | iOS 16.0+ |
| Android | ☐ Yes / ☐ No | ☐ | API 26+ (Android 8.0) |

### Development Strategy

**Approach:**
- ☐ **iOS First** — Develop iOS, then port to Android
- ☐ **Android First** — Develop Android, then port to iOS
- ☐ **Parallel** — Develop both simultaneously
- ☐ **Single Platform** — iOS only or Android only

**Parity Enforcement:**
- ☐ **Strict** — Identical design and functionality (recommended)
- ☐ **Flexible** — Platform-optimized with core parity
- ☐ **Independent** — Platform-specific designs

### Technology Stack

| Aspect | iOS | Android |
|--------|-----|---------|
| **Language** | Swift 5.9+ | Kotlin 1.9+ |
| **UI Framework** | ☐ SwiftUI / ☐ UIKit | ☐ Compose / ☐ Views |
| **Architecture** | ☐ MVVM / ☐ TCA / ☐ Clean | ☐ MVVM / ☐ MVI / ☐ Clean |
| **DI** | ☐ Manual / ☐ Swinject | ☐ Hilt / ☐ Koin |
| **Networking** | ☐ URLSession / ☐ Alamofire | ☐ Retrofit / ☐ Ktor |
| **Package Manager** | ☐ SPM / ☐ CocoaPods | Gradle |

---

## Phase 1: 5W1H Discovery

### WHO - Users & Stakeholders

**Primary User:**
**Secondary Users:**
**Device Preferences:** ☐ Phone / ☐ Tablet / ☐ Both
**Accessibility Needs:**
**Team:**

### WHAT - Product Definition

**Core Purpose:**
**Key Problems Solved:**
1.
2.
3.

**Differentiators vs Competitors:**

**Data Types:**
- ☐ User-generated content
- ☐ Media (photos/videos)
- ☐ Location data
- ☐ Health data
- ☐ Financial data
- ☐ Sensitive/encrypted data

**Third-Party Integrations:**

### WHEN - Timeline

**MVP Target:**
**Beta/TestFlight Target:**
**App Store Release:**

**Milestone Plan:**
| Milestone | iOS | Android | Date |
|-----------|-----|---------|------|
| Alpha | | | |
| Beta | | | |
| RC | | | |
| Release | | | |

### WHERE - Distribution

**App Stores:**
- ☐ Apple App Store
- ☐ Google Play Store
- ☐ Other (specify):

**Geographic Regions:**
**Backend Location:**
**Data Storage:** ☐ On-device / ☐ Cloud / ☐ Hybrid

### WHY - Purpose

**Business Model:** ☐ Free / ☐ Freemium / ☐ Paid / ☐ Subscription
**Primary Revenue Stream:**
**Success KPIs:**
1.
2.
3.

### HOW - Technical Approach

**Shared Design System:** {name}
**API Architecture:** ☐ REST / ☐ GraphQL / ☐ gRPC
**Real-time Features:** ☐ WebSocket / ☐ SSE / ☐ Polling / ☐ None
**Offline Strategy:** ☐ Online-only / ☐ Offline-first / ☐ Sync-when-available
**Testing Strategy:**
- ☐ Unit tests (target: __%  coverage)
- ☐ UI tests
- ☐ Snapshot tests
- ☐ E2E tests

**CI/CD:**
- iOS: ☐ Xcode Cloud / ☐ Fastlane / ☐ GitHub Actions
- Android: ☐ GitHub Actions / ☐ Bitrise / ☐ CircleCI

---

## Platform Capabilities

### Feature Matrix

| Capability | iOS | Android | Notes |
|------------|-----|---------|-------|
| Push Notifications | ☐ | ☐ | APNs / FCM |
| Background Processing | ☐ | ☐ | |
| Camera/Photos | ☐ | ☐ | |
| Location Services | ☐ | ☐ | |
| Biometric Auth | ☐ Face ID / ☐ Touch ID | ☐ Fingerprint / ☐ Face | |
| Home Screen Widgets | ☐ WidgetKit | ☐ Glance | |
| In-App Purchases | ☐ StoreKit 2 | ☐ Google Play Billing | |
| Offline Support | ☐ | ☐ | |
| Deep Linking | ☐ Universal Links | ☐ App Links | |
| Share Extension | ☐ | ☐ | |
| Watch/Wearable | ☐ watchOS | ☐ Wear OS | |

### Platform-Specific Features

**iOS Only (Exceptions):**
-

**Android Only (Exceptions):**
-

---

## Phase 2: Design Thinking

### User Personas

| Persona | Device Preference | Goals | Pain Points |
|---------|-------------------|-------|-------------|
| | ☐ iOS / ☐ Android / ☐ Both | | |
| | ☐ iOS / ☐ Android / ☐ Both | | |

### Problem Statement

"[User persona] needs a way to [user need] because [insight]."

### How Might We...

1.
2.
3.

### Feature Ideas

| # | Idea | Theme | iOS | Android | Feasibility |
|---|------|-------|-----|---------|-------------|
| 1 | | | ☐ | ☐ | |
| 2 | | | ☐ | ☐ | |
| 3 | | | ☐ | ☐ | |

### Navigation Map

```
[Launch] → [Onboarding] → [Home]
                              ├── [Tab 1] ─── [Detail]
                              ├── [Tab 2] ─── [Detail]
                              ├── [Tab 3] ─── [Detail]
                              └── [Profile/Settings]
```

**Navigation Pattern:**
- ☐ Tab Bar (iOS) / Bottom Navigation (Android)
- ☐ Side Menu / Drawer
- ☐ Stack-based
- ☐ Custom

---

## Phase 3: Lean Canvas

| Problem | Solution | Key Metrics |
|---------|----------|-------------|
| 1. | 1. | 1. |
| 2. | 2. | 2. |
| 3. | 3. | 3. |

| Unique Value Proposition | Unfair Advantage | Channels |
|--------------------------|------------------|----------|
| | | App Store, Play Store |

| Customer Segments | Cost Structure | Revenue Streams |
|-------------------|----------------|-----------------|
| | | |

---

## Phase 4: MoSCoW Prioritization

### Must Have (MVP)

| Feature | iOS | Android | Parity |
|---------|-----|---------|--------|
| | ☐ | ☐ | ☐ |
| | ☐ | ☐ | ☐ |
| | ☐ | ☐ | ☐ |

### Should Have (v1.0)

| Feature | iOS | Android | Parity |
|---------|-----|---------|--------|
| | ☐ | ☐ | ☐ |
| | ☐ | ☐ | ☐ |

### Could Have (v1.1+)

| Feature | iOS | Android | Parity |
|---------|-----|---------|--------|
| | ☐ | ☐ | ☐ |
| | ☐ | ☐ | ☐ |

### Won't Have (Out of Scope)

-

---

## Phase 5: User Stories

### Story-001: {Title}

As a {persona}, I want to {action}, so that {value}.

**Acceptance Criteria:**
- [ ] Given {precondition}, when {action}, then {result}

**Platform Requirements:**
- [ ] iOS implementation
- [ ] Android implementation
- [ ] Parity verified

**Priority:** Must / Should / Could
**Size:** S / M / L
**Sprint:** 1

---

## Design System Definition

### Color Tokens

| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| brand.primary | | | Primary actions |
| brand.secondary | | | Secondary actions |
| semantic.success | | | Success states |
| semantic.warning | | | Warning states |
| semantic.error | | | Error states |
| neutral.background | | | Screen backgrounds |
| neutral.surface | | | Cards, sheets |
| neutral.text.primary | | | Primary text |
| neutral.text.secondary | | | Secondary text |

### Typography Scale

| Token | Size | Weight | Usage |
|-------|------|--------|-------|
| heading.large | 28pt | Bold | Screen titles |
| heading.medium | 22pt | Bold | Section headers |
| heading.small | 17pt | Semibold | Subsections |
| body.large | 17pt | Regular | Primary content |
| body.medium | 15pt | Regular | Secondary content |
| body.small | 13pt | Regular | Tertiary content |
| caption | 12pt | Regular | Labels, hints |

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| xxs | 2pt | Minimal spacing |
| xs | 4pt | Tight spacing |
| sm | 8pt | Small gaps |
| md | 16pt | Standard spacing |
| lg | 24pt | Section gaps |
| xl | 32pt | Large separations |
| xxl | 48pt | Major divisions |

---

## Dependencies & Risks

### External Dependencies

| Dependency | Type | iOS | Android | Risk |
|------------|------|-----|---------|------|
| | SDK | ☐ | ☐ | |
| | API | ☐ | ☐ | |
| | Service | ☐ | ☐ | |

### Platform Risks

| Risk | Platform | Mitigation |
|------|----------|------------|
| OS Version fragmentation | Android | Target API 26+, test on multiple versions |
| Review rejection | iOS | Follow HIG, test on TestFlight |
| | | |

---

## Next Steps

1. [ ] `/platform-init both {ProjectName}` — Initialize cross-platform project
2. [ ] `/create-prd` — Generate PRD from brainstorm
3. [ ] `/create-architecture` — Generate architecture document
4. [ ] `/platform-sync` — Generate design token files
5. [ ] `/generate-tasks {feature}` — Create implementation tasks
6. [ ] `/implement-ios {feature}` — Build iOS feature
7. [ ] `/implement-android {feature}` — Build Android feature
8. [ ] `/platform-parity` — Verify cross-platform parity
