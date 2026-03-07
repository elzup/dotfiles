path+=(
    "/usr/local/bin:/usr/local/sbin"
    "/usr/local"
    "/usr/bin:/usr/sbin"
    "/bin:/sbin"
    "/usr/local/share/git-core/contrib/diff-highlight"
    "$HOME/.mos/bin/"
    "/usr/local/opt/qt@5.5/bin"
    "$HOME/.local/bin"
    "/usr/local/opt/gettext/bin"
    "/usr/local/opt/binutils/bin"
    "/usr/local/opt/bison/bin"
    "$HOME/.moon/bin"
    "$HOME/.cargo/bin"
)

if command -v stack > /dev/null; then
    path+=("$(stack path --compiler-bin)")
fi

# brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
eval "$(/opt/homebrew/bin/brew shellenv)"

# sdkman (must be at end of file section for sdkman to work)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# android
export ANDROID_NDK_ROOT=/Applications/Android/android-ndk-r10d
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANT_ROOT=/Applications/Android/apache-ant-1.9.4
export NDK_ROOT=/Applications/Android/android-ndk-r10d
export ANDROID_HOME="$HOME/Library/Android/sdk/"
path+=("$ANDROID_HOME/tools" "$ANDROID_HOME/platform-tools")
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk-bundle"

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
if command -v rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# perl
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
export PERL_CPANM_OPT="--local-lib=$HOME/.perl-extlib"
export PERL5LIB="$HOME/.perl-extlib/lib/perl5:$PERL5LIB"

# go
export GOROOT="$(brew --prefix go)/libexec"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

export XDG_CONFIG_HOME="$HOME/.config"

# openssl
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

export PGDATA=/usr/local/var/postgres

if echo "$OSTYPE" | grep -q darwin; then
    export JAVA_HOME=$(/usr/libexec/java_home -v17)
    export ANDROID_HOME=/Users/hiro/Library/Android/sdk
    path+=("$JAVA_HOME/bin" "$ANDROID_HOME/tools" "$ANDROID_HOME/platform-tools")
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
path+=("$PYENV_ROOT/bin")
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

# PHP
path+=("/usr/local/opt/php@7.4/{bin,sbin}")

# Julia
path+=("/Applications/Julia-1.7.app/Contents/Resources/julia/bin")

# vcpkg
export VCPKG_ROOT="$HOME/.ghq/github.com/microsoft/vcpkg"
path+=("$VCPKG_ROOT")
