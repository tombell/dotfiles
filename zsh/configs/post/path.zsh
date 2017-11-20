# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# load nodenv if available
if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

GOPATH=$PROJECTS/go

PATH="$GOPATH/bin:$PATH"

export -U PATH GOPATH
