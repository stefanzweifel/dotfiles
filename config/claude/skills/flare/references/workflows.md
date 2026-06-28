# Workflows

Detailed workflows for common Flare CLI tasks.

## Error triage

Systematically work through open errors, categorize them, and take action.

### Step 1: Get an overview

```bash
# List open errors, most recent first
flare list-project-errors --project-id=123 --filter-status=open --sort=-last_seen_at --page-size=30
```

Present results as a table: ID, exception class, message (truncated to ~60 chars), occurrence count, last seen.

### Step 2: Categorize by exception class

Group the errors by `exception_class`. Common patterns:
- **Same class, different messages** — likely the same root cause. Fix one and resolve the group.
- **High occurrence count** — prioritize these; they affect users most.
- **`latest_occurrence_has_solutions: true`** — check solutions first, they often have the fix.

### Step 3: Take action on each error

For each error, decide:

| Situation | Action |
|---|---|
| Bug is fixed in code | `flare resolve-error --error-id=ID` |
| Known issue, not worth notifications | `flare snooze-error --error-id=ID --field snooze_type=snooze_forever` |
| Will fix next sprint | `flare snooze-error --error-id=ID --field snooze_type=snooze_until --field snooze_until=YYYY-MM-DDT00:00:00Z` |
| Noisy but want to know if it spikes | `flare snooze-error --error-id=ID --field snooze_type=snooze_number_of_occurrences --field snooze_number_of_occurrences=100` |
| Need more info | Fetch occurrence details (see debugging workflow below) |

### Step 4: Paginate through remaining errors

```bash
# Next page
flare list-project-errors --project-id=123 --filter-status=open --sort=-last_seen_at --page-number=2 --page-size=30
```

Repeat until all pages are triaged. Use `meta.last_page` from the response to know when you're done.

---

## Debug an error with local code

Use occurrence data to pinpoint the bug in the user's local codebase.

### Step 1: Get the latest occurrence

```bash
flare list-error-occurrences --error-id=456 --sort=-received_at --page-size=1
```

Or if you have a specific occurrence ID:

```bash
flare get-error-occurrence --occurrence-id=789
```

### Step 2: Find application frames

From the occurrence's `frames` array, filter for frames where `application_frame` is `true`. These are the user's code — not vendor or framework code.

Each application frame has:
- `relative_file` — path relative to the project root (e.g., `app/Http/Controllers/OrderController.php`)
- `line_number` — the exact line where execution was at this point in the stack
- `class` and `method` — the class and method name
- `code_snippet` — a few lines of code around the error line (from the production server)

### Step 3: Read local source files

For each application frame, read the local file at the reported path and line number. The code may have changed since the error occurred — compare the `code_snippet` from the occurrence with the local file to check.

If `application_version` is set on the occurrence, you can also check git to see what changed:

```bash
git diff <application_version> -- <relative_file>
```

### Step 4: Use context for clues

**Attributes** (`attributes[]`) provide request and environment context:
- `group: "request"` — URL, method, IP, user agent
- `group: "user"` — authenticated user info
- `group: "environment"` — PHP version, server, OS
- `group: "context"` — custom context added by the application

**Events** (`events[]`) show the execution trail leading up to the error:
- Database queries executed
- Log messages written
- Jobs dispatched
- Cache hits/misses
- Events and listeners fired

Events are chronological. Walk through them to understand what happened before the crash.

### Step 5: Check solutions

If `solutions[]` is non-empty, these are AI-generated or provider-supplied fix suggestions. Each solution has:
- `title` — what the solution is
- `description` — how to apply it
- `links[]` — relevant documentation URLs

Present solutions prominently — they're often the fastest path to a fix.

### Step 6: Present findings

Summarize for the user:
1. **Error**: exception class + message
2. **Location**: file:line in their code (link to the application frame)
3. **Context**: relevant attributes (request URL, user, etc.)
4. **Trail**: key events leading to the error
5. **Solutions**: any available solutions
6. **Flare link**: `latest_occurrence_url_on_flare` for the full dashboard view

---

## Interpreting occurrence data

### Frames

The `frames` array is the full stack trace, ordered from the throw point (index 0) to the entry point (last index).

- **`application_frame: true`** — this is code in the user's project (not vendor). Always focus on these.
- **`application_frame: false`** — framework/library code. Useful for understanding the call path but usually not the source of the bug.
- **`code_snippet`** — array of source lines from the production server. Line numbers in the snippet correspond to the actual file.

### Attributes

Attributes are key-value context grouped by category:

| Group | Contains |
|---|---|
| `request` | URL, method, IP, headers, body |
| `user` | Authenticated user details |
| `environment` | PHP version, server software, OS |
| `context` | Custom context added via `Flare::context()` |
| `session` | Session data |
| `cookies` | Cookie values |
| `headers` | HTTP headers |

### Events

Events are a chronological log of what happened during the request/job:

| Event type | What it tells you |
|---|---|
| Query | SQL queries with bindings and timing |
| Log | Application log messages |
| Job | Queued jobs dispatched |
| Cache | Cache gets, puts, misses |
| Event | Laravel events fired |
| View | Blade views rendered |

### Solutions

