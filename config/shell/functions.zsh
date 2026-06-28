# Functions

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

mov_to_mp4() {
    if [ $# -ne 1 ]; then
        echo "Usage: convert_to_mp4 input.mov"
        return 1
    fi

    input_file="$1"
    output_file="${input_file%.mov}.mp4"

    ffmpeg -i "$input_file" -c:v libx264 -preset slow -crf 22 -c:a aac -strict experimental "$output_file"
}

# Intercept npm and redirect to pnpm when pnpm-lock.yaml is present
npm() {
  if [[ -f "pnpm-lock.yaml" ]]; then
    echo "⚠️  This repository uses pnpm (pnpm-lock.yaml detected)."
    echo "→ Running: pnpm $*"
    echo ""
    command pnpm "$@"
  else
    command npm "$@"
  fi
}
