print_file () {
  while IFS='' read -r p; do
    echo "$p"
  done < "$1"
}
