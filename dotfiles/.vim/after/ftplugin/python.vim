setlocal completeopt-=preview
nnoremap ,l :call Flake8()<CR>
let g:quickrun_config = {
\   "python" : {
\       "command" : "python3",
\   }
\}
