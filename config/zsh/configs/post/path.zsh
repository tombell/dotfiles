export PROJECTS="$HOME/Code"

export GOPATH=$HOME/.local/share/go

export PATH="$HOME/.dotfiles/bin:$GOPATH/bin:$PATH"

if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi
