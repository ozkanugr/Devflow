---
name: components
description: Component building expert for creating reusable UI components, design system elements, and modular architecture. Use when creating new components, building design systems, or refactoring UI code.
allowed-tools: Read, Write, Edit
---

# Component Building Expert

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

```
[ComponentName]/
├── [ComponentName].[ext]      # Main component
├── [ComponentName].test.[ext] # Tests
├── [ComponentName].styles.[ext] # Styles (if separate)
├── types.[ext]                # Type definitions
└── index.[ext]                # Public exports
```

## API Design

### Props/Inputs
- Required vs optional (prefer fewer required)
- Default values for optional props
- Type definitions for all props
- Validation where appropriate

### Events/Outputs
- Clear naming (onAction, onChange)
- Consistent callback signatures
- Prevent unnecessary re-renders

### Slots/Children
- Named slots for flexibility
- Default content when appropriate
- Clear documentation of slot purposes

## State Management

| State Type | Where to Manage |
|------------|-----------------|
| UI state (open/closed) | Component local state |
| Form state | Parent or form library |
| Server state | Data fetching layer |
| Global state | State management solution |

## Styling Patterns

### Approach Options
1. **CSS Modules**: Scoped styles, no runtime
2. **CSS-in-JS**: Dynamic, co-located
3. **Utility CSS**: Tailwind-style composition
4. **Native**: Platform-specific (SwiftUI, Compose)

### Best Practices
- Use design tokens/variables
- Support theming (dark mode, etc.)
- Responsive by default
- Consistent spacing scale

## Documentation Template

```markdown
# ComponentName

Brief description of what the component does.

## Usage

\`\`\`[language]
// Basic usage example
\`\`\`

## Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| ... | ... | ... | ... |

## Examples

### Example 1: [Use Case]
\`\`\`[language]
// Code example
\`\`\`

## Accessibility

- [Accessibility feature 1]
- [Accessibility feature 2]
```

## Quality Checklist

- [ ] Clear, focused responsibility
- [ ] Intuitive API (props/events)
- [ ] Default values where sensible
- [ ] Type definitions complete
- [ ] Accessible (keyboard, screen reader)
- [ ] Responsive/adaptive
- [ ] Themed/customizable
- [ ] Unit tested
- [ ] Documented with examples
- [ ] No memory leaks
