# Run phpunit or pest
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
function p
    if test -f vendor/bin/pest
        vendor/bin/pest "$argv"
    else if test -f vendor/bin/phpunit
        vendor/bin/phpunit "$argv"
    else
        echo "phpunit or pest not found."
    end
end
