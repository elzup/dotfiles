# {{{ zplug
source ~/.zplug/init.zsh

zplug "mollifier/anyframe"
zplug "zsh-users/zsh-autosuggestions", nice:10

# }}}

# {{{ basic
# mode -e emacs, -v vim
bindkey -e
## bindkey -v

autoload -Uz compinit promptinit

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
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# .zsh_hisotry の上限
export SAVEHIST=100000
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
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

# プロセス名で補完
zstyle ':completion:*:processes' command "ps -u $USER"
zstyle ':chpwd:*' recent-dirs-max 500
function chpwd() { ls }

# sl_tweet
alias sl="ruby ~/.zsh/sl_tweet/sl.rb"

# }}}
# {{{ bind
bindkey "^U" backward-kill-line
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char
bindkey '^k' insert-last-word

# }}}
# {{{ source plugins, helpers
#  {{{ enhancd
export ENHANCD_COMMAND=cdd
if [ -f ~/enhancd/enhancd.sh ]; then
    source ~/enhancd/enhancd.sh
fi

#  }}}
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
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
alias lope='percol-search-locate'

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

function git() { hub "$@" }
eval "$(hub alias -s)"

#  }}}
#  {{{ print
print_file () {
  while IFS='' read -r p; do
    echo "$p"
  done < "$1"
}
#  }}}

# }}}
# {{{ alias
#  {{{ overwrap options alias
alias ls="ls -F --color=auto -v -alh"	#ディレクトリには/, 色つき, 番号順
alias la="ls -a"				#隠しファイルも
alias ll="ls -lh"				#詳細付き, ファイルサイズに接頭語
alias lla="ls -lha"				#全部詳細

alias mv="mv -i"

#cp
alias cp="cp -i"	#上書きを確認

#exit
alias eixt="exit"

#grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias GREP_OPTIONS=""

alias ln="ln -i -v"
alias cdr="anyframe-widget-cdr"

#  }}} - overwrap options alias
#  {{{ usefuls
# gnome-open
alias gopen="gnome-open"

alias python="python3"
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

# ping
alias pingoogle="ping -c 3 www.google.com"
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

# get screen resolution 解像度
alias screensize="xdpyinfo | grep 'dimensions' | egrep -o '[0-9]+x[0-9]+' | head -1"
alias firefoxp="firefox -P answer --new-instance"

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
# source mac zshrc
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

# added by travis gem
[ -f /Users/hiro/.travis/travis.sh ] && source /Users/hiro/.travis/travis.sh

autoload -U promptinit && promptinit
prompt pure

random_saying
