---
name: context7-fetcher
description: Independent subtask for executing Context7 API calls (internal use)
version: 1.0.1
author: BenedictKing
allowed-tools: Bash
context: fork
---

# Context7 Fetcher Sub-skill

> **Note**: This is an internal sub-skill, invoked by the `context7-auto-research` main skill through the Task tool.

## Purpose

Independently execute Context7 API calls, using `context: fork` to avoid carrying main conversation context, reducing token consumption.

## Received Parameters

Receives complete command through Task tool's prompt parameter:

1. **Search libraries**: `node context7-api.js search <libraryName> <query>`
2. **Get documentation**: `node context7-api.js context <libraryId> <query>`

## Command Examples

```bash
# Search libraries
node .claude/skills/context7-auto-research/context7-api.js search "react" "useEffect hook"

# Get documentation
node .claude/skills/context7-auto-research/context7-api.js context "/facebook/react" "useEffect cleanup"

# Documentation query with version
node .claude/skills/context7-auto-research/context7-api.js context "/vercel/next.js/v15.1.8" "middleware"
```

## Execution Flow

1. **Call API**: Execute context7-api.js script
2. **Return JSON**: Directly return API response JSON data

## Output Format

### Search Libraries Response

```json
{
  "libraries": [
    {
      "id": "/facebook/react",
      "name": "React",
      "description": "A JavaScript library for building user interfaces",
      "trustScore": 98,
      "versions": ["v19.0.0", "v18.3.1"]
    }
  ]
}
```

### Get Documentation Response

```json
{
  "results": [
    {
      "title": "useEffect",
      "content": "useEffect is a React Hook that lets you synchronize...",
      "source": "docs/reference/react/useEffect.md",
      "relevance": 0.95
    }
  ]
}
```

## Important Notes

- Script path must be correct (relative to repository root)
- API key automatically loaded from `.env` file or environment variables
- Network errors will return error messages
- Timeout defaults to Node.js control
