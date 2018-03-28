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
}

setup
