setlocal shiftwidth=2
setlocal tabstop=2
nnoremap <buffer> ,c :w <BAR> !lessc --source-map=%:t:r.css.map -x % > %:t:r.css<CR><Space>
