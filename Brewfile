# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
music = 'Brighid'
work = 'Poppi'

hostname = `scutil --get ComputerName`.chomp

tap 'starkwm/formulae'
tap 'tombell/formulae'

brew 'fd'
brew 'rcm'
brew 'ripgrep'
brew 'starkwm/formulae/skbd'
brew 'zsh-autosuggestions'

cask '1password'
cask 'appcleaner'
cask 'ghostty'
cask 'google-chrome'
cask 'itsycal'
cask 'keka'
cask 'keyboardcleantool'
cask 'starkwm/formulae/stark@tip'
cask 'tombell/formulae/font-iosevka-custom'

if [personal, work].include?(hostname)
  brew 'fzf'
  brew 'git'
  brew 'jq'
  brew 'libyaml'
  brew 'mise'
  brew 'tmux'
  brew 'tombell/formulae/tm'

  cask 'discord'
  cask 'karabiner-elements'
  cask 'telegram'
end

if hostname == personal
  brew 'transmission-cli'

  # NOTE: download site not working
  # cask 'stolendata-mpv'
end

if hostname == work
  tap 'auth0/auth0-cli'
  tap 'heroku/brew'

  brew 'auth0/auth0-cli/auth0'
  brew 'heroku/brew/heroku'
  brew 'libffi'
  brew 'libpq'
  brew 'libxml2'
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
