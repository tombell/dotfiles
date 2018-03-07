# dotfiles

UNIX dotfiles for various tools I use. Inspired by [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

## Installation

These dotfiles are managed by `rcm` from thoughtbot:

    brew tap thoughtbot/formulae
    brew install rcm

Clone the repository from GitHub:

    git clone git@github.com:tombell/dotfiles.git ~/.dotfiles

Install the dotfiles:

    env RCRC=$HOME/.dotfiles/rcrc rcup

Everything will get symlinked into place, ready to use.
