# vim: set ft=ruby:

hostname = `scutil --get ComputerName`.chomp

brew "fzf"
brew "neovim", args: ['HEAD']
brew "nodenv"
brew "ripgrep"
brew "starkwm/formulae/skbd"
brew "stylua"
brew "thoughtbot/formulae/rcm"
brew "zsh-autosuggestions"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "homebrew/cask-fonts/font-iosevka-nerd-font"
cask "homebrew/cask-versions/zulu11"
cask "starkwm/formulae/stark"

if ["Pyra", "Poppi"].include?(hostname)
  brew "git"
  brew "go"
  brew "gopls"
  brew "tmux"
  brew "tombell/formulae/ensong"
  brew "tombell/formulae/tm"

  cask "discord"
  cask "google-chrome"
  cask "rapidapi"
  cask "soundsource"
  cask "telegram"
  cask "the-unarchiver"
end

if ["Pyra"].include?(hostname)
  brew "entr"

  cask "mpv"
  cask "paragon-ntfs"
end

if ["Poppi"].include?(hostname)
  brew "auth0/auth0-cli/auth0"
  brew "heroku/brew/heroku"
  brew "postgresql@14"
  brew "redis"
  brew "watchman"

  cask "android-studio"
  cask "chromedriver"
  cask "displaylink"
  cask "logi-options-plus"
  cask "slack"
  cask "visual-studio-code"
  cask "zoom"
end

if ["Brighid"].include?(hostname)
  cask "rekordbox"
end
