if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

GOPATH=$HOME/.go
PATH="$GOPATH/bin:$PATH"
PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
PATH="/usr/local/sbin:$PATH"

export -U PATH GOPATH
