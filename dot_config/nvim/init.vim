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
Plug 'dcampos/nvim-snippy'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'github/copilot.vim'
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
Plug 'mangeshrex/everblush.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'xuhdev/vim-latex-live-preview'

call plug#end()

" Rest of init.vim
syntax on

set termguicolors

" Random
let g:snipMate = { 'snippet_version' : 1 }

" Schemes
let g:catppuccin_flavor = "macchiato"

lua << EOF

require("catppuccin").setup({
	transparent_background = true,
	styles = {
		comments = { "italic" },
		conditionals = { "bold" },
		loops = {},
		functions = { "bold" },
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = { "bold" },
		properties = {},
		types = {},
		operators = { "bold" },
	}
})

EOF

colorscheme gruvbox

" Clear background
hi Normal ctermbg=NONE guibg=NONE

" Airline
let g:airline_theme='onedark'

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

" PDF viewer
let g:livepreview_previewer = 'zathura'

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>

set foldmethod=indent
set foldlevel=20
set nofoldenable

set mouse=a

au BufRead,BufNewFile *.vert set filetype=glsl
au BufRead,BufNewFile *.frag set filetype=glsl

" Todotree plugin
" source ~/.config/nvim/todotree.vim
" :imap <C-e> <ESC> :call TodoTree() <CR>
" :map <C-e> :call TodoTree() <CR>

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

" Color of line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set number

" Copilot settings
imap <silent><script><expr> <C-D> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

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

" +bindings
inoremap <C-BS> <C-o>db
inoremap <C-Del> <C-o>dw

" Highlighting notes
syn keyword   cTodo   contained    TODO FIXME NOTE
