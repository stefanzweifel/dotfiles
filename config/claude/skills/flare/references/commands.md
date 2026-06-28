# Command reference

Complete reference for all `flare` CLI commands. Every command outputs JSON.

## User

### get-authenticated-user

Get the currently authenticated user.

```bash
flare get-authenticated-user
```

**Parameters:** None

**Response fields:** `id`, `name`, `email`, `photo_url`, `teams[]` (each with `id`, `name`)

---

## Projects

### list-projects

List all projects (paginated).

```bash
flare list-projects
```

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-id` | integer | Filter by project ID |
| `--filter-name` | string | Filter by project name |
| `--filter-team-id` | integer | Filter by team ID |
| `--include` | string | Include related data. Only value: `team` |
| `--page-number` | integer | Page number (default: 1) |
| `--page-size` | integer | Items per page (default: 10, max: 30) |

**Response:** Paginated. Each project has: `id`, `name`, `slug`, `group_name`, `stage`, `technology`, `api_key`, `api_public_key`, `unresolved_errors_count`, `errors_last_7_days_count`, `errors_previous_7_days_count`, `last_error_received_at`, `protect_against_spikes`, `spike_protection_active_until`, `team` (when included)

### create-project

Create a new project.

```bash
flare create-project --field name="My App" --field team_id=1 --field stage=production --field technology=Laravel
```

**Required body fields (via `--field`):**

| Field | Type | Values |
|---|---|---|
| `name` | string | Project name |
| `team_id` | integer | Team ID to own the project |
| `stage` | string | `local`, `development`, `staging`, `production` |
| `technology` | string | `Laravel`, `PHP`, `JS`, `Vue`, `React` |

**Optional body fields:**

| Field | Type | Description |
|---|---|---|
| `group` | string\|null | Project group name |

**Response:** The created project object with `api_key` and `api_public_key`.

### delete-project

Delete a project.

```bash
flare delete-project --project-id=123
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID to delete |

**Response:** 204 No Content

---

## Errors

### list-project-errors

List all errors within a project (paginated).

```bash
flare list-project-errors --project-id=123
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-id` | integer | Filter by error ID |
| `--filter-exception-message` | string | Filter by exception message |
| `--filter-exception-class` | string | Filter by exception class (e.g., `RuntimeException`) |
| `--filter-file` | string | Filter by file path |
| `--filter-status` | string | `open` or `resolved` |
| `--filter-stage` | string | Filter by stage |
| `--filter-level` | string | `debug`, `info`, `notice`, `warning`, `error`, `critical`, `alert`, `emergency` |
| `--filter-first-seen-at` | string | Filter by first seen date |
| `--filter-last-seen-at` | string | Filter by last seen date |
| `--filter-resolved-at` | string | Filter by resolved date |
| `--filter-seen-between` | string | Date range, e.g., `2025-01-01 00:00:00,2025-01-31 23:59:59` |
| `--include` | string | `assignees` — include assigned users |
| `--sort` | string | `first_seen_at`, `last_seen_at`, `-first_seen_at`, `-last_seen_at` |
| `--page-number` | integer | Page number (default: 1) |
| `--page-size` | integer | Items per page (default: 10, max: 30) |

**Response:** Paginated. Each error has: `id`, `slug`, `exception_class`, `exception_message`, `exception_code`, `file`, `line_number`, `class`, `method`, `status` (`open`/`resolved`), `level`, `stage`, `entry_point`, `entry_point_type` (`web`/`cli`/`queue`), `occurrence_count`, `affected_user_count`, `first_seen_at`, `last_seen_at`, `resolved_at`, `resolved_by_user_name`, `snooze_type`, `snoozed_at`, `snoozed_until`, `language`, `framework`, `language_version`, `framework_version`, `application_version`, `latest_occurrence_has_solutions`, `latest_occurrence_url_on_flare`, `assignees[]`

### get-project-error-count

Get the number of unique errors in a date range.

