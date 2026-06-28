---
name: speeding-up-laravel-tests
description: Use when Laravel/Pest test suites are slow, CI duration is growing, individual tests take seconds, or the user asks to speed up, optimize, or profile tests. Covers factories, fakes, config caching, XDebug/pcov, BCRYPT_ROUNDS, LazilyRefreshDatabase, and stray HTTP requests.
---

# Speeding up Laravel tests

A curated list of techniques for making Laravel test suites faster. Apply these in roughly the order shown; environment fixes usually give the biggest wins for the least effort.

## When to use

- Test suite takes more than a few seconds per test on average.
- CI duration is climbing and you want to knock minutes off.
- A specific test is slow and you want to audit what it is actually doing.
- You are onboarding a new project and want a standard checklist.

## Environment and config

- **Set `BCRYPT_ROUNDS=4`** in `.env.testing` (or `phpunit.xml`). Default is 12 and hashing dominates auth tests.
- **Disable XDebug.** Disable pcov too at scale unless you specifically need coverage.
- **Disable background packages** in the testing environment: Pulse, Telescope, Nightwatch, and similar 3rd-party packages that do work on every request/command.
- **Use `WithCachedConfig` and `WithCachedRoutes` traits** to avoid re-parsing config and routes on every test.
- **Call `withoutVite()` (or `withoutMix()`)** in your test setup so the framework does not try to resolve built assets.

## Fake external interactions

Any interaction with an outside service that is not the subject of the test should be faked.

- `Notification::fake()`, `Mail::fake()`, `Bus::fake()`, `Event::fake()`, `Queue::fake()`.
- **HTTP endpoints that dispatch jobs:** fake the queue unless the test is asserting job behavior. Otherwise the jobs execute inline and pull in everything they touch.
- **Event listeners:** if unrelated listeners are firing and doing work, `Event::fake()` them. Use Laravel's event system to discover what is being triggered during a slow test.
- **`Http::preventingStrayRequests()`** in your test suite. A single slow stray request can punish every test. Note this only catches requests made through Laravel's HTTP client. Audit direct Guzzle / cURL usage separately.
- **`Sleep::fake(syncWithCarbon: true)`** so retries and backoffs do not actually sleep. Requires your code to use the `Sleep` helper rather than PHP's `sleep()`.
- **`Exceptions::fake()`** to make sure you are not reporting to Flare/Sentry/Bugsnag from within tests.

## Database

- **`LazilyRefreshDatabase`** instead of `RefreshDatabase`. Tests that never touch the DB skip the migration/truncation cost entirely.
- **Audit factory usage.** Factories are a common hotspot because it is easy to create more models than a test needs. Look for nested `create()` calls spawning extra rows.
- **Use `$factory->recycle($model)`** to create a shared parent once and thread it through nested factory calls, instead of each nested factory creating its own parent.

## Profile and diagnose

- **`./vendor/bin/pest --profile`** prints the slowest tests per shard. Start there. Patterns in the top-10 often apply suite-wide.
- **Visualize the suite** with https://marmelab.com/phpunit-d3-report/ (originally PHPUnit; verify Pest compatibility).
- When a slow test is mysterious, instrument event listeners or add temporary logging to find the unexpected work happening behind the scenes.

## Quick reference

| Area | Action |
|------|--------|
| Hashing | `BCRYPT_ROUNDS=4` |
| Debuggers | Disable XDebug, disable pcov |
| Background pkgs | Disable Pulse, Telescope, Nightwatch |
| Config / routes | `WithCachedConfig`, `WithCachedRoutes` |
| Assets | `withoutVite()` / `withoutMix()` |
| External services | `Notification::fake()`, `Mail::fake()`, `Bus::fake()`, `Event::fake()`, `Queue::fake()` |
| HTTP | `Http::preventingStrayRequests()` |
| Sleep | `Sleep::fake(syncWithCarbon: true)` |
| Exceptions | `Exceptions::fake()` |
| DB | `LazilyRefreshDatabase` |
| Factories | `$factory->recycle($model)`, audit nested creates |
| Profiling | `pest --profile` |

## Common mistakes

- Enabling `RefreshDatabase` on every test even when the test does not hit the DB.
- Calling real `sleep()` or using Carbon in production code, which prevents `Sleep::fake()` from helping.
- Adding `Queue::fake()` but still asserting side effects of the job (those will never happen).
- Running the suite with XDebug loaded "just in case" a test fails.
- Leaving `BCRYPT_ROUNDS` at the default because `.env.testing` was never created.
