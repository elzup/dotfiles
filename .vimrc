scriptencoding utf-8
" {{{ NeoBundleOptions
"  {{{ -Initialize
"neobundle
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle'))
endif

"for path in split(glob('~/.vim/bundle/*'), '\n')
"    if isdirectory(path) | let &runtimepath = &runtimepath.','.path | end
"endfor

""vundle option
"set runtimepath+='~\.vim\bundle\'
"call vundle#rc()

"  }}} end -Initialize
"  {{{ -Bundles
"neobundle 
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'scrooloose/nerdtree.git'
"NeoBundle 'Shougo/neocomplete.vim'

"utility view
NeoBundle 'tpope/vim-markdown'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'LeafCage/foldCC'
"NeoBundle 'yonchu/accelerated-smooth-scroll'

"utility input
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/snipmate-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'kana/vim-operator-replace.git'
NeoBundle 'kana/vim-operator-user.git'
NeoBundle 'Align'
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'LeafCage/yankround.vim'
"NeoBundle 'thinca/vim-splash'
"NeoBundle 'terryma/vim-multiple-cursors'
"NeoBundle 'haya14busa/vim-easymotion'

"tool
NeoBundle 'kien/ctrlp.vim.git'
"NeoBundle 'mbbill/undotree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'cocopon/colorswatch.vim'
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mhinz/vim-startify'


"NeoBundle 'YankRing.vim'
"NeoBundle 'mru.git'
"NeoBundle 'mttn/zen-coding.vim'
"NeoBundle 'emmet-vim'

"html support
NeoBundle 'Emmet.vim'
"NeoBundle 'hokaccha/endtagcomment.vim'

"sublime text 2 NeoBundle 'mattn/multi-vim'
"NeoBundle 'koron/minimap-vim'
NeoBundle 'koron/minimap-vim'
"
" sound
NeoBundle 'osyo-manga/vim-sound'

"language
" less 
NeoBundle 'groenewege/vim-less'

"Lua
NeoBundle 'lua-support'
NeoBundle 'luarefvim'

"Game
"NeoBundle 'amix/vim-2048'
NeoBundle 'AshyIsMe/2048'
"NewGame2048
NeoBundle 'thinca/vim-threes'
"ThreesStart
"NeoBundle 'sudoku_game'
"Sudoku~~
NeoBundle 'mfumi/viminesweeper'
"MineSweeper
"NeoBundle 'TeTrls.vim'
"
NeoBundle 'mattn/invader-vim'
"Invader
NeoBundle 'deris/vim-duzzle'
"DuzzleStart
"nmap ,gt :source<Space>TeTrls.vim<Enter>


"twitter
NeoBundle 'basyura/TweetVim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
"NeoBundle 'TwitVim'

"git
NeoBundle 'tpope/vim-fugitive'

"colorscheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'phd'
NeoBundle 'vim-scripts/summerfruit256.vim'
NeoBundle 'sjl/badwolf'
"
filetype plugin on
filetype indent on

"  }}} -end Bundles

" }}} -end NeoBundleOptions
" {{{ MyConfig
"  {{{ -StartupOptions
set nocompatible
set clipboard=unnamedplus,unnamedplus,autoselect
set modifiable
set write
set go=arc
set tw=0
set langmenu=ja_jp.utf-8
set hlsearch

