GOPATH=$HOME/.local/share/go

PATH="$HOME/.local/bin:$PATH"
PATH="$GOPATH/bin:$PATH"

if [ -d "$HOME/.local/share/neovim/bin" ]; then
  PATH="$HOME/.local/share/neovim/bin:$PATH"
fi

export -U GOPATH PATH
