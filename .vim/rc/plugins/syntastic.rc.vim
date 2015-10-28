let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': ['python', 'ruby', 'php', 'javascript']
    \}
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_quite_warnings=0
nmap <Leader>s :SyntasticCheck<CR>