```bash
flare get-project-error-count --project-id=123 --start-date="2025-01-01 00:00:00" --end-date="2025-01-31 23:59:59"
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |
| `--start-date` | string | Start of period (datetime `Y-m-d H:i:s`) |
| `--end-date` | string | End of period (datetime `Y-m-d H:i:s`) |

**Response:** `{ "count": integer }`

### get-project-error-occurrence-count

Get the number of error occurrences in a date range.

```bash
flare get-project-error-occurrence-count --project-id=123 --start-date="2025-01-01 00:00:00" --end-date="2025-01-31 23:59:59"
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |
| `--start-date` | string | Start of period (datetime `Y-m-d H:i:s`) |
| `--end-date` | string | End of period (datetime `Y-m-d H:i:s`) |

**Response:** `{ "count": integer }`

### resolve-error

Mark an error as resolved.

```bash
flare resolve-error --error-id=456
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--error-id` | integer | Error ID |

**Response:** The updated error object with `status: "resolved"`.

### unresolve-error

Reopen a resolved error.

```bash
flare unresolve-error --error-id=456
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--error-id` | integer | Error ID |

**Response:** The updated error object with `status: "open"`.

### snooze-error

Snooze an error to suppress notifications.

```bash
flare snooze-error --error-id=456 --field snooze_type=snooze_forever
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--error-id` | integer | Error ID |

**Required body fields (via `--field`):**

| Field | Type | Values |
|---|---|---|
| `snooze_type` | string | `snooze_until`, `snooze_forever`, `snooze_number_of_occurrences`, `snooze_application_version` |

**Conditional body fields:**

| Field | Required when | Type | Description |
|---|---|---|---|
| `snooze_until` | `snooze_type=snooze_until` | string (ISO 8601) | Date/time to unsnooze. Must be in the future. |
| `snooze_number_of_occurrences` | `snooze_type=snooze_number_of_occurrences` | integer (min: 1) | Number of additional occurrences before unsnoozing |

**Response:** The updated error object.

### unsnooze-error

Unsnooze a snoozed error.

```bash
flare unsnooze-error --error-id=456
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--error-id` | integer | Error ID |

**Response:** The updated error object.

---

## Error occurrences

### list-error-occurrences

List all occurrences of a specific error (paginated). Each occurrence includes full stack trace, context, and solutions.

