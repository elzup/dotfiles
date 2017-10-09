" {{{ init
if &compatible
  set nocompatible
endif

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER
      \ && $HOME !=# expand('~'.$USER)
      \ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
  return s:is_windows
endfunction

function! IsMac()
  return !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
endfunction

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

" }}}
" {{{ encoding
set encoding=utf-8
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

scriptencoding utf-8

" }}}
" {{{ basic
"  {{{ -Startup Options
" clipboard 設定
set clipboard=unnamedplus,autoselect
set modifiable
set write

set guioptions=arc
set textwidth=0
set langmenu=ja_jp.utf-8
set hlsearch
" command line complete
set wildmenu
set wildmode=longest:full,full
" 空へはばたけ
" set virtualedit=all
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" 拡張子からファイルタイプ変更
filetype on

" 10進数インクリメント
set nrformats=hex
" tags
set tags=./tags,../tags,../../tags,../../../tags,.git/*.tags
au MyAutoCmd BufNewFile,BufRead *.php set tags+=$HOME/php.tags 
au MyAutoCmd BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"

au MyAutoCmd BufNewFile,BufRead,BufEnter * execute ":lcd" . expand ("%:p:h")
set foldmethod=marker
set nowrap

set scrolloff=5
if has("gui_running")
    set transparency=10
endif

" Depreciated
" set autochdir

set laststatus=2
if has("mac")
    set guifont=Ricty\ Regular\ for\ Powerline:h16
else
    set guifont=Ricty\ 10
endif

" color scheme
syntax enable
" color scheme solarized
set t_Co=256
set background=dark

" backup
set undofile
set undodir=~/.vim/undo/
set nobackup
set noswapfile             " I am Japanese Idol
set nodiff
set formatoptions=q


" tab space
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set list
set listchars=tab:▸-,trail:-,nbsp:%,extends:>,precedes:<,eol:$

" 大文字小文字
set ignorecase
" 大文字を含む場合は区別
set smartindent
set incsearch
set splitright

" スペルチェック
" set spell
set nospell
set spelllang=en,cjk

" プレビューウィンドウ非表示
set completeopt=longest,menu

" number
set relativenumber
set number
behave mswin

set modeline
set modelines=5

" Window position
winpos 683 0
set cmdheight=1

" カーソル行をハイライト
set cursorline
" カーソル列をハイライト
" set cursorcolumn

"  }}} end -Startup Options
"  {{{ -Binary Mode
" バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set filetype=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r
    autocmd BufWritePre * endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

"  }}} -end Binary Mode
"  {{{ -Save Position
if has("win32")
    let g:save_window_file = expand('~/.vim/.vimwinpos')
    augroup SaveWindow
        autocmd!
        autocmd VimLeavePre * call s:save_window()
        function! s:save_window()
            let options = [
                        \ 'set columns=' . &columns,
                        \ 'set lines=' . &lines,
                        \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
                        \ ]
            call writefile(options, g:save_window_file)
        endfunction
    augroup END
else
    set columns=100
    set lines=30
endif
" if filereadable(g:save_window_file)
"  execute 'source' g:save_window_file
" endif

"  }}} -end -Save Position 
"  {{{ -Funcs
"   {{{ -Mess Copy
command! MessCopy call s:messcopy()
function! s:messcopy()
redir @+>
silent messages
redir END
" Copy to selection too.
call setreg('*', getreg('+', 1), getregtype('+'))
echo 'yanked messages'
endfunction

"   }}} -end Mess Copy

"  }}} -end Funcs

" }}}
" {{{ mapping
" switch colons
" nnoremap ; :
" nnoremap : ;

inoremap <C-BS> <C-W>
nnoremap <silent> <Leader><Leader> :<C-u>so<space>~/.vimrc<CR>
nnoremap <silent> <Space>p :<C-u>tabnew ~/.vim/rc/init.vim<CR>

nnoremap <Leader>ym :<C-u>MessCopy<CR>

" setting 
nnoremap <silent> <Space>u :10sp solved.memo<CR><C-w>j:vs snippet.memo<CR>:vs keywords.md<CR>

" inoremap <BS> <Nop>

" Movement
nnoremap G Gzz
nnoremap V V$h
vnoremap v $h

nnoremap * *zz
nnoremap # #zz

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <C-CR> O<Esc>

" Super input
nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
" Window Scaleup
nnoremap <Leader>wj 10<C-W>+
nnoremap <Leader>wk 10<C-W>-
nnoremap <Leader>wl 10<C-W>>
nnoremap <Leader>wh 10<C-W><
nnoremap <C-;> <S-A>;<Esc>
" inoremap <C-;> <Esc><S-A>;

nnoremap <Leader>a gg<S-V><S-G>a
" Open on other app
" nnoremap <Leader>e :!explorer .<CR>

" Special Command
nnoremap <Leader>min :set lines=20<CR>:set columns=30<CR>:winpos 1100 420<CR>
" filetype
nnoremap <Leader>ft :set filetype=
if has("mac")
    nnoremap <Leader>gf :set guifont=Ricty\ Regular\ for\ Powerline:h40
else
    nnoremap <Leader>gf :set guifont=Ricty\ 40
endif
"
nnoremap <Leader>nr :set relativenumber<CR>
nnoremap <Leader>nn :set norelativenumber<CR>

" expandtab
nnoremap <Leader>ex :set expandtab<CR>
nnoremap <Leader>en :set noexpandtab<CR>
inoremap <S-Tab> <C-V><Tab>

" reopen
nnoremap <Leader>ee :e ++enc=utf8
nnoremap <Leader>ew :e ++ff=dos

" spell switch
" nnoremap <Leader>Sa :set spell<CR>
" nnoremap <Leader>Sd :set nospell<CR>

" 強制書き込み
nnoremap <Leader>w :w !sudo tee %<CR>
" emacs comamndline
cnoremap <C-a> <Home>
" 一文字戻る
cnoremap <C-b> <Left>
" カーソルの下の文字を削除
cnoremap <C-d> <Del>
" 行末へ移動
cnoremap <C-e> <End>
" 一文字進む
cnoremap <C-f> <Right>
" コマンドライン履歴を一つ進む
cnoremap <C-n> <Down>
" コマンドライン履歴を一つ戻る

cnoremap <C-p> <Up>
" 前の単語へ移動
cnoremap <M-b> <S-Left>
" " 次の単語へ移動
" cnoremap <M-f> <S-Right>

nnoremap <silent> Q :quitall<CR>

" switching windows
" nnoremap s <Nop>
" nnoremap sj <C-w>j
" nnoremap sk <C-w>k
" nnoremap sl <C-w>l
" nnoremap sh <C-w>h
" nnoremap sJ <C-w>J
" nnoremap sK <C-w>K
" nnoremap sL <C-w>L
" nnoremap sH <C-w>H
" nnoremap sn gt
" nnoremap sp gT
" nnoremap sr <C-w>r
" nnoremap s= <C-w>=
" nnoremap sw <C-w>w
" nnoremap so <C-w>_<C-w>|
" nnoremap sO <C-w>=
" nnoremap sN :<C-u>bn<CR>
" nnoremap sP :<C-u>bp<CR>
" nnoremap st :<C-u>tabnew<CR>
" nnoremap sT :<C-u>Unite tab<CR>
" nnoremap ss :<C-u>sp<CR>
" nnoremap sv :<C-u>vs<CR>
" nnoremap sq :<C-u>q<CR>
" nnoremap sQ :<C-u>bd<CR>
" nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
" nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

" scripts
cnoremap <Leader>cc :CountText<CR>
cnoremap <Leader>cl :CountLine<CR>

" scripts
cnoremap <Leader>sp :set spell<CR>
cnoremap <Leader>spn :set nospell<CR>
cnoremap <Leader>nsp :set nospell<CR>

" }}}
" {{{ VimPlug
"  {{{ -Initialize
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

"  }}} end -Initialize
"  {{{ -Bundles
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
Plug 'sjl/gundo.vim'
"NeoBundle 'yonchu/accelerated-smooth-scroll'
"NeoBundle 'scrooloose/nerdtree'

" utility search
Plug 'haya14busa/incsearch.vim'

" utility input
Plug 'Shougo/neosnippet'
Plug 'scrooloose/snipmate-snippets'
Plug 'tpope/vim-surround'
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
Plug 'junegunn/vim-easy-align'

" Plug 'vim-scripts/Align'
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
Plug 'editorconfig/editorconfig-vim'
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
Plug 'vim-scripts/python.vim', { 'for': ['python'] }
Plug 'kevinw/pyflakes-vim', { 'for': ['python'] }
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }
Plug 'vim-scripts/pythoncomplete', { 'for': ['python'] }
Plug 'nvie/vim-flake8', { 'for': ['python'] }

" java
Plug 'claco/jasmine.vim', { 'for': ['java'] }

" javascript
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript']}
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }
" Plug 'mattn/jscomplete-vim', { 'for': ['javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
Plug 'STRML/JSXHint', { 'for': ['javascript'] }

" coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': ['coffeescript'] }

" ruby
Plug 'bbatsov/rubocop', { 'for': ['ruby'] }

" cpp
Plug 'vim-jp/cpp-vim', { 'for': 'cpp' }
Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'cpp']}

" Plug 'vim-scripts/mediawiki.vim'
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
" Plug 'lua-support'
" Plug 'luarefvim'
"Tex
" Plug 'lervag/vim-latex'
" Plug 'lervag/vimtex'
"
" Erlang
Plug 'vim-erlang/vim-erlang-omnicomplete'

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
Plug 'vim-sciprts/phd'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'sfsekaran/cobalt.vim'

" browsing
Plug 'yuratomo/w3m.vim'

" funny
" Plug 'mattn/vim-kaikyaku-buster'

call plug#end()

filetype plugin on
filetype indent on

"  }}} -end Bundles

" }}}
" {{{ mac setting
if IsMac()
    set clipboard=unnamed,autoselect
    colorscheme phd
    set guioptions-=a

    if has('gui_macvim')
        let $PYTHON3_DLL="/usr/local/Cellar/python3/3.4.1_1/Frameworks/Python.framework/Versions/3.4/Python"
    endif
endif

" }}}
"  {{{ Preserve
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

" Shift + F
" autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

"  }}}
"  {{{ Codic
inoremap <silent> <C-x><C-t>  <C-R>=<SID>codic_complete()<CR>
function! s:codic_complete()
  let line = getline('.')
  let start = match(line, '\k\+$')
  let cand = s:codic_candidates(line[start :])
  call complete(start +1, cand)
  return ''
endfunction
function! s:codic_candidates(arglead)
  let cand = codic#search(a:arglead, 30)
  " error
  if type(cand) == type(0)
    return []
  endif
  " english -> english terms
  if a:arglead =~# '^\w\+$'
    return map(cand, '{"word": v:val["label"], "menu": join(map(copy(v:val["values"]), "v:val.word"), ",")}')
  endif
  " Japanese -> English terms
  return s:reverse_candidates(cand)
endfunction
function! s:reverse_candidates(cand)
  let _ = []
  for c in a:cand
    for v in c.values
      call add(_, {"word": v.word, "menu": !empty(v.desc) ? v.desc : c.label })
    endfor
  endfor
  return _
endfunction

"  }}}
"  {{{ cpp  vim
augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.1/include/
augroup END
let g:clang_jumpto_declaration_key = '<C-t>'

" コマンドオプション
let g:clang_user_options = '-std=c++11'


" clang_complete では自動補完を行わない用に設定
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

"  }}}
"  {{{ Ctrl+P
let g:ctrlp_use_migemo = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 500
let g:ctrlp_open_new_file = 1
let g:ctrlp_map = '<c-p>'
"   {{{ ctrlp mapping
nnoremap <Leader>p :<C-u>CtrlP<CR>

"   }}} -end

"  }}}
"  {{{ Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,js EmmetInstall

let g:user_emmet_settings = {
\    'variables': {
\      'lang': "ja"
\    },
\   'indentation': '  '
\ }

"  }}}
"  {{{ github
let g:github_user = 'elzup'
let g:github_token = '688153244513531cc44c754637f19ee9f4debd97'
let g:gist_curl_options = '-k'
let g:gist_private = '-P'
let g:gist_detect_filetype = 1
" mac
if has("mac")
    let g:gist_clip_command = 'pbcopy'
endif


"  }}}
"  {{{ gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_sign_modified_removed = '✔'


"  }}}
"  {{{ jode reanme
command! -nargs=0 JediRename :call jedi#rename()
"let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
"let g:jedi#rename_command = ""

"if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"  }}}
"  {{{ lightline
" lightline
let g:lightlineEnableAtStartup = 1
let g:lightline = {
            \ 'mode_map': { 'c': 'NORMAL' },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode',
            \ },
            \ 'separator': { 'left': '⮀', 'right': '⮂' },
            \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
            \ }

function! MyModified()
    return &filetype =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&filetype == 'vimfiler' ? vimfiler#get_status_string() : 
                \  &filetype == 'unite' ? unite#get_status_string() : 
                \  &filetype == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? '⭠ '._ : ''
    endif
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" tabline
let g:lightline.tabline = {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'close' ] ]
        \ }


"  }}}
"  {{{ neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#min_syntax_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" bit another completes
let g:neocomplete#force_overwrite_completefunc = 1

" Define dictionary.
let b:dict_path='/home/hiro/.vim/dict/'

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default'       : '',
    \ 'php'           : join([b:dict_path.'PHP.dict', b:dict_path.'html.dict', b:dict_path.'twitter.dict'], ','),
    \ 'ruby'          : join([b:dict_path.'twitter.dict'], ','),
    \ 'javascript'    : join([b:dict_path.'javascript.dict', b:dict_path.'jQuery.dict'], ','),
    \ 'css'           : join([b:dict_path.'css.dict', b:dict_path.'html.dict'], ','),
    \ 'stylus'        : join([b:dict_path.'css.dict', b:dict_path.'html.dict'], ','),
    \ 'less'          : join([b:dict_path.'css.dict', b:dict_path.'html.dict', b:dict_path.'bootstrap_less.dict'], ','),
    \ 'html'          : join([b:dict_path.'css.dict', b:dict_path.'html.dict', b:dict_path.'bootstrap_less.dict'], ','),
    \ 'c'             : join([b:dict_path.'c.dict'], ','),
    \ 'cpp'           : join([b:dict_path.'cpp.dict'], ','),
    \ 'editmsg'       : join(['~/.vim/dict/git/*.dict'], ',')
    \ }

" omuni
"let g:neocomplete#omni_patterns
if !exists('g:neocomplete#omni_patterns')
  let g:neocomplete#omni_patterns = {}
endif
let g:neocomplete#omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#omni_patterns.c = '[^. *\t]\.\w*\|\h\w*::'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

"au FileType javascript call JavaScriptFold()
"au BufRead,BufNewFile jquery.*.js set filetype=javascript syntax=jquery
"   {{{ lang omuni complete
au MyAutoCmd FileType java       :setlocal omnifunc=javacomplete#Complete
au MyAutoCmd FileType java       :setlocal completefunc=javacomplete#CompleteParamsInfo
au MyAutoCmd FileType python     :setlocal omnifunc=pythoncomplete#Complete
au MyAutoCmd FileType javascript :setlocal omnifunc=jscomplete#CompleteJS
au FileType javascript :setlocal omnifunc=jscomplete#CompleteJS
au MyAutoCmd FileType coffee     :setlocal omnifunc=jscomplete#CompleteJS
au MyAutoCmd FileType html       :setlocal omnifunc=htmlcomplete#CompleteTags
au MyAutoCmd FileType css        :setlocal omnifunc=csscomplete#CompleteCSS
au MyAutoCmd FileType xml        :setlocal omnifunc=xmlcomplete#CompleteTags
au MyAutoCmd FileType php        :setlocal omnifunc=phpcomplete#CompletePHP
au MyAutoCmd FileType c          :setlocal omnifunc=ccomplete#Complete
au MyAutoCmd FileType ruby       :setlocal omnifunc=rubycomplete#Complete

"   }}}


"  }}}
"  {{{ neosnippet
let g:neosnippet#snippets_directory='~/.vim/snippets/, ~/var_dumvar_dumpp.vim/snippets/, ~/.vim/bundle/neosnippet-snippets'

imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><C-l>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ '\<Plug>(neosnippet_expand_or_jump)' : '\<C-n>'
" SuperTab like snippets behavior.
" {{{ neosnippet mapping
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
nmap g/ :Unite -buffer-name=search line:forward -start-insert -auto-highlight<CR>
" imap <S-Space> <Space>

" }}} -end


"  }}}
"  {{{ previm
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


"  }}}
"  {{{ php cs fixer
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    let g:php_cs_fixer_path = '$HOME/.vim/phpCsFixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
    let g:php_cs_fixer_level='all'              " which level ?
    let g:php_cs_fixer_config='default'         " configuration
    let g:php_cs_fixer_php_path='php'           " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = 'linefeed,short_tag,indentation'
    let g:php_cs_fixer_enable_default_mapping=1 " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run=0                " Call command with dry-run option
    let g:php_cs_fixer_verbose=0                " Return the output of command if 1, else an inline information.
    nnoremap <Leader>php :call PhpCsFixerFixFile()<CR>
endfunction
unlet s:hooks


"  }}}
"  {{{ Quickrun
let g:quickrun_config={'*': {'split': ''}}
nnoremap <silent> <Leader>q :QuickRun<CR>

"  }}}
"  {{{ rsense
if IsMac()
    let g:rsenseHome = '/opt/rsense-0.3'
endif
let g:rsenseUseOmniFunc = 1

"  }}}
"  {{{ startify
" nnoremap <Leader>sf :Startify<Enter>
" startifyのヘッダー部分に表示する文字列を設定する(dateコマンドを実行して日付を設定している)
let g:startify_custom_header = [
\"                                    ..",
\"                                  .::::.",
\"                     ___________ :;;;;:`____________",
\"                     \_________/ ?????L \__________/",
\"                       |.....| ????????> :.......'",
\"                       |:::::| $$$$$$'`.:::::::' ,",
\"                      ,|:::::| $$$$'`.:::::::' .OOS.",
\"                    ,7D|;;;;;| $$'`.;;;;;;;' .OOO888S.",
\"                  .GDDD|;;;;;| ?`.;;;;;;;' .OO8DDDDDNNS.",
\"                   'DDO|IIIII| .7IIIII7' .DDDDDDDDNNNF`",
\"                     'D|IIIIII7IIIII7' .DDDDDDDDNNNF`",
\"                       |EEEEEEEEEE7' .DDDDDDDNNNNF`",
\"                       |EEEEEEEEZ' .DDDDDDDDNNNF`",
\"                       |888888Z' .DDDDDDDDNNNF`",
\"                       |8888Z' ,DDDDDDDNNNNF`",
\"                       |88Z'    'DNNNNNNN'",
\"                       '''        'MMMM'",
\"                                    ''",
\" ",
  \]
" よく使うファイルをブックマークとして登録しておく
let g:startify_bookmarks = [
  \ '~/.vimrc',
  \ '~/memos/.memo',
  \ ]
" \ map(split('date', '\n'), '"   ". v:val') + ['',''],
" デフォルトだと、最近使ったファイルの先頭は数字なので、使用するアルファベットを指定
let g:startify_custom_indices = split('a,b,c,d,f,g,i,m,n,p,r,u,v,w,x,y,z', ',')
"let g:startify_custom_indices = ['a','b','c','d','f','g','i','m','n','p','r','s','t','u','v','w','x','y','z']
let g:startify_list_order = [
  \ ['  Recently'],
  \ 'files',
  \ ['  Bookmarks'],
  \ 'bookmarks',
  \ ]
let g:startify_files_number = 10
"  \ ['  Recently in dir'],
"  \ 'dir',
"  \ ['  Sessions'],
"  \ 'sessions',

"  }}} -end
"  {{{ config foldCC
set foldtext=FoldCCtext()
let g:foldCCtext_head = 'repeat(":", v:foldlevel) . "> "'
let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'
let g:foldCCtext_enable_autofdc_adjuster = 1

"  }}} -end
"  {{{ config over.vim
" over.vimの起動
"   {{{ over mapping
nmap <silent> <Space>: :OverCommandLine<CR>
nmap <silent> <Space>s :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

"   }}} -end


"  }}}
"  {{{ switch
let g:switch_custom_definitions =
    \ [
    \   ['foo', 'bar', 'baz'],
    \   ['TRUE', 'FALSE'],
    \   ['true', 'false'],
    \   ['○', '×', '・'],
    \   ['―', '△', '▲', '○', '●'],
    \   ['absolute', 'relative', 'fixed'],
    \   ['left', 'right', 'top', 'bottom'],
    \   ['for', 'foreach', 'while']
    \ ]
nnoremap + :call switch#Switch(g:switch_custom_definitions)<cr>
nnoremap - :Switch<cr>


"  }}}
"  {{{ systastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': ['python', 'ruby', 'php', 'javascript']
    \}
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_checkers = ['jsxlint']
let g:syntastic_quite_warnings=0
nmap <Leader>s :SyntasticCheck<CR>


"  }}}
"  {{{ tagbar
let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort'    : 0,
\ }

"  }}}
"  {{{ textobj python
let g:textobj_python_no_default_key_mappings = 1
" textobj memo
"     word-column
" P   php <?= ?> <?php  ?>
" da  datetime 2014/10/20
" u   url http://hoge.com
" f   function func(){}
" jb  jabraces 「」【】
" dak keyvalue (key as value)
" -   dash /
" q   enclosedsyntax 正規表現
"  /hogehogeee/af asd 


"  }}}
"  {{{ tweetvim
let g:tweetvim_open_say_cmd = 'botright split'
"   {{{ TweetVim mapping
nnoremap <Leader>twl :TweetVimHomeTimeline<Enter>
nnoremap <Leader>twe :TweetVimSay<Enter>10<C-w><Esc>:set<Space>winheight=10<Enter>
nnoremap <Leader>twm :TweetVimMentions<Enter>
nnoremap <Leader>tws :TweetVimSwitchAccount<Space>
nnoremap <Leader>twh :let<Space>g:tweetvim_footer="#"<Left>

"   }}}

"  }}}
"  {{{ unite
" history/yank を有効化する
let g:unite_source_history_yank_enable = 1
call unite#custom#source('line', 'matchers', 'matcher_migemo')
"   {{{ unite grep
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_source_file_mru_limit = 100
let g:unite_source_file_mru_filename_format = ''
" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

"   }}} -end
"   {{{ unite mapping

nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file -direction=botright<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer -start-insert<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru -start-insert<CR>
nnoremap <silent> [unite]c :<C-u>Unite colorscheme -auto-preview<CR>
" nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>
nnoremap <silent> [unite]g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]G  :<C-u>Unite grep:. -buffer-name=search-buffer -no-quit<CR>

nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search line -start-insert<CR>

" map <Leader>ur :Unite -buffer-name=register register<CR>
" map <Leader>uy     :Unite history/yank<CR>


let s:hooks = neobundle#get_hooks('unite.vim')

"   }}} -end

"  }}}
"  {{{ indent
" Vim 起動時 vim-indent-guides を自動起動
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=1
" 自動カラー無効
" let g:indent_guides_auto_colors=0
" 奇数番目のインデントの色
au MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
" 偶数番目のインデントの色
au MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
" ガイドの幅
let g:indent_guides_guide_size = 1

"  }}}
"  {{{ vim php cs fixer
let s:hooks = neobundle#get_hooks('vim-php-cs-fixer')
function! s:hooks.on_source(bundle)
    let g:php_cs_fixer_path = '$HOME/.vim/phpCsFixer/php-cs-fixer' " define the path to the php-cs-fixer.phar
    let g:php_cs_fixer_level='all'              " which level ?
    let g:php_cs_fixer_config='default'         " configuration
    let g:php_cs_fixer_php_path='php'           " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = 'linefeed,short_tag,indentation'
    let g:php_cs_fixer_enable_default_mapping=1 " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run=0                " Call command with dry-run option
    let g:php_cs_fixer_verbose=0                " Return the output of command if 1, else an inline information.
    nnoremap <Leader>php :call PhpCsFixerFixFile()<CR>
endfunction
unlet s:hooks


"  }}}
"  {{{ vimshell
nnoremap <Leader>v :VimShell<CR>

"  }}}
"  {{{ vimfiler
" vimfiler
"" 自動起動
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
" セーフモードで起動
let g:vimfiler_safe_mode_by_default = 0
" editを新しいタブで開く
"let g:vimfiler_edit_action = 'tabopen'
"
"autocmd FileType vimfiler nmap u <BS>
"" [:e .]のように気軽に起動できるようにする
let g:vimfiler_as_default_explorer = 1
 
" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
" 'v'や'o'で開かれる新しいウィンドウのサイズを指定する
let g:netrw_winsize = 80

"   {{{ vimfiler mapping
" open vimfiler
" defualt
nnoremap <F1> :<C-u>VimFilerExplorer<CR>
  "}}}

"  }}}
"  {{{ vimshell
nnoremap <Leader>v :VimShell<CR>

"  }}}
"  {{{ vimtex
let g:vimtex_latexmk_enabled = 1
"let g:vimtex_latexmk_options = '-pdf'
let g:vimtex_latexmk_options = '-pdfdvi'
"let g:vimtex_latexmk_options = '-pdfps'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
let g:vimtex_view_method = 'general'
let g:vimtex_latexmk_callback = 0

if has('win32')
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
    let g:vimtex_view_general_options = '-forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
elseif has('unix')
    " let g:vimtex_view_general_viewer = 'open'
    let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    " let g:vimtex_view_general_viewer = 'open -a Skim'
    let g:vimtex_view_general_options = '@line @pdf @tex'
endif

let g:vimtex_fold_enabled = 1
let g:vimtex_fold_automatic = 1
let g:vimtex_fold_envs = 1
let g:vimtex_toc_split_pos = "topleft"
let g:vimtex_toc_width = 10

"  }}}
"  {{{ yankround
let g:yankround_max_history = 50
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
"   {{{ yankround mapping
" nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


"  }}}
" }}}
" }}}
" {{{ scripts
" scripts load
" call s:source_rc('./scripts/countline.vim')

" }}}
" vim:set foldmethod=marker
" vim:set foldcolumn=3
" vim:set foldlevel=0
