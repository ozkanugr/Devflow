#!/bin/bash
# Hook: PostToolUse
# Matcher: Write|Edit
# Purpose: Run linting/formatting after file edits
# Usage: Add to settings.json under hooks.PostToolUse with matcher "Write|Edit"

# Read tool input from stdin
INPUT=$(cat)

# Extract file path from JSON
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
    exit 0
fi

# Get file extension
EXT="${FILE##*.}"

# Run appropriate linter based on file type
case "$EXT" in
    # JavaScript/TypeScript
    js|jsx|ts|tsx)
        if command -v eslint &> /dev/null && [ -f ".eslintrc.json" ] || [ -f ".eslintrc.js" ]; then
            echo "Running ESLint..." >&2
            eslint "$FILE" --quiet 2>&1 | head -10 >&2
        fi
        if command -v prettier &> /dev/null; then
            echo "Checking Prettier..." >&2
            prettier --check "$FILE" 2>&1 | head -5 >&2
        fi
        ;;

    # Python
    py)
        if command -v ruff &> /dev/null; then
            echo "Running Ruff..." >&2
            ruff check "$FILE" --quiet 2>&1 | head -10 >&2
        elif command -v flake8 &> /dev/null; then
            echo "Running Flake8..." >&2
            flake8 "$FILE" --max-line-length=120 2>&1 | head -10 >&2
        fi
        ;;

    # Go
    go)
        if command -v golint &> /dev/null; then
            echo "Running golint..." >&2
            golint "$FILE" 2>&1 | head -10 >&2
        fi
        ;;

    # Rust
    rs)
        if command -v clippy &> /dev/null; then
            echo "Running Clippy..." >&2
            cargo clippy --quiet 2>&1 | head -10 >&2
        fi
        ;;

    # Swift
    swift)
        if command -v swiftlint &> /dev/null && [ -f ".swiftlint.yml" ]; then
            echo "Running SwiftLint..." >&2
            swiftlint lint --path "$FILE" --quiet 2>&1 | head -10 >&2
        fi
        ;;

    # Ruby
    rb)
        if command -v rubocop &> /dev/null; then
            echo "Running RuboCop..." >&2
            rubocop "$FILE" --format simple 2>&1 | head -10 >&2
        fi
        ;;

    *)
        # No linter configured for this file type
        ;;
esac

exit 0
