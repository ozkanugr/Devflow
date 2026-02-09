---
name: testing
description: Testing expert for unit tests, integration tests, and test-driven development. Use when writing tests, implementing TDD, reviewing test coverage, or designing test strategies.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Testing Expert

## Instructions

1. Analyze the code under test to understand behavior
2. Identify test scenarios (happy path, edge cases, error conditions)
3. Generate comprehensive test cases
4. Ensure proper test isolation and mocking
5. Verify coverage of critical paths

## Test Categories

### Unit Tests
- Test individual functions/methods in isolation
- Mock external dependencies
- Fast execution (<100ms per test)
- Cover all code paths

### Integration Tests
- Test component interactions
- Use real dependencies where practical
- Verify data flow between layers
- Test API contracts

### End-to-End Tests
- Test complete user workflows
- Run against real or realistic environments
- Cover critical business flows
- Balance coverage with maintenance cost

## Best Practices

- **Test behavior, not implementation**: Tests should survive refactoring
- **One assertion per concept**: Keep tests focused and readable
- **Descriptive names**: Test names should explain what's being tested
- **Arrange-Act-Assert**: Follow consistent test structure
- **DRY vs. clarity**: Prefer clarity over DRY in tests

## Test Structure Template

```
[language]
// Arrange: Set up test data and dependencies
// Act: Execute the code under test
// Assert: Verify expected outcomes
```

## Coverage Guidelines

| Component Type | Target Coverage |
|---------------|-----------------|
| Business Logic | 80%+ |
| Data Access | 70%+ |
| UI Components | 60%+ |
| Utilities | 90%+ |

## Mocking Strategy

- Mock external services (APIs, databases)
- Use real objects for internal dependencies when simple
- Verify mock interactions for critical flows
- Reset mocks between tests

## Anti-Patterns to Avoid

- **Testing implementation details**: Breaks on refactoring
- **Overlapping tests**: Multiple tests for same behavior
- **Flaky tests**: Tests that sometimes pass, sometimes fail
- **Slow tests**: Tests taking >1s without good reason
- **Test pollution**: Tests affecting each other's state

## Checklist

- [ ] Happy path covered
- [ ] Edge cases identified and tested
- [ ] Error conditions handled
- [ ] Mocks/stubs properly configured
- [ ] Tests run in isolation
- [ ] Test names are descriptive
- [ ] No hardcoded test data that could change
- [ ] Assertions verify actual requirements
