# Stefan's dotfiles

<!-- TODO: Add Image of my Terminal -->

Personal macOS dotfiles, managed by [Dotbot](https://github.com/anishathalye/dotbot). Every linked file lives under `config/<tool>/`; `install.conf.yml` declares where each one gets symlinked.

## Installation

On a new Mac, clone the repo and run the bootstrap script:

```
git clone https://github.com/stefanzweifel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bin/first-setup
```

## Scripts

All operational scripts live under `bin/`.

### `bin/first-setup`

Bootstraps a fresh Mac end-to-end. Prompts for confirmation, then:

1. Installs Homebrew if missing.
2. Installs every package in `config/homebrew/Brewfile` (`brew bundle`).
3. Clones [`stefanzweifel/dotfiles-private`](https://github.com/stefanzweifel/dotfiles-private) into `~/.dotfiles-private` — but **only** if `gh` reports the logged-in user as `stefanzweifel`. Skips cleanly on other accounts or when `gh` isn't authenticated.
4. Runs `bin/install` to symlink everything in this repo.
5. Runs `~/.dotfiles-private/bin/install` if the private repo is present.
6. Applies macOS system defaults via `bin/macos-defaults`.

### `bin/install`

Runs Dotbot against `install.conf.yml` — initializes the `dotbot/` submodule first, then symlinks every entry under `link:` into the right destination. Idempotent; safe to re-run after editing any config or adding a new `link:` entry.

### `bin/update`

Brings everything on the machine up to date:

1. `git pull` the public dotfiles repo.
2. `git pull` the private dotfiles repo (`~/.dotfiles-private`), if present.
3. Re-run `bin/install` to pick up any newly-added `link:` entries.
4. Re-run the private repo's `bin/install` if it exists.
5. `brew update`, `brew upgrade`, re-apply the Brewfile, `brew cleanup`.
6. Run `bin/brewfile-sync` so the Brewfile stays honest about what's installed.
7. `npm update -g`.
8. `composer global update`.

### `bin/brewfile-sync`

Keeps `config/homebrew/Brewfile` in sync with whatever is actually installed locally. Compares `brew leaves` (top-level formulae), `brew list --cask`, and `mas list` (Mac App Store apps) against the Brewfile and appends any missing entries as a dated block:

```
# Added by brewfile-sync on 2026-06-28
brew 'pnpm'
cask 'orbstack'
mas 'Things', id: 904280696
```

Idempotent — running twice in a row adds nothing the second time. The script tolerates tap-prefixed entries (e.g. `jordond/tap/jolt`) so they don't get double-added. Grouping (Dev / Apps / Fonts) is left to manual re-sorting when convenient. Called automatically by `bin/update`.

### `bin/macos-defaults`

Applies a curated set of macOS system defaults: faster key-repeat, Finder tweaks, save/print panel expansion, Dock and Mission Control timings, automatic software-update checks, etc. Prompts for confirmation before writing anything. Some changes only take effect after logout/restart.

## Architecture

**Adding or changing a config:**

1. Place the file under `config/<tool>/` (the directory layout mirrors the tool name, not the destination path).
2. Add a `link:` entry to `install.conf.yml` mapping the destination (e.g. `~/.config/foo/bar`) to the repo-relative source.
3. Run `bin/install`. `defaults.link.relink: true` and `force: true` mean existing symlinks/files at the destination get replaced.

## LICENSE

MIT
