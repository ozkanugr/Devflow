---
name: error-handling
description: This skill should be used when the user asks to "handle errors", "add error handling", "implement retry logic", "create fallback strategies", "catch exceptions", "handle failures gracefully", or needs guidance on exception handling, error recovery, graceful degradation, and robust error patterns for iOS and Android platforms.
version: 1.0.0
---

# Error Handling Skill

Provide consistent, robust error handling patterns for cross-platform mobile development.

## Overview

Effective error handling is crucial for user experience and app stability. This skill provides patterns for categorizing errors, implementing recovery strategies, and ensuring graceful degradation across iOS and Android platforms.

## Error Categories

Understanding error types helps choose appropriate handling strategies:

| Category | Recoverability | Strategy | Example |
|----------|---------------|----------|---------|
| **Transient** | Retry likely works | Exponential backoff | Network timeout |
| **Permanent** | Cannot recover | User feedback | Invalid credentials |
| **Configuration** | Fix and retry | Fail fast | Missing API key |
| **Resource** | Wait and retry | Queue | Rate limiting |
| **Validation** | User correction | Inline feedback | Invalid email format |
| **Critical** | App-level handling | Crash reporting | Out of memory |

## Core Principles

### Principle 1: Fail Fast, Recover Gracefully

Detect problems early, but handle them gracefully:

```swift
// iOS: Fail fast on invalid configuration
guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
    fatalError("API_KEY environment variable not set")
}

// Recover gracefully on network errors
func fetchData() async throws -> Data {
    do {
        return try await network.request(endpoint)
    } catch NetworkError.timeout {
        // Retry with backoff
        return try await retryWithBackoff { try await network.request(endpoint) }
    }
}
```

```kotlin
// Android: Fail fast on invalid configuration
val apiKey = BuildConfig.API_KEY
    ?: throw IllegalStateException("API_KEY not configured")

// Recover gracefully on network errors
suspend fun fetchData(): Result<Data> = runCatching {
    network.request(endpoint)
}.recoverCatching { error ->
    when (error) {
        is SocketTimeoutException -> retryWithBackoff { network.request(endpoint) }
        else -> throw error
    }
}
```

### Principle 2: Type-Safe Errors

Use typed errors instead of generic exceptions:

```swift
// iOS: Typed error enum
enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case networkUnavailable
    case sessionExpired
    case rateLimited(retryAfter: TimeInterval)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .networkUnavailable:
            return "Please check your internet connection"
        case .sessionExpired:
            return "Your session has expired. Please log in again"
        case .rateLimited(let seconds):
            return "Too many attempts. Please try again in \(Int(seconds)) seconds"
        }
    }
}
```

```kotlin
// Android: Sealed class for exhaustive handling
sealed class AuthError : Exception() {
    object InvalidCredentials : AuthError()
    object NetworkUnavailable : AuthError()
    object SessionExpired : AuthError()
    data class RateLimited(val retryAfterSeconds: Int) : AuthError()

    val userMessage: String
        get() = when (this) {
            is InvalidCredentials -> "Invalid email or password"
            is NetworkUnavailable -> "Please check your internet connection"
            is SessionExpired -> "Your session has expired. Please log in again"
            is RateLimited -> "Too many attempts. Please try again in $retryAfterSeconds seconds"
        }
}
```

### Principle 3: Result Types

Use Result types for explicit error handling:

```swift
// iOS: Result type with async/await
func login(email: String, password: String) async -> Result<User, AuthError> {
    do {
        let user = try await authService.login(email: email, password: password)
        return .success(user)
    } catch let error as AuthError {
        return .failure(error)
    } catch {
        return .failure(.networkUnavailable)
    }
}

// Usage
let result = await login(email: email, password: password)
switch result {
case .success(let user):
    navigateToHome(user: user)
case .failure(let error):
    showError(error.errorDescription)
}
```

```kotlin
// Android: Kotlin Result or custom sealed class
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val error: Throwable) : Result<Nothing>()

    fun getOrNull(): T? = (this as? Success)?.data
    fun exceptionOrNull(): Throwable? = (this as? Error)?.error
}

suspend fun login(email: String, password: String): Result<User> {
    return try {
        val user = authService.login(email, password)
        Result.Success(user)
    } catch (e: AuthError) {
        Result.Error(e)
    } catch (e: Exception) {
        Result.Error(AuthError.NetworkUnavailable)
    }
}
```

## Recovery Strategies

### Strategy 1: Retry with Exponential Backoff

```swift
// iOS
func retryWithBackoff<T>(
    maxAttempts: Int = 3,
    initialDelay: TimeInterval = 1.0,
    maxDelay: TimeInterval = 30.0,
    multiplier: Double = 2.0,
    operation: () async throws -> T
) async throws -> T {
    var lastError: Error?
    var delay = initialDelay

    for attempt in 1...maxAttempts {
        do {
            return try await operation()
        } catch {
            lastError = error
            if attempt < maxAttempts {
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                delay = min(delay * multiplier, maxDelay)
            }
        }
    }

    throw lastError ?? NSError(domain: "RetryError", code: -1)
}
```

```kotlin
// Android
suspend fun <T> retryWithBackoff(
    maxAttempts: Int = 3,
    initialDelayMs: Long = 1000,
    maxDelayMs: Long = 30000,
    multiplier: Double = 2.0,
    operation: suspend () -> T
): T {
    var currentDelay = initialDelayMs
    repeat(maxAttempts - 1) { attempt ->
        try {
            return operation()
        } catch (e: Exception) {
            delay(currentDelay)
            currentDelay = (currentDelay * multiplier).toLong().coerceAtMost(maxDelayMs)
        }
    }
    return operation() // Last attempt, let it throw
}
```

