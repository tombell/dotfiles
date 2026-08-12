function brepo --description 'Show branches for Git repositories in the current directory'
    for d in *
        test -d "$d"; or continue

        printf '\n%s\n' "$PWD/$d"
        command git -C "$d" branch
    end
end
