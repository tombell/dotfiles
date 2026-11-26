status --is-interactive; or return

function __git_each_repo
    argparse --stop-nonopt only-with-output -- $argv; or return
    set -l result 0
    set -l separator ''
    for dir in * .*
        test -d "$dir"; or continue
        test "$dir" = .git; and continue

        set -l git_dir "$dir/.git"
        if not test -e "$git_dir"
            test -f "$dir/HEAD"; or continue
            set git_dir "$dir" # Bare repository
        end
        command git rev-parse --resolve-git-dir "./$git_dir" >/dev/null 2>&1; or continue

        set -l output
        if set -q _flag_only_with_output
            set output (git -C "$dir" $argv 2>&1)
            or set result $status
            set -q output[1]; or continue
        end

        set -l repo (path normalize -- "$PWD/$dir")
        set -l border (string repeat -n (string length --visible -- " $repo ") '─')
        printf '%s╭%s╮\n│ %s │\n╰%s╯\n' "$separator" "$border" "$repo" "$border"
        set separator \n
        if set -q _flag_only_with_output
            printf '%s\n' $output
        else
            git -C "$dir" $argv; or set result $status
        end
    end
    return $result
end

alias gwtall '__git_each_repo worktree list'
alias gball '__git_each_repo branch -a'
alias gpullall '__git_each_repo pull'
alias gstall '__git_each_repo status --short --branch'
alias gfetchall '__git_each_repo fetch --all --prune'
alias gtrackingall '__git_each_repo branch -vv'
alias gstashall '__git_each_repo --only-with-output stash list'
alias gwtpruneall '__git_each_repo --only-with-output worktree prune --dry-run --verbose'
