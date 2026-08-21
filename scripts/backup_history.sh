#!/bin/sh

set -eu

retention_days=30
history_file=${HISTORY_FILE:-"$HOME/.zsh_history"}
backup_root=${BACKUP_ROOT:-"$HOME/Dropbox/backup"}
backup_dir="$backup_root/backup_zsh_history"
archive_dir="$backup_dir/archive"

migrate_legacy_backups() {
  for legacy_path in "$backup_root"/.zsh_history_*; do
    [ -f "$legacy_path" ] || continue
    backup_name=${legacy_path##*/}
    destination="$backup_dir/$backup_name"

    # Preserve both files if a previous migration left a conflicting backup.
    [ -e "$destination" ] || mv "$legacy_path" "$destination"
  done
}

prune_history_backups() {
  retention_offset=$((retention_days - 1))
  cutoff_date=$(date -v-"${retention_offset}"d "+%Y%m%d")

  for backup_path in "$backup_dir"/.zsh_history_*; do
    [ -f "$backup_path" ] || continue
    backup_date=${backup_path##*_}

    case "$backup_date" in
      [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]) ;;
      *) continue ;;
    esac

    day=${backup_date#??????}
    [ "$backup_date" -lt "$cutoff_date" ] || continue

    if [ "$day" = "01" ]; then
      backup_name=${backup_path##*/}
      archive_path="$archive_dir/$backup_name"
      [ -e "$archive_path" ] || mv "$backup_path" "$archive_path"
    else
      rm -- "$backup_path"
    fi
  done
}

today=$(date "+%Y%m%d")
mkdir -p "$backup_dir" "$archive_dir"
migrate_legacy_backups
cp "$history_file" "$backup_dir/.zsh_history_$today"
prune_history_backups
