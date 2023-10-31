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

all = [personal, work, music]
dev = [personal, work]

hostname = `scutil --get ComputerName`.chomp

if all.include?(hostname)
  brew 'neovim'
  brew 'rcm'
  brew 'skbd'

  cask '1password'
  cask 'stark'
end

if dev.include?(hostname)
  brew 'fzf'
  brew 'git'
  brew 'go'
  brew 'jq'
  brew 'nodenv'
  brew 'rbenv'
  brew 'ripgrep'
  brew 'tombell/formula/tm'
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
  brew 'python@3.12'
  brew 'transmission-cli'

  cask 'doppler'
  cask 'mpv'
  cask 'paragon-ntfs'
  cask 'xld'
end

if hostname == work
  tap 'auth0/auth0-cli'
  tap 'heroku/brew'

  brew 'auth0'
  brew 'heroku'
  brew 'mas'
  brew 'postgresql@15'
  brew 'redis'
  brew 'watchman'

  cask 'android-studio'
  cask 'chromedriver'
  cask 'displaylink'
  cask 'logi-options-plus'
  casl 'postico'
  cask 'rapidapi'
  cask 'slack'
  cask 'zoom'

  mas 'Xcode', id: 497_799_835
end

if hostname == music
  cask 'dupeguru'
  cask 'rekordbox'
end
