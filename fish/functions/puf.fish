# Run phpunit or pest and apply filter
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
function puf
    if test -f vendor/bin/pest
       vendor/bin/pest --filter "$argv"
    else
       vendor/bin/phpunit --filter "$argv"
    end
end
