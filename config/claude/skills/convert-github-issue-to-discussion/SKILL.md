---
name: convert-github-issue-to-discussion
description: Convert GitHub issues to discussions using agent-browser. Use when asked to convert, move, or change an issue to a discussion. Requires agent-browser installed and user to log in via headed browser.
---

# Convert GitHub Issue to Discussion

Convert GitHub issues to discussions using browser automation when the gh CLI doesn't support this operation.

## Prerequisites

- `agent-browser` installed
- User must log in to GitHub when prompted

## Workflow

### 1. Open Browser in Headed Mode

```bash
agent-browser open "https://github.com/<owner>/<repo>/issues/<number>" --headed
```

The `--headed` flag shows the browser window so the user can log in.

### 2. Wait for User Login

Take a snapshot to check if logged in:

```bash
agent-browser snapshot -i
```

If you see "Sign in" in the elements, the user needs to log in. Let them know and wait for confirmation.

### 3. Navigate to the Issue

After login, go to the issue page:

```bash
agent-browser open "https://github.com/<owner>/<repo>/issues/<number>"
```

### 4. Find the Convert Button

Take a snapshot and look for "Convert to discussion":

```bash
agent-browser snapshot -i
```

Look for a button like:
```
- button "Convert to discussion" [ref=e137]
```

### 5. Click Convert to Discussion

```bash
agent-browser click @<ref>
```

### 6. Select Discussion Category

A dialog will appear with category options:

```bash
agent-browser snapshot -i
```

You'll see options like:
```
- combobox "Category for new discussion" [ref=e2]
- option "General" [ref=e3] [selected]
- option "Ideas" [ref=e4]
- option "Q&A" [ref=e6]
- button "I understand, convert this issue" [ref=e9]
```

Select appropriate category (Q&A for support questions, Ideas for feature requests):

```bash
agent-browser select @<combobox-ref> "Q&A"
```

### 7. Confirm Conversion

```bash
agent-browser click @<confirm-button-ref>
```

### 8. Verify Conversion

You don't need to verify, you are done now.

## Quick Reference

```bash
# Open issue page with visible browser
agent-browser open "https://github.com/owner/repo/issues/123" --headed

# Wait for user to log in, then get elements
agent-browser snapshot -i

# Click convert button (ref from snapshot)
agent-browser click @e137

# Wait for dialog, get new elements
agent-browser wait 1000 && agent-browser snapshot -i

# Select category and confirm
agent-browser select @e2 "Q&A"
agent-browser click @e9

# Verify - should redirect to discussions
agent-browser wait 2000 && agent-browser get url
```

## Category Guidelines

- **Q&A**: Support questions, debugging help, how-to questions
- **Ideas**: Feature requests needing discussion
- **General**: General conversation, announcements
- **Show and tell**: Project showcases

## Cleanup

You do not have to close the browser, as we'll use the login state again to convert other issues to discussions

## Looking for issues

When you are asked to find for more good issues to convert to discussions, use gh