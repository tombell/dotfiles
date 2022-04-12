git_prompt_info() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg[blue]%}⸤$current_branch⸣ "
  fi
}

setopt promptsubst

PROMPT='%{$fg[green]%}%c $(git_prompt_info)%{$fg[magenta]%}▶ %{$reset_color%}'