### Strategy 2: Circuit Breaker

```swift
// iOS
actor CircuitBreaker {
    enum State { case closed, open, halfOpen }

    private var state: State = .closed
    private var failureCount = 0
    private var lastFailure: Date?
    private let threshold: Int
    private let resetTimeout: TimeInterval

    init(threshold: Int = 5, resetTimeout: TimeInterval = 30) {
        self.threshold = threshold
        self.resetTimeout = resetTimeout
    }

    func execute<T>(_ operation: () async throws -> T) async throws -> T {
        switch state {
        case .open:
            if let lastFailure, Date().timeIntervalSince(lastFailure) > resetTimeout {
                state = .halfOpen
            } else {
                throw CircuitBreakerError.open
            }
        case .halfOpen, .closed:
            break
        }

        do {
            let result = try await operation()
            if state == .halfOpen {
                state = .closed
                failureCount = 0
            }
            return result
        } catch {
            failureCount += 1
            lastFailure = Date()
            if failureCount >= threshold {
                state = .open
            }
            throw error
        }
    }
}
```

### Strategy 3: Fallback Values

```swift
// iOS
func fetchUserProfile() async -> UserProfile {
    do {
        return try await api.getUserProfile()
    } catch {
        // Return cached data as fallback
        if let cached = cache.getUserProfile() {
            return cached
        }
        // Return default profile
        return UserProfile.default
    }
}
```

```kotlin
// Android
suspend fun fetchUserProfile(): UserProfile {
    return try {
        api.getUserProfile()
    } catch (e: Exception) {
        // Return cached data as fallback
        cache.getUserProfile() ?: UserProfile.DEFAULT
    }
}
```

## UI Error Handling

### Error Display Patterns

| Pattern | Use Case | Implementation |
|---------|----------|----------------|
| **Inline** | Form validation | Text below field |
| **Toast/Snackbar** | Transient errors | Auto-dismiss message |
| **Alert/Dialog** | Critical errors | Modal with actions |
| **Full Screen** | No connectivity | Empty state view |
| **Banner** | Persistent warning | Top/bottom banner |

### Platform Examples

```swift
// iOS: Error alert
func showError(_ error: Error) {
    let alert = UIAlertController(
        title: "Error",
        message: error.localizedDescription,
        preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
}

// SwiftUI
struct ErrorView: View {
    let error: Error
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            Text(error.localizedDescription)
            Button("Try Again", action: retry)
        }
    }
}
```

```kotlin
// Android: Snackbar
fun showError(view: View, error: Throwable) {
    Snackbar.make(view, error.message ?: "An error occurred", Snackbar.LENGTH_LONG)
        .setAction("Retry") { retry() }
        .show()
}

// Compose
@Composable
fun ErrorView(
    error: Throwable,
    onRetry: () -> Unit
) {
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Icon(Icons.Default.Warning, contentDescription = null)
        Text(error.message ?: "An error occurred")
        Button(onClick = onRetry) {
            Text("Try Again")
        }
    }
}
```

## Logging and Monitoring

### Error Logging Best Practices

1. **Log context** — Include relevant state, not just the error
2. **Don't log sensitive data** — Mask passwords, tokens, PII
3. **Use log levels** — Debug for verbose, Error for failures
4. **Include identifiers** — Request ID, user ID for tracing

```swift
// iOS
func logError(_ error: Error, context: [String: Any] = [:]) {
    var info = context
    info["error_type"] = String(describing: type(of: error))
    info["error_message"] = error.localizedDescription
    info["timestamp"] = ISO8601DateFormatter().string(from: Date())

    // Send to crash reporting
    Crashlytics.crashlytics().record(error: error, userInfo: info)
}
```

```kotlin
// Android
fun logError(error: Throwable, context: Map<String, Any> = emptyMap()) {
    val info = context.toMutableMap()
    info["error_type"] = error::class.simpleName
    info["error_message"] = error.message
    info["timestamp"] = Instant.now().toString()

    // Send to crash reporting
    Firebase.crashlytics.log(info.toString())
    Firebase.crashlytics.recordException(error)
}
```

## Anti-Patterns to Avoid

| Anti-Pattern | Problem | Better Approach |
|--------------|---------|-----------------|
| Swallowing exceptions | Hides bugs | At least log them |
| Generic catch-all | Masks specific issues | Catch specific types |
| Retrying forever | Resource exhaustion | Max attempts + backoff |
| Exposing internals | Security/UX issue | User-friendly messages |
| No error state | Confusing UI | Show error states |

## Quality Checklist

- [ ] All network calls have error handling
- [ ] Errors are logged with context
- [ ] User-facing errors have clear messages
- [ ] Retry logic has maximum attempts
- [ ] Critical errors are reported
- [ ] Fallback values exist where appropriate
- [ ] Error states are displayed in UI
- [ ] Sensitive data is never in error messages

## Additional Resources

For detailed platform-specific patterns:
- iOS: [Error Handling in Swift](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)
- Android: [Exceptions in Kotlin](https://kotlinlang.org/docs/exceptions.html)
- Cross-platform: Review `skills/testing/SKILL.md` for error testing patterns
