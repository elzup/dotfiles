#!/bin/sh

set -e
set -u

repository=$HOME/dotfiles

cd "$repository"
/usr/bin/git add .
/usr/bin/git commit -m "Update `date "+%Y-%m-%d %H:%M:%S"`"
/usr/bin/git push origin master
osascript -e 'display notification "Finish syncing dotfiles" with title "dotfiles"'
