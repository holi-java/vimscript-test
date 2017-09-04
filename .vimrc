map <F5> <Esc>:wa<CR>:source .vimrc<CR>:echo 'refresh '.getcwd().'/.vimrc success ...'<CR>
map <S-F10> <Esc>:wa<CR>:execute "UnitTest ".(exists("test") ? test : '%')<CR>:resize<CR>
map <C-S-F10> <Esc>:wa<CR>:let test=expand("%:.")<CR><S-F10>
map <C-F10> <Esc>:wa<CR>:UnitTest test_all.vim<CR>:resize<CR>

