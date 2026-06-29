# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set theme used by bat/cat
# See `bat --list-themes` for list of available themes
export BAT_THEME="gruvbox-dark"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lambda"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras git-trim)

source $ZSH/oh-my-zsh.sh

# Install z (https://github.com/rupa/z)
# . /usr/local/etc/profile.d/z.sh

# Source shell config files
for file in "$DOTFILES"/config/shell/*.zsh; do
  [[ "$(basename $file)" == "zshrc.zsh" ]] && continue
  source "$file"
done
unset file

# Source private shell config files
if [ -d "$HOME/.dotfiles-private/config/shell" ]; then
  for f in "$HOME/.dotfiles-private/config/shell"/*.zsh; do
    [ -f "$f" ] && source "$f"
  done
  unset f
fi

# fnm
eval "$(fnm env --use-on-cd)"

# starship - https://starship.rs
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# zellij
# eval "$(zellij setup --generate-auto-start zsh)"

# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/stefanzweifel/Library/Application Support/Herd/config/php/85/"
