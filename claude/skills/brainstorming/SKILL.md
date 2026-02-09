---
name: brainstorming
description: This skill should be used when the user asks to "brainstorm an idea", "plan a project", "explore product concepts", "use 5w1h analysis", "create a lean canvas", "prioritize features with moscow", "design thinking session", "generate user stories", "analyze risks", "validate assumptions", or needs structured ideation using any of the 14 brainstorming modes (5w1h, design-thinking, lean-canvas, moscow, user-stories, reverse, starburst, scamper, swot, competitor, jtbd, risk, assumption, six-hats). Provides comprehensive multi-mode brainstorming for software development project planning.
version: 1.0.0
---

# Brainstorming Engine

Transform ideas into actionable, well-documented development plans through structured, multi-mode brainstorming.

## Overview

The brainstorming engine supports **14 modes** that combine freely. Each mode provides a different lens for exploring and validating product ideas.

## Available Modes

### Core Modes (Original 5-Phase)

| Mode | Purpose | Best For |
|------|---------|----------|
| `5w1h` | Comprehensive discovery | Starting any project |
| `design-thinking` | User-centered design | UX-focused products |
| `lean-canvas` | Business model | Validating viability |
| `moscow` | Feature prioritization | Scope definition |
| `user-stories` | Implementation specs | Dev handoff |

### Extended Modes

| Mode | Purpose | Best For |
|------|---------|----------|
| `reverse` | Failure mode analysis | Risk prevention |
| `starburst` | Question generation | Early exploration |
| `scamper` | Feature innovation | Differentiation |
| `swot` | Strategic analysis | Market positioning |
| `competitor` | Competitive analysis | Differentiation |
| `jtbd` | Jobs-to-be-Done | User motivation |
| `risk` | Risk assessment | Project planning |
| `assumption` | Assumption validation | De-risking |
| `six-hats` | Multi-perspective | Balanced decisions |

### Preset Combinations

| Preset | Modes | Use Case |
|--------|-------|----------|
| `full` | 5w1h → design-thinking → lean-canvas → moscow → user-stories | New project |
| `quick` | 5w1h → moscow | Quick feature |
| `validate` | reverse → swot → risk → assumption | Risk focus |
| `ideate` | starburst → scamper → six-hats | Creative |
| `business` | lean-canvas → swot → competitor → jtbd | Business |

## Mode Summaries

### 5w1h - Comprehensive Discovery

Cover WHO (stakeholders), WHAT (product definition), WHEN (timeline), WHERE (distribution), WHY (purpose), and HOW (technical approach). Produces comprehensive project scope document.

### design-thinking - User-Centered Design

Five phases: Empathize (personas, pain points), Define (problem statement), Ideate (features), Prototype (conceptual), Test (validation). Produces personas, problem statement, features, navigation map.

### lean-canvas - Business Model

One-page canvas: Problem, Solution, Key Metrics, Unique Value Proposition, Unfair Advantage, Customer Segments, Channels, Cost Structure, Revenue Streams.

### moscow - Feature Prioritization

Categorize features: **Must Have** (MVP-critical), **Should Have** (important), **Could Have** (nice-to-have), **Won't Have** (out of scope). Produces prioritized feature list.

### user-stories - Implementation Specs

Format: "As a [persona], I want to [action], so that [benefit]." Include acceptance criteria, priority, estimate, and sprint assignment.

### reverse - Failure Mode Analysis

Ask "How could we make this fail?" Generate worst-case scenarios, then invert to prevention strategies. Prioritize by likelihood × impact.

### starburst - Question Explosion

Generate 10+ questions per category (WHO, WHAT, WHEN, WHERE, WHY, HOW). Prioritize as critical, important, or nice-to-know.

### scamper - Innovation Technique

Apply to each feature: **S**ubstitute, **C**ombine, **A**dapt, **M**odify, **P**ut to other use, **E**liminate, **R**everse. Produces innovation matrix.

### swot - Strategic Analysis

2x2 matrix: Internal (Strengths, Weaknesses) vs External (Opportunities, Threats). Produces strategic recommendations and action items.

### competitor - Competitive Analysis

