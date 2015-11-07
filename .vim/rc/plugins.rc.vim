" {{{ -Initialize
"neobundle
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle'))
endif

" }}} end -Initialize
" {{{ -Bundles
"neobundle 
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'Shougo/neocomplcache.git'

NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'rking/ag.vim'
NeoBundle 'Sixeight/unite-grep.git'
NeoBundle 'tsukkee/unite-tag'

NeoBundle 'vim-jp/vimdoc-ja'

"fix
"NeoBundle 'fuenor/im_control.vim'

"utility view
NeoBundle 'tpope/vim-markdown'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'taglist.vim'
NeoBundle 'szw/vim-tags'
NeoBundle 'ZoomWin'
"NeoBundle 'yonchu/accelerated-smooth-scroll'
"NeoBundle 'scrooloose/nerdtree.git'

" utility search
NeoBundle 'haya14busa/incsearch.vim'

" utility input
NeoBundle 'Shougo/neosnippet'
NeoBundle 'scrooloose/snipmate-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Align'
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'koron/imcsc-vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'mattn/emmet-vim'

"NeoBundle 'kana/vim-operator-replace.git'
"NeoBundle 'thinca/vim-splash'
"NeoBundle 'terryma/vim-multiple-cursors'
"NeoBundle 'haya14busa/vim-easymotion'

" operator
NeoBundle 'kana/vim-operator-user.git'

" textobj
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'akiyan/vim-textobj-php'
NeoBundle 'bps/vim-textobj-python'
NeoBundle 'kana/vim-textobj-datetime'
NeoBundle 'mattn/vim-textobj-url'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-jabraces'
NeoBundle 'vimtaku/vim-textobj-keyvalue'
NeoBundle 'RyanMcG/vim-textobj-dash'
NeoBundle 'deris/vim-textobj-enclosedsyntax'

"tool
NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'cocopon/colorswatch.vim'
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'mattn/gist-vim'
"NeoBundle 'mbbill/undotree'
"NeoBundle 'YankRing.vim'
"NeoBundle 'mru.git'
"NeoBundle 'mttn/zen-coding.vim'

"sublime text 2 NeoBundle 'mattn/multi-vim'
NeoBundle 'koron/minimap-vim'
"NeoBundle 'koron/minimap-vim'

" sound
NeoBundle 'osyo-manga/vim-sound'

"language
" SQL
NeoBundle 'vim-scripts/dbext.vim', '18.0'
" html5
NeoBundle 'othree/html5.vim'
NeoBundle 'hokaccha/vim-html5validator'
NeoBundle 'hail2u/vim-css3-syntax'

"php
NeoBundleLazy 'stephpy/vim-php-cs-fixer', {
\    'autoload' : {
\        'filetypes': 'php',},}
" python
NeoBundle 'python.vim'
NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'pythoncomplete'
NeoBundle 'nvie/vim-flake8'
" java
NeoBundle 'claco/jasmine.vim'

" javascript
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'STRML/JSXHint'

" coffeescript
NeoBundle 'kchmck/vim-coffee-script'
" ruby
NeoBundle 'bbatsov/rubocop'
" cpp
NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }
NeoBundle 'mediawiki.vim'
"NeoBundle 'wikipedia.vim'

" jade
NeoBundle 'digitaltoad/vim-jade'
" arduino
NeoBundle "sudar/vim-arduino-syntax"

" less
NeoBundle 'groenewege/vim-less'

" stylus
NeoBundle 'wavded/vim-stylus'

" SmallTalk
NeoBundle 'vim-scripts/st.vim'

"Lua
NeoBundle 'lua-support'
NeoBundle 'luarefvim'
"Tex
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'

" md
NeoBundle 'kannokanno/previm'

"Game
"NeoBundle 'amix/vim-2048'
NeoBundle 'AshyIsMe/2048'
"NewGame2048
NeoBundle 'thinca/vim-threes'
"ThreesStart
"NeoBundle 'sudoku_game'
"Sudoku~~
NeoBundle 'mfumi/viminesweeper'
"MineSweeper
"NeoBundle 'TeTrls.vim'
"
NeoBundle 'mattn/invader-vim'
"Invader
NeoBundle 'deris/vim-duzzle'
"DuzzleStart
"nmap <Leader>gt :source<Space>TeTrls.vim<Enter>

"twitter
NeoBundle 'basyura/TweetVim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
"NeoBundle 'TwitVim'

"git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'cohama/agit.vim'


"colorscheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'phd'
NeoBundle 'vim-scripts/summerfruit256.vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'sfsekaran/cobalt.vim'

" browsing
NeoBundle 'yuratomo/w3m.vim'

" funny
NeoBundle 'mattn/vim-kaikyaku-buster'

call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

" }}} -end Bundles
