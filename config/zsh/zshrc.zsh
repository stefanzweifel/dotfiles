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

# direnv - https://direnv.net
eval "$(direnv hook zsh)"

# zellij
# eval "$(zellij setup --generate-auto-start zsh)"

# zsh-patina - https://github.com/michel-kraemer/zsh-patina
eval "$(/opt/homebrew/bin/zsh-patina activate)"

# fzf - Ctrl+T file picker, Alt+C cd into subdir (Ctrl+R history is owned by atuin below)
source <(fzf --zsh)

# atuin - https://atuin.sh
# Loaded after fzf on purpose: fzf's integration binds Ctrl+R, and whichever
# sources last wins, so atuin's init here reclaims Ctrl+R for its history search.
eval "$(atuin init zsh)"

# zsh-completions - extra completion definitions (must be on FPATH before compinit)
FPATH="/opt/homebrew/share/zsh-completions:$FPATH"

# compinit builds the completion cache (~/.zcompdump). It normally re-scans
# fpath and runs a security check on every startup, which is slow. The glob
# qualifier (#qNmh-24) matches ~/.zcompdump only if it was modified in the last
# 24 hours; when it's fresh we run `compinit -C` to skip the rescan/security
# check, otherwise we do a full rebuild.
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi


# zsh-autosuggestions - greyed-out suggestion from history; → or End to accept
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/stefanzweifel/Library/Application Support/Herd/config/php/85/"
