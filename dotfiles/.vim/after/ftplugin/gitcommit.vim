au BufNewFile,BufRead COMMIT_EDITMSG setf editmsg " editmsg という命名は適切？
autocmd FileType editmsg :set dictionary+=~/.vim/dict/gitcommit/*.dict
