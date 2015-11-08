" swich colons
" nnoremap ; :
" nnoremap : ;

inoremap <C-BS> <C-W>
nnoremap <silent> <Leader><Leader> :<C-u>so<space>~/.vimrc<CR>
nnoremap <silent> <Space>p :<C-u>tabnew ~/.vim/rc/init.vim<CR>

nnoremap <Leader>ym :<C-u>MessCopy<CR>

" setting 
nnoremap <silent> <Space>u :10sp solved.memo<CR><C-w>j:vs snippet.memo<CR>:vs keywords.md<CR>

"inoremap <BS> <Nop>

"Movement
nnoremap G Gzz
nnoremap V V$h
vnoremap v $h

nnoremap * *zz
nnoremap # #zz

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <C-CR> O<Esc>

"Super input
nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
"Window Scaleup
nnoremap <Leader>wj 10<C-W>+
nnoremap <Leader>wk 10<C-W>-
nnoremap <Leader>wl 10<C-W>>
nnoremap <Leader>wh 10<C-W><
nnoremap <C-;> <S-A>;<Esc>
"inoremap <C-;> <Esc><S-A>;

nnoremap <Leader>a gg<S-V><S-G>a
"Open on other app
"nnoremap <Leader>e :!explorer .<CR>

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

"reopen
nnoremap <Leader>ee :e ++enc=utf8
nnoremap <Leader>ew :e ++ff=dos

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
"" 次の単語へ移動
"cnoremap <M-f> <S-Right>

nnoremap <silent> Q :quitall<CR>

"switching windows
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
