# vim: set ft=ruby:

hostname = `scutil --get ComputerName`.chomp

tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "starkwm/formulae"
tap "thoughtbot/formulae"
tap "tombell/formulae"

brew "fzf"
brew "neovim"
brew "rcm"
brew "ripgrep"
brew "skbd"
brew "zsh-autosuggestions"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "font-iosevka-nerd-font"
cask "stark"

if ["Pyra", "Poppi"].include?(hostname)
  brew "git"
  brew "go"
  brew "gopls"
  brew "nodenv"
  brew "stylua"
  brew "tm"
  brew "tmux"

  cask "discord"
  cask "google-chrome"
  cask "soundsource"
  cask "telegram"
  cask "the-unarchiver"
  cask "zulu11"
end

if ["Pyra"].include?(hostname)
  brew "entr"
  brew "ensong"

  cask "mpv"
  cask "paragon-ntfs"
end

if ["Poppi"].include?(hostname)
  tap "auth0/auth0-cli"
  tap "heroku/brew"

  brew "auth0"
  brew "heroku"
  brew "postgresql@14"
  brew "redis"
  brew "watchman"

  cask "android-studio"
  cask "chromedriver"
  cask "displaylink"
  cask "logi-options-plus"
  cask "rapidapi"
  cask "slack"
  cask "visual-studio-code"
  cask "zoom"
end
