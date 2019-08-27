PATH="./node_modules/.bin:$PATH"

if command -v rbenv >/dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init - --no-rehash)"
fi

ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

GOPATH=$HOME/.go
PATH="$GOPATH/bin:$HOME/Library/Android/sdk/platform-tools:$PATH:"

export -U PATH GOPATH ANDROID_SDK_ROOT
