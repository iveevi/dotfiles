filetype plugin indent on

filetype plugin indent on

let loaded_matchparen = 1

" Keybinds
:imap <A-Down> <ESC> :m+<CR>i
:imap <A-Up> <ESC> :m-2<CR>i
:imap <C-a> <ESC>:tabn<CR>
:imap <C-e> <ESC><C-e>i
:imap <C-l> <ESC>ddi
:imap <C-s> <ESC>:wa<CR>i
:imap <C-t> <ESC>:tabe
:imap <C-y> <ESC><C-y>i
:imap <F3> <ESC>:copen<CR>
:imap <F4> <ESC><C-w>w<C-w>o
:imap <F6> <ESC>:wa<CR>i
:imap <F7> <ESC>:tabp<CR>
:imap <F8> <ESC>:tabn<CR>
:map <A-Down> <ESC> :m+<CR>
:map <A-Up> <ESC> :m-2<CR>
:map <C-a> :tabn<CR>
:map <C-l> dd
:map <C-s> :wa<CR>
:map <C-t> :tabe
:map <F1> :w <CR> <C-z>
:map <F2> :x <CR>
:map <F3> :copen<CR>
:map <F4> <C-w>w<C-w>o
:map <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
:map <F6> :wa<CR>
:map <F7> :tabp<CR>
:map <F8> :tabn<CR>
:map <leader>O O<ESC>
:map <leader>o o<ESC>

command Q q

autocmd VimEnter * set autochdir

set autochdir
set title
set nowrap
set tabpagemax=150

map gr  :grep -r <cword> *<CR>
map gc  :grep <cword> *<CR>

" Auto Indentation
set autoindent
set smartindent

set tw=80
set fo+=t

set tabstop=8
set shiftwidth=8
