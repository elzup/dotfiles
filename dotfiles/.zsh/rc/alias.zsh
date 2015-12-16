# {{{ overwrap options alias
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
#
alias GREP_OPTIONS=""

alias ln="ln -i -v"
#
# }}} - overwrap options alias
# {{{ usefuls
# gnome-open
alias gopen="gnome-open"

alias python="python3"
alias pip="pip3"
alias htop="sudo htop"

alias unzipjar="jar xvf"
alias xmod="xmodmap ~/.Xmodmap"
alias shutdown="sudo shutdown"
alias yaourt="yaourt --noconfirm"

# lang change
alias lange="LANG=C"
alias langj="LANG=ja_JP.UTF-8"

# rails
# alias rails="./bin/rails"
alias rake="./bin/rake"

# ping
alias pingoogle="ping -c 3 www.google.com"

# get screen resolution 解像度
alias screensize="xdpyinfo | grep 'dimensions' | egrep -o '[0-9]+x[0-9]+' | head -1"
alias firefoxp="firefox -P answer --new-instance"

# }}} - usefuls
# {{{ extensions
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
# }}} - extensions
# {{{ end pipe
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

# }}} end pipe
