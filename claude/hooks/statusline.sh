#!/bin/bash
# .claude/hooks/statusline.sh — Custom status line for Claude Code
# Shows: git branch | uncommitted changes | project type | time

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
BRANCH=$(git -C "$PROJECT_DIR" branch --show-current 2>/dev/null || echo "detached")
CHANGES=$(git -C "$PROJECT_DIR" diff --shortstat 2>/dev/null | sed 's/ file.*/f/' | sed 's/ insertion.*/+/' | tr -d '\n')
TIME=$(date '+%H:%M')

# Detect project type
TYPE="?"
[ -f "$PROJECT_DIR/package.json" ] && TYPE="⬢ Node"
[ -f "$PROJECT_DIR/Cargo.toml" ] && TYPE="🦀 Rust"
[ -f "$PROJECT_DIR/go.mod" ] && TYPE="🐹 Go"
[ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/pyproject.toml" ] && TYPE="🐍 Python"
ls "$PROJECT_DIR"/*.xcodeproj &>/dev/null && TYPE="🍎 Xcode"

echo "⎇ $BRANCH | $TYPE | Δ $CHANGES | ⏱ $TIME"
