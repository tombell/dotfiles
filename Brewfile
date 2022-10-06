# vim: set ft=ruby:

brew "fzf"
brew "git"
brew "go"
brew "gopls"
brew "neovim", args: ['HEAD']
brew "nodenv"
brew "rbenv"
brew "rbenv-gemset"
brew "ripgrep"
brew "starkwm/formulae/skbd"
brew "stylua"
brew "thoughtbot/formulae/rcm"
brew "tmux"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "discord"
cask "google-chrome"
cask "homebrew/cask-drivers/logi-options-plus"
cask "homebrew/cask-fonts/font-iosevka-ss08"
cask "mpv"
cask "paragon-ntfs"
cask "qmk-toolbox"
cask "soundsource"
cask "starkwm/formulae/stark"
cask "telegram"
cask "the-unarchiver"

if File.exist? "/tmp/work"
  brew "git-lfs"
  brew "heroku/brew/heroku"
  brew "postgresql@14"
  brew "redis"

  cask "chromedriver"
  cask "paw"
  cask "slack"
  cask "visual-studio-code"
  cask "zoom"
end

if File.exists? "/tmp/work-mobile"
  brew "watchman"

  cask "adoptopenjdk8"
  cask "android-studio"
end
