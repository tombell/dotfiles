# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
music = 'Brighid'
work = 'Poppi'

hostname = `scutil --get ComputerName`.chomp

tap 'starkwm/formulae'
tap 'tombell/formulae'

brew 'rcm'
brew 'starkwm/formulae/skbd'
brew 'zsh-autosuggestions'

cask '1password'
cask 'appcleaner'
cask 'ghostty'
cask 'google-chrome'
cask 'keka'
cask 'keyboardcleantool'
cask 'starkwm/formulae/stark@tip'
cask 'tombell/formulae/font-iosevka-custom'

if [personal, work].include?(hostname)
  brew 'fd'
  brew 'fzf'
  brew 'git'
  brew 'jq'
  brew 'libyaml'
  brew 'mas'
  brew 'mise'
  brew 'neovim'
  brew 'ripgrep'
  brew 'tmux'
  brew 'tombell/formulae/tmux-manager'

  cask 'discord'
  cask 'itsycal'
  cask 'karabiner-elements'
  cask 'spotify'
  cask 'telegram'

  mas 'Xcode', id: 497_799_835
end

if hostname == personal
  brew 'transmission-cli'

  cask 'stolendata-mpv'
end

if hostname == music
  cask 'rekordbox'
end

if hostname == work
  tap 'auth0/auth0-cli'
  tap 'heroku/brew'

  brew 'auth0/auth0-cli/auth0'
  brew 'git-lfs'
  brew 'heroku/brew/heroku'
  brew 'libffi'
  brew 'libpq'
  brew 'libxml2'
  brew 'postgresql@16'
  brew 'redis'

  cask 'android-studio'
  cask 'chromedriver'
  cask 'postico'
  cask 'rapidapi'
  cask 'slack'
  cask 'soundsource'
  cask 'zulu@17'
end
