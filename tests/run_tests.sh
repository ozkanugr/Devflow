#!/bin/bash
# Devflow Framework Test Runner
# Validates commands, agents, skills, hooks, and integrations

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

# Test results file
RESULTS_FILE="/tmp/claude/devflow-test-results.json"
mkdir -p /tmp/claude

# Usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --all          Run all tests (default)"
    echo "  --commands     Run command tests only"
    echo "  --agents       Run agent tests only"
    echo "  --skills       Run skill tests only"
    echo "  --hooks        Run hook tests only"
    echo "  --integration  Run integration tests only"
    echo "  --verbose      Show detailed output"
    echo "  --help         Show this help message"
    echo ""
}

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASSED++))
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((FAILED++))
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARNINGS++))
}

# Test: File exists
test_file_exists() {
    local file="$1"
    local name="$2"
    if [ -f "$file" ]; then
        log_pass "$name exists"
        return 0
    else
        log_fail "$name does not exist: $file"
        return 1
    fi
}

# Test: Directory exists
test_dir_exists() {
    local dir="$1"
    local name="$2"
    if [ -d "$dir" ]; then
        log_pass "$name directory exists"
        return 0
    else
        log_fail "$name directory does not exist: $dir"
        return 1
    fi
}

# Test: File has frontmatter
test_has_frontmatter() {
    local file="$1"
    local name="$2"
    if head -1 "$file" | grep -q "^---$"; then
        log_pass "$name has frontmatter"
        return 0
    else
        log_fail "$name missing frontmatter: $file"
        return 1
    fi
}

# Test: Frontmatter field exists
test_frontmatter_field() {
    local file="$1"
    local field="$2"
    local name="$3"
    # Extract frontmatter (between first two ---)
    local frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | head -20)
    if echo "$frontmatter" | grep -q "^$field:"; then
        log_pass "$name has '$field' field"
        return 0
    else
        log_warn "$name missing '$field' field"
        return 1
    fi
}

# Test: JSON is valid
test_valid_json() {
    local file="$1"
    local name="$2"
    if jq empty "$file" 2>/dev/null; then
        log_pass "$name is valid JSON"
        return 0
    else
        log_fail "$name is invalid JSON: $file"
        return 1
    fi
}

# Test: Shell script is executable
test_executable() {
    local file="$1"
    local name="$2"
    if [ -x "$file" ]; then
        log_pass "$name is executable"
        return 0
    else
        log_warn "$name is not executable: $file"
        return 1
    fi
}

# Test: Shell script has valid syntax
test_shell_syntax() {
    local file="$1"
    local name="$2"
    if bash -n "$file" 2>/dev/null; then
        log_pass "$name has valid shell syntax"
        return 0
    else
        log_fail "$name has invalid shell syntax: $file"
        return 1
    fi
}

# Test: Agent has triggering examples
test_agent_triggers() {
    local file="$1"
    local name="$2"
    if grep -q "<example>" "$file"; then
        log_pass "$name has triggering examples"
        return 0
    else
        log_warn "$name missing triggering examples"
        return 1
    fi
}

# ========== COMMAND TESTS ==========

run_command_tests() {
    log_info "Running command tests..."
    echo ""

    local cmd_dir=".claude/commands"

    # Test command directory exists
    test_dir_exists "$cmd_dir" "Commands"

    # Test each command file
    for cmd_file in "$cmd_dir"/*.md; do
        if [ -f "$cmd_file" ]; then
            local cmd_name
            cmd_name=$(basename "$cmd_file" .md)

            # Skip base template
            if [ "$cmd_name" = "_base-command" ]; then
                continue
            fi

            log_info "Testing command: $cmd_name"

            # Required tests
            test_has_frontmatter "$cmd_file" "$cmd_name"
            test_frontmatter_field "$cmd_file" "description" "$cmd_name"

            # Recommended tests
            test_frontmatter_field "$cmd_file" "allowed-tools" "$cmd_name" || true
            test_frontmatter_field "$cmd_file" "model" "$cmd_name" || true
        fi
    done

    echo ""
}

# ========== AGENT TESTS ==========

run_agent_tests() {
    log_info "Running agent tests..."
    echo ""

    local agent_dir=".claude/agents"

    # Test agent directory exists
    test_dir_exists "$agent_dir" "Agents"

    # Test each agent file
    for agent_file in "$agent_dir"/*.md; do
        if [ -f "$agent_file" ]; then
            local agent_name
            agent_name=$(basename "$agent_file" .md)

            # Skip base template
            if [ "$agent_name" = "_base-agent" ]; then
                continue
            fi

            log_info "Testing agent: $agent_name"

            # Required tests
            test_has_frontmatter "$agent_file" "$agent_name"
            test_frontmatter_field "$agent_file" "name" "$agent_name"
            test_frontmatter_field "$agent_file" "description" "$agent_name"

            # Recommended tests
            test_frontmatter_field "$agent_file" "model" "$agent_name" || true
            test_frontmatter_field "$agent_file" "tools" "$agent_name" || true
            test_agent_triggers "$agent_file" "$agent_name" || true
        fi
    done

    echo ""
}

# ========== SKILL TESTS ==========

run_skill_tests() {
    log_info "Running skill tests..."
    echo ""

    local skill_dir=".claude/skills"

    # Test skill directory exists
    test_dir_exists "$skill_dir" "Skills"

    # Test each skill
    for skill_path in "$skill_dir"/*/SKILL.md; do
        if [ -f "$skill_path" ]; then
            local skill_name
            skill_name=$(basename "$(dirname "$skill_path")")

            # Skip base template
            if [ "$skill_name" = "_base-skill" ]; then
                continue
            fi

            log_info "Testing skill: $skill_name"

            # Required tests
            test_has_frontmatter "$skill_path" "$skill_name"
            test_frontmatter_field "$skill_path" "name" "$skill_name"
            test_frontmatter_field "$skill_path" "description" "$skill_name"
            test_frontmatter_field "$skill_path" "version" "$skill_name" || true
        fi
    done

    echo ""
}

