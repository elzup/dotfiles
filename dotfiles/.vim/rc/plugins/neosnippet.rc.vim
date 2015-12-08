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

