setopt promptsubst

jj_prompt_info() {
    local jj_data=$(jj log --ignore-working-copy --no-graph --color never -r @ -T '
      change_id.shortest() ++ "|" ++
      change_id.short(4)
    ' 2>/dev/null | head -n 1)

    if [ -n "$jj_data" ]; then
      local -a parts=("${(@s:|:)jj_data}")

      local change_shortest="${parts[1]}"
      local change_short4="${parts[2]}"
      local change_len=${#change_shortest}
      local change_rest="${change_short4:$change_len}"

      echo "%F{magenta}%B${change_shortest}%b%f%F{240}${change_rest}%f "
    fi
}

git_prompt_info() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -n "$current_branch" ]; then
    echo "%F{magenta}$current_branch%f "
  fi
}

vcs_prompt_info() {
  local repo_root=$(git rev-parse --show-toplevel 2> /dev/null)

  if [ -n "$repo_root" ] && [ -d "$repo_root/.jj" ]; then
    jj_prompt_info
    return
  fi

  git_prompt_info
}

PROMPT='%F{yellow}%c $(vcs_prompt_info)%F{cyan}--- %f'
