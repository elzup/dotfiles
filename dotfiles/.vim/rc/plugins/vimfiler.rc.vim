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
