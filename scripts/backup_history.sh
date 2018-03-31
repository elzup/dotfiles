#!/bin/sh

set -eu
today=$(date "+%Y%m%d")
backupdir=$HOME/Dropbox/backup
mkdir -p $backupdir
cp $HOME/.zsh_history $backupdir/.zsh_history_${today}
