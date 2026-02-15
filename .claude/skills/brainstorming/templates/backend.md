# Brainstorming Template: Backend / Server

**Project Name:** {name}
**Date:** {date}
**Team:** {members}
**Framework:** {framework}
**Status:** phase-1

---

## Phase 1: 5W1H Discovery

### WHO - Users & Stakeholders
**API Consumers:**
- Client apps:
- Internal services:
- Third-party integrations:

**Development Team:**
**Operations/DevOps:**
**Stakeholders:**

### WHAT - Product Definition
**Core Purpose:**
**Key Problems Solved:**
1.
2.
3.

**API Endpoints (High-Level):**
**Data Models:**
**Integrations:**
**Differentiators:**

### WHEN - Timeline
**MVP Target:**
**v1.0 Target:**
**Milestones:**

### WHERE - Distribution
**Hosting:** AWS / GCP / Azure / VPS / On-Premise
**Database:** PostgreSQL / MySQL / MongoDB / etc.
**Regions:**
**Environments:** Dev / Staging / Production

### WHY - Purpose
**Business Model:**
**Success KPIs:**
**Why build vs buy:**

### HOW - Technical Approach
**Architecture:** Monolith / Microservices / Serverless
**API Style:** REST / GraphQL / gRPC
**Authentication:** JWT / OAuth / API Keys
**Testing Strategy:**
**CI/CD:**

---

## Phase 2: Design Thinking

### Consumer Personas
| Consumer | Type | Needs | Constraints |
|----------|------|-------|-------------|
| Mobile App |     |       |             |
| Web App |       |       |             |
| Partner API |   |       |             |

### Problem Statement
"[Consumer type] needs a way to [capability] because [current limitation]."

### How Might We...
1. Ensure high availability?
2. Scale efficiently?
3. Maintain security?

### API Design Ideas
| Endpoint | Method | Purpose | Priority |
|----------|--------|---------|----------|
|          |        |         |          |

---

## Phase 3: Lean Canvas

| Problem | Solution | Key Metrics |
|---------|----------|-------------|
| 1.      | 1.       | Uptime      |
| 2.      | 2.       | Latency     |
| 3.      | 3.       | Throughput  |

| Unique Value Proposition | Unfair Advantage | Channels |
|--------------------------|------------------|----------|
|                          |                  | Direct API |
|                          |                  | SDK       |
|                          |                  | Marketplace |

| Customer Segments | Cost Structure | Revenue Streams |
|-------------------|----------------|-----------------|
| Internal Apps     | Infrastructure | N/A (Internal)  |
| Partners          | Development    | API Access      |
| Public            | Operations     | Usage-based     |

---

## Phase 4: MoSCoW Prioritization

### Must Have (v1.0)
- [ ] Core CRUD operations
- [ ] Authentication/Authorization
- [ ] Input validation
- [ ] Error handling
- [ ] Health checks

### Should Have (v1.0)
- [ ] Rate limiting
- [ ] Logging/Monitoring
- [ ] API documentation

### Could Have (v1.1+)
- [ ] Caching
- [ ] Webhooks
- [ ] Batch operations

### Won't Have (Future)
- [ ]
- [ ]

---

## Phase 5: User Stories

### Epic: Core API

**Story API-001:**
As an API consumer,
I want to {operation},
So that {benefit}.

Acceptance Criteria:
- [ ] Responds in < 200ms (p95)
- [ ] Returns appropriate HTTP status codes
- [ ] Validates input and returns clear errors

Priority: Must | Estimate: M | Sprint: 1

---

## Backend-Specific Considerations

### Performance Requirements
| Metric | Target |
|--------|--------|
| Response time (p50) | < 100ms |
| Response time (p95) | < 500ms |
| Throughput | X req/sec |
| Availability | 99.9% |

### Security Requirements
- [ ] HTTPS only
- [ ] Input sanitization
- [ ] SQL injection prevention
- [ ] Rate limiting
- [ ] Audit logging
- [ ] Secret management

### Data Requirements
| Entity | Volume | Growth Rate | Retention |
|--------|--------|-------------|-----------|
|        |        |             |           |

### Scaling Strategy
| Trigger | Action |
|---------|--------|
| CPU > 80% | Horizontal scale |
| Memory > 80% | Vertical scale |
| Queue depth > X | Add workers |

---

## Dependencies

### External Services
| Service | Purpose | SLA | Fallback |
|---------|---------|-----|----------|
|         |         |     |          |

### Database Schema (High-Level)
| Table | Purpose | Key Relations |
|-------|---------|---------------|
|       |         |               |

---

## Operations

### Monitoring
| Metric | Alert Threshold |
|--------|-----------------|
| Error rate | > 1% |
| Latency p95 | > 500ms |
| CPU | > 80% |
| Memory | > 80% |

### Deployment Strategy
- [ ] Blue/Green
- [ ] Rolling
- [ ] Canary

### Rollback Plan
1. Detect issue
2. Trigger rollback
3. Verify recovery
4. Post-mortem

---

## Next Steps
- [ ] `/create-prd` - Generate PRD document
- [ ] `/generate-tasks` - Create feature specification with implementation tasks
