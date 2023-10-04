# vim: set ft=ruby:

hostname = `scutil --get ComputerName`.chomp
personal = "Pyra"
work = "Poppi"
dj = "Mythra"
both = [personal, work]

tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "starkwm/formulae"
tap "thoughtbot/formulae"
tap "tombell/formulae"

if both.include?(hostname)
  brew "fzf"
  brew "git"
  brew "go"
  brew "gopls"
  brew "neovim"
  brew "nodenv"
  brew "rcm"
  brew "ripgrep"
  brew "skbd"
  brew "stylua"
  brew "tm"
  brew "tmux"
  brew "zsh-autosuggestions"

  cask "1password"
  cask "alacritty"
  cask "appcleaner"
  cask "discord"
  cask "font-iosevka-nerd-font"
  cask "google-chrome"
  cask "soundsource"
  cask "stark"
  cask "telegram"
  cask "the-unarchiver"
  cask "zulu11"
end

if hostname == personal
  brew "entr"
  brew "ensong"

  cask "mpv"
  cask "paragon-ntfs"
end

if hostname == work
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
