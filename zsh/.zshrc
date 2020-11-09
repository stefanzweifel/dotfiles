# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lambda"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras)

source $ZSH/oh-my-zsh.sh



source $HOME/.dotfiles/zsh/aliases.zsh


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8




export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Install z (https://github.com/rupa/z)
. /usr/local/etc/profile.d/z.sh


archive () {
   zip -r "$1".zip -i "$1" ;
}

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
