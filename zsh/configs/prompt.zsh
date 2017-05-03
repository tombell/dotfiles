git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg[magenta]%}$current_branch%{$reset_color%} "
  fi
}
setopt promptsubst
PS1='%{$fg_bold[yellow]%}%c $(git_prompt_info)%{$fg_bold[blue]%}▸%{$reset_color%} '
