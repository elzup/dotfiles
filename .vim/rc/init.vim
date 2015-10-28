
" release autogroup in MyAutoCmd

if &compatible
  set nocompatible
endif

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER
      \ && $HOME !=# expand('~'.$USER)
      \ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
  return s:is_windows
endfunction

function! IsMac()
  return !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
endfunction

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

call s:source_rc('encoding.rc.vim')

call s:source_rc('basic.rc.vim')
call s:source_rc('mapping.rc.vim')
call s:source_rc('plugins.rc.vim')

if IsMac()
    call s:source_rc('mac.rc.vim')
endif

runtime! rc/plugins/*.vim


" vim:set foldmethod=marker
" vim:set foldcolumn=3
" vim:set foldlevel=0
