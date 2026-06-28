# Laravel Herd

# Herd injected NVM configuration
export NVM_DIR="/Users/stefanzweifel/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/stefanzweifel/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/stefanzweifel/Library/Application Support/Herd/config/php/85/"

# Load all Postgres Binaries from Herd to support `dropdb`
export PATH="/Users/Shared/Herd/services/postgresql/18/bin/":$PATH
