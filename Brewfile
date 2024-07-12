# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
work = 'Poppi'
music = 'Mythra'

hostname = `scutil --get ComputerName`.chomp

brew 'ripgrep'
brew 'starkwm/formulae/skbd'
brew 'thoughtbot/formulae/rcm'
brew 'zsh-autosuggestions'

cask '1password'
cask 'alacritty'
cask 'font-iosevka-nerd-font'
cask 'starkwm/formulae/stark@beta'

if [personal, work].include?(hostname)
  tap 'tombell/formulae'

  brew 'asdf'
  brew 'fzf'
  brew 'gh'
  brew 'git'
  brew 'jq'
  brew 'neovim', args: ['HEAD']
  brew 'postgresql@16'
  brew 'redis'
  brew 'tmux'
  brew 'tombell/formulae/tm'

  cask 'appcleaner'
  cask 'discord'
  cask 'google-chrome'
  cask 'keyboardcleantool'
  cask 'soundsource'
  cask 'telegram'
  cask 'the-unarchiver'
  cask 'zulu@11'
end

if hostname == personal
  brew 'entr'
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

  cask 'android-studio'
  cask 'chromedriver'
  cask 'displaylink'
  cask 'postico'
  cask 'rapidapi'
  cask 'slack'
  cask 'zoom'

  mas 'Xcode', id: 497_799_835
end

if hostname == music
  cask 'rekordbox'
end
