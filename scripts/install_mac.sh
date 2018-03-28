#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$HOME/dotfiles

  if [ ! -d "$dotfiles" ]; then
      git clone https://github.com/elzup/dotfiles "$dotfiles"
  fi

  symlink() {
    ln -sf "$1" "$2"
  }

  declare -a arr=(".curlrc" ".gitcommit_template" ".gitconfig"
   ".gitignore_global" ".ideavimrc" ".tigrc" ".vimrc" ".zprofile" ".zshrc")
  for filename in "${arr[@]}"
  do
    symlink "$dotfiles/$filename" "$HOME/$filename"
  done

  cp -f "$Brewfile/sync-dotfiles.plist" "$launchd/sync-dotfiles.plist"
  reload "sync-dotfiles.plist"
}

reload(){
  echo "Unload $1"
  launchctl unload ~/Library/LaunchAgents/$1
  echo "Load $1"
  launchctl load ~/Library/LaunchAgents/$1
}

setup
