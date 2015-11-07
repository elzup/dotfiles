
# vim bind normalmode extends emacskey
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# bindkey "^P" history-beginning-search-backward-end
# bindkey "^N" history-beginning-search-forward-end
bindkey "^U" backward-kill-line
# bindkey "^F" emacs-forward-word
# bindkey "^B" emacs-back-word
bindkey "^F" forward-char
bindkey "^B" backward-char
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

