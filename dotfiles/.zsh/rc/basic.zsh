# mode -e emacs, -v vim
bindkey -e
## bindkey -v

autoload -Uz compinit promptinit

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

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
)


# 単語消去で"消す"文字
export WORDCHARS='*?_-.[]~=&;!#$$&^(){}<>'
## =command を command のパス名に展開する
setopt equals

# .zsh_hisotry の上限
export SAVEHIST=100000
