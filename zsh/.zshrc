# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="cloud"

DEFAULT_USER="stefanzweifel"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize to your needs...
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"

source $HOME/.dotfiles/zsh/aliases.zsh

# Go Setup
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8



# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"
