# Architectural Decisions

> Key decisions and their rationale.

## Decision Format

```markdown
## Decision: [Title]

**Date**: YYYY-MM-DD
**Status**: [Proposed | Accepted | Deprecated | Superseded]
**Deciders**: [Who made this decision]

### Context
What is the issue we're addressing?

### Decision
What is the decision we made?

### Alternatives Considered
1. Alternative 1 - Why not chosen
2. Alternative 2 - Why not chosen

### Consequences

**Positive**:
- Benefit 1
- Benefit 2

**Negative**:
- Tradeoff 1
- Tradeoff 2

### Related
- Links to related decisions
- Links to relevant docs
```

---

## Framework Decisions

### Decision: Use MVVM Architecture

**Date**: [Project Start]
**Status**: Accepted
**Deciders**: Project Team

#### Context
Need a consistent architecture pattern that works well on both iOS and Android while supporting testability and separation of concerns.

#### Decision
Use MVVM (Model-View-ViewModel) architecture on both platforms.

#### Alternatives Considered
1. **MVC** - Too much view controller bloat, harder to test
2. **TCA (The Composable Architecture)** - iOS-only, learning curve
3. **MVI** - Good but less familiar to team
4. **Clean Architecture** - More layers than needed initially

#### Consequences

**Positive**:
- Familiar pattern to most developers
- Works naturally with SwiftUI and Compose
- Good testability for ViewModels
- Clear separation of concerns

**Negative**:
- Can lead to massive ViewModels if not careful
- Some boilerplate required
- Need discipline to not put logic in Views

---

### Decision: Design Tokens as Single Source of Truth

**Date**: [Framework v4.0]
**Status**: Accepted
**Deciders**: Framework Authors

#### Context
Need to ensure visual consistency between iOS and Android without manual synchronization.

#### Decision
Store all design tokens in `docs/design/*.json` and generate platform-specific code.

#### Alternatives Considered
1. **Manual sync** - Error-prone, drift over time
2. **Shared library** - Complex cross-platform setup
3. **Design tool export** - Figma/Sketch dependency

#### Consequences

**Positive**:
- Single source of truth
- Automated sync prevents drift
- Platform-native code generated
- Easy to audit changes

**Negative**:
- Must remember to run sync
- Generated code shouldn't be edited
- JSON format limitations

---

### Decision: Three-Layer Task Tracking

**Date**: [Framework v3.0]
**Status**: Accepted
**Deciders**: Framework Authors

#### Context
Need task tracking that is both human-readable and machine-processable, with Claude Code integration.

#### Decision
Three-layer system: Markdown (human) + JSON Registry (machine) + Claude Tasks (session).

#### Alternatives Considered
1. **Markdown only** - Hard to parse reliably
2. **JSON only** - Not human-friendly
3. **External tool (Jira, etc.)** - Additional dependency

#### Consequences

**Positive**:
- Human-readable in git
- Machine-processable for automation
- Session integration for real-time
- Works offline

**Negative**:
- Three places to sync
- Can drift if sync not run
- More complex implementation

---

## Project-Specific Decisions

*Add project-specific decisions below as they are made.*

---

### Decision: [Title]

**Date**: YYYY-MM-DD
**Status**: Proposed
**Deciders**: [Names]

#### Context
[Description]

#### Decision
[Description]

#### Alternatives Considered
1. [Alternative]

#### Consequences
**Positive**: [Benefits]
**Negative**: [Tradeoffs]

---

*Update this file when significant architectural or technical decisions are made.*

*Last Updated: [Date]*
