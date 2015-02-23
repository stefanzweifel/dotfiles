#!/bin/sh
#
# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
# install all the things
./brew/brew.sh
./brew/brew-cask.sh

# https://github.com/thebitguru/play-button-itunes-patch
# disable itunes opening on media keys
#
# cd ~/code
# git clone https://github.com/thebitguru/play-button-itunes-patch


# change to bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
sudo echo $BASHPATH >> /etc/shells
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION # should be 4.x not the old 3.2.X


# Add Homestead to vagrant
vagrant box add laravel/homestead