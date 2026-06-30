# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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

# zsh-history-substring-search - type a substring, ↑/↓ cycles matching history entries
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/stefanzweifel/Library/Application Support/Herd/config/php/85/"
