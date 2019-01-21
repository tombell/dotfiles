PATH="/usr/local/opt/openssl/bin:$PATH"

if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

GOPATH=$HOME/.go

PATH="$GOPATH/bin:/usr/local/opt/go/libexec/bin:$PATH"

export -U PATH GOPATH
