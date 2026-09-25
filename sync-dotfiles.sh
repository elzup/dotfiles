#!/bin/sh

set -eu

repository=$HOME/dotfiles

cd "$repository"
sh "./scripts/backup_history.sh"
/usr/bin/git add .
# 変更の無い日に commit が exit 1 になり、set -e でジョブ全体が失敗扱いになるのを避ける。
# push は毎回行い、手動コミットの未 push 分も送る
/usr/bin/git diff --cached --quiet || /usr/bin/git commit -m "Update `date "+%Y-%m-%d %H:%M:%S"`"
/usr/bin/git push origin main
osascript -e 'display notification "Finish syncing dotfiles" with title "dotfiles"'
