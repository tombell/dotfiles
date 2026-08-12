function stashed --description 'Show stashes for Git repositories in the current directory'
    for d in *
        test -d "$d"; or continue

        printf '\n%s\n' "$PWD/$d"
        command git -C "$d" stash list
    end
end