Flare's solution providers suggest fixes based on the error type. A solution includes:
- `title` — short description (e.g., "Add the missing method")
- `description` — detailed instructions
- `links` — documentation references
- `is_runnable` — whether it can be auto-applied (via Flare dashboard only, not CLI)

---

## Investigate slow performance

Use the monitoring commands to find performance bottlenecks, drill into specific routes or queries, and inspect individual traces.

### Step 1: Get a performance overview

```bash
flare get-monitoring-summary --project-id=123 --filter-interval=24h
```

This returns metrics and trends for routes, jobs, commands, and queries, plus the top-10 slowest routes and top-10 slowest queries. Start here to understand the overall health of the application.

### Step 2: List aggregations for a specific type

Pick the type that looks problematic (e.g. `routes` or `queries`) and list the aggregations sorted by p95 descending:

```bash
flare list-monitoring-aggregations --project-id=123 --type=routes --sort=-p95 --filter-interval=24h
```

Present results as a table: label, p95, average, count, error rate. Focus on aggregations with high p95 values or high error rates.

To filter for only slow aggregations:

```bash
flare list-monitoring-aggregations --project-id=123 --type=queries --filter-p95=500 --sort=-p95
```

### Step 3: View time series for trends

Check if slowness is a recent spike or a sustained pattern:

```bash
flare get-monitoring-time-series --project-id=123 --type=routes --filter-interval=7d
```

To scope to a single aggregation:

```bash
flare get-monitoring-time-series --project-id=123 --type=routes --uuid=<uuid> --filter-interval=7d
```

### Step 4: Drill into a specific aggregation

Get details on a slow route, query, job, etc.:

```bash
flare get-monitoring-aggregation --type=routes --uuid=<uuid> --include=children
```

The `children` include shows what the route calls (queries, external HTTP, views, etc.) — these are often the source of slowness. The `parents` include shows what calls this aggregation.

### Step 5: List traces for the aggregation

```bash
flare list-aggregation-traces --type=routes --uuid=<uuid> --sort=slowest
```

This returns trace summaries sorted by duration. Pick the slowest traces to inspect.

### Step 6: Inspect a trace

```bash
flare get-trace --trace-id=<trace-id>
```

This returns the full span tree with events, resources, and contexts. Walk through the span tree to find the bottleneck:

- Look for spans with the longest duration — these are the slowest operations
- Check child spans to see where time is actually being spent
- Review events for context (queries executed, cache operations, etc.)
- Use resources and contexts for environment details

### Step 7: Present findings

Summarize for the user:
1. **Bottleneck**: which route/query/job is slow and its p95 latency
2. **Pattern**: whether it's a sustained issue or a recent spike (from time series)
3. **Root cause**: what the trace reveals (e.g. slow query, N+1 problem, slow external API)
4. **Children**: downstream operations contributing to the slowness
5. **Recommendation**: specific actions to improve performance

---

## Snooze strategies

Choose the right snooze type based on the situation:

| Strategy | When to use | Command |
|---|---|---|
| **Forever** | Known issue you'll never fix, or acceptable behavior | `--field snooze_type=snooze_forever` |
| **Until date** | Will be fixed by a specific deadline or release date | `--field snooze_type=snooze_until --field snooze_until=2025-06-01T00:00:00Z` |
| **N occurrences** | Tolerable at low volume, but want to know if it spikes | `--field snooze_type=snooze_number_of_occurrences --field snooze_number_of_occurrences=100` |
| **Application version** | Will be fixed in the next deploy | `--field snooze_type=snooze_application_version` |

To unsnooze any error:

```bash
flare unsnooze-error --error-id=456
```

---

## Create a project and get API keys

### Step 1: Find your team ID

```bash
flare get-authenticated-user
```

The response includes a `teams` array — note the `id` of the team you want to create the project in.

### Step 2: Create the project

```bash
flare create-project --field name="My App" --field team_id=1 --field stage=production --field technology=Laravel
```

**`technology`** values: `Laravel`, `PHP`, `JS`, `Vue`, `React`

**`stage`** values: `local`, `development`, `staging`, `production`

### Step 3: Retrieve the API keys

The `create-project` response includes two keys:

- **`api_key`** — for server-side SDKs (PHP, Laravel). Set as the `FLARE_KEY` environment variable.
- **`api_public_key`** — for client-side SDKs (JavaScript). Used in `flare.light()`.

To find keys for an existing project:

```bash
# List all projects
flare list-projects

# Search by name
flare list-projects --filter-name="My App"
```

The project object in the response contains both `api_key` and `api_public_key`.

For instructions on installing the SDK in your application, see the Flare docs for your technology:

- **Laravel**: https://flareapp.io/docs/laravel
- **PHP**: https://flareapp.io/docs/php
- **JavaScript / React / Vue**: https://flareapp.io/docs/javascript

### Step 4: Verify errors are flowing

Once your application is configured and sending errors:

```bash
# Check error count
flare get-project-error-count --project-id=123 --start-date="2025-01-01 00:00:00" --end-date="2025-12-31 23:59:59"

# Or list recent errors
flare list-project-errors --project-id=123 --sort=-last_seen_at --page-size=5
```
