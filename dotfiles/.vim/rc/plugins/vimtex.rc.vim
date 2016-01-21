""
"" vimtex
""
let g:vimtex_latexmk_enabled = 1
"let g:vimtex_latexmk_options = '-pdf'
let g:vimtex_latexmk_options = '-pdfdvi'
"let g:vimtex_latexmk_options = '-pdfps'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
let g:vimtex_view_method = 'general'
let g:vimtex_latexmk_callback = 0

if has('win32')
    let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
    let g:vimtex_view_general_options = '-forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
elseif has('unix')
    " let g:vimtex_view_general_viewer = 'open'
    " let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_viewer = 'open -a Skim'
    let g:vimtex_view_general_options = '@line @pdf @tex'
endif

let g:vimtex_fold_enabled = 1
let g:vimtex_fold_automatic = 1
let g:vimtex_fold_envs = 1
let g:vimtex_toc_split_pos = "topleft"
let g:vimtex_toc_width = 10
