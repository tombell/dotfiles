function __jj_prompt_info
    type -q jj; or return

    set -l jj_data (
        jj log \
            --ignore-working-copy \
            --no-graph \
            --color never \
            -r @ \
            -T 'change_id.shortest() ++ "|" ++ change_id.short(4)' \
            2>/dev/null |
        head -n 1
    )

    test -n "$jj_data"; or return

    set -l parts (string split '|' -- "$jj_data")
    set -l shortest $parts[1]
    set -l short4 $parts[2]
    set -l remainder (string replace -- "$shortest" '' "$short4")

    set_color --bold magenta
    printf '%s' "$shortest"

    set_color normal
    set_color 585858
    printf '%s ' "$remainder"

    set_color normal
end

function __git_prompt_info
    type -q git; or return

    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    test -n "$branch"; or return

    set_color magenta
    printf '%s ' "$branch"
    set_color normal
end

function __vcs_prompt_info
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)

    if test -n "$repo_root"; and test -d "$repo_root/.jj"
        __jj_prompt_info
        return
    end

    __git_prompt_info
end

function fish_prompt
    if set -q SSH_CONNECTION; or set -q SSH_CLIENT; or set -q SSH_TTY
        set_color green
        printf '%s@%s ' "$USER" (prompt_hostname)
    end

    set_color yellow

    if test "$PWD" = "$HOME"
        printf '~ '
    else
        printf '%s ' (path basename "$PWD")
    end

    __vcs_prompt_info

    set_color cyan
    printf '%s ' ---

    set_color normal
end
