export ZSHHOME="${HOME}/.zsh"
ZSHRCHOME="${ZSHHOME}/rc"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.zsh/antigen/antigen.zsh
antigen bundle sorin-ionescu/prezto


# source rc files
. $ZSHRCHOME/basic.zsh
. $ZSHRCHOME/plugins.zsh
. $ZSHRCHOME/envpath.zsh
. $ZSHRCHOME/bind.zsh
# . $ZSHRCHOME/vimbind.zsh

# {{{ source plugins, helpers
# source all files in folder
ZSHRCPLUGINS="${ZSHRCHOME}/plugins"
ZSHRCHELPERS="${ZSHRCHOME}/helpers"

if [ -d $ZSHRCPLUGINS -a -r $ZSHRCPLUGINS -a \
     -x $ZSHRCPLUGINS ]; then
    for i in $ZSHRCPLUGINS/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# source all files in folder
if [ -d $ZSHRCHELPERS -a -r $ZSHRCHELPERS -a \
     -x $ZSHRCHELPERS ]; then
    for i in $ZSHRCHELPERS/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
# }}} --source plugins, helpers
. $ZSHRCHOME/alias.zsh

# source mac zshrc
if echo $OSTYPE | grep -q darwin; then
    source $ZSHRCHOME/.mzshrc
fi

# source mac zshrc
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/hiro/.sdkman"
# [[ -s "/Users/hiro/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hiro/.sdkman/bin/sdkman-init.sh"

# added by travis gem
[ -f /Users/hiro/.travis/travis.sh ] && source /Users/hiro/.travis/travis.sh

random_saying
