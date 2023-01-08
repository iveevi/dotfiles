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
Plug 'xuhdev/vim-latex-live-preview'
Plug 'folke/todo-comments.nvim'
Plug 'isaacsloan/vim-slang'
Plug 'sainnhe/everforest'
Plug 'ayu-theme/ayu-vim'
Plug 'folke/tokyonight.nvim'
Plug 'kaicataldo/material.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'vedavamadathil/tasks.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'folke/trouble.nvim'
Plug 'phaazon/mind.nvim', { 'tag': 'v2.2' }
Plug 'matbme/JABS.nvim'

call plug#end()

" Rest of init.vim
syntax on
set termguicolors

" Schemes
let g:everforest_background = 'soft'
let g:everforest_transparent_background = 1
colorscheme everforest

" Clear background
" hi NonText ctermbg=NONE
hi Normal ctermbg=NONE guibg=NONE

" Airline
let g:airline_theme='everforest'

" let g:airline#extensions#tabline#enabled = 1
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

lua << EOF
-- Nvim tree and bindings
require('nvim-tree').setup({
	view = {
		adaptive_size = true,
	}
})

vim.keymap.set('n', '<C-f>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-f>', '<ESC>:NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Buffer line
require('bufferline').setup({
	options = {
		indicator = {
			style = 'underline'
		},
		diagnostics = 'coc',
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	}
})

-- Trouble
require('trouble').setup({})

-- TODO: comments
require('todo-comments').setup({})

-- Mind
require('mind').setup({})

-- JABS
require('jabs').setup({})

EOF

:imap <C-m> <ESC>:MindOpenMain<CR>
:map <C-m> :MindOpenMain<CR>

:imap <C-j> <ESC>:JABSOpen<CR>
:map <C-j> :JABSOpen<CR>

" Goyo
:imap <C-g> <ESC> :Goyo <CR>
:map <C-g> :Goyo <CR>

" Limelight
:imap <C-l> <ESC> :Limelight!! <CR>
:map <C-l> :Limelight!! <CR>

" Vista
:imap <C-q> <ESC> :Vista!! <CR>
:map <C-q> :Vista!! <CR>

" TeX Live Preview
let g:livepreview_engine = 'xelatex'
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
	direction = 'vertical',
	float_opts = {
		border = 'curved',
		width = 100,
		height = 50,
	}
}
EOF

" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><C-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><C-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><C-`> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" Telescope
nnoremap <silent> <C-p> :Telescope find_files<CR>
inoremap <silent> <C-p> <ESC> :Telescope find_files<CR>

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
require('nvim-treesitter.configs').setup {
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

" Syntax highlighting for specific filetypes
au BufRead,BufNewFile *.smake set filetype=python

" Comments for Nord colorscheme
highlight Comment ctermfg=yellow cterm=italic

lua << EOF

-- Keybinds
local map = vim.api.nvim_set_keymap

-- Neovim Tasks
require('tasker').setup()

map('n', '<C-p>', ':Telescope find_files<CR>', {noremap = true, silent = true})
map('i', '<C-p>', '<ESC>:Telescope find_files<CR>', {noremap = true, silent = true})

-- Telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-g>', builtin.git_files, {noremap = true, silent = true})
vim.keymap.set('i', '<C-g>', builtin.git_files, {noremap = true, silent = true})

--[[
vim.keymap.set('n', '<C-[>',
	function()
		builtin.grep_string({
			search = vim.fn.input('grep files > ')
		})
	end
) --]]

EOF