# ========== HOOK TESTS ==========

run_hook_tests() {
    log_info "Running hook tests..."
    echo ""

    local hook_dir=".claude/hooks"

    # Test hook directory exists
    test_dir_exists "$hook_dir" "Hooks"

    # Test each hook file
    for hook_file in "$hook_dir"/*.sh; do
        if [ -f "$hook_file" ]; then
            local hook_name
            hook_name=$(basename "$hook_file")

            log_info "Testing hook: $hook_name"

            # Required tests
            test_shell_syntax "$hook_file" "$hook_name"
            test_executable "$hook_file" "$hook_name" || true
        fi
    done

    echo ""
}

# ========== INTEGRATION TESTS ==========

run_integration_tests() {
    log_info "Running integration tests..."
    echo ""

    # Test: Settings file is valid JSON
    if [ -f ".claude/settings.json" ]; then
        test_valid_json ".claude/settings.json" "settings.json"
    fi

    if [ -f ".claude/settings.local.json" ]; then
        test_valid_json ".claude/settings.local.json" "settings.local.json"
    fi

    # Test: Platform configuration
    if [ -f "docs/platform.json" ]; then
        test_valid_json "docs/platform.json" "platform.json"
    fi

    # Test: Design tokens
    for token_file in docs/design/*.json; do
        if [ -f "$token_file" ]; then
            local token_name
            token_name=$(basename "$token_file")
            test_valid_json "$token_file" "$token_name"
        fi
    done

    # Test: CLAUDE.md exists and has content
    if [ -f "CLAUDE.md" ]; then
        local line_count
        line_count=$(wc -l < "CLAUDE.md")
        if [ "$line_count" -gt 50 ]; then
            log_pass "CLAUDE.md has substantial content ($line_count lines)"
        else
            log_warn "CLAUDE.md seems minimal ($line_count lines)"
        fi
    else
        log_fail "CLAUDE.md does not exist"
    fi

    # Test: Cross-references
    log_info "Checking cross-references..."

    # Check if commands referenced in CLAUDE.md exist
    local missing_refs=0
    while IFS= read -r cmd; do
        local cmd_name
        cmd_name=$(echo "$cmd" | sed 's/^\/\([a-z-]*\).*/\1/')
        if [ -n "$cmd_name" ] && [ ! -f ".claude/commands/${cmd_name}.md" ]; then
            log_warn "Command referenced but not found: $cmd_name"
            ((missing_refs++))
        fi
    done < <(grep -oE '/[a-z][-a-z]*' CLAUDE.md 2>/dev/null | sort -u | head -30)

    if [ "$missing_refs" -eq 0 ]; then
        log_pass "All command references valid"
    fi

    echo ""
}

# ========== SUMMARY ==========

print_summary() {
    echo ""
    echo "========================================"
    echo "           TEST SUMMARY"
    echo "========================================"
    echo ""
    echo -e "  ${GREEN}Passed:${NC}   $PASSED"
    echo -e "  ${RED}Failed:${NC}   $FAILED"
    echo -e "  ${YELLOW}Warnings:${NC} $WARNINGS"
    echo ""

    local total=$((PASSED + FAILED))
    if [ "$total" -gt 0 ]; then
        local pass_rate=$((PASSED * 100 / total))
        echo "  Pass Rate: ${pass_rate}%"
    fi

    echo ""

    # Write results to JSON
    cat > "$RESULTS_FILE" << EOF
{
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "passed": $PASSED,
  "failed": $FAILED,
  "warnings": $WARNINGS,
  "total": $total,
  "status": "$([ "$FAILED" -eq 0 ] && echo "success" || echo "failure")"
}
EOF

    if [ "$FAILED" -eq 0 ]; then
        echo -e "${GREEN}All critical tests passed!${NC}"
        echo ""
        return 0
    else
        echo -e "${RED}Some tests failed. Please review the output above.${NC}"
        echo ""
        return 1
    fi
}

# ========== MAIN ==========

main() {
    local run_all=true
    local run_commands=false
    local run_agents=false
    local run_skills=false
    local run_hooks=false
    local run_integration=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all)
                run_all=true
                shift
                ;;
            --commands)
                run_all=false
                run_commands=true
                shift
                ;;
            --agents)
                run_all=false
                run_agents=true
                shift
                ;;
            --skills)
                run_all=false
                run_skills=true
                shift
                ;;
            --hooks)
                run_all=false
                run_hooks=true
                shift
                ;;
            --integration)
                run_all=false
                run_integration=true
                shift
                ;;
            --verbose)
                set -x
                shift
                ;;
            --help)
                usage
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done

    echo ""
    echo "========================================"
    echo "    DEVFLOW FRAMEWORK TEST RUNNER"
    echo "========================================"
    echo "    Version: 1.0.0"
    echo "    Date: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
    echo ""

    # Change to project root
    cd "$(dirname "$0")/.."

    # Run selected tests
    if [ "$run_all" = true ] || [ "$run_commands" = true ]; then
        run_command_tests
    fi

    if [ "$run_all" = true ] || [ "$run_agents" = true ]; then
        run_agent_tests
    fi

    if [ "$run_all" = true ] || [ "$run_skills" = true ]; then
        run_skill_tests
    fi

    if [ "$run_all" = true ] || [ "$run_hooks" = true ]; then
        run_hook_tests
    fi

    if [ "$run_all" = true ] || [ "$run_integration" = true ]; then
        run_integration_tests
    fi

    # Print summary
    print_summary
}

# Run main
main "$@"
