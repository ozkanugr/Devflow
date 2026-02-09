---
description: Generate Architecture document from PRD, then auto-update CLAUDE.md with both PRD and Architecture context
allowed-tools: Read, Write, Edit, Glob, Grep
model: opus
argument-hint: "[prd-file] - Optional: path to PRD file (defaults to docs/PRD.md)"
---

# Create Architecture Document

Generate a comprehensive architecture document based on the PRD, then automatically update CLAUDE.md with project context.

## Pre-Flight Check

1. **Verify PRD exists**: Check `docs/PRD.md` (or `$ARGUMENTS` if provided)
2. **If PRD not found**: Recommend running `/create-prd` first
3. **If PRD found**: Proceed with architecture generation

## Process

### Step 1: Analyze PRD

Read the PRD and extract:
- Core features and their technical requirements
- Non-functional requirements (performance, security, scalability)
- External dependencies and integrations
- Data models implied by features
- User flows and interaction patterns

### Step 2: Generate Architecture Document

Create `docs/ARCHITECTURE.md` following the template structure with:
- System Overview and high-level architecture
- Technology Stack with rationale
- Core Components and their responsibilities
- Data Architecture (models, flow, storage)
- API Design (internal and external)
- Security Architecture
- Scalability & Performance targets
- Infrastructure & Deployment
- Architecture Decision Records (ADRs)
- Dependencies (internal and external)

### Step 3: Auto-Update CLAUDE.md

After generating `docs/ARCHITECTURE.md`, automatically update `CLAUDE.md`:

1. **Read current CLAUDE.md**
2. **Extract from PRD.md:**
   - Project name
   - Platform target
   - Core features summary
3. **Extract from ARCHITECTURE.md:**
   - Language and framework
   - Architecture pattern
   - Technology stack
   - Project structure
4. **Update CLAUDE.md sections:**
   - Replace `[PROJECT_NAME]` with actual project name
   - Update Quick Reference (Platform, Language, Framework, Architecture, Package Manager)
   - Update Project Structure based on architecture
   - Update Patterns section with architectural patterns
   - Ensure Memory Imports reference both files:
     ```
     @import docs/PRD.md
     @import docs/ARCHITECTURE.md
     ```

## Output

1. Architecture document at `docs/ARCHITECTURE.md`
2. Updated `CLAUDE.md` with project-specific context
3. Summary of key architectural decisions

## Suggested Next Steps

- `/generate-tasks <feature>` to create feature specification with implementation task breakdown

## Validation Checklist

Before finalizing, verify:
- [ ] All PRD features have corresponding components
- [ ] Data models support all identified features
- [ ] Security requirements from PRD are addressed
- [ ] Performance targets are defined
- [ ] Dependencies are documented with risks
- [ ] At least one ADR documents a key decision
- [ ] CLAUDE.md reflects the actual project context

## Dependency Tracking

| Input | Output | Status |
|-------|--------|--------|
| `docs/PRD.md` | Architecture decisions | Required |
| Architecture analysis | `docs/ARCHITECTURE.md` | Generated |
| PRD.md + ARCHITECTURE.md | `CLAUDE.md` update | Auto-updated |
