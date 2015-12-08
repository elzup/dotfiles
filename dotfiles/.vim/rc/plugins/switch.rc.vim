let g:switch_custom_definitions =
    \ [
    \   ['foo', 'bar', 'baz'],
    \   ['TRUE', 'FALSE'],
    \   ['true', 'false'],
    \   ['○', '×', '・'],
    \   ['―', '△', '▲', '○', '●'],
    \   ['absolute', 'relative', 'fixed'],
    \   ['left', 'right', 'top', 'bottom'],
    \   ['for', 'foreach', 'while']
    \ ]
nnoremap + :call switch#Switch(g:switch_custom_definitions)<cr>
nnoremap - :Switch<cr>

