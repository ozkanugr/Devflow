---
description: Interactive tutorial for learning the Devflow framework from beginner to advanced
argument-hint: "[lesson-number|list|progress] — Guided learning sessions"
allowed-tools: Read, Write, AskUserQuestion, Glob
model: sonnet
---

# Interactive Tutorial System

Guided learning for the Devflow framework, from first steps to advanced customization.

## Purpose

Help users progressively learn the framework through hands-on tutorials that:
- Start with fundamentals
- Build on previous knowledge
- Provide practical exercises
- Track completion progress

## Usage

```bash
/tutorial              # Start from where you left off
/tutorial 1            # Start Lesson 1
/tutorial list         # List all lessons
/tutorial progress     # Show completion status
/tutorial reset        # Reset progress
```

## Lesson Structure

### Skill Levels

| Level | Lessons | Focus |
|-------|---------|-------|
| Beginner (0-20) | 1-3 | Basics, navigation, first commands |
| Intermediate (21-40) | 4-6 | Full workflows, task management |
| Proficient (41-60) | 7-9 | Cross-platform, customization |
| Advanced (61-80) | 10-12 | Creating agents, commands, hooks |
| Expert (81-100) | 13-15 | Orchestration, contribution |

## Lessons

### Lesson 1: Welcome to Devflow

**Level**: Beginner
**Duration**: ~10 minutes
**Prerequisites**: None

#### Objectives
- Understand what Devflow is
- Navigate the directory structure
- Run your first command

#### Content

Welcome to Devflow! This framework helps you build cross-platform mobile apps with AI assistance.

**Step 1: Understand the Structure**

The framework is organized into:
```
.claude/
├── agents/     # AI specialists
├── commands/   # Slash commands (/brainstorm, /build)
├── skills/     # Auto-activated capabilities
├── hooks/      # Event automation
└── memory/     # Persistent learning
```

**Step 2: Run Your First Command**

Let's validate the framework is set up correctly:
```
/validate
```

You should see all components passing validation.

**Step 3: Explore Documentation**

Read the main documentation:
```
Open CLAUDE.md and README.md
```

#### Exercise

Run `/validate` and note how many commands, agents, and skills are available.

#### Checkpoint

- [ ] Understood directory structure
- [ ] Ran /validate successfully
- [ ] Read project documentation

---

### Lesson 2: Your First Brainstorm

**Level**: Beginner
**Duration**: ~15 minutes
**Prerequisites**: Lesson 1

#### Objectives
- Start a brainstorming session
- Understand brainstorming modes
- Save and resume sessions

#### Content

Brainstorming is the starting point for any project in Devflow.

**Step 1: Basic Brainstorm**

Start a simple brainstorm:
```
/brainstorm A todo list app
```

The system will auto-detect appropriate modes based on your description.

**Step 2: Explicit Modes**

Try with specific modes:
```
/brainstorm quick A simple notes app
/brainstorm full A fitness tracking platform
```

**Step 3: Answer Questions**

The brainstorm agent will ask questions one at a time. Answer thoughtfully—these answers shape your project.

**Step 4: Session Management**

List your sessions:
```
/brainstorm list
```

Resume an incomplete session:
```
/brainstorm resume
```

#### Exercise

Complete a `quick` brainstorm for a simple app idea of your choice.

#### Checkpoint

- [ ] Started a brainstorming session
- [ ] Answered questions interactively
- [ ] Viewed session list

---

### Lesson 3: Understanding Agents

**Level**: Beginner
**Duration**: ~10 minutes
**Prerequisites**: Lesson 2

#### Objectives
- Understand what agents are
- Know when agents activate
- Recognize agent responses

#### Content

Agents are AI specialists that activate automatically based on context.

**Step 1: Meet the Agents**

Available agents:
| Agent | Specialty |
|-------|-----------|
| brainstorm | Ideation and planning |
| architect | System design |
| researcher | API and technology research |
| ios-specialist | iOS/Swift implementation |
| android-specialist | Android/Kotlin implementation |
| task-manager | Progress tracking |
| debug-agent | Error diagnosis |
| security-auditor | Security review |
| reviewer | Code quality |
| orchestrator | Multi-agent coordination |

**Step 2: Triggering Agents**

Agents activate on specific phrases:

```
"How should I structure the database?"
→ Activates: architect

"Implement login for iOS"
→ Activates: ios-specialist

"Why is this test failing?"
→ Activates: debug-agent
```

**Step 3: Reading Agent Files**

Explore an agent definition:
```
Read .claude/agents/architect.md
```

Notice the trigger examples in `<example>` blocks.

#### Exercise

Read 3 different agent files and identify their trigger conditions.

#### Checkpoint

- [ ] Know what agents do
- [ ] Understand triggering
- [ ] Read agent definitions

---

### Lesson 4: Complete Workflow - Planning

**Level**: Intermediate
**Duration**: ~20 minutes
**Prerequisites**: Lessons 1-3

#### Objectives
- Complete the planning workflow
- Generate PRD and architecture
- Understand document flow

#### Content

The planning workflow transforms ideas into actionable documents.

**Step 1: Start with Brainstorming**

If you haven't already:
```
/brainstorm full A habit tracking mobile app
```

**Step 2: Generate PRD**

Create a Product Requirements Document:
```
/create-prd
```

This synthesizes your brainstorm into formal requirements.

**Step 3: Generate Architecture**

Design the system architecture:
```
/create-architecture
```

This creates technical decisions based on the PRD.

**Step 4: Review Documents**

Check the generated documents:
- `docs/PRD.md`
- `docs/ARCHITECTURE.md`
- `CLAUDE.md` (updated with imports)

