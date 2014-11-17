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
ZSH_THEME="adben"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/grass/bin:/opt/grass/scripts:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/hiro/.gem/ruby/2.1.0/bin"

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
source ./.myzshrc
# {{{ path
#
export PATH=~/CodeSourcery/Sourcery_G++_Lite/bin:$PATH

# android ndk
export PATH=$PATH:/opt/android-ndk-r9d
export NDK_ROOT=/opt/android-ndk-r9d
export ANDROID_NDK_ROOT=/opt/android-ndk-r9d
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANT_ROOT=/usr/bin


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
# }}} 
# {{{ alias

#ls
alias ls="ls -F --color=auto -v"	#ディレクトリには/, 色つき, 番号順
alias la="ls -a"				#隠しファイルも
alias ll="ls -lh"				#詳細付き, ファイルサイズに接頭語
alias lla="ls -lha"				#全部詳細

#cp
alias cp="cp -i"	#上書きを確認

#sl
alias -g sl="echo you are an idiot!"

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

# char alias
alias -g G="| grep"
alias -g C='| xsel --input --clipboard'

# ping
alias pingoogle="ping google.com"

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
clear
