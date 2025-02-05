fpath=(~/.config/zsh/completion /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions $fpath)

for function in ~/.config/zsh/functions/*; do
  source $function
done

# enable extended globbing
setopt extendedglob

# better history handling
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt inc_append_history

# allow [ or ] whereever you want
unsetopt nomatch

setopt promptsubst

HISTSIZE=4096
SAVEHIST=4096

autoload -U colors
colors

autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward

export CLICOLOR=1

export PROJECTS="$HOME/Code"
export GOPATH=$HOME/.local/share/go

export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

export VISUAL=nvim
export EDITOR=$VISUAL

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

[[ -f ~/.localrc ]] && source ~/.localrc

source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]] &&  source "$(brew --prefix asdf)/libexec/asdf.sh"

git_prompt_info() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg[blue]%}$current_branch "
  fi
}

PROMPT='%{$fg[yellow]%}%c $(git_prompt_info)%{$fg[magenta]%} %{$reset_color%}'

alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="nvim"

alias path='echo $PATH | tr -s ":" "\n"'

alias d="cd ~/.dotfiles"

alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"
alias bd="brew leaves | xargs brew deps --formula --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""

alias todo="rg -F 'TODO'"

alias urepo='for d in *; do (cd $d && pwd && git pull && echo); done'
alias brepo='for d in *; do (cd "$d" && pwd && git branch && echo); done'

alias ds='find . -name ".DS_Store" -type f -delete'

alias safe='xattr -r -d com.apple.quarantine'
