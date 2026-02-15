#!/bin/bash
# Hook: PreToolUse
# Matcher: Write|Edit
# Purpose: Block edits to sensitive files
# Usage: Add to settings.json under hooks.PreToolUse with matcher "Write|Edit"
# Returns: Exit 0 to allow, Exit 2 to block

# Read tool input from stdin
INPUT=$(cat)

# Extract file path from JSON
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

if [ -z "$FILE" ]; then
    exit 0
fi

# Define protected file patterns
# Customize this list for your project
PROTECTED_PATTERNS=(
    # Environment and secrets
    ".env"
    ".env.local"
    ".env.production"
    "secrets"
    "credentials"
    ".key"
    ".pem"
    ".p12"

    # Lock files (should be modified by package managers)
    "package-lock.json"
    "yarn.lock"
    "Podfile.lock"
    "Cargo.lock"
    "Gemfile.lock"

    # Git internals
    ".git/"

    # IDE/editor configs (optional - remove if you want Claude to edit these)
    # ".vscode/"
    # ".idea/"

    # Build outputs (shouldn't be edited directly)
    "node_modules/"
    "dist/"
    "build/"
    ".next/"
    "target/"

    # Platform-specific secrets
    "GoogleService-Info.plist"
    "google-services.json"
    "firebase.json"
)

# Check if file matches any protected pattern
for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILE" == *"$pattern"* ]]; then
        echo "BLOCKED: Protected file pattern matched: $pattern" >&2
        echo "File: $FILE" >&2
        echo "" >&2
        echo "This file is protected from modification. If you need to edit it:" >&2
        echo "1. Make the change manually" >&2
        echo "2. Or remove the pattern from file-protection.sh" >&2
        exit 2  # Block the operation
    fi
done

# Additional checks

# Block binary files
if file "$FILE" 2>/dev/null | grep -q "binary"; then
    echo "BLOCKED: Binary file detected" >&2
    echo "File: $FILE" >&2
    exit 2
fi

# Allow the operation
exit 0
