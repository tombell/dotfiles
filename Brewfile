# vim: set ft=ruby:

hostname = `scutil --get ComputerName`.chomp

tap "homebrew/cask-fonts"
tap "starkwm/formulae"
tap "thoughtbot/formulae"
tap "tombell/formulae"

brew "fzf"
brew "neovim", args: ['HEAD']
brew "nodenv"
brew "rcm"
brew "ripgrep"
brew "starkwm/formulae/skbd"
brew "stylua"
brew "zsh-autosuggestions"

cask "1password"
cask "alacritty"
cask "appcleaner"
cask "font-iosevka-nerd-font"
cask "raycast"
cask "starkwm/formulae/stark"

if ["Pyra"].include?(hostname)
  brew "entr"
  brew "git"
  brew "go"
  brew "gopls"
  brew "postgresql@14"
  brew "tmux"
  brew "tombell/formulae/ensong"
  brew "tombell/formulae/tm"

  cask "discord"
  cask "google-chrome"
  cask "mpv"
  cask "paragon-ntfs"
  cask "rapidapi"
  cask "soundsource"
  cask "telegram"
  cask "the-unarchiver"
end

if ["Brighid"].include?(hostname)
  cask "rekordbox"
end
