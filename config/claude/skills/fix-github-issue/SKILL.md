---
name: fix-github-issue
description: Fix GitHub issues using gh CLI. Use when asked to fix, resolve, or address a GitHub issue. Creates fixes on separate branches, runs tests locally, and creates PRs when tests pass. Requires gh CLI authenticated and repo cloned locally.
---

# GitHub Issue Fixer

Fix GitHub issues by implementing solutions on feature branches with proper testing.

## Prerequisites

- `gh` CLI installed and authenticated
- Repository cloned locally
- Test command available (auto-detected or specified)

## Workflow

### 1. Understand the Issue

```bash
gh issue view <issue-number>
```

Read the issue thoroughly.

### 2. Create Feature Branch

```bash
git checkout main && git pull origin main
git checkout -b fix-<short-description>
```

Branch naming: `fix-description` (lowercase, hyphens).

### 3. Analyze the Codebase

Before coding, understand the relevant parts:
- Locate files related to the issue
- Check existing tests for patterns
- Review any referenced code in the issue

### 4. Implement the Fix

Make minimal, focused changes that address the issue. Follow existing code style and patterns.

### 5. Run Tests Locally

Detect and run the test suite. Most likely it will be pest or phpunit. Take a look what is defined in composer.json or the testing github file.

**Tests must pass locally before proceeding.** If tests fail:
1. Analyze failures
2. Fix the implementation
3. Re-run until all pass

### 6. Commit Changes

```bash
git add -A
git commit -m "Fix #<issue-number>: <concise description>"
```

Use conventional commit message referencing the issue number.

### 7. Push and Create PR

```bash
git push -u origin fix/issue-<issue-number>-<short-description>
gh pr create --title "Fix #<issue-number>: <title>" --body "Fixes #<issue-number>

## Changes
- <bullet points of changes>

## Testing
- All local tests pass
- <any additional testing done>"
```

### 8. Monitor CI

```bash
gh pr checks --watch
```

If CI fails:
1. Review the failure: `gh run view <run-id> --log-failed`
2. Fix locally
3. Push additional commits
4. Repeat until CI passes

## Quick Reference

```bash
# View issue
gh issue view 123

# Create branch
git checkout -b fix/issue-123-description

# After fixing and tests pass
git add -A && git commit -m "Fix #123: description"
git push -u origin fix/issue-123-description
gh pr create --fill

# Watch CI
gh pr checks --watch
```