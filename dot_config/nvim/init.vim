" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'EdenEast/nightfox.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'arcticicestudio/nord-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh',}
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vista.vim'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'phanviet/vim-monokai-pro'
Plug 'preservim/nerdtree'
Plug 'rakr/vim-two-firewatch'
Plug 'romainl/Apprentice'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/sonokai'
Plug 'sonph/onehalf'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimsence/vimsence'

call plug#end()

" Rest of init.vim
syntax on

set termguicolors

" Schemes
colorscheme gruvbox
set background=dark

let g:airline_theme='gruvbox'

" Kill background color
hi Normal guibg=NONE ctermbg=NONE

" More on vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

" Limelight
let g:limelight_conceal_ctermfg = 240

" Doxygen
let g:load_doxygen_syntax=1

highlight CocFloating ctermbg=240

" More on vista
set tags=tags

" Source keybind file
source ~/.keybinds.vim

" NERDTree
:imap <C-f> <ESC> :Telescope find_files <CR>
:map <C-f> :Telescope find_files <CR>

" Goyo
:imap <C-g> <ESC> :Goyo <CR>
:map <C-g> :Goyo <CR>

" Limelight
:imap <C-l> <ESC> :Limelight!! <CR>
:map <C-l> :Limelight!! <CR>

" Vista
:imap <C-q> <ESC> :Vista!! <CR>
:map <C-q> :Vista!! <CR>

" Terminal Function
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <C-t> :call TermToggle(18)<CR>
inoremap <C-t> <Esc>:call TermToggle(18)<CR>
tnoremap <C-t> <C-\><C-n>:call TermToggle(18)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <F2> <C-\><C-n>:q!<CR>

set foldmethod=indent
set foldlevel=20
set nofoldenable

set mouse=a

au BufRead,BufNewFile *.vert set filetype=glsl
au BufRead,BufNewFile *.frag set filetype=glsl

" Todotree plugin
source ~/.config/nvim/todotree.vim
:imap <C-e> <ESC> :call TodoTree() <CR>
:map <C-e> :call TodoTree() <CR>
