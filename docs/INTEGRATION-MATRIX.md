# Command-Agent Integration Matrix

This document defines the relationships between commands, agents, and their collaborative workflows.

## Integration Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          Claude Code Configuration Framework                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐   │
│  │  Commands   │ ←→ │   Agents    │ ←→ │   Skills    │ ←→ │   Hooks     │   │
│  │  (User)     │    │  (AI)       │    │  (Auto)     │    │  (Events)   │   │
│  └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘   │
│         ↓                  ↓                  ↓                  ↓           │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        Shared Resources                              │    │
│  │  docs/platform.json  docs/tasks/*.md  docs/design/*.json            │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Command-Agent Matrix

| Command | Primary Agent | Supporting Agents | Shared Resources |
|---------|---------------|-------------------|------------------|
| `/brainstorm` | brainstorm | architect | docs/brainstorm/*.md |
| `/create-prd` | brainstorm | architect | docs/PRD.md, docs/brainstorm/ |
| `/create-architecture` | architect | researcher | docs/ARCHITECTURE.md, docs/PRD.md |
| `/generate-tasks` | task-manager | - | docs/tasks/*.md, .task-registry.json |
| `/platform-init` | - | ios-specialist, android-specialist | docs/platform.json |
| `/platform-sync` | - | ios-specialist, android-specialist | docs/design/*.json |
| `/platform-parity` | - | ios-specialist, android-specialist | docs/platform-parity.json |
| `/implement-ios` | ios-specialist | task-manager | ios/Sources/, docs/tasks/ |
| `/implement-android` | android-specialist | task-manager | android/app/src/, docs/tasks/ |
| `/task-status` | task-manager | - | .task-registry.json |
| `/next-task` | task-manager | - | .task-registry.json |
| `/update-task` | task-manager | - | .task-registry.json, docs/tasks/*.md |
| `/sync-tasks` | task-manager | - | .task-registry.json |
| `/build` | - | ios-specialist, android-specialist | platform source code |
| `/test` | - | ios-specialist, android-specialist | test source code |
| `/create-feature` | - | ios-specialist, android-specialist | feature source code |
| `/validate` | - | - | all configuration files |

## Agent Collaboration Matrix

| Agent | Collaborates With | Triggered By | Outputs |
|-------|-------------------|--------------|---------|
| **brainstorm** | architect | User ideation requests | Session files, structured insights |
| **architect** | brainstorm, researcher | Architecture/design questions | ADRs, system diagrams, decisions |
| **researcher** | architect, specialists | Unknown technology questions | Research summaries, code examples |
| **ios-specialist** | android-specialist, task-manager | iOS implementation requests | Swift/SwiftUI code, tests |
| **android-specialist** | ios-specialist, task-manager | Android implementation requests | Kotlin/Compose code, tests |
| **task-manager** | specialists | Task tracking requests | Registry updates, status reports |
| **reviewer** | - | Code review requests | Review comments, suggestions |

## Workflow Integrations

### 1. Ideation → Documentation Flow

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

### 2. Task Management Flow

```
/generate-tasks ──────────────────► task-manager-agent
    │                                      │
    │                                      ▼
    ▼                              ┌──────────────────────┐
docs/tasks/{feature}.md            │ .task-registry.json  │
    │                              └──────────────────────┘
    │                                      │
    ▼                                      ▼
┌─────────────────────────────────────────────────────────┐
│                    Claude Code Tasks                     │
│  (TaskCreate, TaskUpdate, TaskList, TaskGet)            │
└─────────────────────────────────────────────────────────┘
    │
    ▼
/task-status, /next-task, /update-task
```

### 3. Cross-Platform Implementation Flow

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

### 4. Quality Assurance Flow

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
                      /validate (integrity check)
```

## Resource Dependencies

### Commands → Resources

| Command | Reads | Writes | Requires |
|---------|-------|--------|----------|
| `/brainstorm` | docs/brainstorm/ (resume) | docs/brainstorm/*.md | - |
| `/create-prd` | docs/brainstorm/*.md | docs/PRD.md, CLAUDE.md | Brainstorm session (optional) |
| `/create-architecture` | docs/PRD.md | docs/ARCHITECTURE.md, CLAUDE.md | PRD.md |
| `/generate-tasks` | docs/PRD.md | docs/tasks/*.md, .task-registry.json | PRD.md |
| `/platform-init` | - | docs/platform.json, docs/platform-parity.json, docs/design/*.json | - |
| `/platform-sync` | docs/design/*.json | ios/Core/Design/, android/core/design/ | platform.json |
| `/platform-parity` | docs/platform-parity.json, source code | docs/platform-parity.json | Platform config |
| `/implement-ios` | docs/tasks/*.md, docs/design/ | ios/Sources/ | Task spec |
| `/implement-android` | docs/tasks/*.md, docs/design/ | android/app/src/ | Task spec |
| `/task-status` | .task-registry.json, docs/tasks/*.md | - | Task registry |
| `/next-task` | .task-registry.json | - | Task registry |
| `/update-task` | .task-registry.json | .task-registry.json, docs/tasks/*.md | Task ID |
| `/sync-tasks` | docs/tasks/*.md | .task-registry.json, Claude Tasks | Task files |
| `/build` | Source code, platform.json | Build artifacts | Source code |
| `/test` | Test code, platform.json | Test results | Test code |
| `/create-feature` | platform.json | Source files | Platform config |
| `/validate` | All config files | - | - |

### Agents → Resources

| Agent | Primary Resources | Writes To |
|-------|-------------------|-----------|
| brainstorm | docs/brainstorm/, skills/brainstorming/ | docs/brainstorm/*.md |
| architect | docs/ARCHITECTURE.md, PRD.md | docs/ARCHITECTURE.md |
| researcher | External docs, APIs | Research summaries |
| ios-specialist | ios/, docs/design/, docs/tasks/ | ios/Sources/, Tests/ |
| android-specialist | android/, docs/design/, docs/tasks/ | android/app/src/, test/ |
| task-manager | docs/tasks/, .task-registry.json | .task-registry.json, docs/tasks/ |
| reviewer | Source code | Review comments |

## Event-Based Integrations

### Hook Points

| Event | Hook Type | Potential Actions |
|-------|-----------|-------------------|
| Pre-commit | Shell hook | Run /validate, /test |
| Post-generate-tasks | Internal | Sync to Claude Tasks |
| Post-implementation | Internal | Update task status |
| Pre-build | Shell hook | Run /platform-sync |
| Post-build | Shell hook | Run /test |

### Skill Activations

| Trigger Context | Skill | Action |
|-----------------|-------|--------|
| Cross-platform code | cross-platform | Enforce parity patterns |
| iOS implementation | - | Apply Swift conventions |
| Android implementation | - | Apply Kotlin conventions |

## Model Assignments

| Component | Model | Rationale |
|-----------|-------|-----------|
| /brainstorm | opus | Complex creative reasoning |
| /create-prd | opus | Synthesis and structure |
| /create-architecture | opus | Technical decisions |
| /generate-tasks | sonnet | Structured output |
| /platform-* | sonnet | Technical implementation |
| /implement-* | sonnet | Code generation |
| /task-status | haiku | Simple aggregation |
| /next-task | haiku | Query and filter |
| /update-task | haiku | Simple updates |
| /sync-tasks | sonnet | Complex sync logic |
| /build | sonnet | Error analysis |
| /test | sonnet | Test analysis |
| /validate | haiku | Pattern matching |
| architect | opus | Deep reasoning |
| brainstorm | opus | Creative thinking |
| ios-specialist | sonnet | Implementation |
| android-specialist | sonnet | Implementation |
| task-manager | sonnet | Lifecycle management |
| reviewer | sonnet | Code analysis |
| researcher | sonnet | Research synthesis |

## Troubleshooting Integration Issues

### Common Issues

| Issue | Cause | Resolution |
|-------|-------|------------|
| Command not finding agent | Missing tools in agent | Add required tools to agent YAML |
| Agent not triggering | Missing examples | Add `<example>` blocks |
| Task sync failing | Registry out of sync | Run `/sync-tasks` |
| Parity check failing | Missing platform config | Run `/platform-init` |
| Build failing after sync | Token drift | Run `/platform-sync --force` |

### Debug Commands

```bash
# Check command configuration
/validate --commands

# Check agent configuration
/validate --agents

# Check platform configuration
/validate --platform

# Check task integrity
/validate --tasks

# Full validation
/validate
```
