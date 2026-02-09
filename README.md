# Devflow — Claude Code Configuration Framework

> A comprehensive, schema-compliant Claude Code project configuration featuring **cross-platform iOS/Android development**, **dynamic multi-mode brainstorming** (14 modes), **integrated task tracking**, and **design parity enforcement**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://claude.ai/code)
[![Version](https://img.shields.io/badge/Version-4.1.0-green.svg)](#changelog)

---

## Table of Contents

1. [Overview](#overview)
   - [What This Framework Does](#what-this-framework-does)
   - [Key Features](#key-features)
   - [System Requirements](#system-requirements)
2. [Quick Start](#quick-start)
   - [Installation](#installation)
   - [First Run](#first-run)
   - [Minimal Workflow](#minimal-workflow)
3. [Core Concepts](#core-concepts)
   - [Framework Architecture](#framework-architecture)
   - [Component Types](#component-types)
   - [Design Token Flow](#design-token-flow)
   - [Task Tracking System](#task-tracking-system)
4. [Commands Reference](#commands-reference)
   - [Planning Commands](#planning-commands)
   - [Platform Commands](#platform-commands)
   - [Task Management Commands](#task-management-commands)
   - [Development Commands](#development-commands)
5. [Agents Reference](#agents-reference)
   - [Agent Overview](#agent-overview)
   - [Agent Specifications](#agent-specifications)
6. [Integration Matrix](#integration-matrix)
   - [Command-Agent Matrix](#command-agent-matrix)
   - [Agent Collaboration Matrix](#agent-collaboration-matrix)
   - [Resource Dependencies](#resource-dependencies)
   - [Model Assignments](#model-assignments)
7. [Workflow Diagrams](#workflow-diagrams)
   - [Complete Development Flow](#complete-development-flow)
   - [Ideation to Documentation](#ideation-to-documentation)
   - [Cross-Platform Implementation](#cross-platform-implementation)
   - [Quality Assurance Flow](#quality-assurance-flow)
8. [Configuration Schema](#configuration-schema)
   - [Platform Configuration](#platform-configuration)
   - [Design Tokens Schema](#design-tokens-schema)
   - [Task Registry Schema](#task-registry-schema)
9. [Testing Guide](#testing-guide)
   - [Quick Validation](#quick-validation)
   - [Command Tests](#command-tests)
   - [Agent Tests](#agent-tests)
   - [Integration Tests](#integration-tests)
   - [Regression Tests](#regression-tests)
10. [Directory Structure](#directory-structure)
11. [Troubleshooting](#troubleshooting)
    - [Common Issues](#common-issues)
    - [Debug Commands](#debug-commands)
12. [FAQ](#faq)
13. [Best Practices](#best-practices)
14. [Changelog](#changelog)
15. [References](#references)

---

## Overview

### What This Framework Does

Devflow is a **Claude Code configuration framework** that provides a complete cross-platform development workflow from ideation to implementation. It orchestrates AI agents, commands, skills, and hooks to deliver:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     Claude Code Configuration Framework                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐   │
│  │  Commands   │ ←→ │   Agents    │ ←→ │   Skills    │ ←→ │   Hooks     │   │
│  │  (User)     │    │  (AI)       │    │  (Auto)     │    │  (Events)   │   │
│  └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘   │
│         ↓                  ↓                  ↓                  ↓           │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        Shared Resources                              │    │
│  │  docs/platform.json  docs/tasks/*.md  docs/design/*.json            │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**The workflow at a glance:**

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

### Key Features

| Feature | Description |
|---------|-------------|
| **Cross-Platform Development** | iOS + Android with design parity enforcement |
| **14-Mode Brainstorming** | Structured ideation with auto-detection |
| **Three-Layer Task Tracking** | Markdown + JSON Registry + Claude Code Tasks |
| **Design Token Sync** | Single source → generated Swift/Kotlin code |
| **Specialized Agents** | Platform experts, architect, researcher |
| **Validation System** | Framework integrity verification |

### System Requirements

| Requirement | Version | Notes |
|-------------|---------|-------|
| Claude Code | Latest | CLI tool from Anthropic |
| macOS | 12.0+ | For iOS development |
| Xcode | 14.0+ | iOS builds (optional) |
| Android Studio | Latest | Android builds (optional) |
| Node.js | 18+ | For tooling (optional) |

---

## Quick Start

### Installation

```bash
# 1. Clone or copy the framework to your project
cp -r .claude/ your-project/
cp -r docs/ your-project/
cp CLAUDE.md README.md your-project/

# 2. Make hooks executable
chmod +x your-project/.claude/hooks/*.sh

# 3. Navigate to your project
cd your-project
```

### First Run

```bash
# Start Claude Code
claude

# Validate the framework is working
/validate
```

**Expected output:**
```
✅ Commands: 16/16 valid
✅ Agents: 7/7 valid
✅ Skills: 4/4 valid
✅ Platform config: Valid
✅ Task registry: Valid
```

### Minimal Workflow

```bash
# Initialize a cross-platform project
/platform-init both MyApp

# Start brainstorming
/brainstorm A mobile task manager app

# Generate requirements
/create-prd

# View your tasks
/task-status
```

---

## Core Concepts

### Framework Architecture

The framework consists of four interconnected component types:

```
┌─────────────────────────────────────────────────────────────────┐
│                        USER REQUEST                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  COMMANDS (.claude/commands/*.md)                               │
│  User-invocable slash commands that orchestrate workflows       │
│  Example: /brainstorm, /build, /platform-init                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  AGENTS (.claude/agents/*.md)                                   │
│  Specialized AI experts that handle complex domain tasks        │
│  Example: ios-specialist, architect, task-manager               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  SKILLS (.claude/skills/*/SKILL.md)                             │
│  Auto-activated capabilities triggered by context               │
│  Example: cross-platform skill, brainstorming modes             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  HOOKS (.claude/hooks/*.sh)                                     │
│  Shell scripts triggered by events                              │
│  Example: pre-commit validation, post-edit sync                 │
└─────────────────────────────────────────────────────────────────┘
```

### Component Types

| Component | Location | Trigger | Purpose |
|-----------|----------|---------|---------|
| **Commands** | `.claude/commands/` | `/command-name` | User-initiated actions |
| **Agents** | `.claude/agents/` | Context/Task tool | Domain expertise |
| **Skills** | `.claude/skills/` | Auto-detected | Contextual enhancements |
| **Hooks** | `.claude/hooks/` | System events | Automation scripts |

### Design Token Flow

Design tokens ensure visual consistency across platforms:

```
docs/design/colors.json (Single Source of Truth)
        │
        ▼
   /platform-sync
        │
        ├───────────────────────────────────────────┐
        ▼                                           ▼
   iOS (Swift)                              Android (Kotlin)
   ios/Core/Design/Colors.swift             android/core/design/Colors.kt
```

**Example Token Definition:**

```json
{
  "colors": {
    "brand": {
      "primary": {
        "value": "#007AFF",
        "description": "Primary brand color"
      }
    }
  }
}
```

**Generated iOS Code:**
```swift
extension Color {
    static let brandPrimary = Color("BrandPrimary")  // #007AFF
}
```

**Generated Android Code:**
```kotlin
object AppColors {
    val BrandPrimary = Color(0xFF007AFF)
}
```

### Task Tracking System

Tasks are synchronized across three layers:

```
┌─────────────────────────────────────────────────────────────────┐
│  Layer 1: Documentation                                         │
│  docs/tasks/{feature}.md                                        │
│  Human-readable task breakdowns                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  Layer 2: Registry                                              │
│  docs/tasks/.task-registry.json                                 │
│  Machine-readable state tracking                                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  Layer 3: Claude Code Tasks                                     │
│  TaskCreate, TaskUpdate, TaskList, TaskGet                      │
│  Session-based with dependencies                                │
└─────────────────────────────────────────────────────────────────┘
```

**Task ID Format:**
```
{feature-prefix}-{step}[.{subtask}]

Examples:
- auth-1      → Authentication, Step 1
- auth-1.2    → Step 1, Subtask 2
- profile-3   → Profile feature, Step 3
```

---

## Commands Reference

### Planning Commands

#### `/brainstorm [modes] <description>`

Multi-mode structured ideation with 14 combinable modes.

| Mode | Description | Best For |
|------|-------------|----------|
| `5w1h` | WHO, WHAT, WHEN, WHERE, WHY, HOW | Requirements discovery |
| `design-thinking` | User-centered design process | UX-focused projects |
| `lean-canvas` | Business model canvas | Startup validation |
| `moscow` | Must/Should/Could/Won't prioritization | Feature scoping |
| `user-stories` | Implementation specifications | Development prep |
| `reverse` | Failure mode analysis | Risk identification |
| `swot` | Strengths/Weaknesses/Opportunities/Threats | Strategic planning |
| `starburst` | Question explosion technique | Deep exploration |
| `scamper` | Innovation technique | Product improvement |
| `competitor` | Competitive analysis | Market positioning |
| `jtbd` | Jobs to be done | User motivation |
| `risk` | Risk assessment | Project planning |
| `assumption` | Assumption mapping | Validation planning |
| `six-hats` | De Bono's thinking hats | Perspective analysis |

**Presets:**

| Preset | Expands To | Use Case |
|--------|------------|----------|
| `full` | 5w1h → design-thinking → lean-canvas → moscow → user-stories | New projects |
| `quick` | 5w1h → moscow | Quick features |
| `validate` | reverse → swot → risk → assumption | Risk assessment |
| `business` | lean-canvas → swot → competitor → jtbd | Business model |

**Usage:**
```bash
# Auto-detect modes (recommended)
/brainstorm A fitness tracking app for iOS and Android

# Explicit modes
/brainstorm full A cross-platform messaging app
/brainstorm 5w1h,swot,moscow A mobile payment solution

# Resume previous session
/brainstorm resume

# List all sessions
/brainstorm list
```

#### `/create-prd [session]`

Generate Product Requirements Document from brainstorm session.

**Usage:**
```bash
# From most recent brainstorm
/create-prd

# From specific session
/create-prd docs/brainstorm/session-2024-01-15.md
```

**Output:** Creates `docs/PRD.md` with structured requirements.

#### `/create-architecture [prd]`

Generate Architecture document and update CLAUDE.md.

**Usage:**
```bash
# Standard invocation
/create-architecture

# With specific PRD
/create-architecture docs/PRD.md
```

**Output:** Creates `docs/ARCHITECTURE.md` and updates `CLAUDE.md`.

### Platform Commands

#### `/platform-init <platform> [name]`

Initialize cross-platform project configuration.

| Platform | Description |
|----------|-------------|
| `ios` | iOS-only project |
| `android` | Android-only project |
| `both` | Cross-platform with parity |

**Usage:**
```bash
/platform-init both MyApp
/platform-init ios MyiOSApp
/platform-init android MyAndroidApp
```

**Creates:**
- `docs/platform.json` — Platform configuration
- `docs/platform-parity.json` — Parity tracking
- `docs/design/*.json` — Design token templates

#### `/platform-sync [options]`

Synchronize design tokens to platform-specific code.

**Options:**
```bash
/platform-sync              # Sync all tokens
/platform-sync --colors     # Sync colors only
/platform-sync --typography # Sync typography only
/platform-sync --force      # Force regeneration
```

**Output:** Generated Swift and Kotlin design code.

#### `/platform-parity [feature]`

Check cross-platform feature parity.

**Usage:**
```bash
/platform-parity              # Check all features
/platform-parity authentication # Check specific feature
```

**Output:**
```
## Parity Score: 85%

| Feature | iOS | Android | Status |
|---------|-----|---------|--------|
| Auth    | ✅  | ✅      | Full   |
| Profile | ✅  | ⚠️      | Partial|
| Settings| ✅  | ✅      | Full   |
```

#### `/implement-ios <feature>`

Implement a feature for iOS using the shared specification.

**Usage:**
```bash
/implement-ios authentication
/implement-ios profile
```

**Prerequisites:** Feature spec must exist in `docs/tasks/`.

#### `/implement-android <feature>`

Implement a feature for Android using the shared specification.

**Usage:**
```bash
/implement-android authentication
/implement-android profile
```

**Prerequisites:** Feature spec must exist in `docs/tasks/`.

### Task Management Commands

#### `/generate-tasks <feature>`

Create feature specification with tracked tasks.

**Usage:**
```bash
/generate-tasks authentication
/generate-tasks user-profile
```

**Creates:**
- `docs/tasks/{feature}.md` — Human-readable breakdown
- Updates `.task-registry.json` — Machine-readable tracking

#### `/task-status [feature]`

View task progress across all features.

**Usage:**
```bash
/task-status              # All features
/task-status authentication # Specific feature
```

#### `/next-task [feature]`

Get the next available unblocked task.

**Usage:**
```bash
/next-task              # From any feature
/next-task authentication # From specific feature
```

#### `/update-task <id> <status>`

Update task status in all tracking systems.

**Status values:** `pending`, `in-progress`, `complete`, `blocked`

**Usage:**
```bash
/update-task auth-1 complete
/update-task profile-2.1 in-progress
```

#### `/sync-tasks [feature]`

Synchronize task registry with markdown files.

**Usage:**
```bash
/sync-tasks              # All features
/sync-tasks authentication # Specific feature
```

### Development Commands

#### `/build [platform]`

Build the project for specified platforms.

**Usage:**
```bash
/build          # Build all enabled platforms
/build ios      # Build iOS only
/build android  # Build Android only
```

#### `/test [pattern] [options]`

Run tests with optional filtering.

**Usage:**
```bash
/test                    # Run all tests
/test authentication     # Run matching tests
/test --ios              # iOS tests only
/test --android          # Android tests only
```

#### `/create-feature <name> [options]`

Scaffold a new feature structure.

**Options:**
```bash
/create-feature profile           # Both platforms
/create-feature profile --ios     # iOS only
/create-feature profile --android # Android only
```

#### `/validate [options]`

Validate framework configuration integrity.

**Usage:**
```bash
/validate             # Full validation
/validate --commands  # Commands only
/validate --agents    # Agents only
/validate --platform  # Platform config only
/validate --tasks     # Task registry only
```

---

## Agents Reference

### Agent Overview

| Agent | Model | Trigger Context | Primary Role |
|-------|-------|-----------------|--------------|
| `brainstorm` | Opus | Ideation requests | Structured brainstorming facilitator |
| `architect` | Opus | Architecture questions | System design & decisions |
| `researcher` | Sonnet | Unknown technology | API research & documentation |
| `ios-specialist` | Sonnet | iOS implementation | Swift/SwiftUI expert |
| `android-specialist` | Sonnet | Android implementation | Kotlin/Compose expert |
| `task-manager` | Sonnet | Task tracking | Lifecycle management |
| `reviewer` | Sonnet | Code review requests | Quality & best practices |

### Agent Specifications

#### brainstorm

**Triggers on:**
- "Let's brainstorm..."
- "I need ideas for..."
- "Help me think through..."

**Capabilities:**
- 14 brainstorming modes
- Session persistence
- Mode auto-detection
- PRD generation support

#### architect

**Triggers on:**
- "How should I structure..."
- "What's the best architecture for..."
- "Should I use microservices or..."

**Capabilities:**
- ADR generation
- System diagrams
- Trade-off analysis
- Technology selection

#### researcher

**Triggers on:**
- "How do I use the [API] for..."
- "What's the best library for..."
- "I'm getting this error..."

**Capabilities:**
- Web search
- Documentation analysis
- Code example synthesis
- Best practice recommendations

#### ios-specialist

**Triggers on:**
- "Implement for iOS..."
- "How do I [X] in Swift..."
- "Add [feature] to the iOS app..."

**Capabilities:**
- SwiftUI implementation
- UIKit when needed
- iOS platform APIs
- App Store guidelines

#### android-specialist

**Triggers on:**
- "Implement for Android..."
- "How do I [X] in Kotlin..."
- "Add [feature] to the Android app..."

**Capabilities:**
- Jetpack Compose
- Android platform APIs
- Play Store guidelines
- Gradle configuration

#### task-manager

**Triggers on:**
- Task status queries
- Task updates
- Registry synchronization

**Capabilities:**
- Three-layer sync
- Dependency tracking
- Progress reporting
- Blocking management

#### reviewer

**Triggers on:**
- "Review this code..."
- "Are there security issues in..."
- "How can I refactor..."

**Capabilities:**
- Code quality analysis
- Security review
- Performance suggestions
- Best practice enforcement

---

## Integration Matrix

### Command-Agent Matrix

| Command | Primary Agent | Supporting Agents | Shared Resources |
|---------|---------------|-------------------|------------------|
| `/brainstorm` | brainstorm | architect | docs/brainstorm/*.md |
| `/create-prd` | brainstorm | architect | docs/PRD.md, docs/brainstorm/ |
| `/create-architecture` | architect | researcher | docs/ARCHITECTURE.md, docs/PRD.md |
| `/generate-tasks` | task-manager | — | docs/tasks/*.md, .task-registry.json |
| `/platform-init` | — | ios-specialist, android-specialist | docs/platform.json |
| `/platform-sync` | — | ios-specialist, android-specialist | docs/design/*.json |
| `/platform-parity` | — | ios-specialist, android-specialist | docs/platform-parity.json |
| `/implement-ios` | ios-specialist | task-manager | ios/Sources/, docs/tasks/ |
| `/implement-android` | android-specialist | task-manager | android/app/src/, docs/tasks/ |
| `/task-status` | task-manager | — | .task-registry.json |
| `/next-task` | task-manager | — | .task-registry.json |
| `/update-task` | task-manager | — | .task-registry.json, docs/tasks/*.md |
| `/sync-tasks` | task-manager | — | .task-registry.json |
| `/build` | — | ios-specialist, android-specialist | platform source code |
| `/test` | — | ios-specialist, android-specialist | test source code |
| `/create-feature` | — | ios-specialist, android-specialist | feature source code |
| `/validate` | — | — | all configuration files |

### Agent Collaboration Matrix

| Agent | Collaborates With | Triggered By | Outputs |
|-------|-------------------|--------------|---------|
| **brainstorm** | architect | User ideation requests | Session files, structured insights |
| **architect** | brainstorm, researcher | Architecture/design questions | ADRs, system diagrams, decisions |
| **researcher** | architect, specialists | Unknown technology questions | Research summaries, code examples |
| **ios-specialist** | android-specialist, task-manager | iOS implementation requests | Swift/SwiftUI code, tests |
| **android-specialist** | ios-specialist, task-manager | Android implementation requests | Kotlin/Compose code, tests |
| **task-manager** | specialists | Task tracking requests | Registry updates, status reports |
| **reviewer** | — | Code review requests | Review comments, suggestions |

### Resource Dependencies

#### Commands → Resources

| Command | Reads | Writes | Requires |
|---------|-------|--------|----------|
| `/brainstorm` | docs/brainstorm/ (resume) | docs/brainstorm/*.md | — |
| `/create-prd` | docs/brainstorm/*.md | docs/PRD.md, CLAUDE.md | Session (optional) |
| `/create-architecture` | docs/PRD.md | docs/ARCHITECTURE.md, CLAUDE.md | PRD.md |
| `/generate-tasks` | docs/PRD.md | docs/tasks/*.md, .task-registry.json | PRD.md |
| `/platform-init` | — | docs/platform.json, docs/platform-parity.json | — |
| `/platform-sync` | docs/design/*.json | ios/Core/Design/, android/core/design/ | platform.json |
| `/platform-parity` | docs/platform-parity.json, source | docs/platform-parity.json | Platform config |
| `/implement-ios` | docs/tasks/*.md, docs/design/ | ios/Sources/ | Task spec |
| `/implement-android` | docs/tasks/*.md, docs/design/ | android/app/src/ | Task spec |
| `/task-status` | .task-registry.json | — | Registry |
| `/next-task` | .task-registry.json | — | Registry |
| `/update-task` | .task-registry.json | .task-registry.json, docs/tasks/*.md | Task ID |
| `/sync-tasks` | docs/tasks/*.md | .task-registry.json, Claude Tasks | Task files |
| `/build` | Source code, platform.json | Build artifacts | Source code |
| `/test` | Test code, platform.json | Test results | Test code |
| `/validate` | All config files | — | — |

#### Agents → Resources

| Agent | Primary Resources | Writes To |
|-------|-------------------|-----------|
| brainstorm | docs/brainstorm/, skills/brainstorming/ | docs/brainstorm/*.md |
| architect | docs/ARCHITECTURE.md, PRD.md | docs/ARCHITECTURE.md |
| researcher | External docs, APIs | Research summaries |
| ios-specialist | ios/, docs/design/, docs/tasks/ | ios/Sources/, Tests/ |
| android-specialist | android/, docs/design/, docs/tasks/ | android/app/src/, test/ |
| task-manager | docs/tasks/, .task-registry.json | .task-registry.json |
| reviewer | Source code | Review comments |

### Model Assignments

| Component | Model | Rationale |
|-----------|-------|-----------|
| `/brainstorm` | Opus | Complex creative reasoning |
| `/create-prd` | Opus | Synthesis and structure |
| `/create-architecture` | Opus | Technical decisions |
| `/generate-tasks` | Sonnet | Structured output |
| `/platform-*` | Sonnet | Technical implementation |
| `/implement-*` | Sonnet | Code generation |
| `/task-status` | Haiku | Simple aggregation |
| `/next-task` | Haiku | Query and filter |
| `/update-task` | Haiku | Simple updates |
| `/sync-tasks` | Sonnet | Complex sync logic |
| `/build` | Sonnet | Error analysis |
| `/test` | Sonnet | Test analysis |
| `/validate` | Haiku | Pattern matching |
| architect | Opus | Deep reasoning |
| brainstorm | Opus | Creative thinking |
| ios-specialist | Sonnet | Implementation |
| android-specialist | Sonnet | Implementation |
| task-manager | Sonnet | Lifecycle management |
| reviewer | Sonnet | Code analysis |
| researcher | Sonnet | Research synthesis |

---

## Workflow Diagrams

### Complete Development Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DEVELOPMENT LIFECYCLE                              │
└─────────────────────────────────────────────────────────────────────────────┘

Phase 1: IDEATION
─────────────────
User Input → /brainstorm → brainstorm-agent → docs/brainstorm/

Phase 2: DOCUMENTATION
───────────────────────
/create-prd → docs/PRD.md → /create-architecture → docs/ARCHITECTURE.md
                                    ↓
                              CLAUDE.md (updated)

Phase 3: PLATFORM SETUP
───────────────────────
/platform-init → docs/platform.json → /platform-sync → Generated tokens

Phase 4: TASK GENERATION
────────────────────────
/generate-tasks → docs/tasks/{feature}.md → .task-registry.json

Phase 5: IMPLEMENTATION
───────────────────────
         ┌───────────────────────────────────────────┐
         │                                           │
         ▼                                           ▼
/implement-ios                              /implement-android
         │                                           │
         ▼                                           ▼
ios-specialist                              android-specialist
         │                                           │
         ▼                                           ▼
ios/Sources/                                android/app/src/
         │                                           │
         └───────────────────┬───────────────────────┘
                             ▼
                    /platform-parity

Phase 6: QUALITY ASSURANCE
──────────────────────────
/build → Build Report → /test → Test Report → /validate
```

### Ideation to Documentation

```
User Input
    │
    ▼
/brainstorm ──────────────────────► brainstorm-agent
    │                                      │
    │                                      ▼
    │                              docs/brainstorm/
    ▼                                      │
/create-prd ──────────────────────────────┘
    │
    │                              ┌──────────────┐
    │                              │ architect    │
    │                              │ (consulted)  │
    │                              └──────────────┘
    ▼
docs/PRD.md
    │
    ▼
/create-architecture ─────────────► architect-agent
    │                                      │
    │                                      ▼
    ▼                              docs/ARCHITECTURE.md
CLAUDE.md (updated)
```

### Cross-Platform Implementation

```
/platform-init
    │
    ├──────────────────────────────────────────────────────┐
    │                                                       │
    ▼                                                       ▼
docs/platform.json                               docs/design/*.json
    │                                                       │
    ▼                                                       │
/generate-tasks {feature}                                   │
    │                                                       │
    ├───────────────────┬───────────────────┐               │
    │                   │                   │               │
    ▼                   ▼                   ▼               │
/implement-ios    /implement-android   /platform-sync ◄────┘
    │                   │                   │
    ▼                   ▼                   ▼
ios-specialist    android-specialist   Generated tokens
    │                   │                   │
    ▼                   ▼                   ▼
ios/Sources/      android/app/src/    ios/Core/Design/
                                      android/core/design/
    │                   │
    └───────────────────┘
              │
              ▼
    /platform-parity
              │
              ▼
    docs/platform-parity.json
```

### Quality Assurance Flow

```
Implementation Complete
    │
    ├─────────────────────────────────────┐
    │                                     │
    ▼                                     ▼
  /build                               /test
    │                                     │
    ├──────────┬──────────┐               ├──────────┬──────────┐
    │          │          │               │          │          │
    ▼          ▼          ▼               ▼          ▼          ▼
  iOS      Android      Both            iOS      Android      Both
    │          │          │               │          │          │
    ▼          ▼          ▼               ▼          ▼          ▼
xcodebuild  gradlew    (both)         XCTest    JUnit      (both)
    │          │          │               │          │          │
    └──────────┴──────────┘               └──────────┴──────────┘
              │                                     │
              ▼                                     ▼
        Build Report                          Test Report
              │                                     │
              └─────────────────────────────────────┘
                              │
                              ▼
                      /validate (integrity)
```

---

## Configuration Schema

### Platform Configuration

**File:** `docs/platform.json`

```json
{
  "$schema": "devflow/platform-config/v1",
  "project": {
    "name": "string",
    "bundleId": "string"
  },
  "platforms": {
    "enabled": ["ios", "android"],
    "primary": "ios | android",
    "ios": {
      "minVersion": "16.0",
      "uiFramework": "swiftui | uikit",
      "architecture": "mvvm | tca | viper",
      "packageManager": "spm | cocoapods"
    },
    "android": {
      "minSdk": 26,
      "targetSdk": 34,
      "uiFramework": "compose | xml",
      "architecture": "mvvm | mvi",
      "packageManager": "gradle"
    }
  },
  "parity": {
    "enforced": true,
    "checkOnBuild": true
  }
}
```

### Design Tokens Schema

**File:** `docs/design/colors.json`

```json
{
  "$schema": "devflow/design-tokens/v1",
  "colors": {
    "brand": {
      "primary": {
        "value": "#007AFF",
        "description": "Primary brand color"
      },
      "secondary": {
        "value": "#5856D6",
        "description": "Secondary brand color"
      }
    },
    "semantic": {
      "success": { "value": "#34C759" },
      "warning": { "value": "#FF9500" },
      "error": { "value": "#FF3B30" },
      "info": { "value": "#007AFF" }
    },
    "background": {
      "primary": { "value": "#FFFFFF" },
      "secondary": { "value": "#F2F2F7" }
    }
  }
}
```

**File:** `docs/design/typography.json`

```json
{
  "$schema": "devflow/design-tokens/v1",
  "typography": {
    "heading": {
      "h1": { "size": 34, "weight": "bold", "lineHeight": 41 },
      "h2": { "size": 28, "weight": "bold", "lineHeight": 34 },
      "h3": { "size": 22, "weight": "semibold", "lineHeight": 28 }
    },
    "body": {
      "large": { "size": 17, "weight": "regular", "lineHeight": 22 },
      "regular": { "size": 15, "weight": "regular", "lineHeight": 20 },
      "small": { "size": 13, "weight": "regular", "lineHeight": 18 }
    }
  }
}
```

### Task Registry Schema

**File:** `docs/tasks/.task-registry.json`

```json
{
  "$schema": "devflow/task-registry/v1",
  "version": "1.0.0",
  "features": {
    "authentication": {
      "id": "auth",
      "name": "Authentication",
      "status": "in-progress",
      "tasks": [
        {
          "id": "auth-1",
          "title": "Create login screen",
          "status": "complete",
          "platform": "both",
          "dependencies": []
        },
        {
          "id": "auth-2",
          "title": "Implement OAuth flow",
          "status": "in-progress",
          "platform": "both",
          "dependencies": ["auth-1"]
        }
      ]
    }
  },
  "lastSync": "2024-01-15T10:30:00Z"
}
```

---

## Testing Guide

### Quick Validation

```bash
# Validate entire framework (run this first)
/validate

# Expected output:
# ✅ Commands: 16/16 valid
# ✅ Agents: 7/7 valid
# ✅ Skills: 4/4 valid
# ✅ Platform config: Valid
# ✅ Task registry: Valid
```

### Command Tests

Each command should pass these test criteria:

| Test | Description | Expected Result |
|------|-------------|-----------------|
| Invocation | Command can be called | No errors |
| Help text | Shows usage information | Displays argument-hint |
| Arguments | Handles valid arguments | Proper execution |
| Edge cases | Handles missing/invalid args | Graceful error |
| Output | Produces expected output | Matches documented format |

#### Test Scenarios

**Brainstorming:**
```bash
/brainstorm A mobile fitness app           # Basic
/brainstorm full A task management system  # With preset
/brainstorm 5w1h,lean-canvas An e-commerce # With modes
/brainstorm resume                         # Resume session
/brainstorm list                           # List sessions
```

**Platform Commands:**
```bash
/platform-init both TestApp    # Initialize
/platform-sync                 # Sync tokens
/platform-parity               # Check parity
```

**Task Commands:**
```bash
/generate-tasks test-feature   # Generate
/task-status                   # View status
/next-task                     # Get next
/update-task test-1 complete   # Update
/sync-tasks                    # Sync all
```

**Build/Test:**
```bash
/build                # Build all
/build ios            # Build iOS
/test                 # Run all tests
/test --ios           # iOS tests only
```

### Agent Tests

Test that agents trigger on appropriate prompts:

**architect:**
```
User: How should I structure the database for user management?
User: Should I use microservices or a monolith?
```

**researcher:**
```
User: How do I use the Stripe API for subscriptions?
User: What's the best pagination library for React?
```

**ios-specialist:**
```
User: Implement the login screen for iOS
User: How do I handle deep links in Swift?
```

**android-specialist:**
```
User: Implement the login screen for Android
User: How do I handle deep links in Kotlin?
```

### Integration Tests

#### Workflow 1: Full Feature Development

```bash
# 1. Start brainstorming
/brainstorm A user authentication system with OAuth

# 2. Create PRD
/create-prd

# 3. Create architecture
/create-architecture

# 4. Generate tasks
/generate-tasks authentication

# 5. Check status
/task-status

# 6. Get next task
/next-task

# 7. (Implement feature)

# 8. Update task
/update-task auth-1 complete

# 9. Build
/build

# 10. Test
/test authentication
```

#### Workflow 2: Cross-Platform Feature

```bash
# 1. Initialize platforms
/platform-init both MyApp

# 2. Generate tasks
/generate-tasks profile

# 3. Implement iOS
/implement-ios profile

# 4. Implement Android
/implement-android profile

# 5. Check parity
/platform-parity profile

# 6. Sync tokens
/platform-sync
```

#### Workflow 3: Task Recovery

```bash
# 1. (Simulate out-of-sync state)

# 2. Sync tasks
/sync-tasks

# 3. Verify registry
/validate --tasks

# 4. Check status
/task-status
```

### Regression Tests

After framework updates, verify:

1. **Configuration Validation**
   ```bash
   /validate  # No critical errors
   ```

2. **Command Availability** — Each command is callable

3. **Agent Triggering** — Each agent responds to its triggers

4. **Task Lifecycle** — Create, update, complete a task

5. **Platform Sync** — Tokens generate correctly

---

## Directory Structure

```
project-root/
├── ios/                            # iOS project
│   ├── Sources/
│   │   ├── App/                    # App entry point
│   │   ├── Features/               # Feature modules
│   │   └── Core/
│   │       ├── Design/             # Generated design tokens
│   │       ├── Network/            # API client
│   │       └── Utils/              # Helpers
│   └── Tests/
├── android/                        # Android project
│   ├── app/src/
│   │   ├── main/java/.../
│   │   │   ├── feature/            # Feature modules
│   │   │   ├── core/
│   │   │   │   ├── design/         # Generated design tokens
│   │   │   │   └── network/
│   │   │   └── di/                 # Dependency injection
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
│   ├── PRD.md                      # Product requirements
│   ├── ARCHITECTURE.md             # Architecture decisions
│   ├── brainstorm/                 # Brainstorming sessions
│   └── tasks/                      # Task breakdowns
│       ├── .task-registry.json     # Machine-readable registry
│       └── {feature}.md            # Human-readable specs
├── .claude/
│   ├── settings.json               # Claude Code settings
│   ├── agents/                     # Agent definitions
│   │   ├── architect.md
│   │   ├── brainstorm.md
│   │   ├── ios-specialist.md
│   │   ├── android-specialist.md
│   │   ├── task-manager.md
│   │   ├── reviewer.md
│   │   └── researcher.md
│   ├── commands/                   # Slash commands
│   │   ├── brainstorm.md
│   │   ├── create-prd.md
│   │   ├── platform-init.md
│   │   └── ...
│   ├── skills/                     # Auto-activated skills
│   │   ├── brainstorming/
│   │   └── cross-platform/
│   └── hooks/                      # Event hooks
│       ├── session-start.sh
│       └── post-edit.sh
├── CLAUDE.md                       # Project instructions
└── README.md                       # Project readme
```

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Command not found | Missing from `.claude/commands/` | Verify file exists and has correct frontmatter |
| Agent not triggering | Missing `<example>` blocks | Add trigger examples to agent file |
| Task sync fails | Invalid JSON in registry | Run `/validate --tasks` to diagnose |
| Platform sync fails | Missing `docs/design/` folder | Run `/platform-init` first |
| Build failing after sync | Token drift | Run `/platform-sync --force` |
| Parity check failing | Missing platform config | Run `/platform-init` first |

### Debug Commands

```bash
# Full validation
/validate

# Component-specific validation
/validate --commands    # Check all commands
/validate --agents      # Check all agents
/validate --platform    # Check platform config
/validate --tasks       # Check task registry

# Check file structure
ls -la .claude/commands/
ls -la .claude/agents/
ls -la docs/design/

# Validate JSON files
cat docs/platform.json | jq .
cat docs/tasks/.task-registry.json | jq .

# Check frontmatter
head -10 .claude/commands/build.md
head -15 .claude/agents/architect.md
```

---

## FAQ

### General Questions

**Q: What is Devflow?**
A: Devflow is a Claude Code configuration framework that provides a structured workflow for cross-platform mobile development, from ideation through implementation.

**Q: Do I need both iOS and Android?**
A: No. You can use `/platform-init ios` or `/platform-init android` for single-platform projects.

**Q: Can I customize the brainstorming modes?**
A: Yes. Edit `.claude/skills/brainstorming/SKILL.md` to add or modify modes.

### Workflow Questions

**Q: What's the recommended starting point?**
A: Start with `/brainstorm` to explore your idea, then `/create-prd` to formalize requirements.

**Q: Do I have to use every command?**
A: No. The workflow is modular. Use what fits your needs.

**Q: Can I skip brainstorming and go straight to implementation?**
A: Yes, but brainstorming helps clarify requirements and reduces rework.

### Technical Questions

**Q: How do I add a new design token?**
A: Add the token to the appropriate file in `docs/design/`, then run `/platform-sync`.

**Q: How do I add a new agent?**
A: Create a markdown file in `.claude/agents/` following the existing pattern. See `_base-agent.md` for the template.

**Q: How do I add a new command?**
A: Create a markdown file in `.claude/commands/` with proper frontmatter. See `_base-command.md` for the template.

**Q: Why isn't my agent triggering?**
A: Agents need `<example>` blocks showing trigger phrases. Check the agent file has examples matching your input.

### Troubleshooting Questions

**Q: `/validate` shows errors. What do I do?**
A: Read the specific error messages. Most issues are missing files or malformed JSON.

**Q: Tasks are out of sync. How do I fix it?**
A: Run `/sync-tasks` to reconcile all three tracking layers.

**Q: Design tokens didn't generate. Why?**
A: Ensure `docs/platform.json` exists and has platforms enabled. Run `/validate --platform`.

---

## Best Practices

### Workflow Best Practices

1. **Always start with `/validate`** — Catch configuration issues early
2. **Use presets for brainstorming** — `full` for new projects, `quick` for features
3. **Generate tasks before implementing** — Creates clear success criteria
4. **Run `/platform-parity` after both implementations** — Catch drift early

### Code Best Practices

1. **Never hardcode design values** — Always use generated tokens
2. **Match behavior across platforms** — Same user flows, same API contracts
3. **Document platform exceptions** — Use the parity exception system
4. **Keep features small** — Easier to track and verify

### Configuration Best Practices

1. **Don't modify generated files** — They get overwritten by `/platform-sync`
2. **Keep `docs/design/` as source of truth** — All tokens originate here
3. **Use hierarchical task IDs** — `feature-step.subtask` format
4. **Commit `.task-registry.json`** — Keeps team in sync

### Common Pitfalls to Avoid

| Pitfall | Why It's Bad | What to Do Instead |
|---------|--------------|---------------------|
| Skipping brainstorming | Unclear requirements lead to rework | Spend 15 minutes with `/brainstorm quick` |
| Hardcoding colors | Breaks design system | Use generated token files |
| Implementing iOS only first | Android becomes afterthought | Alternate or parallelize |
| Ignoring parity warnings | Technical debt accumulates | Fix immediately or document exception |
| Manual task tracking | Gets out of sync | Use `/update-task` and `/sync-tasks` |

---

## Changelog

### v4.1.0 — Cross-Platform Edition (Current)

- **Added:** Cross-platform iOS/Android support
- **Added:** Platform specialist agents
- **Added:** Design token synchronization
- **Added:** Parity enforcement system
- **Added:** Platform commands (`/platform-init`, `/platform-sync`, `/platform-parity`)
- **Added:** Implementation commands (`/implement-ios`, `/implement-android`)
- **Enhanced:** Three-layer task tracking
- **Enhanced:** Brainstorming with 14 modes

### v3.0.0 — Task Management Edition

- **Added:** Task tracking system
- **Added:** Task management commands
- **Added:** Registry synchronization

### v2.0.0 — Brainstorming Edition

- **Added:** Multi-mode brainstorming
- **Added:** PRD generation
- **Added:** Architecture generation

### v1.0.0 — Initial Release

- **Added:** Basic command structure
- **Added:** Agent definitions
- **Added:** Validation system

---

## References

### Official Documentation

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

### Platform References

- [Swift Style Guide](https://google.github.io/swift/)
- [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Material Design 3](https://m3.material.io/)

### Architecture References

- [MVVM Pattern](https://en.wikipedia.org/wiki/Model–view–viewmodel)
- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

*Framework Version: 4.1.0 — Cross-Platform Edition*
*Last Updated: 2026-02-09*
*Compatible with Claude Code*
