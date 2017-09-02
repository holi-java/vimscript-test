map <F5> <Esc>:wa<CR>:source .vimrc<CR>:echo 'refresh '.getcwd().'/.vimrc success ...'<CR>
map <S-F10> <Esc>:wa<CR>:execute "!clear&&vunit ".(exists("test") ? test : '%')<CR>
map <C-S-F10> <Esc>:wa<CR>:let test=expand("%:.")<CR><S-F10>
map <C-F10> <Esc>:wa<CR>:!clear&&vunit test_all.vim<CR>

