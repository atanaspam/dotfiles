#!/bin/bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Launchpad.app"
dockutil --no-restart --add "/System/Cryptexes/App/System/Applications/Safari.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/System/Applications/App Store.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"

killall Dock

# https://macos-defaults.com/

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Week starts on monday
defaults write com.apple.iCal "first day of week" -int 1

# Set Activity Monitor icon to be showing CPU Usage over time
defaults write com.apple.ActivityMonitor "IconType" -int "6"

# Keyboard: How quickly are key presses repeated on initial key hold
defaults write -g InitialKeyRepeat -int 20 # default is 30

# Keyboard: How quickly are key presses repeated on key hold
defaults write -g KeyRepeat -int 2
