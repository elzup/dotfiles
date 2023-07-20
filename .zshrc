## ----- Plugins -----

### zsh-utils
# mkdir -p ~/.zsh/plugins
# ghq get https://github.com/zsh-users/zsh-completions
# ghq get https://github.com/zsh-users/zsh-autosuggestions
# ghq get https://github.com/zsh-users/zsh-syntax-highlighting
# ghq get git@github.com:mollifier/anyframe.git

fpath=(~/.ghq/github.com/zsh-users/zsh-completions/src $fpath)
source $HOME/.ghq/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.ghq/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line


### chpwd_recent_dirs
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

## chpwd_tab_color
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

chpwd_tab_color() {
  case $PWD/ in
    */.ghq/github.com/elzup/*) tab-color 100 0 100;; # purple
    */.ghq/github.com/elzup-sandbox/*) tab-color 100 100 255;; # blue
    */.ghq/github.com/planckunits/*) tab-color 50 71 81;; # gray
    */.ghq/github.com/*o/*) tab-color 255 255 200;; # light yellow
    */.ghq/github.com/*) tab-color 100 100 100;; # base gray
    *) tab-reset;;
  esac
}
add-zsh-hook chpwd chpwd_tab_color

chpwd_tab_color

### anyframe
fpath=($HOME/.ghq/github.com/mollifier/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init

## direnv
eval "$(direnv hook zsh)"

### pecol
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
alias gitsw='anyframe-widget-insert-git-branch'

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



# }}}

### ghq
# {{{ ghq

function cdg () {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

GHQ=`ghq root`/github.com
ME=`git config --get user.name`

gcd() {
    ghq get $1
    if [ `dirname "$1"` = "." ]; then
        cd $GHQ/$ME/$1
    else
        cd $GHQ/$1
    fi
}
alias grep="grep --color=auto"

function ghq-new() {
  NEW_PROJ_PATH=$GHQ/elzup/$1
  mkdir -p $NEW_PROJ_PATH
  cd $NEW_PROJ_PATH
}

mkdev () {
	if [ ! -n "$1" ]
	then
		echo "Usage: mkdev dir-name [org-name]"
		return
	fi
	local dirName=$1
	local rootDir=$(ghq root)
	local githubUser="github.com/$(git config user.name)"
	if echo "${dirName}" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -q "/"
	then
		githubUser="github.com"
	fi
	local devPath="${rootDir}/${githubUser}/${dirName}"
	mkdir -p ${devPath}
	cd ${devPath}
}

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

# }}}

### pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

### pure-prompt

autoload -U promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=10

zmodload zsh/nearcolor
zstyle :prompt:pure:git:stash show yes

prompt pure

# PROMPT='%(?.%F{magenta}△.%F{red}▲)%f '


###star ship
# eval "$(starship init zsh)"

## ----- Basic -----

# mode -e emacs, -v vim
bindkey -e
# bindkey -v

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

# User configuration

# 単語消去で"消す"文字
export WORDCHARS='*?_-.[]~=&;!#$$&^(){}<>'
## =command を command のパス名に展開する
setopt equals

# {{{ styles
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

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
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# }}}

### history
# .zsh_hisotry の上限
export SAVEHIST=100000
export HISTSIZE=100000
export HISTFILE=~/.zsh_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups           # 前と重複する行は記録しない
setopt hist_ignore_all_dups       # 履歴中の重複行をファイル記録前に無くす
setopt hist_ignore_space          # 行頭がスペースのコマンドは記録しない

setopt hist_find_no_dups          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_reduce_blanks         # 余分な空白は詰めて記録
setopt hist_no_store              # histroyコマンドは記録しない


# yarn completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit


### alias
# {{{ alias

### bind
bindkey "^U" backward-kill-line
bindkey '^]f'   vi-find-next-char
bindkey '^]b' vi-find-prev-char
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^k' insert-last-word

# overwrap options alias
alias lsa="ls -a"
alias mv="mv -i"
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sl="ls"
alias lg="lazygit"

alias cp="cp -i"	#上書きを確認

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias GREP_OPTIONS=""

alias ln="ln -i -v"
alias cdr="anyframe-widget-cdr"


### usefuls

# alias npm=prioritize-yarn

# extra cd
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

alias basename-current='basename ${PWD}'
alias basename-parent='echo `basename ${PWD%/*}`/`basename $PWD`'
alias reponame=basename-parent

alias rsync-e="rsync -rtvpl --exclude-from=.rsyncignore"
alias rsync-n="rsync -nrtvpl"
alias rsync-en="rsync -nrtvpl --exclude-from=.rsyncignore"

function duh() {
  du -h -d 1 $1 | sort -h
}
function randpw(){
  openssl rand -base64 12 | fold -w 12 | head -1
}

funciton pathname() {
  basename "$PWD"
}

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
alias da="direnv allow"

alias novel="code ~/.ghq/github.com/elzup/novel"
alias poem=novel
alias memo="vim ~/memos/free"

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

alias intellij="open -a IntelliJ\ IDEA\ CE"
alias vscode="open -a Visual\ Studio\ Code"
alias rubymine="open -a RubyMine"
alias webstorm="open -a WebStorm"
alias androidstudio="open -a Android\ Studio ."

alias geai="open https://github.com/elzup/admin/issues"

# react native
alias rn="react-native"


### extensions
#
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
# wines
alias -s exe=wine

alias -s asta=astah


### end pipe

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


# }}}
# {{{ mac

if echo $OSTYPE | grep -q darwin; then
    alias ls="exa -l --icons --group-directories-first"
    alias -g C='| pbcopy'

    alias gvim="mvim"

    # path=(/Applications/ ~/bin(N-/) /usr/local/bin(N-/) ${path})

    alias firefox="open -a Firefox"
    alias firefoxp='/Applications/Firefox.app/Contents/MacOS/firefox-bin -P "answer" &'
    alias safari="open -a Safari"
    alias prev="open -a Preview"
    alias finder="open -a Finder"
    alias chrome="open -a Google\ Chrome"
    alias vim="nvim"
fi

# }}}

# {{{ hello
# FLAG_KYOKO_KYOKO_TOSHINO
# }}}


zstyle ':chpwd:*' recent-dirs-max 1000
function chpwd() { ls }


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hiro/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hiro/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hiro/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hiro/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh


export CLOUDSDK_PYTHON=~/.pyenv/versions/3.8.1/bin/python

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hiro/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hiro/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/hiro/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hiro/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### bench mark

# zsh zshrc bentch mark
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

bindkey "^F" forward-char