Analyze direct, indirect, and potential competitors. Assess features, pricing, target audience, strengths, weaknesses. Define differentiation strategy.

### jtbd - Jobs-to-be-Done

Identify functional, emotional, and social jobs. Format: "When [situation], I want to [motivation], so I can [outcome]." Map pains and gains.

### risk - Risk Assessment

Categories: Technical, Market, Operational, Financial, Legal/Compliance. Create risk register with Likelihood × Impact scoring and mitigation plans.

### assumption - Assumption Mapping

Categories: User, Problem, Solution, Business assumptions. For each: statement, confidence (1-5), validation method, success criteria.

### six-hats - Parallel Thinking

**White** (Facts), **Red** (Emotions), **Black** (Caution), **Yellow** (Benefits), **Green** (Creativity), **Blue** (Process). Produces balanced multi-perspective analysis.

## Mode Combination Rules

### Execution Order

Modes execute in specified order. Later modes reference earlier outputs.

### Information Flow

- `5w1h` provides foundation for all other modes
- `design-thinking` personas feed into `user-stories` and `jtbd`
- `lean-canvas` informs `swot` and `competitor`
- `reverse` and `risk` complement each other
- `assumption` validates outputs from all modes

### Recommended Flows

**New Product:**
```
5w1h → design-thinking → lean-canvas → swot → moscow → user-stories
```

**Validation Focus:**
```
5w1h → assumption → reverse → risk → competitor
```

**Innovation Focus:**
```
starburst → scamper → six-hats → design-thinking → moscow
```

## Session Management

### File Location

`docs/brainstorm/session-{YYYY-MM-DD-HHmm}.md`

### Session States

- `in-progress` - Currently being worked on
- `complete` - All modes finished
- `archived` - Moved to archive

### Resume Capability

Sessions track completed modes, current mode progress, and all gathered information.

## Questioning Strategy

### Rules

1. Ask ONE question at a time
2. Probe deeper on vague answers
3. Offer 2-4 options when user is unsure
4. Summarize before moving to next section
5. Skip redundant questions if answered earlier
6. Record everything in session document

### Adaptive Follow-ups

**When user says "I don't know":**
- Offer concrete examples
- Reference similar products
- Suggest deferring to Open Questions

**When answer is vague:**
- "Can you give a specific example?"
- "What would that look like for a real user?"
- "How would you measure success?"

**When answers conflict:**
- Surface the conflict
- Ask which takes priority
- Document the trade-off

## Integration with PRD Workflow

| Mode Output | PRD Section |
|-------------|-------------|
| 5w1h WHO | Target Users |
| 5w1h WHAT | Problem Statement, Features |
| 5w1h WHY | Success Metrics |
| design-thinking | Personas, Validation |
| lean-canvas | Executive Summary |
| moscow | Core Features, Out of Scope |
| user-stories | Feature Specifications |
| risk | Risks & Mitigations |
| competitor | Competitive Analysis |
| assumption | Open Questions |

## Quick Reference

### Starting a Session

```bash
# Auto-detect modes (recommended)
/brainstorm A fitness tracking app for iOS and Android

# Explicit modes
/brainstorm full A cross-platform messaging app

# Specific modes
/brainstorm 5w1h,swot,moscow A mobile payment solution

# Resume previous session
/brainstorm resume

# List all sessions
/brainstorm list
```

### Mode Selection Guide

| Situation | Recommended Modes |
|-----------|-------------------|
| New startup idea | `full` preset |
| Quick feature exploration | `quick` preset |
| Risk assessment | `validate` preset |
| Creative ideation | `ideate` preset |
| Business model focus | `business` preset |
| Technical planning | `5w1h`, `risk`, `assumption` |
| User research focus | `design-thinking`, `jtbd` |
| Competition analysis | `swot`, `competitor` |

## Additional Resources

For detailed mode instructions with all questions and frameworks:
- **`references/question-bank.md`** - Complete question sets for all modes
- **`references/design-thinking.md`** - Design Thinking methodology deep dive
- **`references/lean-canvas.md`** - Lean Canvas framework guide
- **`templates/`** - Session templates by project type (mobile-app, backend, library)
