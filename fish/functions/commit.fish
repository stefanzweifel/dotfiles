#  Commit everything
function commit
    set commit_message "$argv"

    if "$commit_message" = ""
        set commit_message "wip"
    end

    git add .
    eval "git commit -a -m '$commit_message'"
end
