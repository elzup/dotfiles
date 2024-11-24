path+=(
    "/usr/local/bin:/usr/local/sbin"
    "/usr/local"
    "/usr/bin:/usr/sbin"
    "/bin:/sbin"
    "/usr/local/share/git-core/contrib/diff-highlight"
    $HOME"/.mos/bin/"
    "/usr/local/opt/qt@5.5/bin"
    "$HOME/.local/bin"
    "/usr/local/opt/gettext/bin"
    "/usr/local/opt/binutils/bin"
    "$HOME/.cargo/bin")

if command -v stack > /dev/null; then
    path+=("$(stack path --compiler-bin)")
fi

# {{{ brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# }}}
# {{{ sdkman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR=$HOME/.sdkman
[[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source $SDKMAN_DIR/bin/sdkman-init.sh

# }}}
# {{{ android
# export PATH=$PATH:/opt/android-ndk-r10d
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


export ANDROID_HOME=$HOME/Library/Android/sdk/

path+=($ANDROID_HOME/tools $ANDROID_HOME/platform-tools)


export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk-bundle
# }}}
# {{{ rbenv
export PATH=$HOME/.rbenv/shims:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# rmagick :-1:
#
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/bin":$PKG_CONFIG_PATH


# }}}
# {{{ perl
PERL_MB_OPT="--install_base \""$HOME"/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

export PERL_CPANM_OPT="--local-lib=$HOME/.perl-extlib"
export PERL5LIB="$HOME/.perl-extlib/lib/perl5:$PERL5LIB"

# }}}
# {{{ go
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

# }}}
# {{{ neo-vim
export XDG_CONFIG_HOME="$HOME/.config"

# }}}
# {{{ image magic
# export MAGICK_HOME=$HOME/Library/ImageMagick-7.0.3
# export PATH="$MAGICK_HOME/bin:$PATH"
# export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# }}}
# {{{ C++
# export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/lib
# export $HOME/lib
# }}}
#


# export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
# export CPATH=/usr/local/opt/openssl/include:$CPATH
# export LDFLAGS=-L/usr/local/opt/openssl/lib
# export CPPFLAGS=-I/usr/local/opt/openssl/include
# export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH

# {{{ openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# }}}


export PGDATA=/usr/local/var/postgres

if echo $OSTYPE | grep -q darwin; then
    export JAVA_HOME=`/usr/libexec/java_home -v 14`
    # export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
    export ANDROID_HOME=/Users/hiro/Library/Android/sdk
    # export ANDROID_NDK_HOME=/Users/hiro/Library/Android/sdk/ndk-bundle/
    path+=($JAVA_HOME/bin $ANDROID_HOME/tools $ANDROID_HOME/platform-tools)
fi


# export LDFLAGS="-L/usr/local/opt/gettext/lib"
# export CPPFLAGS="-I/usr/local/opt/gettext/include"

export PYENV_ROOT="$HOME/.pyenv"
path+=("$PYENV_ROOT/bin")
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi


# PHP
path+=("/usr/local/opt/php@7.4/{bin,sbin}")


# Julia
path+=("/Applications/Julia-1.7.app/Contents/Resources/julia/bin")

export PATH=":$PATH"