" {{{ -Initialize
"neobundle
filetype off

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

" }}} end -Initialize
" {{{ -Bundles
"neobundle 
Plug 'Shougo/neobundle.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
"NeoBundle 'Shougo/neocomplcache'

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc', { 'do': 'make' }

Plug 'scrooloose/syntastic'
Plug 'rking/ag.vim'
Plug 'Sixeight/unite-grep'
Plug 'tsukkee/unite-tag'

Plug 'vim-jp/vimdoc-ja'

"fix
"NeoBundle 'fuenor/im_control.vim'

"utility view
Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
Plug 'itchyny/lightline.vim'
Plug 'LeafCage/foldCC'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'taglist.vim'
Plug 'majutsushi/tagbar'
Plug 'szw/vim-tags'
Plug 'ZoomWin'
Plug 'sjl/gundo.vim'
"NeoBundle 'yonchu/accelerated-smooth-scroll'
"NeoBundle 'scrooloose/nerdtree'

" utility search
Plug 'haya14busa/incsearch.vim'

" utility input
Plug 'Shougo/neosnippet'
Plug 'scrooloose/snipmate-snippets'
Plug 'tpope/vim-surround'
Plug 'Align'
Plug 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
Plug 'osyo-manga/vim-over'
Plug 'LeafCage/yankround.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'alpaca-tc/alpaca_tags'
Plug 'tpope/vim-endwise'
Plug 'kana/vim-arpeggio'
Plug 'koron/imcsc-vim'
Plug 'tpope/vim-abolish'
Plug 'haya14busa/vim-migemo'
Plug 'mattn/emmet-vim'
Plug 'koron/codic-vim'

"NeoBundle 'kana/vim-operator-replace'
"NeoBundle 'thinca/vim-splash'
"NeoBundle 'terryma/vim-multiple-cursors'
"NeoBundle 'haya14busa/vim-easymotion'

" operator
" Plug 'kana/vim-operator-user'

" textobj
Plug 'kana/vim-textobj-user'
Plug 'coderifous/textobj-word-column.vim'
Plug 'akiyan/vim-textobj-php'
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-datetime'
Plug 'mattn/vim-textobj-url'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-jabraces'
Plug 'vimtaku/vim-textobj-keyvalue'
Plug 'RyanMcG/vim-textobj-dash'
Plug 'deris/vim-textobj-enclosedsyntax'

"tool
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'cocopon/colorswatch.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'thinca/vim-quickrun'
Plug 'mhinz/vim-startify'
Plug 'mattn/gist-vim'
"NeoBundle 'mbbill/undotree'
"NeoBundle 'YankRing.vim'
"NeoBundle 'mru'
"NeoBundle 'mttn/zen-coding.vim'

"sublime text 2 NeoBundle 'mattn/multi-vim'
Plug 'koron/minimap-vim'
"NeoBundle 'koron/minimap-vim'

" sound
Plug 'osyo-manga/vim-sound'

"language
" html5
Plug 'othree/html5.vim', { 'for': ['html'] }
Plug 'hokaccha/vim-html5validator', { 'for': ['html'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['html'] }

"php
Plug 'stephpy/vim-php-cs-fixer', { 'for': ['php'] }

" python
Plug 'python.vim', { 'for': ['python'] }
Plug 'kevinw/pyflakes-vim', { 'for': ['python'] }
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }
Plug 'pythoncomplete', { 'for': ['python'] }
Plug 'nvie/vim-flake8', { 'for': ['python'] }

" java
Plug 'claco/jasmine.vim', { 'for': ['java'] }

" javascript
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript']}
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
Plug 'mattn/jscomplete-vim', { 'for': ['javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
Plug 'STRML/JSXHint', { 'for': ['javascript'] }

" coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': ['coffeescript'] }

" ruby
Plug 'bbatsov/rubocop', { 'for': ['ruby'] }

" cpp
Plug 'vim-jp/cpp-vim', { 'for': 'cpp' }
Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp']}

Plug 'mediawiki.vim'
" NeoBundle 'wikipedia.vim'

" jade
Plug 'digitaltoad/vim-jade', { 'for': ['jade'] }
" arduino
Plug 'sudar/vim-arduino-syntax'

" less
Plug 'groenewege/vim-less', { 'for': ['less'] }

" stylus
Plug 'wavded/vim-stylus', { 'for': ['stylus'] }

" SmallTalk
Plug 'vim-scripts/st.vim'

"Lua
Plug 'lua-support'
Plug 'luarefvim'
"Tex
" Plug 'lervag/vim-latex'
" Plug 'lervag/vimtex'

" md
Plug 'kannokanno/previm'

"Game
"NeoBundle 'amix/vim-2048'
Plug 'AshyIsMe/2048', { 'on': 'NewGame2048' }
"NewGame2048
Plug 'thinca/vim-threes', { 'on': 'ThreesStart' }
"ThreesStart
"NeoBundle 'sudoku_game'
"Sudoku
Plug 'mfumi/viminesweeper', { 'on': 'MineSweeper' }
"MineSweeper
"NeoBundle 'TeTrls.vim'
"
Plug 'mattn/invader-vim'
"Invader
Plug 'deris/vim-duzzle'
"DuzzleStart
"nmap <Leader>gt :source<Space>TeTrls.vim<Enter>

"twitter
Plug 'basyura/TweetVim'

Plug 'mattn/webapi-vim'
Plug 'basyura/twibill.vim'
Plug 'tyru/open-browser.vim'
Plug 'h1mesuke/unite-outline'
Plug 'basyura/bitly.vim'
"NeoBundle 'TwitVim'

"git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'pocke/neco-gh-issues'

"colorscheme
Plug 'ujihisa/unite-colorscheme'
Plug 'phd'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'sfsekaran/cobalt.vim'

" browsing
Plug 'yuratomo/w3m.vim'

" funny
" Plug 'mattn/vim-kaikyaku-buster'

call plug#end()

filetype plugin on
filetype indent on

" }}} -end Bundles