```bash
flare list-error-occurrences --error-id=456
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--error-id` | integer | Error ID |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--sort` | string | `received_at` or `-received_at` |
| `--page-number` | integer | Page number (default: 1) |
| `--page-size` | integer | Items per page (default: 10, max: 30) |

**Response:** Paginated. Each occurrence has: `id`, `error_id`, `received_at`, `entry_point`, `exception_class`, `exception_message`, `exception_code`, `application_path`, `application_version`, `notifier_client_name`, `language_version`, `framework_version`, `stage`, `entry_point_type`, plus nested:

- **`frames[]`** — stack trace frames: `file`, `relative_file`, `line_number`, `class`, `method`, `code_snippet[]`, `application_frame` (boolean)
- **`attributes[]`** — context items: `group`, `key`, `value` (groups: request, user, environment, etc.)
- **`events[]`** — execution trail: `id`, `name`, `level`, `meta_data`, `received_at`, `microtime`
- **`solutions[]`** — fix suggestions: `id`, `title`, `description`, `links[]`, `action_description`, `is_runnable`
- **`error`** — the parent error object

### get-error-occurrence

Get a single error occurrence by ID.

```bash
flare get-error-occurrence --occurrence-id=789
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--occurrence-id` | integer | Occurrence ID |

**Response:** Same structure as a single item in `list-error-occurrences`.

---

## Performance monitoring

### Shared parameters

**`--type`** (required for most monitoring commands): `routes`, `queries`, `jobs`, `commands`, `external-http`, `views`, `livewire-components`

**`--filter-interval`** (optional, default `24h`): `1h`, `3h`, `6h`, `24h`, `48h`, `7d`, `14d`

### get-monitoring-summary

Get a performance overview for a project: metrics and trends for routes, jobs, commands, and queries, plus the top-10 slowest routes and queries.

```bash
flare get-monitoring-summary --project-id=123
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-interval` | string | Time window (default: `24h`) |

**Response:** Metrics and trends per type (routes, jobs, commands, queries), plus `top_slowest_routes` and `top_slowest_queries` arrays (each up to 10 items).

### list-monitoring-aggregations

List aggregated performance data for a monitoring type (paginated, sortable, filterable).

```bash
flare list-monitoring-aggregations --project-id=123 --type=routes --sort=-p95
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |
| `--type` | string | Monitoring type (see shared parameters) |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-interval` | string | Time window (default: `24h`) |
| `--filter-search` | string | Search by name/label |
| `--filter-p95` | string | Filter by p95 value (operator `>=` is encoded in the API param name) |
| `--filter-average` | string | Filter by average value (operator `>=` is encoded in the API param name) |
| `--filter-count` | string | Filter by request count (operator `>=` is encoded in the API param name) |
| `--filter-error-rate` | string | Filter by error rate (operator `>=` is encoded in the API param name) |
| `--sort` | string | Sort field: `p50`, `p90`, `p95`, `p99`, `average`, `count`, `error_rate`, `importance`. Prefix with `-` for descending (default: `-p95`) |
| `--page-number` | integer | Page number (default: 1) |
| `--page-size` | integer | Items per page |

The comparison operator is encoded in the API parameter name (e.g. `filter[p95:>=]` → `--filter-p95`). Pass only the numeric value: `--filter-p95=500`.

**Response:** Paginated. Each aggregation has: `uuid`, `type`, `label`, `p50`, `p90`, `p95`, `p99`, `average`, `count`, `error_rate`, `trend`.

### get-monitoring-time-series

Get time series data for a monitoring type.

```bash
flare get-monitoring-time-series --project-id=123 --type=routes
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--project-id` | integer | Project ID |
| `--type` | string | Monitoring type (see shared parameters) |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-interval` | string | Time window (default: `24h`) |
| `--uuid` | string | Scope to a single aggregation UUID |
| `--filter-search` | string | Search by name/label |
| `--filter-p95` | string | Filter by p95 value with operator |

**Response:** `precision` (minute, hour, or day) and `data[]` — array of time series points.

### get-monitoring-aggregation

Get details for a specific aggregation (e.g. a single route, query, or job).

```bash
flare get-monitoring-aggregation --type=routes --uuid=<uuid>
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--type` | string | Monitoring type (see shared parameters) |
| `--uuid` | string | Aggregation UUID |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--filter-interval` | string | Time window (default: `24h`) |
| `--include` | string | Comma-separated: `parents`, `children` |

**Response:** Aggregation detail with `uuid`, `type`, `label`, percentiles, `count`, `error_rate`, `trend`, `interval`, parent/child links. When `--include` is used, includes `parents[]` and/or `children[]` arrays.

### list-aggregation-traces

List traces for a specific aggregation (paginated).

```bash
flare list-aggregation-traces --type=routes --uuid=<uuid>
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--type` | string | Monitoring type (see shared parameters) |
| `--uuid` | string | Aggregation UUID |

**Optional parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--sort` | string | `slowest` (default), `fastest`, `latest`, `oldest` |
| `--page-number` | integer | Page number (default: 1) |
| `--page-size` | integer | Items per page |

**Response:** Paginated. Each trace summary has: `trace_id`, `started_at`, `duration_ms`.

### get-trace

Get a full trace with its span tree.

```bash
flare get-trace --trace-id=<trace-id>
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--trace-id` | string | Trace ID |

**Response:** Full span tree with events, resources, and contexts for each span.

---

## Teams

### get-team

Get a team and its members.

```bash
flare get-team --team-id=1
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--team-id` | integer | Team ID |

**Response:** `id`, `name`, `slug`, `users[]` (each with `user_id`, `team_id`, `user_email`, `role` — one of `admin`, `owner`, `member`)

### remove-team-user

Remove a user from a team.

```bash
flare remove-team-user --team-id=1 --user-id=42
```

**Required parameters:**

| Parameter | Type | Description |
|---|---|---|
| `--team-id` | integer | Team ID |
| `--user-id` | integer | User ID to remove |

**Response:** 200 OK
