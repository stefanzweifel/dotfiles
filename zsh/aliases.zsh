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
alias dv="cd ~/Developer"
alias sites="cd ~/Developer"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias dotfiles="cd $DOTFILES"

# PHP
alias pserve="php -S localhost:"

# Laravel
alias art='php artisan'
alias mfs='php artisan migrate:fresh --seed'

# Composer
alias c="/opt/homebrew/bin/composer"
alias ci="/opt/homebrew/bin/composer install"
alias cr="/opt/homebrew/bin/composer require"
alias cda="/opt/homebrew/bin/composer dumpautoload"
alias co="/opt/homebrew/bin/composer outdated --direct"

# PHP Unit
alias pw="phpunit-watcher watch"
alias pwf="phpunit-watcher watch --filter "

# Git
alias gs="git status"
alias gc="git checkout"
alias gpo="git push origin"
alias gm="git merge"
alias gt="git trim --merged"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias nah='git reset --hard;git clean -df'

# PhpStorm
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'

alias github='open -a "/Applications/GitHub Desktop.app" "`pwd`"'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Start Google Chrome Browser
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# Analyse Disk Space
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias cat="bat"
alias ping='prettyping --nolegend'
alias help='tldr'
alias mux=tmuxinator

# Borg Backup
# https://github.com/stefanzweifel/borg-backup-scripts
alias borg:backup="sh $HOME/bin/borg-backup-scripts/backup.sh"
alias borg:list="sh $HOME/bin/borg-backup-scripts/list.sh"
alias borg:check="sh $HOME/bin/borg-backup-scripts/check.sh"
alias borg:export="sh $HOME/bin/borg-backup-scripts/export.sh"
