# Stefan's dotfiles

## Setup

Clone Repo, install homebrew, apps and tools. Add homestead-box to vagrant.

```
git clone https://github.com/stefanzweifel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh scripts/setup.sh
```

## OSX Settings

Set default OSX Settings.

```
~/.dotfiles/.osx
```

## Symlinking settings

Some of my personal dotfiles. I use `stow` to manage the symlinks, so first `brew install stow`.

```
$ git clone git@github.com:stefanzweifel/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow bash
$ stow zsh
$ stow git
```