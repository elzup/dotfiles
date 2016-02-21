" {{{ -Startup Options
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

" tags
set tags=./tags,../tags,../../tags,../../../tags,.git/*.tags
au MyAutoCmd BufNewFile,BufRead *.php set tags+=$HOME/php.tags 
au MyAutoCmd BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"

au MyAutoCmd BufNewFile,BufRead,BufEnter * execute ":lcd" . expand ("%:p:h")
set foldmethod=marker
set nowrap

set scrolloff=5

" Depreciated
" set autochdir

set laststatus=2
if has("mac")
    set guifont=Ricty\ Regular\ for\ Powerline:h13
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
set noswapfile
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

" }}} end -Startup Options
" {{{ -Binary Mode
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

" }}} -end Binary Mode
" {{{ -Save Position
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

" }}} -end -Save Position 
" {{{ -Funcs
"  {{{ -Mess Copy
command! MessCopy call s:messcopy()
function! s:messcopy()
redir @+>
silent messages
redir END
" Copy to selection too.
call setreg('*', getreg('+', 1), getregtype('+'))
echo 'yanked messages'
endfunction

"  {{{ -end Mess Copy

" }}} -end Funcs
