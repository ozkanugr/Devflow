# Project Context

> Technical details, conventions, and patterns specific to this project.

## Project Overview

**Name**: [PROJECT_NAME]
**Type**: Cross-platform Mobile (iOS + Android)
**Framework Version**: Devflow 4.3.0

## Architecture

**Pattern**: MVVM
**iOS**: SwiftUI with async/await
**Android**: Jetpack Compose with Kotlin Coroutines

## Conventions

### Naming

| Type | iOS (Swift) | Android (Kotlin) |
|------|-------------|------------------|
| Files | PascalCase.swift | PascalCase.kt |
| Classes | PascalCase | PascalCase |
| Functions | camelCase | camelCase |
| Constants | camelCase | SCREAMING_SNAKE |
| Packages | - | lowercase.dot.separated |

### Code Organization

```
Feature/
├── View/           # UI components
├── ViewModel/      # Business logic
├── Model/          # Data models
├── Repository/     # Data access
└── DI/             # Dependency injection
```

## Key Patterns

### Data Flow

```
View → ViewModel → Repository → DataSource
  ↑                                  ↓
  └──────── State Updates ───────────┘
```

### Error Handling

- Use Result types (not exceptions) for expected failures
- Reserve exceptions for truly exceptional cases
- User-facing errors must have localized messages

## Dependencies

### iOS
- Networking: URLSession (native)
- Storage: SwiftData / CoreData
- DI: Manual / Swift Dependencies

### Android
- Networking: Retrofit + OkHttp
- Storage: Room
- DI: Hilt / Koin

## Important Files

| Purpose | Location |
|---------|----------|
| Design tokens | `docs/design/*.json` |
| Platform config | `docs/platform.json` |
| Task registry | `docs/tasks/.task-registry.json` |
| API contracts | `docs/api/contracts.json` |

## Environment

### Development
- iOS: Simulator, Xcode
- Android: Emulator, Android Studio

### CI/CD
- [To be documented]

---

*Last Updated: [Date]*
*Updated By: [Agent/User]*
