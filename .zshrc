bindkey -e

autoload -U compinit promptinit
# {{{ GENERAL
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
# }}}
# {{{ OPTION
setopt no_beep
setopt auto_cd
alias ...='cd ../..'
alias ....='cd ../../..'
promptinit

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
# setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

setopt pushd_ignore_dups
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space

export

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*sudo:*' command-path /usr/local/bin /usr/bin /sbin /bin
zstyle ':completion:*' list-colors $$${(s.:.)LS_COLORS}

WORDCHARS='*?_-.[]~=&;!#$$&^(){}<>'

# {{{ THEME
ZSH_THEME="powerline"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_HIDE_GIT_PROMPT_STATUS="true"
POWERLINE_SHOW_GIT_ON_RIGHT="true"

# }}}

#}}}
# {{{ PROMPT
# colors
local BLACK=$'%{\e[1;30m%}'
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local PURPLE=$'%{\e[1;35m%}'
local LIGHTBLUE=$'%{\e[1;36m%}'
local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$'%{\e[1;m%}'
#	%n	ユーザー名
#	%M	コンピュータ名
#	%c	カレントディレクトリ
PROMPT=$DEFAULT"%n@%M:"$BLUE"%c"$DEFAULT"$ "
PROMPT2="%_$ "
SPROMPT="%r is correct? [n,y,a,e]: " 
RPROMPT=$DEFAULT"["$GREEN"%*"$DEFAULT"]"

# title
case "${TERM}" in
kterm*|xterm)
	precmd() {
		echo -ne "\033]0;`basename ${PWD}`[${PWD}]\007"
	}
	;;
esac
eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# }}}
# {{{ ALIAS

#ls
alias ls="ls -F --color=auto -v"	#ディレクトリには/, 色つき, 番号順
alias la="ls -a"				#隠しファイルも
alias ll="ls -lh"				#詳細付き, ファイルサイズに接頭語
alias lla="ls -lha"				#全部詳細

#cp
alias cp="cp -i"	#上書きを確認

#sl
alias -g sl="echo you are an idiot!"

#auto app
alias hoge=""

#ls
alias s="ls"
alias l="ls"

#exit
alias eixt="exit"
alias :q="exit"

#grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

#ln
alias ln="ln -i -v"

#xmodmap
alias xmod="xmodmap ~/.Xmodmap"

#geditのデバッグを消去
alias gedit="gedit $@ > /dev/null 2> /dev/null"

#  {{{ extensions
#extension
alias -s c=vim
alias -s C=vim
alias -s cpp=vim
alias -s h=vim
alias -s html=vim
alias -s java=vim
alias -s py=myPyOpen
alias -s txt=vim
alias -s xhtml=vim
alias -s xml=vim
alias -s zip=zipinfo

alias -s png=eog
alias -s jpg=eog
alias -s jpeg=eog
alias -s gif=eog
alias -s bmp=eog
#wines
alias -s exe=wine

alias -s asta=astah

#  }}} -end extensions

#apache2
alias apache2="sudo /etc/init.d/apache2"

#sudo用gedit
alias suedit="sudo XMODIFIERS=@im=ibus GTK_IM_MODULE=xim gedit"

#stdoutをクリップボードへ
alias -g toclip=" | xsel -bi"
#stdout+stderrをクリップボードへ
alias -g toclipall=" 2>&1 | xsel -bi"
#stdoutをクリップボードとstdoutへ
alias -g andclip=" | (cat 1>&2 | xsel -bi) 2>&1"
#stdout+stderrをクリップボードとstdoutへ
alias -g andclipall=" 2>&1 | (cat 1>&2 | xsel -bi) 2>&1"

#gnome-open
alias gopen="gnome-open"

#geditのデバッグがウザい
alias gedit="gedit >/dev/null 2>/dev/null"

#git
alias graph="log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short"

# }}}
# {{{ FUNC
# function cd() { builtin cd $@ && ls }
function chpwd() { ls -v -F --color=auto }

# }}}
# {{{APP alias
alias tweetdeck="chromium --app=https://tweetdeck.twitter.com"

# }}} -end

# {{{ PLAY
# {{{ MY SHIRI
alias こんにちは="echo 「どうもどうもこんにちは」"
alias お腹すいた="echo 「っカレー」"
# }}}

# }}} -end
