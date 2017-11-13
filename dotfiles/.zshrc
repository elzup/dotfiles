# {{{ basic
# mode -e emacs, -v vim
bindkey -e
## bindkey -v

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

# User configuration

# 単語消去で"消す"文字
export WORDCHARS='*?_-.[]~=&;!#$$&^(){}<>'
## =command を command のパス名に展開する
setopt equals

export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

autoload -U compinit
compinit
#  {{{ completion
fpath=(~/zsh_plugins/zsh-completions/src $fpath)

#  }}}
#
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:processes' command "ps -u $USER"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.png' '*.jpg' '*.jpeg' '*.pdf'
zstyle ':completion:*:*:gvim:*:*files' ignored-patterns '*.png' '*.jpg' '*.jpeg' '*.pdf'

zstyle ':chpwd:*' recent-dirs-max 500
function chpwd() { ls }


# .zsh_hisotry の上限
export SAVEHIST=100000
export HISTSIZE=100000
export HISTFILE=~/.zsh_history
setopt share_history
setopt extended_history

setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない

# }}}
# {{{ plugins
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# sl_tweet
alias sl="ruby ~/.zsh/sl_tweet/sl.rb"

# auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax hilight
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-notify
#  source ~/.ghq/github.com/marzocchi/zsh-notify/notify.plugin.zsh
#  zstyle ':notify:*' error-sound "Glass"
#  zstyle ':notify:*' success-sound "default"
#  zstyle ':notify:*' command-complete-timeout 3

## [](#installation)

# }}}
# {{{ bind
bindkey "^U" backward-kill-line
bindkey '^]f'   vi-find-next-char
bindkey '^]b' vi-find-prev-char
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^k' insert-last-word

# }}}
# {{{ hello
# FLAG_KYOKO_KYOKO_TOSHINO
# }}}
# {{{ plugins, helpers
#  {{{ pecol
function percol-search-document() {
    if [ $# -ge 1 ]; then
        DOCUMENT_DIR=$*
    else
        DOCUMENT_DIR=($HOME/Dropbox)
        if [ -d $HOME/Documents ]; then
            DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
        fi
    fi
    SELECTED_FILE=$(echo $DOCUMENT_DIR | \
        xargs find | \
        grep -E "\.(txt|md|pdf|key|numbers|pages|doc|xls|ppt)$" | \
        percol --match-method migemo)
    if [ $? -eq 0 ]; then
        echo $SELECTED_FILE | sed 's/ /\\ /g'
    fi
}
alias pd='percol-search-document'

# history search with percol
function exists { which $1 &> /dev/null }
if exists peco; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi



#  }}}
#  {{{ background
case ${OSTYPE} in
    darwin*)
        background() {
            bg=$1
            if [ ${bg%%:*} = "http" ] ; then ;
                filename=${${bg:t}%\?*}
                wget $bg -O ~/Pictures/tmpbg/$filename
                bg=~/Pictures/tmpbg/$filename
                ;fi
            osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$bg\""
        }
        ;;
    *)
        alias background="display -window root -resize \`screensize\`"
        ;;
esac

#  }}}
#  {{{ git
function myline() {
    git ls-files | xargs -n1 git --no-pager blame -f -w|grep $1 | wc -l
}

#  }}}
#  {{{ print
print_file () {
  while IFS='' read -r p; do
    echo "$p"
  done < "$1"
}
#  }}}
# anyframe {{{
fpath=(/usr/local/opt/zplug/repos/mollifier/anyframe(N-/) $fpath)

autoload -Uz anyframe-init
anyframe-init

# }}}
# {{{ wine
alias typewell="wine ~/.wine/drive_c/Program\ Files/typewell/TWellJR.exe"
alias typewellk="wine ~/.wine/drive_c/Program\ Files/typewell/TWellJK.exe"
alias typewelle="wine ~/.wine/drive_c/Program\ Files/typewell/TWellEW.exe"

