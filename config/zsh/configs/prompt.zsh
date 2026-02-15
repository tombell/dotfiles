setopt promptsubst

vcs_prompt_info() {
  local repo_root=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$repo_root" ] && [ -d "$repo_root/.jj" ]; then
    local jj_id=$(jj log --no-graph -r @ -T 'self.change_id().shortest(3)' 2> /dev/null)
    if [ -n "$jj_id" ]; then
      echo "%{$fg[cyan]%}$jj_id%{$reset_color%} "
      return
    fi
  fi
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ -n "$current_branch" ]; then
    echo "%{$fg[blue]%}$current_branch%{$reset_color%} "
  fi
}

PROMPT='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m "}%{$fg[yellow]%}%c $(vcs_prompt_info)%{$fg[magenta]%}--- %{$reset_color%}'
