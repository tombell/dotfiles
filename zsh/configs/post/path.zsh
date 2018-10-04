PATH="/usr/local/opt/curl/bin:$PATH"
PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
PATH="/usr/local/opt/openssl/bin:$PATH"
PATH="/usr/local/opt/sqlite/bin:$PATH"

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# load nodenv if available
if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

GOPATH=$HOME/.go

PATH="$GOPATH/bin:/usr/local/opt/go/libexec/bin:$PATH"

export -U PATH GOPATH
