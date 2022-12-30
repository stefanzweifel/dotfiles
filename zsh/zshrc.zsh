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
plugins=(git git-extras git-trim artisan)

source $ZSH/oh-my-zsh.sh



# User configuration

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Add Homebrews sbin path
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Add Support for opening files and folders in Sublime Text
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# Set vim as default editor
export EDITOR=vim

# Install z (https://github.com/rupa/z)
# . /usr/local/etc/profile.d/z.sh


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $HOME/.dotfiles/zsh/aliases.zsh





# Create a new directory and enter it
function mkd() {
   mkdir -p "$@" && cd "$@"
}


#  Commit everything
function commit() {
  commitMessage="$1"

  if [ "$commitMessage" = "" ]; then
     commitMessage="wip"
  fi

  git add .
  eval "git commit -a -m '${commitMessage}'"
}


# Open Database
function opendb () {
    [ ! -f .env ] && { echo "No .env file found."; exit 1; }

    DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
    DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
    DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
    DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
    DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
    DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

    DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

    echo "Opening ${DB_URL}"
    open $DB_URL
 }


# Execute a single test n times
function brittle-test() {
    for i in {1.."${2:-5}"}; do ./vendor/bin/phpunit --filter $1; done
}

# Run phpunit or pest
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
function p() {
    if [ -f vendor/bin/pest ]; then
       vendor/bin/pest "$@"
    else
       vendor/bin/phpunit "$@"
    fi
 }

# Run phpunit or pest and apply filter
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
 function puf() {
    if [ -f vendor/bin/pest ]; then
       vendor/bin/pest --filter "$@"
    else
       vendor/bin/phpunit --filter "$@"
    fi
 }

# Fix puppeteer install on M1 MacBook
# export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
# export PUPPETEER_EXECUTABLE_PATH=`which chrome`
# export PUPPETEER_PRODUCT=firefox


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# fnm
eval "$(fnm env --use-on-cd)"


# starship - https://starship.rs
eval "$(starship init zsh)"


# Bun
## bun completions
[ -s "/Users/stefan/.bun/_bun" ] && source "/Users/stefan/.bun/_bun"

## bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
