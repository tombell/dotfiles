# vim: set ft=ruby:

tap "homebrew/cask-drivers"
tap "homebrew/cask-fonts"
tap "starkwm/formulae"
tap "thoughtbot/formulae"
tap "tombell/formulae"

brew "amfora"
brew "entr"
brew "fzf"
brew "git"
brew "go"
brew "gopls"
brew "neovim", args: ['HEAD']
brew "nodenv"
brew "postgresql@14"
brew "rbenv"
brew "rbenv-gemset"
brew "rcm"
brew "ripgrep"
brew "skbd"
brew "stylua"
brew "tmux"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "discord"
cask "doppler"
cask "font-iosevka-nerd-font"
cask "google-chrome"
cask "logi-options-plus"
cask "mpv"
cask "paragon-ntfs"
cask "rapidapi"
cask "soundsource"
cask "stark"
cask "telegram"
cask "the-unarchiver"

if File.exist? "/tmp/work"
  tap "heroku/brew"

  brew "git-lfs"
  brew "heroku"
  brew "postgresql@14"
  brew "redis"

  cask "chromedriver"
  cask "rapidapi"
  cask "slack"
  cask "visual-studio-code"
  cask "zoom"
end

if File.exists? "/tmp/work-mobile"
  brew "watchman"

  cask "adoptopenjdk8"
  cask "android-studio"
end
