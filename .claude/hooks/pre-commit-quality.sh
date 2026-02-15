#!/bin/bash
# Hook: PreToolUse
# Matcher: Bash
# Purpose: Enforce code quality before git commits
# Usage: Add to settings.json under hooks.PreToolUse with matcher for git commit commands
# Returns: Exit 0 to allow, Exit 2 to block

set -euo pipefail

# Read tool input from stdin
INPUT=$(cat)

# Extract command from JSON
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Only process git commit commands
if [[ ! "$COMMAND" =~ ^git\ commit ]]; then
    exit 0
fi

# Colors for output (stderr)
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Counter for issues
WARNINGS=0
ERRORS=0

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    ((ERRORS++))
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" >&2
    ((WARNINGS++))
}

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1" >&2
}

# Get staged files
STAGED_FILES=$(git diff --cached --name-only 2>/dev/null || echo "")

if [ -z "$STAGED_FILES" ]; then
    log_info "No staged files to check"
    exit 0
fi

log_info "Running pre-commit quality checks..."

# ========== CHECK 1: Secrets Detection ==========

log_info "Checking for potential secrets..."

SECRET_PATTERNS=(
    # API Keys
    "api[_-]?key[\"']?[[:space:]]*[:=][[:space:]]*[\"'][a-zA-Z0-9]"
    "apikey[[:space:]]*[:=]"

    # Tokens
    "token[\"']?[[:space:]]*[:=][[:space:]]*[\"'][a-zA-Z0-9]"
    "bearer[[:space:]]"

    # Passwords
    "password[\"']?[[:space:]]*[:=][[:space:]]*[\"'][^\"']"
    "passwd[[:space:]]*[:=]"

    # AWS
    "AKIA[0-9A-Z]{16}"
    "aws[_-]?secret"

    # Private keys
    "BEGIN RSA PRIVATE KEY"
    "BEGIN PRIVATE KEY"
    "BEGIN EC PRIVATE KEY"

    # Connection strings
    "mongodb\+srv://[^[:space:]]+"
    "postgres://[^[:space:]]+"
    "mysql://[^[:space:]]+"
)

for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        for pattern in "${SECRET_PATTERNS[@]}"; do
            if grep -iE "$pattern" "$file" 2>/dev/null | grep -v "^#" | grep -v "//" | head -1 >/dev/null; then
                log_error "Potential secret found in $file (pattern: ${pattern:0:30}...)"
            fi
        done
    fi
done

# ========== CHECK 2: Debug Code Detection ==========

log_info "Checking for debug code..."

DEBUG_PATTERNS=(
    # Console/print debugging
    "console\.log\("
    "print\(.*debug"
    "debugPrint\("
    "NSLog\(@"
    "Log\.d\("
    "println\(.*DEBUG"

    # Debugger statements
    "debugger"
    "breakpoint\(\)"

    # TODO/FIXME in critical paths
    "TODO.*REMOVE"
    "FIXME.*BEFORE.*COMMIT"
    "HACK.*TEMPORARY"
)

for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        for pattern in "${DEBUG_PATTERNS[@]}"; do
            matches=$(grep -nE "$pattern" "$file" 2>/dev/null | head -3)
            if [ -n "$matches" ]; then
                log_warn "Debug code in $file: $pattern"
            fi
        done
    fi
done

# ========== CHECK 3: Large File Detection ==========

log_info "Checking for large files..."

MAX_FILE_SIZE=500000  # 500KB

for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        size=$(wc -c < "$file" 2>/dev/null || echo "0")
        if [ "$size" -gt "$MAX_FILE_SIZE" ]; then
            log_warn "Large file detected: $file ($(( size / 1024 ))KB)"
        fi
    fi
done

# ========== CHECK 4: Merge Conflict Markers ==========

log_info "Checking for merge conflict markers..."

for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        if grep -E "^(<<<<<<<|=======|>>>>>>>)" "$file" 2>/dev/null; then
            log_error "Merge conflict markers in $file"
        fi
    fi
done

# ========== CHECK 5: File Extension Checks ==========

log_info "Checking file types..."

for file in $STAGED_FILES; do
    # Check for files without extensions in source directories
    if [[ "$file" =~ ^(src|lib|app)/ ]] && [[ ! "$file" =~ \. ]]; then
        log_warn "File without extension in source directory: $file"
    fi

    # Check for potentially unwanted files
    case "$file" in
        *.exe|*.dll|*.so|*.dylib)
            log_error "Binary file staged: $file"
            ;;
        *.log|*.tmp|*.temp)
            log_warn "Temporary file staged: $file"
            ;;
        .DS_Store|Thumbs.db|desktop.ini)
            log_warn "OS metadata file staged: $file"
            ;;
    esac
done

# ========== CHECK 6: iOS/Android Specific ==========

# Check iOS files
for file in $STAGED_FILES; do
    if [[ "$file" =~ \.swift$ ]]; then
        # Check for force unwraps in production code
        if grep -E "![[:space:]]*$|!\." "$file" 2>/dev/null | grep -v "// swiftlint:disable" | head -1 >/dev/null; then
            log_warn "Force unwrap (!) in $file - consider safer alternatives"
        fi
    fi

    if [[ "$file" =~ \.kt$ ]]; then
        # Check for !! in Kotlin
        if grep -E "!!" "$file" 2>/dev/null | head -1 >/dev/null; then
            log_warn "Non-null assertion (!!) in $file - consider safer alternatives"
        fi
    fi
done

# ========== SUMMARY ==========

echo "" >&2
log_info "Quality check complete: $ERRORS errors, $WARNINGS warnings"

if [ "$ERRORS" -gt 0 ]; then
    echo "" >&2
    echo -e "${RED}Commit blocked due to errors.${NC}" >&2
    echo "Please fix the issues above before committing." >&2
    echo "" >&2
    echo "To bypass this check (not recommended):" >&2
    echo "  git commit --no-verify -m \"your message\"" >&2
    exit 2
fi

if [ "$WARNINGS" -gt 0 ]; then
    echo "" >&2
    echo -e "${YELLOW}Commit allowed with warnings.${NC}" >&2
    echo "Consider addressing the warnings above." >&2
fi

exit 0
