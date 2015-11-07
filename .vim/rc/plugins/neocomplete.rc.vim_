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

