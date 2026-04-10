# ============================================================================
# .zshrc — Shell Configuration Summary
# ============================================================================
#
# [Plugins]
#   zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting
#   anyframe (fzf selector), zsh_codex (AI completion, iTerm only)
#
# [Prompt]
#   pure (iTerm), starship (default)
#
# [Navigation]
#   zoxide (cd replacement) .............. alias cd="z"
#   ghq + fzf ............................ cdg, gcd, fzf-src (^])
#   cdr (recent dirs + fzf) .............. cdr
#   chpwd_recent_dirs .................... auto-track recent dirs
#   chpwd_tab_color ...................... iTerm tab color by project
#
# [History]
#   fzf history search ................... ^R (percol_select_history)
#   directory-aware history .............. ZSH_HISTORY_DIR_FILE
#   SAVEHIST/HISTSIZE=100000, share_history, dedup
#
# [Tools]
#   eza (ls replacement) ................. alias ls="eza -l --icons ..."
#   nvim ................................. alias vim="nvim"
#   lazygit .............................. alias lg="lazygit"
#   direnv (cached) ...................... auto env switching
#   mise (cached) ........................ runtime version manager
#   pyenv (lazy load) .................... on-demand init
#   n (Node.js) .......................... + .node-version check on chpwd
#   uv (cached completion)
#   Google Cloud SDK, bun, moonbit, ghcup
#
# [Key Bindings]
#   ^R  history search     ^]  fzf-src (ghq)    ^F  forward-char
#   ^U  backward-kill-line ^K  insert-last-word  ^G  zsh_codex
#   ^Xe edit-command-line (iTerm)
#
# [Global Aliases]
#   G (grep), C (pbcopy), P (percol), X (xargs), PX (fzf|xargs)
#   A (alert on finish)
#
# [Safety]
#   rm → rmtrash, mv -i, cp -i, ln -i -v
#
# [Profiling]
#   enabled_prof=1 to activate zprof benchmarking
#
# ============================================================================

## ----- Plugins -----
#

ulimit -n 524288

enabled_prof=0
if [ $enabled_prof -eq 1 ]; then
  zmodload zsh/zprof
  zprof
fi



### zsh-utils
# mkdir -p ~/.zsh/plugins
# ghq get https://github.com/zsh-users/zsh-completions
# ghq get https://github.com/zsh-users/zsh-autosuggestions
# ghq get https://github.com/zsh-users/zsh-syntax-highlighting
# ghq get git@github.com:mollifier/anyframe.git
export ZSH_CODEX_PYTHON="$HOME/.pyenv/versions/3.10.12/bin/python3"

fpath=(~/.ghq/github.com/zsh-users/zsh-completions/src $fpath)
source $HOME/.ghq/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.ghq/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  source $HOME/.ghq/github.com/tom-doerr/zsh_codex/zsh_codex.plugin.zsh

  ### edit-command-line
  autoload -Uz edit-command-line
  zle -N edit-command-line
  bindkey '^xe' edit-command-line
fi



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

if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  add-zsh-hook chpwd chpwd_tab_color
  chpwd_tab_color
fi
function set_name () {
  local dir_name
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # Inside a Git repository
    local root_dir_name=$(basename "$(git rev-parse --show-toplevel)")
    local relative_path=$(git rev-parse --show-prefix)
    dir_name="${root_dir_name}/${relative_path}"
  else
    # Not inside a Git repository
    dir_name=$(basename "$PWD")
  fi
  echo -ne "\033]0;$dir_name\007"
}


if [ "$TERM_PROGRAM" = "WarpTerminal" ]; then
  # precmd_functions+=(set_name)
fi

### anyframe
fpath=($HOME/.ghq/github.com/mollifier/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
zstyle ":anyframe:selector:" command fzf

## direnv (cached)
_direnv_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/direnv_hook.zsh"
if [[ ! -f "$_direnv_cache" || "$(command -v direnv)" -nt "$_direnv_cache" ]]; then
  mkdir -p "${_direnv_cache:h}"
  direnv hook zsh > "$_direnv_cache"
fi
source "$_direnv_cache"
unset _direnv_cache

### fzf utils
#  {{{ fzf utils
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

# history search with fzf
function exists { which $1 &> /dev/null }
if exists fzf; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        local dir_cmds=""
        if [[ -f "$ZSH_HISTORY_DIR_FILE" ]]; then
            dir_cmds=$(awk -F'\t' -v dir="$PWD" '$1 == dir { print $2 }' "$ZSH_HISTORY_DIR_FILE" | sort -u)
        fi
        local selected
        selected=$(history -n 1 | eval $tac | awk '!a[$0]++' | while IFS= read -r line; do
            if echo "$dir_cmds" | grep -qxF "$line"; then
                echo " @ $line"
            else
                echo "   $line"
            fi
        done | fzf --exact --no-sort --scheme=history --layout=reverse --query "$LBUFFER")
        if [ $? -eq 0 ]; then
            BUFFER="${selected#???}"
            CURSOR=$#BUFFER
        fi
        zle reset-prompt
    }
