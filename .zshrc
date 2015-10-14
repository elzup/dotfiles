# {{{ oh-myzsh
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# adben, af-magic, blinks, candy, cypher
# 3den Soliah adben af-magic afowler agnoster alanpeabody amuse apple arrow aussiegeek avit awesomepanda bira blinks bureau candy-kingdom candy
# clean cloud crcandy crunch cypher dallas darkblood daveverwer dieter dogenpunk dpoggi dst dstufft duellj eastwood edvardm essembeh evan example
# fino-time fino fishy flazz fletcherm fox frisk frontcube funky fwalch gallifrey gallois garyblessington gentoo geoffgarside gianu gnzh gozilla
# half-life humza imajes intheloop itchy jaischeema jbergantine jispwoso jnrowe jonathan josh jreese jtriley juanghurtado junkfood kafeitu kardan
# kennethreitz kiwi kolo kphoen lambda linuxonly lukerandall macovsky-ruby macovsky maran mgutz mh michelebologna mikeh miloshadzic minimal mortalscumbag
# mrtazz murilasso muse nanotech nebirhos nicoulaj norm obraun peepcode philips pmcgee pure pygmalion re5et rgm risto rixius rkj-repos rkj robbyrussell
# sammy simonoff simple skaro smt sonicradish sorin sporty_256 steeef sunaku sunrise superjarin suvash takashiyoshida terminalparty theunraveler tjkirch
# tjkirch_mod tonotdo trapd00r wedisagree wezm+ wezm wuffers xiong-chiamiov-plus xiong-chiamiov ys zhann
ZSH_THEME="adben_elzup"
# ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rbenv)

source $ZSH/oh-my-zsh.sh

# User configuration

path=(
    $path
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/bin"
    "/opt/grass/bin"
    "/opt/grass/scripts"
    "/opt/java/bin"
    "/opt/java/db/bin"
    "/opt/java/jre/bin"
    "/usr/bin/site_perl"
    "/usr/bin/vendor_perl"
    "/usr/bin/core_perl"
    "$HOME/.gem/ruby/2.1.0/bin"
    "$HOME/.rbenv"
)
eval "$(rbenv init -)"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# }}}
source ~/.myzshrc
## vim mode
# bindkey -v
# {{{ path
#
export PATH=~/CodeSourcery/Sourcery_G++_Lite/bin:$PATH


# }}}
# {{{ ctags
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

# }}}
# {{{ mounts
functoin mountin() {
    help() {
        echo 'mountin help'
        echo 'Usage: mountin [name]'
        echo ' ->sudo mount -o {name:options} {name:url} {name:mount_dir} | cd {name:mount_dir}'
        return
    }
    case $1 in
        -h|-help)
            help
            return
            ;;
        usb)
            sudo mount /dev/sdb1 /mnt/usb
            cd /mnt/usb
            return
            ;;
        tdu)
            sudo mount -o username=${TDU_USER},password=${TDU_PASS} //nas002.term.usmc.dendai.ac.jp/授業用ワークスペース /mnt/tdu
            cd /mnt/tdu
            return
            ;;
        ev3)
            sudo mount /dev/mmcblk0p2 /run/media/hiro/LMS2012_EXT
            cd /run/media/hiro/LMS2012_EXT
            return
            ;;
        cps)
            sudo mount -o username=${CPS_USER},password=${CPS_PASS} //192.168.1.230/contents /mnt/cps
            cd /mnt/cps
            return
            ;;
        sd)
            sudo mount /dev/mmcblk0p2 /mnt/sd
            cd /mnt/sd
            return
            ;;
    esac
}

_mountincmd() {
  _arguments \
    '(- *)'{-h,--help}'[show help]' \
    '*: :->modes'

  case $state in
    modes)
      _values \
      'to' \
      'tdu[tdu workspace]' \
      'usb[main usb port]' \
      'sd [main sd card slot]' \
      'ev3 [ev3 cernel sd card]' \
      'cps [cps server]'
    ;;
  esac
}

compdef _mountincmd mountin

# }}}
# {{{ option
# 単語消去で"消す"文字
WORDCHARS='*?_-.[]~=&;!#$$&^(){}<>'

setopt equals
# }}} 
# {{{ alias

#ls
alias ls="ls -F --color=auto -v -al"	#ディレクトリには/, 色つき, 番号順
alias la="ls -a"				#隠しファイルも
alias ll="ls -lh"				#詳細付き, ファイルサイズに接頭語
alias lla="ls -lha"				#全部詳細

alias tig="tig --all"	#ディレクトリには/, 色つき, 番号順

#cp
alias cp="cp -i"	#上書きを確認

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
#
GREP_OPTIONS=""

# char alias
alias -g G="| grep"
alias -g C='| xsel --input --clipboard'
alias -g P='| percol'
alias -g X='| xargs'
alias -g PX='| peco | xargs'

# ping
alias pingoogle="ping -c 3 www.google.com"

# get screen resolution 解像度
alias screensize="xdpyinfo | grep 'dimensions' | egrep -o '[0-9]+x[0-9]+' | head -1"

# change background
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

#ln
alias ln="ln -i -v"

#useful
alias xmod="xmodmap ~/.Xmodmap"
alias shutdown="sudo shutdown"
alias yaourt="yaourt --noconfirm"

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
alias -s rb=ruby
alias -s py=myPyOpen
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

#  }}} -end extensions

#apache2
alias apache2="sudo /etc/init.d/apache2"

#sudo用gedit
alias suedit="sudo XMODIFIERS=@im=ibus GTK_IM_MODULE=xim gedit"

#apache2
alias lampp="sudo /opt/lampp/lampp"

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

