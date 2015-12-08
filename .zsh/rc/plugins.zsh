
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
autoload -Uz add-zsh-hock

# TDOO
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char
bindkey '^k' insert-last-word

# プロセス名で補完
zstyle ':completion:*:processes' command "ps -u $USER"
zstyle ':chpwd:*' recent-dirs-max 500
function chpwd() { ls }

# sl_tweet
alias sl="ruby ~/.zsh/sl_tweet/sl.rb"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
