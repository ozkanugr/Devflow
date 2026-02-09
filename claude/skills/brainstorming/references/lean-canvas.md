# Lean Canvas for Software Projects

## Overview

The Lean Canvas is a one-page business model adapted for software development. It validates that the project solves a real problem worth solving before committing to full development.

---

## Canvas Structure

```
┌───────────────┬───────────────────────┬───────────────┐
│  2. PROBLEM   │   4. SOLUTION         │  8. KEY       │
│               │                       │     METRICS   │
│ List top 3    │ Top 3 features that   │               │
│ problems your │ address the problems  │ Key numbers   │
│ users face    │                       │ that tell you │
│               │                       │ if the app is │
├───────────────┤                       │ working       │
│ EXISTING      │                       │               │
│ ALTERNATIVES  │                       │               │
│               │                       │               │
│ How users     │                       │               │
│ solve it now  │                       │               │
├───────────────┼───────────────────────┼───────────────┤
│ 3. UNIQUE     │  5. UNFAIR            │  7. CHANNELS  │
│    VALUE      │     ADVANTAGE         │               │
│    PROP.      │                       │ How users     │
│               │ What makes this       │ discover and  │
│ Single, clear │ hard to copy or       │ get the app   │
│ compelling    │ buy? (Your moat)      │               │
│ message       │                       │               │
│               │ - Proprietary data    │               │
│ "We help [X]  │ - Network effects     │               │
│  do [Y]       │ - Team expertise      │               │
│  by [Z]"      │ - Platform advantage  │               │
├───────────────┼───────────────────────┤               │
│ 1. CUSTOMER   │  6. REVENUE           │               │
│    SEGMENTS   │     STREAMS           │               │
│               │                       │               │
│ Target users  │ - Free with ads       │               │
│ - Primary     │ - Freemium            │               │
│ - Secondary   │ - Subscription        │               │
│ - Early       │ - One-time purchase   │               │
│   adopters    │ - Enterprise license  │               │
│               │                       │               │
├───────────────┴───────────────────────┴───────────────┤
│ 9. COST STRUCTURE                                     │
│                                                       │
│ - Development costs (team, tools, infrastructure)     │
│ - Operations (server, storage, monitoring)            │
│ - Marketing (content, ads, community)                 │
│ - Ongoing (support, maintenance, updates)             │
└───────────────────────────────────────────────────────┘
```

---

## Section Guide

### 1. Customer Segments

**Define your target users:**
- Primary users (core audience)
- Secondary users (adjacent audience)
- Early adopters (who will use v1.0 despite rough edges?)

**Consider:**
- Technical skill level
- Platform preferences
- Usage patterns (daily, weekly, occasional)
- Willingness to pay

### 2. Problem

**Validate against:**
- Is this a real problem? (evidence, not assumption)
- How painful is it? (1-10 scale)
- How often does it occur?
- Are people actively looking for solutions?

