export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

# Shortcuts
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L9
alias d="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"

# -------
# Aliases
# Source: https://jonsuh.com/blog/bash-command-line-shortcuts/
# -------
alias clr="clear" # Clear your terminal screen
alias flush="sudo discoveryutil udnsflushcaches" # Flush DNS (Yosemite)
alias ip="curl icanhazip.com" # Your public IP address
alias ll="ls -al" # List all files in current directory in long list format
alias ldir="ls -al | grep ^d" # List all directories in current directory in long list format
alias o="open ." # Open the current directory in Finder
alias ut="uptime" # Computer uptime


# ----------------------
# Git Aliases
# Source: https://jonsuh.com/blog/git-command-line-shortcuts/
# ----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gb='git branch'
alias gbd='git branch -d '
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }


# See: https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L104
# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# See: https://github.com/mathiasbynens/dotfiles/blob/master/.aliases#L133
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"