# }}}
#  {{{ ghq
#
function cdg () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

#  }}}
#  {{{ peco-ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

#  }}}
#  {{{ pyenv
#
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#  }}}
# }}}

# {{{ alias
#  {{{ overwrap options alias
# alias ls="ls -F --color=auto -v -alh"	#ディレクトリには/, 色つき, 番号順
alias lsa="ls -a"				#隠しファイルも
alias lsl="ls -lh"				#詳細付き, ファイルサイズに接頭語
alias lsa="ls -lha"				#全部詳細
alias lst="ls -lhta"				#詳細付き, ファイルサイズに接頭語

alias mv="mv -i"
alias rm="rmtrash"

#cp
alias cp="cp -i"	#上書きを確認

#grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias GREP_OPTIONS=""

alias ln="ln -i -v"
alias cdr="anyframe-widget-cdr"

#  }}} - overwrap options alias
#  {{{ usefuls

alias reload="source ~/.zshrc"

# extra cd
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

alias rsync-e="rsync -rtvpl --exclude-from=.rsyncignore"
alias rsync-n="rsync -nrtvpl"
alias rsync-en="rsync -nrtvpl --exclude-from=.rsyncignore"

# gnome-open
alias gopen="gnome-open"

alias python="python3"
alias ipython="ipython3"
alias pip="pip3"
alias htop="sudo htop"

alias unzipjar="jar xvf"
alias xmod="xmodmap ~/.Xmodmap"
alias shutdown="sudo shutdown"
alias yaourt="yaourt --noconfirm"

alias dc="docker-compose"

# lang change
alias lange="LANG=C"
alias langj="LANG=ja_JP.UTF-8"

# rails
# alias rails="./bin/rails"
alias rake="./bin/rake"

alias tig="tig --all"

# ping
alias pingoogle="ping -c 3 www.google.com"
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

alias m='vim ~/memos/memo.md'

# get screen resolution 解像度
# 格言一つ発射
alias random_saying="cat ~/memos/saying.txt | gshuf -n 1"
alias saying="python ~/memos/random_say.py"
alias screensize="xdpyinfo | grep 'dimensions' | egrep -o '[0-9]+x[0-9]+' | head -1"
alias firefoxp="firefox -P answer --new-instance"

alias intellij="open -a IntelliJ\ IDEA"
alias vscode="open -a Visual\ Studio\ Code"
alias rubymine="open -a RubyMine"
alias webstorm="open -a WebStorm"


# react native
alias rn="react-native"
#  }}} - usefuls
#  {{{ extensions
alias -s c=vim
alias -s C=vim
alias -s cpp=vim
alias -s h=vim
alias -s html=vim
alias -s java=vim
alias -s rb=ruby
alias -s py=python
alias -s txt=vim
alias -s xhtml=vim
alias -s xml=vim
alias -s zip=zipinfo

alias -s php=php

alias -s ino=arduino

alias -s png=eog
alias -s jpg=eog
alias -s jpeg=eog
alias -s gif=eog
alias -s bmp=eog
#wines
alias -s exe=wine

alias -s asta=astah

#  }}} - extensions
#  {{{ end pipe
# char alias
alias -g G="| grep"
alias -g C='| xsel --input --clipboard'
alias -g P='| percol'
alias -g X='| xargs'
alias -g PX='| peco | xargs'

alias alert="osascript -e 'display notification \"🕐 get work!\" with title \"Command Finish!\"' -e 'beep 2'"
alias -g A="&& osascript -e 'display notification \"🕐 get work!\" with title \"Command Finish!\"' -e 'beep 2'"

#stdoutをクリップボードへ
alias -g toclip=" | xsel -bi"
#stdout+stderrをクリップボードへ
alias -g toclipall=" 2>&1 | xsel -bi"
#stdoutをクリップボードとstdoutへ
alias -g andclip=" | (cat 1>&2 | xsel -bi) 2>&1"
#stdout+stderrをクリップボードとstdoutへ
alias -g andclipall=" 2>&1 | (cat 1>&2 | xsel -bi) 2>&1"

