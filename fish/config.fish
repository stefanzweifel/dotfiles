if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

#  Commit everything
function commit
    set commit_message "$argv"

    if "$commit_message" = ""
        set commit_message "wip"
    end

    git add .
    eval "git commit -a -m '$commit_message'"
end

# Run phpunit or pest
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
function p
    if test -f vendor/bin/pest
       vendor/bin/pest "$argv"
    else
       vendor/bin/phpunit "$argv"
    end
end

# Run phpunit or pest and apply filter
# https://freek.dev/2142-a-bash-function-to-run-tests-for-both-phpunit-and-pest
function puf
    if test -f vendor/bin/pest
       vendor/bin/pest --filter "$argv"
    else
       vendor/bin/phpunit --filter "$argv"
    end
end

# fnm
eval "$(fnm env --use-on-cd)"


