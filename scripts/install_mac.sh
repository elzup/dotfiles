#!/bin/sh

set -e
set -u

setup(){
    dotfiles=$HOME/dotfiles

    has(){
        type "$1" > /dev/null 2>&1
    }

    symlink(){
    	ln -sf "$1" "$2"
    }

#     if [ -d "$dotfiles" ]; then
#         (cd "$dotfiles" && git pull --rebase)
#     else
#         git clone git@github.com:munisystem/dotfiles "$dotfiles"
#     fi


    symlink "$dotfiles/.vimperatorrc" "$HOME/.vimperatorrc"
    symlink "$dotfiles/.gitconfig" "$HOME/.gitconfig"
    symlink "$dotfiles/.gitignore_local" "$HOME/.gitignore"

    if has zsh; then
        symlink "$dotfiles/.zshrc" "$HOME/.zshrc"
        symlink "$dotfiles/.myzshrc" "$HOME/.myzshrc"
        symlink "$dotfiles/muni.zsh-theme" "$HOME/.oh-my-zsh/themes/muni.zsh-theme"
    fi

    if has vim; then
        symlink "$dotfiles/.vimrc" "$HOME/.vimrc"
        rm -r "$HOME/.vim"
        symlink "$dotfiles/.vim" "$HOME/.vim"
    fi
    
    if has vim; then
      symlink "$dotfiles/.tmux.conf" "$HOME/.tmux.conf"
    fi
}

setup
