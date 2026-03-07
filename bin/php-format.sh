#!/bin/bash

FILE="$1"
GLOBAL_PINT="$HOME/.composer/vendor/bin/pint"

find_project_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/composer.json" ]; then
            echo "$dir"
            return
        fi
        dir="$(dirname "$dir")"
    done
}

PROJECT_ROOT=$(find_project_root "$(dirname "$FILE")")

TEMP=$(mktemp /tmp/php-format.XXXXXX.php)
cat > "$TEMP"

if [ -n "$PROJECT_ROOT" ] && [ -f "$PROJECT_ROOT/vendor/bin/pint" ]; then
    "$PROJECT_ROOT/vendor/bin/pint" "$TEMP" > /dev/null 2>&1
elif [ -n "$PROJECT_ROOT" ] && [ -f "$PROJECT_ROOT/vendor/bin/php-cs-fixer" ]; then
    cd "$PROJECT_ROOT"
    ./vendor/bin/php-cs-fixer fix --allow-risky=yes "$TEMP" > /dev/null 2>&1
else
    "$GLOBAL_PINT" "$TEMP" > /dev/null 2>&1
fi

cat "$TEMP"
rm -f "$TEMP"
