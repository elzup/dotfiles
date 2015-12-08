functoin ctagsin() {
    help() {
        echo 'ctagsin help'
        echo 'Usage: ctagsin [name]'
        echo ' ->sudo ctags -a -R {options} ./'
        return
    }
    case $1 in
        -h|-help)
            help
            return
            ;;
        php)
            ctags -a -R --langmap=PHP:.php.inc --php-types=c+f ./
            return
            ;;
    esac
}

_ctagsincmd() {
  _arguments \
    '(- *)'{-h,--help}'[show help]' \
    '*: :->modes'

  case $state in
    modes)
      _values \
      'to' \
      'php[php project]'
    ;;
  esac
}

compdef _ctagsincmd ctagsin

