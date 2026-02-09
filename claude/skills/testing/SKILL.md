---
name: testing
description: This skill should be used when the user asks to "write unit tests", "create integration tests", "implement TDD", "test this function", "add test coverage", "mock dependencies", "write acceptance criteria", "test edge cases", "review test quality", or needs guidance on testing strategies, test organization, mocking patterns, or test-driven development best practices.
version: 1.0.0
---

# Testing Expert

Comprehensive testing guidance for unit tests, integration tests, and test-driven development workflows.

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

## Test Structure (AAA Pattern)

```
// Arrange: Set up test data and dependencies
// Act: Execute the code under test
// Assert: Verify expected outcomes
```

### iOS Example (XCTest)

```swift
func testUserLoginWithValidCredentials() {
    // Arrange
    let authService = MockAuthService()
    let viewModel = LoginViewModel(authService: authService)
    authService.loginResult = .success(User(id: "123"))

    // Act
    viewModel.login(email: "test@example.com", password: "password")

    // Assert
    XCTAssertTrue(viewModel.isLoggedIn)
    XCTAssertNil(viewModel.error)
}
```

### Android Example (JUnit)

```kotlin
@Test
fun `user login with valid credentials succeeds`() {
    // Arrange
    val authService = mockk<AuthService>()
    val viewModel = LoginViewModel(authService)
    coEvery { authService.login(any(), any()) } returns Result.success(User("123"))

    // Act
    viewModel.login("test@example.com", "password")

    // Assert
    assertThat(viewModel.isLoggedIn.value).isTrue()
    assertThat(viewModel.error.value).isNull()
}
```

## Coverage Guidelines

| Component Type | Target Coverage | Priority |
|---------------|-----------------|----------|
| Business Logic | 80%+ | Critical |
| ViewModels | 80%+ | Critical |
| Data Access | 70%+ | High |
| UI Components | 60%+ | Medium |
| Utilities | 90%+ | High |
| Extensions | 70%+ | Medium |

## Mocking Strategy

### When to Mock

- External services (APIs, databases)
- Time-dependent operations
- Random number generators
- File system operations
- Network requests

### When NOT to Mock

- Simple value objects
- Pure functions
- Framework code
- Internal dependencies (when simple)

### Mock Verification

```swift
// iOS - Verify mock was called
XCTAssertEqual(mockService.loginCallCount, 1)
XCTAssertEqual(mockService.lastLoginEmail, "test@example.com")
```

```kotlin
// Android - Verify mock was called
verify { authService.login("test@example.com", "password") }
```

## Test Naming Conventions

### Format Options

1. **Descriptive**: `testUserLoginWithValidCredentialsShouldSucceed`
2. **Given-When-Then**: `givenValidCredentials_whenLogin_thenSucceeds`
3. **Should**: `shouldSucceed_whenLoginWithValidCredentials`
4. **Backtick (Kotlin)**: `` `user login with valid credentials succeeds` ``

### Naming Rules

- Describe the scenario being tested
- Include expected outcome
- Be specific enough to understand without reading code
- Use consistent format across project

## Edge Cases Checklist

### Input Validation

- [ ] Empty string
- [ ] Null/nil values
- [ ] Whitespace only
- [ ] Maximum length exceeded
- [ ] Special characters
- [ ] Unicode characters
- [ ] Negative numbers
- [ ] Zero
- [ ] Very large numbers

### State Transitions

- [ ] Initial state
- [ ] Loading state
- [ ] Success state
- [ ] Error state
- [ ] Empty state
- [ ] Partial data state

### Concurrency

- [ ] Simultaneous requests
- [ ] Request cancellation
- [ ] Race conditions
- [ ] Timeout handling

### Network

- [ ] No internet connection
- [ ] Slow connection
- [ ] Intermittent connection
- [ ] Invalid response
- [ ] Server error (5xx)
- [ ] Client error (4xx)

## Anti-Patterns to Avoid

### Testing Implementation Details

❌ **Bad**: Testing private methods directly
✅ **Good**: Testing through public interface

### Overlapping Tests

❌ **Bad**: Multiple tests verifying same behavior
✅ **Good**: One test per behavior/scenario

### Flaky Tests

❌ **Bad**: Tests depending on timing, network, or random values
✅ **Good**: Deterministic tests with mocked dependencies

### Slow Tests

❌ **Bad**: Unit tests taking >1s each
✅ **Good**: Fast, isolated tests (<100ms each)

### Test Pollution

❌ **Bad**: Tests sharing mutable state
✅ **Good**: Each test sets up its own state

### Magic Numbers

❌ **Bad**: `XCTAssertEqual(result, 42)`
✅ **Good**: `XCTAssertEqual(result, expectedSum)`

## TDD Workflow

### Red-Green-Refactor

1. **Red**: Write a failing test for new functionality
2. **Green**: Write minimal code to make test pass
3. **Refactor**: Improve code while keeping tests green

### TDD Rules

- Never write production code without a failing test
- Write only enough test to fail
- Write only enough code to pass
- Refactor immediately after green

## Platform-Specific Patterns

### iOS Testing Tools

| Tool | Purpose |
|------|---------|
| XCTest | Unit and UI tests |
| XCTUnwrap | Safe optional unwrapping |
| XCTestExpectation | Async testing |
| ViewInspector | SwiftUI testing |

### Android Testing Tools

| Tool | Purpose |
|------|---------|
| JUnit 5 | Unit testing |
| MockK | Kotlin mocking |
| Turbine | Flow testing |
| Espresso | UI testing |
| Robolectric | Android framework |

## Quality Checklist

- [ ] Happy path covered
- [ ] Edge cases identified and tested
- [ ] Error conditions handled
- [ ] Mocks/stubs properly configured
- [ ] Tests run in isolation
- [ ] Test names are descriptive
- [ ] No hardcoded test data that could change
- [ ] Assertions verify actual requirements
- [ ] Tests are deterministic (no flakiness)
- [ ] Tests execute quickly (<100ms unit, <5s integration)

## Best Practices Summary

1. **Test behavior, not implementation**: Tests should survive refactoring
2. **One assertion per concept**: Keep tests focused and readable
3. **Descriptive names**: Test names should explain what's being tested
4. **Arrange-Act-Assert**: Follow consistent test structure
5. **DRY vs. clarity**: Prefer clarity over DRY in tests
6. **Fast feedback**: Run tests frequently during development
7. **Maintain tests**: Treat test code with same care as production code
