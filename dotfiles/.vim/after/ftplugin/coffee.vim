setlocal shiftwidth=2
setlocal tabstop=2
nnoremap <buffer> ,c :w <BAR> !coffee -c % > %:t:r.js<CR><Space>