#  }}} end pipe

# }}}
# {{{ mac
if echo $OSTYPE | grep -q darwin; then
    alias ls="ls -alh -G"
    alias -g C='| pbcopy'

    alias gvim="mvim"

    path=(/Applications/ ~/bin(N-/) /usr/local/bin(N-/) ${path})
    # path=(/Applications/MacVim.app/Contents/MacOS ~/bin(N-/) /usr/local/bin(N-/) ${path})

    alias firefox="open -a Firefox"
    alias firefoxp='/Applications/Firefox.app/Contents/MacOS/firefox-bin -P "answer" &'
    alias safari="open -a Safari"
    alias prev="open -a Preview"
    alias finder="open -a Finder"
    alias chrome="open -a Google\ Chrome"
fi

# }}}
# {{{ Trap
# alias vim="imagesnap -q ~/Pictures/zainin/camera_\`date +%Y-%m-%d_%H%M%S\`.jpg && vim"
# alias alias="imagesnap -q ~/Pictures/zcamera_\`date +%Y-%m-%d_%H%M%S\`.jpg && alias"

# }}}
# {{{ pure-prompt
autoload -U promptinit && promptinit
prompt pure

# }}}
# {{{ start printing
random_saying

# }}}
# {{{ zbell
#
# # thanks https://gist.github.com/jpouellet/5278239
# # This script prints a bell character when a command finishes
# # if it has been running for longer than $zbell_duration seconds.
# # If there are programs that you know run long that you don't
# # want to bell after, then add them to $zbell_ignore.
# #
# # This script uses only zsh builtins so its fast, there's no needless
# # forking, and its only dependency is zsh and its standard modules
# #
# # Written by Jean-Philippe Ouellet <jpo@vt.edu>
# # Made available under the ISC license.
# 
# # only do this if we're in an interactive shell
# [[ -o interactive ]] || return
# 
# # get $EPOCHSECONDS. builtins are faster than date(1)
# zmodload zsh/datetime || return
# 
# # make sure we can register hooks
# autoload -Uz add-zsh-hook || return
# 
# # initialize zbell_duration if not set
# (( ${+zbell_duration} )) || zbell_duration=15
# 
# # initialize zbell_ignore if not set
# (( ${+zbell_ignore} )) || zbell_ignore=($EDITOR $PAGER)
# 
# # initialize it because otherwise we compare a date and an empty string
# # the first time we see the prompt. it's fine to have lastcmd empty on the
# # initial run because it evaluates to an empty string, and splitting an
# # empty string just results in an empty array.
# zbell_timestamp=$EPOCHSECONDS
# 
# # right before we begin to execute something, store the time it started at
# zbell_begin() {
# 	zbell_timestamp=$EPOCHSECONDS
# 	zbell_lastcmd=$1
# }
# 
# # when it finishes, if it's been running longer than $zbell_duration,
# # and we dont have an ignored command in the line, then print a bell.
# zbell_end() {
# 	ran_long=$(( $EPOCHSECONDS - $zbell_timestamp >= $zbell_duration ))
# 
# 	has_ignored_cmd=0
# 	for cmd in ${(s:;:)zbell_lastcmd//|/;}; do
# 		words=(${(z)cmd})
# 		util=${words[1]}
# 		if (( ${zbell_ignore[(i)$util]} <= ${#zbell_ignore} )); then
# 			has_ignored_cmd=1
# 			break
# 		fi
# 	done
# 
# 	if (( ! $has_ignored_cmd )) && (( ran_long )); then
# 		say "done!"
# 	fi
# }
# 
# # register the functions as hooks
# add-zsh-hook preexec zbell_begin
# add-zsh-hook precmd zbell_end
# }}}
# {{{ bench mark
# zsh zshrc bentch mark
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
# }}}
