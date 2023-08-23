export CLICOLOR=1

export PROJECTS="$HOME/Code"
export GOPATH=$HOME/.local/share/go

export LESSHISTFILE=-

export VISUAL=nvim
export EDITOR=$VISUAL

autoload -U colors
colors

setopt extendedglob
unsetopt nomatch
setopt promptsubst
setopt hist_ignore_all_dups
setopt inc_append_history

HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward

c() { cd "$PROJECTS/$1" }

fpath=(~/.config/zsh/completion /usr/local/share/zsh/site-functions $fpath)

autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending

if [[ -d "/opt/homebrew/bin" ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

export PATH="$HOME/.dotfiles/bin:$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

[[ -f ~/.localrc ]] && source ~/.localrc

if command -v brew >/dev/null; then
  if [[ $(uname -p) == "arm" ]]; then
    source "/opt/homebrew/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  else
    source "/usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

git_prompt_info() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg[blue]%}$current_branch "
  fi
}

PROMPT='%{$fg[green]%}%c $(git_prompt_info)%{$fg[magenta]%} %{$reset_color%}'

alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="$VISUAL"

alias path='echo $PATH | tr -s ":" "\n"'

alias d="cd ~/.dotfiles"

alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"
alias bd="brew leaves | xargs brew deps --formula --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""

alias todo="rg -F 'TODO'"

alias j="npx jest"
alias tc="npx tsc --noEmit"

alias urepo='for d in *; do; (cd $d && pwd && git pull && echo); done'

export HOMEBREW_NO_ENV_HINTS=1
