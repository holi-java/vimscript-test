map <F5> <Esc>:wa<CR>:source .vimrc<CR>:echo 'refresh '.getcwd().'/.vimrc success ...'<CR>
map <F9> <Esc>:wa<CR>:!clear&&vunit %<CR>
