# vim: set ft=ruby:
# frozen_string_literal: true

personal = 'Pyra'
work = 'Poppi'
music = 'Mythra'

ALL = [personal, work, music].freeze
DEV = [personal, work].freeze
WOW = [work].freeze
STREAM = [work].freeze

hostname = `scutil --get ComputerName`.chomp

if ALL.include?(hostname)
  brew 'thoughtbot/formulae/rcm'
  brew 'starkwm/formulae/skbd'

  cask '1password@nightly'
  cask 'starkwm/formulae/stark@beta'
end

if DEV.include?(hostname)
  brew 'asdf'
  brew 'fzf'
  brew 'git'
  brew 'jq'
  brew 'neovim', args: ['HEAD']
  brew 'postgresql@16'
  brew 'redis'
  brew 'ripgrep'
  brew 'tmux'
  brew 'tombell/formulae/tm'
  brew 'zsh-autosuggestions'

  cask 'alacritty'
  cask 'appcleaner'
  cask 'discord'
  cask 'font-iosevka-nerd-font'
  cask 'google-chrome'
  cask 'keyboardcleantool'
  cask 'soundsource'
  cask 'telegram'
  cask 'the-unarchiver'
  cask 'zulu@11'
end

if WOW.include?(hostname)
  cask 'battle-net'
  cask 'curseforge'
  cask 'weakauras-companion'
end

if STREAM.include?(hostname)
  cask 'obs'
end

if hostname == personal
  brew 'entr'
  brew 'libusb'
  brew 'tombell/formulae/ensong'
  brew 'transmission-cli'

  cask 'stolendata-mpv'
  cask 'xld'
end

if hostname == work
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
  cask 'dupeguru'
  cask 'rekordbox'
end
