""""""""""""""""""""""""""""""""""
" shortcut keys with leader prefix
""""""""""""""""""""""""""""""""""

""" B

nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bk :bdelete<cr>
nnoremap <leader>bl :buffers<cr>

""" E
nnoremap <leader>ee :edit $MYVIMRC<Cr>

""" L

" location list shortcut
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>

""" R
nnoremap <leader>r :source $MYVIMRC<CR>

""" T
nnoremap <F2> :silent! NERDTreeToggle<CR>
nnoremap tt :silent! NERDTreeToggle<CR>
nnoremap tn :tab new<CR>
nmap tl :TagbarClose<cr>:Tlist<cr>
nmap tb :TagbarToggle<CR>

""" W
map <leader>wn <C-W>w
map <leader>wp <C-W>W

" map 1-9 to window(0-9)
for i in range(1, 9)
    " exec "nnoremap t" . i . " " . i . "<C-W><C-W>"
    exec "nnoremap <leader>" . i . " " . i . "gt"
endfor

""""""""""""""""""""""""""""""""""
" shortcut keys with letter prefix
""""""""""""""""""""""""""""""""""
""" C

nnoremap co :copen<CR>
nnoremap cc :ccl<CR>
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>

nnoremap cw :q<CR>

""" F

" 搜索当前 word
nnoremap f :Grepper<CR>
