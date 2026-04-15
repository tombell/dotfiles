GOPATH=$HOME/.local/share/go

PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.local/share/neovim/bin" ]; then
  PATH="$HOME/.local/share/neovim/bin:$PATH"
fi

export -U GOPATH PATH