fi

# }}}

### ghq
# {{{ ghq

_GHQ_CACHE="$HOME/.cache/ghq-list"
zmodload -F zsh/stat b:zstat
zmodload -F zsh/datetime p:EPOCHSECONDS

function _ghq_list_cached () {
  if [ ! -f "$_GHQ_CACHE" ] || (( EPOCHSECONDS - $(zstat +mtime "$_GHQ_CACHE") > 3600 )); then
    mkdir -p "${_GHQ_CACHE:h}"
    ghq list -p > "$_GHQ_CACHE"
  fi
}

function cdg () {
  _ghq_list_cached
  local selected_dir=$(fzf --exact --layout=reverse --query "$*" < "$_GHQ_CACHE")
  if [ -n "$selected_dir" ]; then
    cd "${selected_dir}"
  fi
}

function cdg-refresh () {
  rm -f "$_GHQ_CACHE"
  _ghq_list_cached
  echo "ghq cache refreshed"
}

GHQ=`ghq root`/github.com
ME=`git config --get user.name`
export GHQ_GET_OPTIONS="--depth=1 --single-branch"


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

function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --exact --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src


# }}}

### pyenv (lazy load)
export PYENV_VIRTUALENV_INIT=0
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

### pure-prompt


if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
  export PURE_PROMPT_SYMBOL="❯"
  zmodload zsh/nearcolor
  autoload -U promptinit; promptinit
  PURE_CMD_MAX_EXEC_TIME=10
  
  zstyle :prompt:pure:git:stash show yes
  
  prompt pure
fi

# PROMPT='%(?.%F{magenta}△.%F{red}▲)%f '


###star ship
# eval "$(starship init zsh)"

## ----- Basic -----

# mode -e emacs, -v vim
bindkey -e
# bindkey -v

export EDITOR=nvim       # エディタをnvimに設定
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
zstyle ':completion:*' file-sort modification

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

# history with directory tracking
export ZSH_HISTORY_DIR_FILE=~/.zsh_history_dir

preexec_record_dir() {
    echo "$PWD	$1" >> "$ZSH_HISTORY_DIR_FILE"
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_record_dir

# yarn completion

# autoload -U +X compinit && compinit
autoload -Uz compinit
if [[ -f ~/.zcompdump && $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null) ]]; then
  compinit
else
  compinit -C
fi

# autoload -U +X bashcompinit && bashcompinit


### alias
# {{{ alias

### bind
bindkey "^U" backward-kill-line
bindkey '^]f'   vi-find-next-char
bindkey '^]b' vi-find-prev-char
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^k' insert-last-word # → alt(meta) + .

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
function cdr () {
  local selected_dir=$(sed "s/^\$'//;s/'$//" ~/.chpwd-recent-dirs | fzf --exact --layout=reverse --no-sort --query "$*")
  if [ -n "$selected_dir" ]; then
    cd "${selected_dir}"
  fi
}


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
alias chmox="chmod +x"

alias ktest='kotlinc Main.kt && oj t -c "kotlin MainKt" -d ./tests/'

function duh() {
  du -h -d 1 $1 | sort -h
}
function randpw(){
  openssl rand -base64 12 | fold -w 12 | head -1
}

funciton pathname() {
  basename "$PWD"
}

