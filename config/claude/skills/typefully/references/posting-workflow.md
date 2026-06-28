# Typefully Posting Workflow

Standard workflow for creating social media posts for @freekmurze across all platforms.

## ⚠️ Golden Rules

1. **NEVER publish immediately.** Always create as draft or schedule for a specific time. No exceptions.
2. **Always enable ALL platforms.** Every draft (thread or single post) must be synced to all connected platforms. For threads: create with `--platform x,mastodon,threads,bluesky` first, then add LinkedIn via `--update`. For single posts: use `--all`. Never skip platforms unless explicitly told to.
3. **Never post a bare link in a tweet.** Always add accompanying text before the URL.
4. **Vary the link text.** Don't always use the same phrase. Rotate naturally between variations like:
   - "Read the full post here:"
   - "Check it out:"
   - "Full blog post:"
   - "Dive deeper here:"
   - "More details on the blog:"
   - "Here's the full write-up:"
   - "Learn more:"

## Connected Platforms

| Platform | Username | Supports Threads |
|----------|----------|-----------------|
| X | @freekmurze | ✅ |
| LinkedIn | freek-van-der-herten | ❌ (single post only) |
| Mastodon | @freekmurze@phpc.social | ✅ |
| Threads | @freek | ✅ |
| Bluesky | freek@spatie.be | ✅ |

Social set ID: `284563`

## Creating a Thread Post (All Platforms)

LinkedIn does NOT support threads. Creating a draft with threads + LinkedIn in one call will fail with `VALIDATION_ERROR`. Always split into two steps:

### Step 1: Create draft for thread-capable platforms

```bash
./scripts/typefully.js drafts:create \
  --platform x,mastodon,threads,bluesky \
  --text "Main post text

---

Accompanying text with link: https://example.com" \
  --media <media_id>
```

Use `---` on its own line to split into thread posts.

### Step 2: Add LinkedIn (single post with link in body)

```bash
./scripts/typefully.js drafts:update <draft_id> \
  --platform linkedin \
  --text "Main post text

Accompanying text with link: https://example.com" \
  --media <media_id> \
  --use-default
```

LinkedIn gets the first post text PLUS the link from the second tweet combined into one post (since LinkedIn can't do threads). Freek will manually adjust further in the Typefully UI if needed.

## Creating a Single Post (All Platforms)

When there's no thread, all platforms can be created in one call:

```bash
./scripts/typefully.js drafts:create \
  --all \
  --text "Post text" \
  --media <media_id>
```

## Media Upload

Upload images/screenshots before creating drafts:

```bash
./scripts/typefully.js media:upload /path/to/image.png
# Returns: { "media_id": "...", "status": "ready" }
```

Pass the `media_id` to `--media` in create/update commands. The same media_id can be reused across platforms.

## Scheduling

```bash
# Next available slot
./scripts/typefully.js drafts:schedule <draft_id> --time next-free-slot --use-default

# Specific time (ISO 8601, UTC)
./scripts/typefully.js drafts:schedule <draft_id> --time "2026-02-18T13:30:00Z" --use-default

# Schedule at creation time
./scripts/typefully.js drafts:create --text "..." --schedule next-free-slot
```

## API Limitations

These actions require the Typefully UI (not available via API):
- Unsync LinkedIn content from other platforms
- Add a "first comment" on LinkedIn posts
- Reorder platforms or fine-tune per-platform settings
