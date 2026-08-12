function urepo --description 'Pull each Git repository in the current directory'
    for d in *
        test -d "$d"; or continue

        printf '\n%s\n' "$PWD/$d"
        command git -C "$d" pull
    end
end
