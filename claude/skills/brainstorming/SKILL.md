---
name: brainstorming
description: Dynamic multi-mode brainstorming engine supporting 14 modes for comprehensive software development project planning.
model: opus
---

# Brainstorming Engine

Transform ideas into actionable, well-documented development plans through structured, multi-mode brainstorming.

## Overview

The brainstorming engine supports **14 modes** that can be combined freely. Each mode provides a different lens for exploring and validating product ideas.

---

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

---

## Mode: 5w1h

Comprehensive discovery using the 5W1H framework.

### WHO - Stakeholders & Users
- Primary end user
- Technical skill level
- Secondary/indirect users
- Project stakeholders
- Development team size and expertise

### WHAT - Product Definition
- Core functionality (one sentence)
- Top 3 problems solved
- Competing solutions
- Differentiators
- Data types handled
- Third-party integrations
- Non-negotiable v1.0 features

### WHEN - Timeline & Phases
- MVP completion target
- Full v1.0 release target
- External deadlines
- Release cadence

### WHERE - Distribution & Environment
- Target platforms
- Distribution channels
- Backend infrastructure
- Data storage location
- Geographic regions

### WHY - Purpose & Value
- Reason for existence
- Business model
- Success KPIs
- Market timing

### HOW - Technical Approach
- Architecture pattern
- UI framework
- Testing strategy
- CI/CD configuration
- Performance monitoring

**Output:** Comprehensive project scope document

---

## Mode: design-thinking

User-centered design methodology.

### Empathize
- Create 2-3 user personas
- Map pain points
- Document current user journey

### Define
- Problem statement: "[Persona] needs [need] because [insight]"
- "How Might We" questions (3-5)
- Success metrics

### Ideate
- Generate 10+ feature ideas
- Group into themes
- Cross-reference with user needs

### Prototype (Conceptual)
- Screen flow / navigation map
- Key UI components
- Data flow between screens

### Test (Validation)
- Testable hypotheses
- Validation criteria
- User testing plan

**Output:** Personas, problem statement, features, navigation map, validation plan

---

## Mode: lean-canvas

One-page business model canvas.

### Canvas Sections

```
┌─────────────────┬─────────────────┬─────────────────┐
│    PROBLEM      │   SOLUTION      │  KEY METRICS    │
│                 │                 │                 │
│ Top 3 problems  │ Top 3 features  │ Success numbers │
├─────────────────┤                 ├─────────────────┤
│ EXISTING ALT.   │                 │ COST STRUCTURE  │
│                 │                 │                 │
│ Current ways    │                 │ Build + run     │
├─────────────────┼─────────────────┼─────────────────┤
│ UNIQUE VALUE    │ UNFAIR          │ REVENUE         │
│ PROPOSITION     │ ADVANTAGE       │ STREAMS         │
│                 │                 │                 │
│ "We help X      │ What can't be   │ How it makes    │
│  do Y by Z"     │ easily copied   │ money           │
├─────────────────┼─────────────────┼─────────────────┤
│ CUSTOMER        │ CHANNELS        │                 │
│ SEGMENTS        │                 │                 │
│                 │ Discovery +     │                 │
│ Target users    │ distribution    │                 │
└─────────────────┴─────────────────┴─────────────────┘
```

**Output:** Complete Lean Canvas

---

## Mode: moscow

Feature prioritization framework.

### Categories

- **Must Have (M)** - No product without these
- **Should Have (S)** - Important but not MVP-critical
- **Could Have (C)** - Nice to have, deferrable
- **Won't Have (W)** - Explicitly out of scope

### Validation Checks
- MVP scope realistic for timeline?
- Priority conflicts resolved?
- Dependencies mapped?

**Output:** Prioritized feature list with rationale

---

## Mode: user-stories

User story generation with acceptance criteria.

### Story Format
```
As a [persona],
I want to [action],
So that [benefit].

Acceptance Criteria:
- [ ] Given [precondition], when [action], then [result]

Priority: [Must/Should/Could]
Estimate: [S/M/L/XL]
Sprint: [Suggested]
```

**Output:** Complete user stories ready for implementation

---

## Mode: reverse

Reverse brainstorming - identify failures to prevent them.

### Process
1. Ask: "How could we make this fail?"
2. Generate worst-case scenarios
3. Invert each to prevention strategy
4. Prioritize by likelihood × impact

### Questions
- What would make users abandon immediately?
- How could onboarding be maximally confusing?
- What would cause security breaches?
- How could we ensure terrible performance?
- What would make the app inaccessible?
- How could data become unreliable?

**Output:** Risk prevention checklist, failure modes, mitigations

---

## Mode: starburst

Question-explosion technique.

### Generate 10+ Questions Per Category

**WHO:** Users, buyers, influencers, stakeholders, team
**WHAT:** Problems, features, data, integrations, differentiators
**WHEN:** Usage times, deadlines, lifecycle, failure points
**WHERE:** Platforms, geography, infrastructure, distribution
**WHY:** Motivations, business model, timing, alternatives
**HOW:** Technology, process, measurement, learning

### Prioritization
- Critical questions (must answer before building)
- Important questions (should answer for v1)
- Nice-to-know (can defer)