#buttery残量の表示
alias buttery="sudo cat /sys/class/power_supply/CMB1/capacity"

alias python="python3"
alias pip="pip3"

#lang change
alias lange="LANG=C"
alias langj="LANG=ja_JP.UTF-8"

function tenki() {
    php /home/hiro/Documents/opt/php-tenki/tenki.php $1
}

#git
#alias graph="log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short"
function myline() {
    git ls-files | xargs -n1 git --no-pager blame -f -w|grep $1 | wc -l
}
#http

# }}}
# {{{ greps
functoin greps() {
    help() {
        echo 'greps help'
        echo 'Usage: greps [word]'
        echo ' ->sudo mount -o {name:options} {name:url} {name:mount_dir} | cd {name:mount_dir}'
        return
    }
    grep $1 * -r
}

# }}}
# {{{ python
function myPyOpen() {
	if [ -f $1 ] ; then
		python $@
	else
		python ~/bin/$@
	fi
}

# }}}
# {{{ edit line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# }}}

# autojump
alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
autoload -Uz add-zsh-hock

bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char
bindkey '^k' insert-last-word

# プロセス名で補完
zstyle ':completion:*:processes' command "ps -u $USER"
zstyle ':chpwd:*' recent-dirs-max 500
if echo $OSTYPE | grep -q darwin; then
    source ~/.mzshrc
fi

function chpwd() { ls }

# antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
  source $HOME/.zsh/antigen/antigen.zsh
  antigen bundle mollifier/anyframe
  antigen apply
#  _zsh_highlight_myhighlighter_highlighter() {
#    ZSH_HIGHLIGHT_STYLES[alias]='fg=orange,bold'
#  }
#  ZSH_HIGHLIGHT_HIGHLIGHTERS+=(myhighlighter)
  antigen-bundle zsh-users/zsh-syntax-highlighting
fi

alias cdr="anyframe-widget-cdr"

ENHANCD_COMMAND=cdd; export ENHANCD_COMMAND
if [ -f ~/enhancd/enhancd.sh ]; then
    source ~/enhancd/enhancd.sh
fi

# percol
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

function percol_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER             # move cursor
    zle -R -c                   # refresh
}
#----- history search with percol
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
# clear

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

alias mv="mv -i"
alias unzipjar="jar xvf"
case ${OSTYPE} in
    darwin*)
        alias rm='rmtrash'
        ;;
esac


# auto sodo
alias htop="sudo htop"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# android ndk
export PATH=$PATH:/opt/android-ndk-r10d

case ${OSTYPE} in
    darwin*)
        export ANDROID_NDK_ROOT=/Applications/Android/android-ndk-r10d
        export ANDROID_SDK_ROOT=/Applications/Android/sdk
        export ANT_ROOT=/Applications/Android/apache-ant-1.9.4
        export NDK_ROOT=/Applications/Android/android-ndk-r10d
        ;;
    *)
        export NDK_ROOT=/opt/android-ndk-r9d
        export ANDROID_NDK_ROOT=/opt/android-ndk-r9d
        export ANDROID_SDK_ROOT=/opt/android-sdk
        export ANT_ROOT=/usr/bin
        ;;
esac

export PTOOLSPATH=~/phalcon-tools
export PATH=$PATH:$PTOOLSPATH
export PATH=$PATH:/Users/hiro/Applications/android-sdk-macosx/platform-tools

export PATH=$PATH:~/bin/


function git() { hub "$@" }

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh


export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib

export PATH=/Users/hiro/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/Users/hiro/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist
export DYLD_LIBRARY_PATH=/Users/hiro/torch/install/lib:$DYLD_LIBRARY_PATH  # Added automatically by torch-dist

# # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
# export COCOS_CONSOLE_ROOT=/Users/hiro/Library/cocos2d-x-3.6/tools/cocos2d-console/bin
# export PATH=$COCOS_CONSOLE_ROOT:$PATH

# # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
# export COCOS_TEMPLATES_ROOT=/Users/hiro/Library/cocos2d-x-3.6/templates
# export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/hiro/Applications/cocos2d-x-3.2/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH


# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

export PHPENV_ROOT="/usr/local/phpenv"
PATH="$PATH:$PHPENV_ROOT/bin"
eval "$(phpenv init -)"

# rbenv & phpenv
export PATH=$HOME/.rbenv/bin:$HOME/.phpenv/bin:$PATH
eval "$(rbenv init -)"
eval "$(phpenv init -)"


# caffe
export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/cuda/lib:$HOME/.pyenv/versions/anaconda-2.0.1/lib:/usr/local/lib:/usr/lib

# plus addon

# nvm
NVM_HOME=${HOME}/.nvm
if [ -e "${NVM_HOME}" ]; then
  source ${NVM_HOME}/nvm.sh
  nvm use stable
fi 


PERL_MB_OPT="--install_base \"/Users/hiro/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/hiro/perl5"; export PERL_MM_OPT;


export PERL_CPANM_OPT="--local-lib=$HOME/.perl-extlib"

export PERL5LIB="$HOME/.perl-extlib/lib/perl5:$PERL5LIB"

alias emacs="echo -e '
   \\  less  /
　　｢＼
　　ヽ )　　　／~)
　　/ /　　　(　/
　 / /　　　 ｜｜ < drwxr-xr-x
　(　＼　　　｜｜
　 ＼　＼　　/ ｜
　　 ＼　ヽ／　/　
　　　｜　　／ﾅﾉ

  ＿人人 人人＿ 
  ＞　grep　＜ 
  ￣Y^Y^Y^Y￣'"