#### Exercise

Complete the full planning workflow for your app idea.

#### Checkpoint

- [ ] Generated PRD
- [ ] Generated Architecture
- [ ] Reviewed documents

---

### Lesson 5: Task Management

**Level**: Intermediate
**Duration**: ~15 minutes
**Prerequisites**: Lesson 4

#### Objectives
- Generate tasks from requirements
- Track task progress
- Update task status

#### Content

The three-layer task system keeps work organized.

**Step 1: Generate Tasks**

Create task breakdown:
```
/generate-tasks authentication
```

This creates:
- `docs/tasks/authentication.md` (human-readable)
- Updates `.task-registry.json` (machine-readable)
- Creates Claude Code tasks (session)

**Step 2: View Status**

Check overall progress:
```
/task-status
```

**Step 3: Get Next Task**

Find what to work on:
```
/next-task
```

**Step 4: Update Progress**

Mark tasks complete:
```
/update-task auth-1 complete
/update-task auth-2 in-progress
```

**Step 5: Sync Tasks**

Keep systems aligned:
```
/sync-tasks
```

#### Exercise

Generate tasks for a feature, complete one, and view updated status.

#### Checkpoint

- [ ] Generated tasks
- [ ] Viewed task status
- [ ] Updated task progress

---

### Lesson 6: Cross-Platform Development

**Level**: Intermediate
**Duration**: ~20 minutes
**Prerequisites**: Lesson 5

#### Objectives
- Initialize cross-platform project
- Sync design tokens
- Verify platform parity

#### Content

Devflow ensures iOS and Android stay in sync.

**Step 1: Initialize Platforms**

Set up cross-platform configuration:
```
/platform-init both MyApp
```

This creates:
- `docs/platform.json` (configuration)
- `docs/platform-parity.json` (tracking)
- Design token templates

**Step 2: Design Tokens**

Review token files:
- `docs/design/colors.json`
- `docs/design/typography.json`
- `docs/design/spacing.json`

**Step 3: Sync to Platforms**

Generate platform code:
```
/platform-sync
```

This creates Swift and Kotlin files from tokens.

**Step 4: Check Parity**

Verify platforms match:
```
/platform-parity
```

**Step 5: Implement Features**

Use platform commands:
```
/implement-ios authentication
/implement-android authentication
```

#### Exercise

Initialize platforms, modify a color token, and sync to both platforms.

#### Checkpoint

- [ ] Initialized platforms
- [ ] Synced design tokens
- [ ] Checked parity

---

### Lesson 7: Creating Custom Commands

**Level**: Proficient
**Duration**: ~25 minutes
**Prerequisites**: Lessons 1-6

#### Objectives
- Understand command structure
- Create a simple command
- Configure tools and model

#### Content

Custom commands extend the framework for your needs.

**Step 1: Study the Template**

Read the base command:
```
Read .claude/commands/_base-command.md
```

**Step 2: Frontmatter Fields**

| Field | Purpose |
|-------|---------|
| description | Shown in command menu |
| argument-hint | Usage hint |
| allowed-tools | Available tools |
| model | AI model (haiku/sonnet/opus) |

**Step 3: Create Your Command**

Create a simple command:
```markdown
---
description: Count lines of code in the project
argument-hint: "[directory] — Directory to count"
allowed-tools: Bash, Glob
model: haiku
---

# Line Counter

Count lines of code in the specified directory.

## Steps

1. If $ARGUMENTS provided, use as directory
2. Default to current directory
3. Count lines by file type
4. Display summary table
```

**Step 4: Test Your Command**

Run and verify:
```
/your-command
```

#### Exercise

Create a command that lists recent git commits with messages.

#### Checkpoint

- [ ] Understood frontmatter
- [ ] Created custom command
- [ ] Tested command

---

### Lesson 8-15: Advanced Topics

**Note**: Remaining lessons cover:

- **Lesson 8**: Creating custom agents
- **Lesson 9**: Building hooks
- **Lesson 10**: Creating skills
- **Lesson 11**: Agent orchestration
- **Lesson 12**: Memory system usage
- **Lesson 13**: Framework customization
- **Lesson 14**: Testing and validation
- **Lesson 15**: Contributing improvements

Run `/tutorial 8` through `/tutorial 15` for these advanced topics.

---

## Progress Tracking

Track completion in `.claude/memory/tutorial-progress.json`:

```json
{
  "currentLesson": 1,
  "completed": [],
  "startedAt": "2024-01-15",
  "lastActivity": "2024-01-15"
}
```

## Output Format

### Starting a Lesson

```markdown
# Lesson [N]: [Title]

**Level**: [Skill Level]
**Duration**: ~[X] minutes
**Prerequisites**: [List]

---

## Objectives

By the end of this lesson, you will:
- [Objective 1]
- [Objective 2]

---

[Lesson content...]

---

## Exercise

[Hands-on task]

## Checkpoint

Before proceeding, verify:
- [ ] [Checkpoint 1]
- [ ] [Checkpoint 2]

Ready for Lesson [N+1]? Type `/tutorial [N+1]`
```

### Progress Report

```markdown
# Tutorial Progress

**Started**: [Date]
**Current Lesson**: [N]
**Skill Level**: [Level Name]

## Completed Lessons

| # | Title | Completed |
|---|-------|-----------|
| 1 | Welcome to Devflow | ✅ 2024-01-15 |
| 2 | Your First Brainstorm | ✅ 2024-01-15 |
| 3 | Understanding Agents | 🔄 In Progress |

## Next Steps

Continue with Lesson 3: Understanding Agents
```
