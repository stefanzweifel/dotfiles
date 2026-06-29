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

# Set vim as default editor
export EDITOR=vim

# Set theme used by bat/cat
# See `bat --list-themes` for list of available themes
export BAT_THEME="gruvbox-dark"
