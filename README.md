# Stefan's dotfiles

Some of my personal dotfiles. I use `stow` to manage the symlinks, so first `brew install stow`.

```
$ git clone git@github.com:stefanzweifel/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow $FODLER_NAME
```

## Install Applications

First, install homebrew

`ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`

and then

`brew bundle ~/.dotfiles/Brewfile`