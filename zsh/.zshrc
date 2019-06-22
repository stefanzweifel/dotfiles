
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="common"

DEFAULT_USER="stefanzweifel"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras git-flow npm brew composer sublime laravel5)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize to your needs...
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"

# TMUX Settings
export DISABLE_AUTO_TITLE='true'

# https://github.com/pindexis/qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

qfc_quick_command 'cd' '\C-b' 'cd $0'

source $HOME/.dotfiles/zsh/aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# See: http://calebporzio.com/bash-alias-composer-link-use-local-folders-as-composer-dependancies/
composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

# Go Setup

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
