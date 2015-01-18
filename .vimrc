"  {{{ -Encoding 
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
"  }}} -end -Encoding 
" {{{ NeoBundleOptions
"  {{{ -Initialize
"neobundle
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle'))
endif

"for path in split(glob('~/.vim/bundle/*'), '\n')
"    if isdirectory(path) | let &runtimepath = &runtimepath.','.path | end
"endfor

""vundle option
"set runtimepath+='~\.vim\bundle\'
"call vundle#rc()

"  }}} end -Initialize
"  {{{ -Bundles
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

"NeoBundle 'kana/vim-operator-replace.git'
"NeoBundle 'haya14busa/vim-migemo'
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
"NeoBundle 'emmet-vim'

"html support
NeoBundle 'Emmet.vim'
"NeoBundle 'hokaccha/endtagcomment.vim'

"sublime text 2 NeoBundle 'mattn/multi-vim'
NeoBundle 'koron/minimap-vim'
"NeoBundle 'koron/minimap-vim'

" sound
NeoBundle 'osyo-manga/vim-sound'

"language
" html5
NeoBundle 'othree/html5.vim'
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
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'javacomplete'
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
" arduino
NeoBundle "sudar/vim-arduino-syntax"

" less
NeoBundle 'groenewege/vim-less'

" stylus
NeoBundle 'wavded/vim-stylus'
"NeoBundle 'css3'

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
"nmap ,gt :source<Space>TeTrls.vim<Enter>

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


call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

"  }}} -end Bundles

" }}} -end NeoBundleOptions
" {{{ MyConfig
"  {{{ -StartupOptions

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" vi互換
" set nocompatible
" clipboard 設定
set clipboard=unnamedplus,autoselect
set modifiable
set write

set guioptions=arc
set textwidth=0
set langmenu=ja_jp.utf-8
set hlsearch
" commandline complete
set wildmenu
set wildmode=longest:full,full
"空へはばたけ
"set virtualedit=all
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" 拡張子からファイルタイプ変更
filetype on

