setlocal shiftwidth=2
setlocal tabstop=2
nnoremap <buffer> ,c :w <BAR> !sass %:%:t:r.css --sourcemap --style compressed<CR><Space>
