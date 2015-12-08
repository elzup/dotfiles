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

