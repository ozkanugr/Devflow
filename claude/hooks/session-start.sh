#!/bin/bash
# Hook: SessionStart
# Purpose: Initialize environment and display project information
# Usage: Add to settings.json under hooks.SessionStart

# Get project information
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Display session start banner
echo "======================================" >&2
echo "  Starting Session: $PROJECT_NAME" >&2
echo "======================================" >&2

# Check for common development tools (customize for your stack)
check_tool() {
    if command -v "$1" &> /dev/null; then
        VERSION=$($1 --version 2>/dev/null | head -1)
        echo "  [OK] $1: $VERSION" >&2
    else
        echo "  [!!] $1: Not installed" >&2
    fi
}

# Uncomment/customize based on your development environment:
# check_tool "node"
# check_tool "npm"
# check_tool "python"
# check_tool "go"
# check_tool "swift"
# check_tool "cargo"

# Check for project-specific files
echo "" >&2
echo "Project Detection:" >&2

if [ -f "$PROJECT_DIR/package.json" ]; then
    echo "  [JS/TS] Node.js project detected" >&2
fi

if [ -f "$PROJECT_DIR/Cargo.toml" ]; then
    echo "  [Rust] Cargo project detected" >&2
fi

if [ -f "$PROJECT_DIR/go.mod" ]; then
    echo "  [Go] Go module detected" >&2
fi

if [ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/pyproject.toml" ]; then
    echo "  [Python] Python project detected" >&2
fi

if [ -d "$PROJECT_DIR"/*.xcodeproj ] || [ -d "$PROJECT_DIR"/*.xcworkspace ]; then
    echo "  [iOS] Xcode project detected" >&2
fi

# Check git status
if [ -d "$PROJECT_DIR/.git" ]; then
    BRANCH=$(git -C "$PROJECT_DIR" rev-parse --abbrev-ref HEAD 2>/dev/null)
    STATUS=$(git -C "$PROJECT_DIR" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    echo "" >&2
    echo "Git Status:" >&2
    echo "  Branch: $BRANCH" >&2
    echo "  Uncommitted changes: $STATUS files" >&2
fi

echo "" >&2
echo "Ready!" >&2
