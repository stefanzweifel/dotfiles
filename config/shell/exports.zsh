# Exports

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load global Composer binaries
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load global Node binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific Node and Composer binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Add Homebrews sbin path
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Add Support for opening files and folders in Sublime Text with `subl`
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# Add binaries from .local to the Path
export PATH="$HOME/.local/bin:$PATH"

# Disable Homebrew auto updates
export HOMEBREW_NO_AUTO_UPDATE=1

# Disable Zoxide doctor
export _ZO_DOCTOR=0

# Set vim as default editor
export EDITOR=vim

# Set theme used by bat/cat
# See `bat --list-themes` for list of available themes
export BAT_THEME="gruvbox-dark"

# Point ssh-add and other SSH_AUTH_SOCK-aware tools at the 1Password agent.
# ~/.ssh/config already sets IdentityAgent for `ssh` itself, but tools that
# don't parse ssh_config (ssh-add, some editors, CI helpers) need this.
# Skipped inside SSH sessions so a forwarded agent keeps working.
if [[ -z "$SSH_CONNECTION" ]]; then
  _op_agent_sock="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  [[ -S "$_op_agent_sock" ]] && export SSH_AUTH_SOCK="$_op_agent_sock"
  unset _op_agent_sock
fi
