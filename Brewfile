# vim: set ft=ruby:
# frozen_string_literal: true

tap 'homebrew/cask-fonts'
tap 'homebrew/cask-versions'
tap 'starkwm/formulae'
tap 'thoughtbot/formulae'
tap 'tombell/formulae'

personal = 'Pyra'
work = 'Poppi'
music = 'Mythra'

ALL = [personal, work, music].freeze
DEV = [personal, work].freeze

hostname = `scutil --get ComputerName`.chomp

if ALL.include?(hostname)
  brew 'rcm'
  brew 'skbd'

  cask '1password'
  cask 'stark'
end

if DEV.include?(hostname)
  brew 'fzf'
  brew 'git'
  brew 'jq'
  brew 'mise'
  brew 'neovim'
  brew 'postgresql@16'
  brew 'redis'
  brew 'ripgrep'
  brew 'tombell/formulae/tm'
  brew 'tmux'
  brew 'zsh-autosuggestions'

  cask 'alacritty'
  cask 'appcleaner'
  cask 'discord'
  cask 'font-iosevka-nerd-font'
  cask 'google-chrome'
  cask 'soundsource'
  cask 'telegram'
  cask 'the-unarchiver'
  cask 'zulu11'
end

if hostname == personal
  brew 'ensong'
  brew 'entr'
  brew 'libusb'
  brew 'python@3.11'
  brew 'transmission-cli'

  # cask 'doppler'
  # cask 'paragon-ntfs'
  cask 'stolendata-mpv'
  cask 'xld'
end

if hostname == work
  tap 'auth0/auth0-cli'
  tap 'heroku/brew'

  brew 'auth0'
  brew 'heroku'
  brew 'mas'
  brew 'watchman'

  cask 'android-studio'
  cask 'chromedriver'
  cask 'displaylink'
  cask 'logi-options-plus'
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
