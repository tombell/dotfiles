# dotfiles

These are my dotfiles for macOS (and Linux).

## Installation

Install the dotfiles:

    env RCRC=$HOME/.dotfiles/rcrc rcup

## Neovim

`minpac` will need cloning (due to not supporting it as a submodule currently):

    git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

Then it will be possible to install the neovim plugins:

    nvim +PackUpdate
