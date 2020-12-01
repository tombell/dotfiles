if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

GOPATH=$HOME/.go

PATH="$GOPATH/bin:$PATH"
PATH="./node_modules/.bin:$PATH"

export -U GOPATH PATH
