#!/bin/sh

set -e
set -u

setup() {
  readonly DOTFILES=$HOME/dotfiles
  readonly LAUNCHD=$HOME/Library/LaunchAgents
  readonly PLISTFILE=$DOTFILES/sync.dotfiles.plist

  if [ ! -d "$DOTFILES" ]; then
      git clone https://github.com/elzup/dotfiles "$DOTFILES"
  fi

  symlink() {
    ln -sf "$1" "$2"
  }

  declare -a arr=(".curlrc" ".gitcommit_template" ".gitconfig"
    ".gitignore_global" ".tigrc" ".zprofile" ".zshrc" 
    ".ideavimrc" ".vimrc" ".vsvimrc" ".sshrc")
  for filename in "${arr[@]}"
  do
    symlink "$DOTFILES/$filename" "$HOME/$filename"
  done
  symlink "$DOTFILES/.config/starship.toml" "$HOME/.config/starship.toml"

  # zed/ には prompts の DB や他リポ由来の themes も置かれるので、ディレクトリごとではなくファイル単位で張る
  mkdir -p "$HOME/.config/zed"
  for filename in settings.json keymap.json
  do
    symlink "$DOTFILES/.config/zed/$filename" "$HOME/.config/zed/$filename"
  done

  readonly NEOVIM_PATH=$HOME/.config/nvim
  mkdir -p $NEOVIM_PATH
  symlink "$DOTFILES/.vimrc" "$NEOVIM_PATH/init.vim"
  cp -f "$DOTFILES/$PLISTFILE" "$LAUNCHD/$PLISTFILE"
  reload "$PLISTFILE"
}

reload(){
  echo "Unload $1"
  launchctl unload ~/Library/LaunchAgents/$1
  echo "Load $1"
  launchctl load ~/Library/LaunchAgents/$1
}

setup