set tags=./tags,../tags,../../tags,../../../tags,.git/*.tags

au BufEnter * execute ":lcd " . expand("%:p:h")
set foldmethod=marker
set encoding=utf-8
set nowrap
set laststatus=2
set guifont=Ricty\ 11
"colorscheme
syntax enable
"colorscheme solarized
colorscheme badwolf
set background=dark
"colorscheme ron
"set incsearch

set nobackup
set noswapfile
set fo=q

"tab space
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

"numbr
set number
behave mswin
set tw=0

"Window position
winpos 683 0
set cmdheight=1

"  }}} -end -StartupOptions
"  {{{ -KeyMapping
inoremap <C-BS> <C-W>
nnoremap <Leader><Leader> <Esc>:so<space>~/.vimrc

"Movement
nnoremap G Gzz
"Super input
nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"Switching Opacity
nnoremap ,oo :set tra=220<CR>
nnoremap ,on :set tra=0<CR>
nnoremap ,o+ :set tra+=10<CR>
nnoremap ,o- :set tra-=10<CR>
"Window Scaleup
nnoremap ,wj 10<C-W>+
nnoremap ,wk 10<C-W>-
nnoremap ,wl 10<C-W>>
nnoremap ,wh 10<C-W><
nnoremap <C-;> <S-A>;<Esc>
"inoremap <C-;> <Esc><S-A>;

nnoremap ,a gg<S-V><S-G>a
"Open on other app
nnoremap ,e :!explorer .<CR>

nnoremap ,min :set lines=20<CR>:set columns=30<CR>:winpos 1100 420<CR>
nnoremap ,ft :set ft=
"Line number
nnoremap ,nr :set rnu<CR>
nnoremap ,nn :set nornu<CR>

highlight CursorLine gui=underline guifg=NONE guibg=NONE

"nmap ,utt <Esc>:UndoTreeToggle

"  }}} -end -KeyMapping
"  {{{ -BinayMode 
"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
augroup BinaryXXD
        autocmd!
        autocmd BufReadPre  *.bin let &binary =1
        autocmd BufReadPost * if &binary | silent %!xxd -g 1
        autocmd BufReadPost * set ft=xxd | endif
        autocmd BufWritePre * if &binary | %!xxd -r
        autocmd BufWritePre * endif
        autocmd BufWritePost * if &binary | silent %!xxd -g 1
        autocmd BufWritePost * set nomod | endif
augroup END

"  }}} -end -BinayMode
"  {{{ -SavePosition 
let g:save_window_file = expand('~/.vim/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END
"if filereadable(g:save_window_file)
"  execute 'source' g:save_window_file
"endif

"  }}} -end -SavePosition 
"  {{{ -Encoding 
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"  }}} -end -Encoding 

" }}} -end MyConfig
" {{{ PluginOptions
"  {{{ config ctrlp 
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 500
let g:ctrlp_open_new_file = 1
let g:ctrlp_map = '<c-p>'
"   {{{ ctrlp map
nnoremap ,p :<C-u>CtrlP<CR>

"   }}} -end

"  }}} -end
"  {{{ config neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"  }}} -end
"  {{{ config neocomplcache
"au FileType javascript call JavaScriptFold()
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
let $DICT_DIR='~/.vim/dict/'
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default'    : '',
            \ 'php'        : $DICT_DIR.'PHP.dict,'       .$DICT_DIR.'html.dict'  ,
            \ 'javascript' : $DICT_DIR.'javascript.dict,'.$DICT_DIR.'jQuery.dict',
            \ 'css'        : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  ,
            \ 'less'       : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  .$DICT_DIR.'bootstrap_less.dict',
            \ 'html'       : $DICT_DIR.'css.dict,'       .$DICT_DIR.'html.dict'  .$DICT_DIR.'bootstrap_less.dict',
            \ 'c'          : $DICT_DIR.'c.dict',
            \ 'cpp'        : $DICT_DIR.'cpp.dict'
            \ }
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"  }}} -end
"  {{{ config neosnippet 
let g:neosnippet#snippets_directory='~/.vim/snippets/, ~/var_dumvar_dumpp.vim/snippets/, ~/.vim/bundle/snipmate-snippets/'
imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><C-l>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ '\<Plug>(neosnippet_expand_or_jump)' : '\<C-n>'
" SuperTab like snippets behavior.
"   {{{ neosnippet map
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
nmap g/ :Unite -buffer-name=search line:forward -start-insert -auto-highlight<CR>

"   }}} -end

"  }}} -end
"  {{{ config unite
" history/yank を有効化する
let g:unite_source_history_yank_enable = 1
"   {{{ unite map
nnoremap ,ub :<C-u>Unite buffer<CR>
nnoremap ,uh :<C-u>Unite file_mru<CR>
nnoremap ,uf :<C-u>UniteWithBufferDir -buffer-name=files file -direction=botright <cr>
nnoremap ,uc :<C-u>Unite colorscheme -auto-preview<CR>
map ,ur :Unite -buffer-name=register register<CR>
map ,uy     :Unite history/yank<CR>

"   }}} -end

"  }}} -end
"  {{{ config TweetVim
let g:tweetvim_open_say_cmd = 'botright split'
"   {{{ TweetVim map
nnoremap ,twl :TweetVimHomeTimeline<Enter>
nnoremap ,twe :TweetVimSay<Enter>10<C-w><Esc>:set<Space>winheight=10<Enter>
nnoremap ,twm :TweetVimMentions<Enter>
nnoremap ,tws :TweetVimSwitchAccount<Space>
nnoremap ,twh :let<Space>g:tweetvim_footer="#"<Left>

"   }}} -end

"  }}} -end
"  {{{ config Align
"let g:Align_enable_at_startup = 1;
let g:Align_xstrlen=3

"  }}} -end
"  {{{ config lightLine
let g:lightlineEnableAtStartup = 1
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': ">", 'right': ">" },
      \ 'subseparator': { 'left': ">", 'right': ">" }
      \ }
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'component': {
"      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
"      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
"      \ },
"      \ 'separator': { 'left': '⮀', 'right': '⮂' },
"      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
"      \ }

"  }}} -end
"  {{{ config startify
nnoremap ,sf :Startify<Enter>
" startifyのヘッダー部分に表示する文字列を設定する(dateコマンドを実行して日付を設定している)
let g:startify_custom_header = [
\"                                    ..",
\"                                  .::::.",
\"                     ___________ :;;;;:`____________",
\"                     \_________/ ?????L \__________/",
\"                       |.....| ????????> :.......'",
\"                       |:::::| $$$$$$'`.:::::::' ,",
\"                      ,|:::::| $$$$'`.:::::::' .OOS.",
\"                    ,7D|;;;;;| $$'`.;;;;;;;' .OOO888S.",
\"                  .GDDD|;;;;;| ?`.;;;;;;;' .OO8DDDDDNNS.",
\"                   'DDO|IIIII| .7IIIII7' .DDDDDDDDNNNF`",
\"                     'D|IIIIII7IIIII7' .DDDDDDDDNNNF`",
\"                       |EEEEEEEEEE7' .DDDDDDDNNNNF`",
\"                       |EEEEEEEEZ' .DDDDDDDDNNNF`",
\"                       |888888Z' .DDDDDDDDNNNF`",
\"                       |8888Z' ,DDDDDDDNNNNF`",
\"                       |88Z'    'DNNNNNNN'",
\"                       '''        'MMMM'",
\"                                    ''",
\" ",
  \]
" よく使うファイルをブックマークとして登録しておく
let g:startify_bookmarks = [
  \ '~/.vimrc',
  \ '~/note/.memo',
  \ '~/workspace',
  \ ]
" \ map(split('date', '\n'), '"   ". v:val') + ['',''],
" デフォルトだと、最近使ったファイルの先頭は数字なので、使用するアルファベットを指定
let g:startify_custom_indices = split('a,b,c,d,f,g,i,m,n,p,r,s,t,u,v,w,x,y,z', ',')
"let g:startify_custom_indices = ['a','b','c','d','f','g','i','m','n','p','r','s','t','u','v','w','x','y','z']
let g:startify_list_order = [
  \ ['  Recently'],
  \ 'files',
  \ ['  Recently in dir'],
  \ 'dir',
  \ ['  Sessions'],
  \ 'sessions',
  \ ['  Bookmarks'],
  \ 'bookmarks',
  \ ]
let g:startify_files_number = 5

"  }}} -end
"  {{{ config foldCC
set foldtext=foldCC#foldtext()
let g:foldCCtext_head = 'repeat(":", v:foldlevel) . "> "'
let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

"  }}} -end
"  {{{ config over.vim
"over.vim option
" over.vimの起動
"  {{{ over map
nmap <silent> ,ov :OverCommandLine<CR>
nmap <silent> ,oV :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
"vim-operator-replace
nmap <c-p> <Plug>(operator-replace)

"   }}} -end

"  }}} -end
"  {{{ config Quickrun
let g:quickrun_config={'*': {'split': ''}}
"   {{{ Quicakrun map
nnoremap <silent> ,r :QuickRun

"   }}} -end

"  }}} -end
"  {{{ config yankround
let g:yankround_max_history = 50
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
"   {{{ yankround map
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"   }}} -end
"  }}} -end
"  {{{ [x] config undotree.vim
"let g:undotree_EnableAtStartup = 1
"let g:undotree_SetFocusWhenToggle = 1
"let g:undotree_SplitLocation = 'topleft'
"let g:undotree_SplitWidth = 35
"let g:undotree_diffAutoOpen = 1
"let g:undotree_diffpanelHeight = 25
"let g:undotree_RelativeTimestamp = 1
"let g:undotree_TreeNodeShape = '*'
"let g:undotree_HighlightChangedText = 1
"let g:undotree_HighlightSyntax = "UnderLined"

"  }}} -end
"  {{{ [x] config easymotion
""easy-motion option
"let g:EasyMotion_keys='hjklasdfyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"let g:EasyMotion_smartcase=1
"let g:EasyMotion_use_migemo=1
"let g:EasyMotion_leader_key="'"
"let g:EasyMotion_grouping=1
"hi EasyMotionTarget ctermbg=none ctermfg=red
"hi EasyMotionShade  ctermbg=none ctermfg=blue

"  }}} -end
"  {{{ [x] config NERDTreeToggle
" let g:nerdtreetoggle_enable_at_startup = 1
 
"  }}} -end

" }}} -end PluginOptions


