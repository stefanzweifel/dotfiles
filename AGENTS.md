# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal macOS dotfiles, managed by [Dotbot](https://github.com/anishathalye/dotbot) (vendored as a git submodule). `install.conf.yml` is the source of truth — it declares which files in `config/` are symlinked to which locations in `$HOME`.

## Commands

- `./install` — Run Dotbot against `install.conf.yml`. Idempotent; safe to re-run after editing configs or the manifest. Initializes submodules first.
- `bin/update` — Pull latest dotfiles, then `brew update/upgrade`, re-apply `config/homebrew/Brewfile`, `brew cleanup`, `npm update -g`, `composer global update`.

## Architecture

**Adding/changing a config:**

1. Place the file under `config/<tool>/` (the directory layout mirrors the tool name, not the destination path).
2. Add a `link:` entry to `install.conf.yml` mapping the destination (e.g. `~/.config/foo/bar`) to the repo-relative source.
3. Run `./install`. `defaults.link.relink: true` and `force: true` mean existing symlinks/files at the destination get replaced.

**Source-of-truth pattern:** Every linked file lives in `config/<tool>/`. The home-directory copies are symlinks — never edit `~/.zshrc`, `~/.gitconfig`, etc. directly; edit the file under `config/` and the symlink picks it up.

**Shell config is split:** `config/zsh/zshrc.zsh` is the entry point. It sources every `*.zsh` file in `config/shell/` (aliases, exports, functions, herd) automatically — drop a new `.zsh` file there and it gets loaded next shell. Theme is oh-my-zsh `lambda`, but Starship is initialized at the end and takes over the prompt.

**Submodules:** `dotbot/` and `dotbot-brew/` are vendored. `./install` runs `git submodule update --init --recursive` first; if Dotbot looks broken, check the submodule.

**Homebrew:** `config/homebrew/Brewfile` is canonical. `bin/update` re-applies it on every run, so adding a brew/cask/mas line there and running `bin/update` is the install path.
