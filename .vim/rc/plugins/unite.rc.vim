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
map <Leader>ur :Unite -buffer-name=register register<CR>
map <Leader>uy     :Unite history/yank<CR>

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