**Problem Categories:**
- Efficiency problems (takes too long)
- Complexity problems (too hard to understand)
- Access problems (can't get to what they need)
- Cost problems (too expensive)
- Quality problems (current solutions are poor)

### 3. Unique Value Proposition

**Formula:** "We help [customer segment] [solve problem] by [key differentiator]"

**What makes a strong UVP:**
- Clear and specific (not generic)
- Differentiated from alternatives
- Addresses the #1 problem
- Easy to understand in 10 seconds

**Examples:**
- "We help busy professionals track expenses in 10 seconds"
- "We help teams collaborate on documents without version conflicts"
- "We help developers deploy code without managing infrastructure"

### 4. Solution

Map top 3 problems to top 3 features:

| Problem | Solution Feature | Key Capability |
|---------|-----------------|----------------|
| Problem 1 | Feature A | Primary interaction |
| Problem 2 | Feature B | Secondary feature |
| Problem 3 | Feature C | Supporting feature |

**Solution Guidelines:**
- Start with minimum viable solution
- Each feature should address a specific problem
- Avoid scope creep in early validation

### 5. Unfair Advantage

**What makes it hard to copy:**
- **Proprietary data** - Unique datasets
- **Network effects** - Value increases with users
- **Team expertise** - Specialized domain knowledge
- **Platform advantage** - Deep integration
- **Brand/community** - Established trust
- **First-mover** - Early market position

**Honest Assessment:**
- If you don't have one, acknowledge it
- Plan to build one over time
- Don't claim false advantages

### 6. Revenue Streams

**Common Models:**

| Model | Best For | Considerations |
|-------|----------|----------------|
| Free + Ads | Consumer apps | Scale required |
| Freemium | SaaS, utilities | Conversion metrics |
| Subscription | Content, services | Churn management |
| One-time | Tools, games | Upsell strategy |
| Enterprise | B2B | Sales team needed |
| Transaction | Marketplaces | Volume required |

**Pricing Strategy:**
- Research competitor pricing
- Test price sensitivity
- Consider free tier strategy
- Plan upgrade path

### 7. Channels

**Discovery channels:**
- Organic search (SEO, app store)
- Social media (Twitter, Reddit, LinkedIn)
- Content marketing (blog, video, podcast)
- Paid advertising (search, social)
- Partnerships (integrations, affiliates)
- Word of mouth (referrals, reviews)

**Distribution channels:**
- App stores
- Package managers
- Direct download
- Marketplace listings
- Enterprise sales

### 8. Key Metrics

**AARRR Framework:**

| Stage | Metric | Measurement |
|-------|--------|-------------|
| **A**cquisition | Downloads/signups | Analytics |
| **A**ctivation | Onboarding completion | Funnel tracking |
| **R**etention | D1/D7/D30 retention | Cohort analysis |
| **R**evenue | ARPU, LTV, MRR | Revenue tracking |
| **R**eferral | Share rate, viral coefficient | Analytics events |

**Define 3-5 key metrics that matter most for your stage:**
- Early stage: Activation, retention
- Growth stage: Acquisition, revenue
- Scale stage: Efficiency, profitability

### 9. Cost Structure

**Development Costs:**
- Team (salaries, contractors)
- Tools (IDEs, design tools, services)
- Infrastructure (development environments)
- Testing (devices, services)

**Operational Costs:**
- Hosting/servers
- Database/storage
- CDN/bandwidth
- Monitoring/alerting
- Third-party APIs

**Growth Costs:**
- Marketing
- Customer support
- Documentation
- Community management

---

## Validation Checklist

Before proceeding to requirements:

- [ ] Problem is validated (real users have this problem)
- [ ] Solution addresses top problems directly
- [ ] UVP is clear and differentiated
- [ ] Revenue model is sustainable
- [ ] Channels to reach users are identified
- [ ] Key metrics are measurable
- [ ] Cost structure is acceptable
- [ ] Unfair advantage is defensible (or planned)

---

## Canvas Evolution

The Lean Canvas is a living document:

| Stage | Focus | Updates |
|-------|-------|---------|
| Ideation | Problem/Solution fit | Weekly |
| Validation | Customer/Channel fit | Bi-weekly |
| Development | Metrics/Revenue | Monthly |
| Growth | Scale/Efficiency | Quarterly |

---

## Integration with Brainstorming

| 5W1H Category | Canvas Section |
|---------------|----------------|
| WHO | Customer Segments |
| WHAT | Problem, Solution |
| WHEN | (Timeline, not on canvas) |
| WHERE | Channels |
| WHY | UVP, Revenue Streams |
| HOW | Key Metrics, Cost Structure |

---

## Templates

### One-Liner Pitch
"For [target customer] who [has problem], our [product name] is a [category] that [key benefit]. Unlike [alternatives], we [key differentiator]."

### Quick Canvas Checklist
```markdown
## Lean Canvas - [Project Name]

### Customer
- Primary: [who]
- Early adopter: [who]

### Problem (Top 3)
1. [problem]
2. [problem]
3. [problem]

### Solution (Top 3)
1. [feature] → solves [problem 1]
2. [feature] → solves [problem 2]
3. [feature] → solves [problem 3]

### UVP
"We help [X] do [Y] by [Z]"

### Channels
- [channel 1]
- [channel 2]

### Revenue
- [model]

### Metrics
- [metric 1]
- [metric 2]

### Costs
- [cost 1]
- [cost 2]

### Advantage
- [advantage]
```
