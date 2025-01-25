# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
work = 'Poppi'

hostname = `scutil --get ComputerName`.chomp

tap 'starkwm/formulae'
tap 'thoughtbot/formulae'

brew 'fd'
brew 'ripgrep'
brew 'starkwm/formulae/skbd'
brew 'thoughtbot/formulae/rcm'
brew 'zsh-autosuggestions'

cask '1password'
cask 'ghostty@tip'
cask 'starkwm/formulae/stark@tip'
cask 'tombell/formulae/font-iosevka-custom'

if [personal, work].include?(hostname)
  tap 'tombell/formulae'

  brew 'asdf'
  brew 'fzf'
  brew 'git'
  brew 'jq'
  brew 'neovim', args: ['HEAD']
  brew 'tmux'
  brew 'tombell/formulae/tm'

  cask 'appcleaner'
  cask 'discord'
  cask 'google-chrome'
  cask 'keyboardcleantool'
  cask 'telegram-desktop'
  cask 'the-unarchiver'
end

if hostname == personal
  brew 'tombell/formulae/ensong'
  brew 'transmission-cli'

  cask 'stolendata-mpv'
  cask 'xld'
end

if hostname == work
  tap 'auth0/auth0-cli'
  tap 'heroku/brew'

  brew 'auth0/auth0-cli/auth0'
  brew 'heroku/brew/heroku'
  brew 'libffi'
  brew 'libpq'
  brew 'libxml2'
  brew 'libyaml'
  brew 'mas'
  brew 'postgresql@16'
  brew 'redis'

  cask 'android-studio'
  cask 'chromedriver'
  cask 'displaylink'
  cask 'postico'
  cask 'rapidapi'
  cask 'slack'
  cask 'soundsource'
  cask 'zoom'
  cask 'zulu@17'

  mas 'Xcode', id: 497_799_835
end
