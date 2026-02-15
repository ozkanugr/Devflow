---
description: Create a new Product Requirements Document, optionally from a brainstorming session or through guided discovery
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion
model: opus
argument-hint: "[session-file] - Optional: path to brainstorming session file"
---

# Create Product Requirements Document

Create a comprehensive PRD in `docs/PRD.md`.

## Pre-Flight Check

Before starting, check for existing brainstorming sessions:

1. **Search for sessions**: Look in `docs/brainstorm/` for completed sessions
2. **If session found**:
   - Ask if user wants to use it as the foundation
   - If yes, extract all relevant data from the session
   - If no, proceed with discovery questions
3. **If no session found**:
   - Offer two paths:
     - **Quick Path**: Answer focused discovery questions (5-10 min)
     - **Full Path**: Run `/brainstorm` first for comprehensive planning

## Process

### Path A: From Brainstorming Session

If a brainstorming session is available:

1. Read the session file from `docs/brainstorm/`
2. Extract and map content:
   - 5W1H WHO → Target Users
   - 5W1H WHAT → Problem Statement, Core Features
   - 5W1H WHY → Success Metrics, Executive Summary
   - Personas → Detailed User Descriptions
   - Lean Canvas → Business Context
   - MoSCoW → Feature Priorities, Out of Scope
   - User Stories → Feature Specifications
   - Dependencies → Dependencies Section
3. Generate PRD with all sections pre-filled
4. Present for review and refinement

### Path B: Quick Discovery

If no session or user prefers quick path:

1. Ask focused questions about:
   - **Product vision** (1 sentence description)
   - **Target users** (primary and secondary)
   - **Core problem** being solved
   - **Top 3 features** for v1.0
   - **Success metrics** (how will you measure success?)
   - **Technical constraints** (platforms, integrations, deadlines)
   - **Out of scope** (what are you NOT building?)

2. Use extended thinking to synthesize answers

3. Generate PRD with gathered information

4. Identify gaps and list as open questions

## PRD Structure

```markdown
# Product Requirements Document: [Product Name]

**Version:** 1.0
**Last Updated:** [Date]
**Status:** Draft | Review | Approved
**Owner:** [Name]

---

## Executive Summary

[Brief description of the product and its primary value proposition. 2-3 sentences maximum.]

---

## Problem Statement

### The Problem
[What problem does this solve? Be specific.]

### Who Experiences It
[Who has this problem? How often? How painful is it?]

### Current Solutions
[How do people solve this today? What's wrong with current approaches?]

---

## Target Users

### Primary User: [Persona Name]
- **Role/Context:** [Who they are]
- **Goals:** [What they want to achieve]
- **Pain Points:** [Current frustrations]
- **Success Looks Like:** [Desired outcome]

### Secondary User: [Persona Name]
- **Role/Context:** [Who they are]
- **Goals:** [What they want to achieve]

---

## Success Metrics

| Metric | Target | Measurement Method | Timeline |
|--------|--------|-------------------|----------|
| [Metric 1] | [Target] | [How measured] | [When] |
| [Metric 2] | [Target] | [How measured] | [When] |

---

## Core Features

### Feature 1: [Name]

**Priority:** P0 (Must Have) | P1 (Should Have) | P2 (Could Have)

**Description:**
[Detailed description of the feature]

**User Stories:**
- As a [user type], I want [action] so that [benefit]

**Acceptance Criteria:**
- [ ] Given [precondition], when [action], then [result]
- [ ] Given [precondition], when [action], then [result]

**Technical Requirements:**
- [Requirement 1]
- [Requirement 2]

**Dependencies:**
- Depends on: [other feature or external system]
- Blocks: [features that depend on this]

---

## Non-Functional Requirements

### Performance
- [Specific performance requirements with measurable targets]

### Security
- [Security requirements and compliance needs]

### Accessibility
- [Accessibility standards to meet]

### Scalability
- [Expected scale and growth considerations]

### Reliability
- [Uptime requirements, error handling]

---

## Out of Scope (v1.0)

Explicitly excluded from this release:
- [Item 1] - Reason: [why excluded]
- [Item 2] - Reason: [why excluded]

---

## Technical Constraints

| Constraint | Impact | Mitigation |
|-----------|--------|------------|
| [Constraint 1] | [How it affects design] | [How to handle] |
| [Constraint 2] | [How it affects design] | [How to handle] |

---

## Dependencies

### External Dependencies
| Dependency | Type | Owner | Status | Risk |
|------------|------|-------|--------|------|
| [Service/API] | External | [Owner] | [Status] | [Risk level] |

### Internal Dependencies
| Feature | Depends On | Status |
|---------|------------|--------|
| [Feature A] | [Feature B] | [Status] |

---

## Risks & Mitigations

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [How to address] |

---

## Open Questions

Questions requiring stakeholder input:
- [ ] [Question 1]?
- [ ] [Question 2]?

---

## Timeline

| Phase | Scope | Target Date |
|-------|-------|-------------|
| Phase 1: MVP | [Core features] | [Date] |
| Phase 2 | [Additional features] | [Date] |

---

## Appendix

### Glossary
| Term | Definition |
|------|------------|
| [Term] | [Definition] |

### References
- [Link to brainstorming session if applicable]
- [Link to design documents]
- [Link to technical specifications]

### Change Log
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Name] | Initial draft |
```

## Output

- Complete PRD document at `docs/PRD.md`
- Auto-updated `CLAUDE.md` with project context (name, platform, core features)
- List of open questions requiring stakeholder input
- Dependencies clearly documented
- Suggested next steps:
  - `/create-architecture` to generate architecture document
  - `/generate-tasks [feature]` to create feature specification with implementation task breakdown

## Post-Generation: Auto-Update CLAUDE.md

After PRD is generated, automatically update `CLAUDE.md`:

1. Extract from generated PRD:
   - Project name → CLAUDE.md title
   - Target platform → Quick Reference
   - Core features summary → Project context
2. Update CLAUDE.md Quick Reference section
3. Preserve all other CLAUDE.md sections

## Validation Checklist

Before finalizing, verify:
- [ ] Executive summary is clear and compelling
- [ ] Problem statement is specific and evidence-based
- [ ] Target users are well-defined with clear personas
- [ ] Success metrics are measurable and time-bound
- [ ] All P0 features have acceptance criteria
- [ ] Dependencies are documented and owners assigned
- [ ] Out of scope is explicitly stated
- [ ] Open questions are captured for follow-up
