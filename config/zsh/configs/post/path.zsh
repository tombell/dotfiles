GOPATH=$HOME/.go

PATH="/usr/local/sbin:$PATH"
PATH="$HOME/.dotfiles/bin:$PATH"

if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
  PATH="$HOME/.cargo/bin":$PATH
fi

if [[ -d "$HOME/.spicetify" ]]; then
  PATH="$HOME/.spicetify":$PATH
fi

export -U GOPATH PATH
