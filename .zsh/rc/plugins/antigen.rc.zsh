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
