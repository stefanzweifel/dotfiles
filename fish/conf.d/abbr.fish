
abbr reload "exec $SHELL -l"

# Paths
abbr dl 'cd ~/Downloads'
abbr dt 'cd ~/Desktop'
abbr dv 'cd ~/Developer'
abbr sites 'cd ~/Developer'
abbr dotfiles 'cd ~/.dotfiles'

# PHP
abbr pserve 'php -s localhost:'

# Laravel
abbr art 'php artisan'
abbr mfs 'php artisan migrate:fresh --seed'

# Composer
abbr c '/opt/homebrew/bin/composer'
abbr ci '/opt/homebrew/bin/composer install'
abbr cr '/opt/homebrew/bin/composer require'
abbr cda '/opt/homebrew/bin/composer dumpautoload'

# PHP Unit
abbr pw 'phpunit-watcher watch'
abbr pwf 'phpunit-watcher watch --filter '

# Git
abbr gs 'git status'
abbr gc 'git checkout'
abbr gpo 'git push origin'
abbr gm 'git merge'
abbr glog "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr nah 'git reset --hard;git clean -df'

# PhpStorm
abbr phpstorm 'open -a /Applications/PhpStorm.app '`pwd`''

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
abbr emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'

# Start Google Chrome Browser
abbr chrome '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# Analyse Disk Space
abbr du 'ncdu --color dark -rr -x --exclude .git --exclude node_modules'

abbr lscleanup '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
abbr cat 'bat'
abbr ping 'prettyping --nolegend'
abbr ls 'ls -Fog'