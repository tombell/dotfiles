function git --wraps git --description 'Show git diffs with difftastic in the terminal'
    # Scripts, pipes and redirects keep git's normal patch output.
    if not test -t 1; or not command -q difft
        command git $argv
        return
    end

    set -lx GIT_EXTERNAL_DIFF 'difft --display=side-by-side-show-both'

    # Find the subcommand, skipping global options and their values.
    set -l i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case -C -c --git-dir --work-tree --namespace --config-env
                set i (math $i + 2)
            case '-*'
                set i (math $i + 1)
            case '*'
                break
        end
    end

    # git diff uses GIT_EXTERNAL_DIFF by default; show and log need --ext-diff.
    if contains -- "$argv[$i]" show log
        set -l rest (math $i + 1)
        command git $argv[1..$i] --ext-diff $argv[$rest..]
    else
        command git $argv
    end
end