**Output:** 60+ organized questions, prioritized by importance

---

## Mode: scamper

Innovation technique for feature ideation.

### Apply to Each Core Feature

**S - Substitute**
What can be replaced? Tech? Input method? Provider?

**C - Combine**
What can merge? Features? Platforms? Steps?

**A - Adapt**
What works elsewhere? Other industries? Products?

**M - Modify/Magnify/Minimize**
What changes size? Faster? Simpler? More powerful?

**P - Put to Other Use**
What else could it do? Other users? Markets?

**E - Eliminate**
What's unnecessary? Steps? Features? Complexity?

**R - Reverse/Rearrange**
What if opposite? Different order? Inverted flow?

**Output:** Innovation matrix, feature variations, simplifications

---

## Mode: swot

Strategic analysis framework.

### 2x2 Matrix

|  | Positive | Negative |
|--|----------|----------|
| **Internal** | Strengths | Weaknesses |
| **External** | Opportunities | Threats |

### Strengths (Internal, Positive)
- Competitive advantages
- Unique resources
- Team expertise
- Technical capabilities

### Weaknesses (Internal, Negative)
- Resource gaps
- Limitations
- Areas needing improvement
- Competitor advantages

### Opportunities (External, Positive)
- Market trends
- Technology changes
- Regulatory shifts
- Unmet needs

### Threats (External, Negative)
- Competitors
- Market changes
- Technology disruption
- Regulatory risks

**Output:** SWOT matrix, strategic recommendations, action items

---

## Mode: competitor

Competitive landscape analysis.

### Competitor Types
1. **Direct** - Same problem, same solution
2. **Indirect** - Same problem, different solution
3. **Potential** - Adjacent markets

### Analysis Per Competitor
- Core features
- Pricing model
- Target audience
- Strengths
- Weaknesses
- Market position

### Differentiation
- Unique angle
- Switching motivators
- Defensibility

**Output:** Competitor matrix, differentiation strategy, positioning

---

## Mode: jtbd

Jobs-to-be-Done framework.

### Job Types

**Functional Jobs** - Tasks to accomplish
**Emotional Jobs** - How to feel
**Social Jobs** - How to be perceived

### Job Statement Format
"When [situation], I want to [motivation], so I can [outcome]."

### Per Job Analysis
- **Pains** - Frustrations, risks, obstacles
- **Gains** - Delights, desired outcomes

### Prioritization
- Frequency (how often?)
- Importance (how critical?)
- Satisfaction (how well served?)

**Output:** Job statements, pain/gain map, opportunity scores

---

## Mode: risk

Risk identification and assessment.

### Risk Categories
1. Technical - Architecture, scalability, integration
2. Market - Demand, competition, timing
3. Operational - Team, resources, dependencies
4. Financial - Budget, revenue, funding
5. Legal/Compliance - Regulations, privacy, IP

### Risk Register Format

| Risk | Likelihood (1-5) | Impact (1-5) | Score | Mitigation | Owner |
|------|------------------|--------------|-------|------------|-------|
| ... | ... | ... | L×I | ... | ... |

### Trigger Identification
- Warning signs for each risk
- Monitoring approach

**Output:** Risk register, mitigation plan, monitoring checklist

---

## Mode: assumption

Surface and validate hidden assumptions.

### Assumption Categories

**User Assumptions**
- Problem exists
- Willingness to pay
- Reachable through channels

**Problem Assumptions**
- Significant enough
- Inadequate solutions exist
- Will persist

**Solution Assumptions**
- Solves the problem
- Understandable
- Technically feasible

**Business Assumptions**
- Buildable within budget
- Acquirable users
- Large enough market

### Per Assumption
- Clear statement
- Confidence (1-5)
- Validation method
- Success criteria
- Smallest test

**Output:** Assumption map, validation experiments, confidence scores

---

## Mode: six-hats

Six Thinking Hats - parallel thinking.

### Hats

**White Hat (Facts)**
- What data exists?
- What's needed?
- Known facts?

**Red Hat (Emotions)**
- Gut feelings?
- Concerns?
- Excitement?

**Black Hat (Caution)**
- What could fail?
- Risks?
- Obstacles?

**Yellow Hat (Benefits)**
- Advantages?
- Best case?
- Why succeed?

**Green Hat (Creativity)**
- Alternatives?
- New ideas?
- Different approaches?

**Blue Hat (Process)**
- Next steps?
- How proceed?
- Decisions made?

**Output:** Multi-perspective analysis, balanced view, action items

---

## Mode Combination Rules

### Execution Order
Modes execute in the order specified. Later modes can reference earlier outputs.

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

---

## Session Management

### File Location
`docs/brainstorm/session-{YYYY-MM-DD-HHmm}.md`

### Session States
- `in-progress` - Currently being worked on
- `complete` - All modes finished
- `archived` - Moved to archive

### Resume Capability
Sessions track:
- Completed modes
- Current mode progress
- All gathered information

---

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

---

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

---

## References

- `references/question-bank.md` - Extended questions for all modes
- `references/design-thinking.md` - Design Thinking deep dive
- `references/lean-canvas.md` - Lean Canvas guide
- `templates/` - Session templates by project type
