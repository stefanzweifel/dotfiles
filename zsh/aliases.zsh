alias reload="exec $SHELL -l"

# Shortcuts
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L9

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though

# Paths
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dv="cd ~/dev"

# PHP
alias pserve="php -S localhost:"

# Laravel
alias art='php artisan'
alias mfs='php artisan migrate:fresh --seed'

# Composer
alias ci="composer install"
alias cr="composer require"
alias cda="composer dumpautoload"

# PHP Unit
alias puf="./vendor/bin/phpunit --filter="
alias pw="phpunit-watcher watch"
alias pwf="phpunit-watcher watch --filter "

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"


alias cat="bat"
alias ping='prettyping --nolegend'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help='tldr'