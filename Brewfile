# vim: set ft=ruby:

hostname = `scutil --get ComputerName`.chomp

tap "homebrew/cask-fonts"
tap "starkwm/formulae"
tap "thoughtbot/formulae"

brew "fzf"
brew "neovim", args: ['HEAD']
brew "nodenv"
brew "rcm"
brew "ripgrep"
brew "skbd"
brew "stylua"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "font-caskaydia-cove-nerd-font"
cask "font-iosevka-nerd-font"
cask "stark"

if ["Pyra"].include?(hostname)
  brew "amfora"
  brew "ensong"
  brew "entr"

  cask "mpv"
  cask "paragon-ntfs"
end

if ["Poppi"].include?(hostname)
  tap "heroku/brew"
  tap "homebrew/cask-drivers"

  brew "git-lfs"
  brew "heroku"
  brew "rbenv"
  brew "rbenv-gemset"
  brew "redis"
  brew "watchman"

  cask "android-studio"
  cask "chromedriver"
  cask "logi-options-plus"
  cask "slack"
  cask "visual-studio-code"
  cask "zoom"
  cask "zulu11"
end

if ["Pyra", "Poppi"].include?(hostname)
  tap "tombell/formulae"

  brew "git"
  brew "go"
  brew "gopls"
  brew "postgresql@14"
  brew "tm"
  brew "tmux"

  cask "discord"
  cask "google-chrome"
  cask "rapidapi"
  cask "soundsource"
  cask "telegram"
  cask "the-unarchiver"
end

if ["Brighid"].include?(hostname)
  cask "rekordbox"
end
