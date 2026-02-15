---
name: components
description: This skill should be used when the user asks to "create a component", "build a reusable UI element", "design a component API", "refactor UI code", "implement a button/card/modal", "create a design system element", "compose components", or needs guidance on component architecture, state management, accessibility, styling patterns, or modular UI development best practices.
version: 1.0.0
---

# Component Building Expert

Create reusable UI components, design system elements, and modular architecture for iOS and Android platforms.

## Instructions

1. Analyze requirements for the component
2. Check existing components for reuse opportunities
3. Design component API (props/inputs, events/outputs)
4. Implement with proper state management
5. Add documentation and usage examples

## Component Design Principles

### Single Responsibility

- Each component does one thing well
- Extract sub-components when complexity grows
- Separate presentation from logic

### Composability

- Components should work together
- Use composition over inheritance
- Support slot/children patterns

### Reusability

- Avoid hardcoded values
- Use theming/configuration
- Support customization through props

### Accessibility

- Semantic HTML elements
- Keyboard navigation
- Screen reader support
- Color contrast compliance

## Component Structure

### iOS (SwiftUI)

```
ComponentName/
├── ComponentName.swift        # Main component
├── ComponentNameViewModel.swift # Logic (if complex)
├── ComponentName+Styles.swift # Style extensions
└── ComponentNameTests.swift   # Tests
```

### Android (Compose)

```
component_name/
├── ComponentName.kt           # Main composable
├── ComponentNameViewModel.kt  # Logic (if complex)
├── ComponentNameDefaults.kt   # Default values
└── ComponentNameTest.kt       # Tests
```

## API Design

### Props/Inputs

| Guideline | Rationale |
|-----------|-----------|
| Prefer fewer required props | Easier to use |
| Provide sensible defaults | Works out of box |
| Type all props clearly | Prevent errors |
| Validate where appropriate | Fail fast |

### Events/Outputs

| Guideline | Rationale |
|-----------|-----------|
| Clear naming (onAction, onChange) | Self-documenting |
| Consistent callback signatures | Predictable |
| Prevent unnecessary re-renders | Performance |

### Slots/Children

| Guideline | Rationale |
|-----------|-----------|
| Named slots for flexibility | Customizable |
| Default content when appropriate | Works without config |
| Clear slot documentation | Discoverable |

## State Management

| State Type | Where to Manage |
|------------|-----------------|
| UI state (open/closed) | Component local state |
| Form state | Parent or form library |
| Server state | Data fetching layer |
| Global state | State management solution |

## Platform-Specific Patterns

### iOS (SwiftUI) Button Example

```swift
struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void

    init(
        _ title: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text(title)
            }
        }
        .buttonStyle(.primary)
        .disabled(isLoading)
    }
}
```

### Android (Compose) Button Example

```kotlin
@Composable
fun PrimaryButton(
    text: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    isLoading: Boolean = false,
    enabled: Boolean = true
) {
    Button(
        onClick = onClick,
        modifier = modifier,
        enabled = enabled && !isLoading
    ) {
        if (isLoading) {
            CircularProgressIndicator(
                modifier = Modifier.size(16.dp),
                color = MaterialTheme.colorScheme.onPrimary
            )
        } else {
            Text(text)
        }
    }
}
```

## Styling Patterns

### Approach Options

| Approach | Pros | Cons |
|----------|------|------|
| Design Tokens | Consistent, themeable | Initial setup |
| CSS-in-JS | Dynamic, co-located | Runtime cost |
| Utility CSS | Fast development | Verbose |
| Native Styling | Platform optimized | Different per platform |

### Best Practices

- Use design tokens/variables from `/platform-sync`
- Support theming (dark mode, etc.)
- Responsive by default
- Consistent spacing scale

## Documentation Template

```markdown
# ComponentName

Brief description of what the component does.

## Usage

\`\`\`swift
ComponentName(title: "Hello")
    .onTap { /* action */ }
\`\`\`

## Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| title | String | - | Display text |
| isLoading | Bool | false | Loading state |

## Examples

### Basic Usage
...

### With Loading State
...

## Accessibility

- Supports VoiceOver/TalkBack
- Minimum touch target 44pt
```

## Anti-Patterns to Avoid

### Too Many Props

❌ **Bad**: Component with 20+ props
✅ **Good**: Break into smaller, focused components

### Hardcoded Styles

❌ **Bad**: `Color(0xFF007AFF)` inline
✅ **Good**: `AppColors.brandPrimary` from tokens

### Tight Coupling

❌ **Bad**: Component depends on specific parent
✅ **Good**: Component works in any context

### Missing Accessibility

❌ **Bad**: No accessibility labels
✅ **Good**: Full VoiceOver/TalkBack support

## Quality Checklist

- [ ] Clear, focused responsibility
- [ ] Intuitive API (props/events)
- [ ] Default values where sensible
- [ ] Type definitions complete
- [ ] Accessible (keyboard, screen reader)
- [ ] Responsive/adaptive
- [ ] Themed/customizable (uses design tokens)
- [ ] Unit tested
- [ ] Documented with examples
- [ ] No memory leaks
- [ ] Cross-platform parity maintained