function pwdf() {
  local selected
  selected=$(ls -1A | fzf --preview 'ls -lh {}' --prompt 'pwdf> ') || return
  local fullpath="${PWD}/${selected}"
  local result="${fullpath/#$HOME/~}"
  echo "$result"
  echo -n "$result" | pbcopy
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
alias dc="docker compose"
alias ts-node="tsx"
alias da="direnv allow"

alias novel="code ~/.ghq/github.com/elzup/novel"
alias pg="code ~/.ghq/github.com/elzup/jupyter-notebook-pg"
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
alias rubymine="open -a RubyMine"
alias webstorm="open -a WebStorm"
alias androidstudio="open -a Android\ Studio ."
alias ghostty="open -a /Applications/Ghostty.app"

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
alias -s asta=astah


### end pipe

# char alias
alias -g G="| rg"
alias -g C='| xsel --input --clipboard'
alias -g P='| percol'
alias -g X='| xargs'
alias -g PX='| fzf | xargs'

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

# less after hilight
lessc() {
  if [[ -z "$1" ]]; then
    echo "Usage: less-c <filename>"
    return 1
  fi

  # ccze がインストールされているか確認
  if command -v ccze >/dev/null 2>&1; then
    ccze -A < "$1" | less -R

  # `pygmentize` がインストールされているか確認
  # elif command -v pygmentize >/dev/null 2>&1; then
  #   pygmentize -g "$1" | less -R
  # `source-highlight` がインストールされているか確認
  fi
}


# }}}
# {{{ mac

if echo $OSTYPE | grep -q darwin; then
    alias ls="eza -l --icons --group-directories-first --time-style=long-iso"
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

    # wines
    alias -s exe=wine
fi

# }}}
# {{{ windows
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
    alias open="explorer.exe"
fi
# }}}

# {{{ hello
# FLAG_KYOKO_KYOKO_TOSHINO
# }}}


zstyle ':chpwd:*' recent-dirs-max 3000
function chpwd() { ls }


# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hiro/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hiro/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hiro/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hiro/google-cloud-sdk/completion.zsh.inc'; fi


export CLOUDSDK_PYTHON=$(pyenv which python3)

# uv-zsh-completion (cached)
_uv_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/uv_completion.zsh"
if [[ ! -f "$_uv_cache" || "$(command -v uv)" -nt "$_uv_cache" ]]; then
  mkdir -p "${_uv_cache:h}"
  uv generate-shell-completion zsh > "$_uv_cache"
fi
source "$_uv_cache"
unset _uv_cache

# shell gpt


function sgpt_completion() {
    # 現在の行全体を取得
    local current_line=$(fc -ln -1 | sed 's/^\s*//')

    # 最後の単語を抽出（例: 未完成部分）
    local last_word=$(echo "$current_line" | awk '{print $NF}')

    # 最後の単語だけを ChatGPT に送信して補完候補を取得
    local suggestion=$(sgpt "$last_word" 2>/dev/null)

    # fzf を使って候補を選択（任意）
    if command -v fzf &>/dev/null; then
        suggestion=$(echo "$suggestion" | fzf --prompt="Select suggestion: ")
    fi

    # 補完結果を現在の行に追加
    if [ -n "$suggestion" ]; then
        # 現在の行に続きとして補完を追加
        print -z "${current_line%$last_word}$last_word$suggestion"
    fi
}
# unbindkey '^G'
# bindkey '^G' sgpt_completion


plugins=(zsh_codex)
zle -N create_completion
bindkey '^G' create_completion


### yaji
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


### bench mark

# zsh zshrc bentch mark
if [ $enabled_prof -eq 1 ]; then
  if (which zprof > /dev/null 2>&1) ;then
    zprof
  fi
fi

bindkey "^F" forward-char
# if [ "$TERM_PROGRAM" = "WarpTerminal" ]; then
  # starship (cached)
  _starship_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/starship_init.zsh"
  if [[ ! -f "$_starship_cache" || "$(command -v starship)" -nt "$_starship_cache" ]]; then
    mkdir -p "${_starship_cache:h}"
    starship init zsh > "$_starship_cache"
  fi
  source "$_starship_cache"
  unset _starship_cache
# fi

# Ghostty uses xterm-ghostty which tig doesn't recognize
if [ "$TERM_PROGRAM" = "ghostty" ]; then
  export TERM=xterm-256color
  # Reset kitty keyboard protocol and terminal state on each prompt.
  # Programs (e.g. claude) may enable it and not clean up on exit,
  # leaving the terminal sending extended escape sequences (backspace broken, etc).
  _reset_keyboard_protocol() { printf '\e[<u'; stty sane 2>/dev/null }
  add-zsh-hook precmd _reset_keyboard_protocol
fi
export TERMINFO=~/.terminfo

alias bison="/usr/local/opt/bison/bin/bison"

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"



# mise (cached)
_mise_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/mise_activate.zsh"
if [[ ! -f "$_mise_cache" || "$(command -v mise)" -nt "$_mise_cache" ]]; then
  mkdir -p "${_mise_cache:h}"
  mise activate zsh > "$_mise_cache"
fi
source "$_mise_cache"
unset _mise_cache

# claude

[ -f "/Users/hiro/.ghcup/env" ] && . "/Users/hiro/.ghcup/env" # ghcup-env

# codepack
export COREPACK_ENABLE_AUTO_PMM=0


# moonbit
export PATH="$HOME/.moon/bin:$PATH"

# n (Node.js version manager)
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Warn if node version doesn't match .node-version
autoload -U add-zsh-hook
check-node-version() {
  local current_version=$(node -v 2>/dev/null | sed 's/^v//')
  if [[ -f .node-version ]]; then
    local required_version=$(cat .node-version | tr -d '[:space:]')
    if [[ "$current_version" != "$required_version"* ]]; then
      echo "\033[33m⚠ .node-version requires $required_version but current is $current_version (run: n $required_version)\033[0m"
    fi
  else
    if [[ "$current_version" != 22.* ]]; then
      echo "\033[33m⚠ node is $current_version (not 22.x) — run: n 22\033[0m"
    fi
  fi
}
add-zsh-hook chpwd check-node-version

if exists fzf; then
    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# bun completions
[ -s "/Users/hiro/.bun/_bun" ] && source "/Users/hiro/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

# zoxide (must be at the end of .zshrc)
if [[ -o interactive ]]; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
