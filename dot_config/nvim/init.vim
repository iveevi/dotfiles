if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'EdenEast/nightfox.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'arcticicestudio/nord-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh',}
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'danilo-augusto/vim-afterglow'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'liuchengxu/vista.vim'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'octol/vim-cpp-enhanced-highlight'
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
Plug 'vimsence/vimsence'

call plug#end()

" Rest of init.vim
syntax on

set termguicolors

" Schemes
colorscheme gruvbox
let g:gruvbox_contrast='soft'

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
:imap <C-f> <ESC> :NERDTreeToggle<CR>
:map <C-f> :NERDTreeToggle<CR>

" Goyo
:imap <C-g> <ESC> :Goyo <CR>
:map <C-g> :Goyo <CR>

" Limelight
:imap <C-l> <ESC> :Limelight!! <CR>
:map <C-l> :Limelight!! <CR>

" Vista
:imap <C-q> <ESC> :Vista!! <CR>
:map <C-q> :Vista!! <CR>

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

" Terminal
lua << EOF
require("toggleterm").setup {
	float_opts = {
		border = 'curved',
		width = 100,
		height = 50,
	}
}
EOF

tnoremap <silent> <A-t> <C-\><C-n> :ToggleTerm direction=float<CR>
nnoremap <silent> <A-t> :ToggleTerm direction=float<CR>
inoremap <silent> <A-t> <ESC> :ToggleTerm direction=float<CR>

" Highlighting notes
syn keyword   cTodo   contained    TODO FIXME NOTE

" Color of line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set number

" Copilot settings
" imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

" Comment color
highlight Comment guifg=Gray

" Coc
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Syntax highlighting
lua << EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	},
}
EOF
