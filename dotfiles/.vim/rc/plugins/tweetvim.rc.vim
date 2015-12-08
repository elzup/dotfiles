let g:tweetvim_open_say_cmd = 'botright split'
"   {{{ TweetVim mapping
nnoremap <Leader>twl :TweetVimHomeTimeline<Enter>
nnoremap <Leader>twe :TweetVimSay<Enter>10<C-w><Esc>:set<Space>winheight=10<Enter>
nnoremap <Leader>twm :TweetVimMentions<Enter>
nnoremap <Leader>tws :TweetVimSwitchAccount<Space>
nnoremap <Leader>twh :let<Space>g:tweetvim_footer="#"<Left>

