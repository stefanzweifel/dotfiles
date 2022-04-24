if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

fish_add_path $HOME/.composer/vendor/bin
fish_add_path $HOME/.node/bin
fish_add_path node_modules/.bin
fish_add_path vendor/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# fnm
# eval "$(fnm env --use-on-cd)"
