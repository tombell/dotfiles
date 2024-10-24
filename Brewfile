# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
work = 'Poppi'

hostname = `scutil --get ComputerName`.chomp

tap 'starkwm/formulae'
tap 'thoughtbot/formulae'

brew 'ripgrep'
brew 'starkwm/formulae/skbd'
brew 'thoughtbot/formulae/rcm'
brew 'zsh-autosuggestions'

cask '1password'
cask 'font-iosevka-nerd-font'
cask 'starkwm/formulae/stark@beta'
cask 'wezterm'

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
  # NOTE: using older version, due to ARK crap
  # cask 'soundsource'
  cask 'telegram'
  cask 'the-unarchiver'
  cask 'zulu@17'
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
  cask 'zoom'

  mas 'Xcode', id: 497_799_835
end