" tags
set tags=./tags,../tags,../../tags,../../../tags,.git/*.tags
au MyAutoCmd BufNewFile,BufRead *.php set tags+=$HOME/php.tags 
au MyAutoCmd BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"

au MyAutoCmd BufNewFile,BufRead,BufEnter * execute ":lcd" . expand ("%:p:h")
set foldmethod=marker
set nowrap

set autochdir

set laststatus=2
set autochdir
set guifont=Ricty\ 10
"colorscheme
syntax enable
"colorscheme solarized
set t_Co=256
set background=dark
"colorscheme badwolf
colorscheme badwolf

"colorscheme ron "set incsearch

"backup
set undofile
set undodir=~/.vim/undo/
set nobackup
set noswapfile
set nodiff
set formatoptions=q


"tab space
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


" プレビューウィンドウ非表示
set completeopt=longest,menu

"numbr
set number
behave mswin

"Window position
winpos 683 0
set cmdheight=1


"set cursorline				" カーソル行をハイライト
"set cursorcolumn		    " カーソル列をハイライト
"augroup cch
"	autocmd! cch
"	autocmd WinLeave * set nocursorline
"	autocmd WinEnter,BufRead * set cursorline
"augroup END
"hi CursorLine ctermbg=black guibg=black
"augroup vimrc-auto-cursorline
"  autocmd!
"  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
"  autocmd CursorHold,CursorHoldI * setlocal cursorline
"augroup END

"  }}} -end -StartupOptions
"  {{{ -Key mapping
"
" Unbind key
nnoremap gt <Nop>
nnoremap gT <Nop>

inoremap <C-BS> <C-W>
nnoremap <silent> <Leader><Leader> :<C-u>so<space>~/.vimrc<CR>
nnoremap <silent> <Space>p :<C-u>tabnew $MYVIMRC<CR>

nnoremap ,ym :<C-u>MessCopy<CR>

" setting 
nnoremap <silent> <Space>u :10sp solved.memo<CR><C-w>j:vs todo.memo<CR>

"inoremap <BS> <Nop>

"Movement
nnoremap G Gzz
nnoremap V V$h
vnoremap v $h

nnoremap * *zz
nnoremap # #zz

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap gT <Nop>

nnoremap <C-CR> O<Esc>

"Super input
nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
"Switching Opacity
let g:save_window_file = expand('~/.vim/.vimwinpos')
if has("win32")
    nnoremap ,oo :set tra=220<CR>
    nnoremap ,on :set tra=0<CR>
    nnoremap ,o+ :set tra+=10<CR>
    nnoremap ,o- :set tra-=10<CR>
else
    function! s:Transset(opacity)
        call system('transset-df --id ' . v:windowid . ' ' . a:opacity)
    endfunction
    command! -nargs=1 Transset call <SID>Transset(<q-args>) 
    nnoremap ,oo :set tra=220<CR>
    nnoremap ,on :set tra=0<CR>
    nnoremap ,o+ :set tra+=10<CR>
    nnoremap ,o- :set tra-=10<CR>
endif
"Window Scaleup
nnoremap ,wj 10<C-W>+
nnoremap ,wk 10<C-W>-
nnoremap ,wl 10<C-W>>
nnoremap ,wh 10<C-W><
nnoremap <C-;> <S-A>;<Esc>
"inoremap <C-;> <Esc><S-A>;

nnoremap ,a gg<S-V><S-G>a
"Open on other app
"nnoremap ,e :!explorer .<CR>

" Special Command
nnoremap ,min :set lines=20<CR>:set columns=30<CR>:winpos 1100 420<CR>
" filetype
nnoremap ,ft :set filetype=
nnoremap ,gf :set guifont=Ricty\ 40

"
nnoremap ,nr :set rnu<CR>
nnoremap ,nn :set nornu<CR>

" expandtab
nnoremap ,ex :set expandtab<CR>
nnoremap ,en :set noexpandtab<CR>

"reopen
nnoremap ,ee :e ++enc=utf8
nnoremap ,er :e ++ff=dos

" 強制書き込み
nnoremap ,w :w !sudo tee %<CR>
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
"" 次の単語へ移動
"cnoremap <M-f> <S-Right>

nnoremap <silent> Q :quitall<CR>

"switching windows
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

"  }}} -end -KeyMapping
"  {{{ -Augroup
"   {{{ -BinayMode 
"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
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

"   }}} -end
"
"  }}} -end -Augroup
"  {{{ -SavePosition 
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
"if filereadable(g:save_window_file)
"  execute 'source' g:save_window_file
"endif

"  }}} -end -SavePosition 
"  {{{ -Funcs
command! MessCopy call s:messcopy()
function! s:messcopy()
redir @+>
silent messages
redir END
" Copy to selection too.
call setreg('*', getreg('+', 1), getregtype('+'))
echo 'yanked messages'
endfunction

"  }}} -end Funcs

" }}} -end MyConfig
" {{{ PluginOptions
"  {{{ config resense
let g:rsenseHome = '/opt/rsense-0.3'
let g:rsenseUseOmniFunc = 1

"   }}} -end
"  {{{ config ctrlp 
let g:ctrlp_use_migemo = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 500
let g:ctrlp_open_new_file = 1
let g:ctrlp_map = '<c-p>'
"   {{{ ctrlp mapping
nnoremap ,p :<C-u>CtrlP<CR>

"   }}} -end

"  }}} -end
"  {{{ config neocomlete
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
    \ 'default'    : '',
    \ 'php'        : join([b:dict_path.'PHP.dict', b:dict_path.'html.dict', b:dict_path.'twitter.dict'], ','),
    \ 'ruby'       : join([b:dict_path.'twitter.dict'], ','),
    \ 'javascript' : join([b:dict_path.'javascript.dict', b:dict_path.'jQuery.dict'], ','),
    \ 'css'        : join([b:dict_path.'css.dict', b:dict_path.'html.dict'], ','),
    \ 'less'       : join([b:dict_path.'css.dict', b:dict_path.'html.dict', b:dict_path.'bootstrap_less.dict'], ','),
    \ 'html'       : join([b:dict_path.'css.dict', b:dict_path.'html.dict', b:dict_path.'bootstrap_less.dict'], ','),
    \ 'c'          : join([b:dict_path.'c.dict'], ','),
    \ 'cpp'        : join([b:dict_path.'cpp.dict'], ',')
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
au MyAutoCmd FileType coffee     :setlocal omnifunc=jscomplete#CompleteJS
au MyAutoCmd FileType html       :setlocal omnifunc=htmlcomplete#CompleteTags
au MyAutoCmd FileType css        :setlocal omnifunc=csscomplete#CompleteCSS
au MyAutoCmd FileType xml        :setlocal omnifunc=xmlcomplete#CompleteTags
au MyAutoCmd FileType php        :setlocal omnifunc=phpcomplete#CompletePHP
au MyAutoCmd FileType c          :setlocal omnifunc=ccomplete#Complete
au MyAutoCmd FileType ruby       :setlocal omnifunc=rubycomplete#Complete

"   }}}

"  }}} -end
"  {{{ config neosnippet 
let g:neosnippet#snippets_directory='~/.vim/snippets/, ~/var_dumvar_dumpp.vim/snippets/, ~/.vim/bundle/neosnippet-snippets'

imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><C-l>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ '\<Plug>(neosnippet_expand_or_jump)' : '\<C-n>'
" SuperTab like snippets behavior.
"   {{{ neosnippet mapping
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
nmap g/ :Unite -buffer-name=search line:forward -start-insert -auto-highlight<CR>

"   }}} -end

"  }}} -end
"  {{{ config unite
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
nnoremap <silent> ,ub :<C-u>Unite buffer -start-insert<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru -start-insert<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file -direction=botright <cr>
nnoremap <silent> ,uc :<C-u>Unite colorscheme -auto-preview<CR>
map ,ur :Unite -buffer-name=register register<CR>
map ,uy     :Unite history/yank<CR>

nnoremap <silent> <Space>g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

nnoremap <silent> <Space>/ :<C-u>Unite -buffer-name=search line -start-insert<CR>

nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>

let s:hooks = neobundle#get_hooks('unite.vim')

"   }}} -end

"  }}} -end
"  {{{ config vimfiler
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

function! s:hooks.on_source(bundle)
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    " use vimfiler to open directory
    call unite#custom_default_action('source/bookmark/directory', 'vimfiler')
    call unite#custom_default_action('directory', 'vimfiler')
    call unite#custom_default_action('directory_mru', 'vimfiler')
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        imap <buffer> <Esc><Esc> <Plug>(unite_exit)
        nmap <buffer> <Esc> <Plug>(unite_exit)
        nmap <buffer> <C-n> <Plug>(unite_select_next_line)
        nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
    endfunction
endfunction
"   {{{ vimfiler mapping
" open vimfiler
nnoremap <silent><A-1> :<C-u>VimFilerExplorer<CR>:Tlist<CR>

"   }}} -end

"  }}} -end
"  {{{ config TweetVim
let g:tweetvim_open_say_cmd = 'botright split'
"   {{{ TweetVim mapping
nnoremap ,twl :TweetVimHomeTimeline<Enter>
nnoremap ,twe :TweetVimSay<Enter>10<C-w><Esc>:set<Space>winheight=10<Enter>
nnoremap ,twm :TweetVimMentions<Enter>
nnoremap ,tws :TweetVimSwitchAccount<Space>
nnoremap ,twh :let<Space>g:tweetvim_footer="#"<Left>

"   }}} -end

"  }}} -end
"  {{{ config Align
"let g:Align_enable_at_startup = 1;
let g:Align_xstrlen=3

"  }}} -end
"  {{{ config lightLine
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
            \   'fugitive': 'MyFugitive',
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

"  }}} -end
"  {{{ config startify
nnoremap ,sf :Startify<Enter>
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
  \ '~/workspace',
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
set foldtext=foldCC#foldtext()
let g:foldCCtext_head = 'repeat(":", v:foldlevel) . "> "'
let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

"  }}} -end
"  {{{ config over.vim
" over.vimの起動
"   {{{ over mapping
nmap <silent> <Space>: :OverCommandLine<CR>
nmap <silent> <Space>s :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

"   }}} -end

"  }}} -end
"  {{{ config Quickrun
let g:quickrun_config={'*': {'split': ''}}
"   {{{ Quicakrun mapping
nnoremap <silent> ,q :QuickRun<CR>

"   }}} -end

"  }}} -end
"  {{{ config yankround
let g:yankround_max_history = 50
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
"   {{{ yankround mapping
" nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

"   }}} -end

"  }}} -end
"  {{{ config vim-indent-guides
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

"  }}} -end
"  {{{ config Switch.vim
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

"  }}} -end
"  {{{ config gist.vim
let g:github_user = 'elzzup'
let g:github_token = '688153244513531cc44c754637f19ee9f4debd97'
let g:gist_curl_options = '-k'
let g:gist_private = '-P'
let g:gist_detect_filetype = 1

"  }}} -end
"  {{{ config TagList.vim
let g:Tlist_Use_Split_Window = 1
let g:Tlist_WinHeight = 20

"  }}} -end
"  {{{ config gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_sign_modified_removed = '✔'

"  }}} -end
"  {{{ config rubocop
" robocop
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'passive_filetypes': ['python']
    \}

"  }}}
"  {{{ config emmet
let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }


"  }}}
"  {{{ config jscomplete
" DOMとMozilla関連とES6のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']

"  }}}
"  {{{ config textobj-user
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
"  {{{ config open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"  }}}
"  {{{ config cpp-vim
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
"  {{{ config previm
let g:previm_open_cmd = 'firefox '

"  }}}
"  {{{ config incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"  }}}
"  {{{ config jedi-search
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
"  {{{ config php_cs_fixer
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
"  {{{ config bps/vim-textobj-python
let g:textobj_python_no_default_key_mappings = 1

"  }}}
"  {{{ config latex
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'xdg-open'
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
"let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'

"  }}}
"  {{{ [x] config neocomplcache
"" let g:acp_enableAtStartup = 0
"" let g:neocomplcache_enable_at_startup = 1
"" let g:neocomplcache_enable_smart_case = 1
"" let g:neocomplcache_enable_camel_case_completion = 1
"" let g:neocomplcache_enable_underbar_completion = 1
"" let g:neocomplcache_min_syntax_length = 3
"" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : ''
"    \ }
"
"" omuni
""let g:neocomplcache_omni_patterns
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplcache#smart_close_popup() . "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"
""au FileType javascript call JavaScriptFold()
""au BufRead,BufNewFile jquery.*.js set filetype=javascript syntax=jquery
"let $DICT_DIR='~/.vim/dict/'
"let g:neocomplcache_dictionary_filetype_lists = {
"            \ 'default'    : '',
"            \ 'php'        : $DICT_DIR.'PHP.dict,'       .$DICT_DIR.'html.dict'  ,
"            \ 'javascript' : $DICT_DIR.'javascript.dict,'.$DICT_DIR.'jQuery.dict',
"            \ 'css'        : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  ,
"            \ 'less'       : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  .$DICT_DIR.'bootstrap_less.dict',
"            \ 'html'       : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  .$DICT_DIR.'bootstrap_less.dict',
"            \ 'c'          : $DICT_DIR.'c.dict',
"            \ 'cpp'        : $DICT_DIR.'cpp.dict'
"            \ }
"if !exists('g:neocomplcache_keyword_patterns')
"        let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"  }}} -end
"  {{{ [x] config undotree.vim
"let g:undotree_EnableAtStartup = 1
"let g:undotree_SetFocusWhenToggle = 1
"let g:undotree_SplitLocation = 'topleft'
"let g:undotree_SplitWidth = 35
"let g:undotree_diffAutoOpen = 1
"let g:undotree_diffpanelHeight = 25
"let g:undotree_RelativeTimestamp = 1
"let g:undotree_TreeNodeShape = '*'
"let g:undotree_HighlightChangedText = 1
"let g:undotree_HighlightSyntax = "UnderLined"

"  }}} -end
"  {{{ [x] config easymotion
""easy-motion option
"let g:EasyMotion_keys='hjklasdfyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"let g:EasyMotion_smartcase=1
"let g:EasyMotion_use_migemo=1
"let g:EasyMotion_leader_key="'"
"let g:EasyMotion_grouping=1
"hi EasyMotionTarget ctermbg=none ctermfg=red
"hi EasyMotionShade  ctermbg=none ctermfg=blue

"  }}} -end
"  {{{ [x] config im_control
" 「日本語入力固定モード」切替キー
"inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
"" PythonによるIBus制御指定
"let IM_CtrlIBusPython = 1
""バッファ毎に日本語入力固定モードの状態を制御。
"let g:IM_CtrlBufLocalMode = 1

"  }}} -end
"  {{{ [x] config NERDTree
" "   {{{ NERDTree mapping
" nnoremap <silent>,nt :<C-u>NERDTree<CR>
" 
" "   }}} -end
" 
"  }}} -end

" }}} -end PluginOptions
" vim:set foldmethod=marker:
