-- Load plugins
require('packer').startup(function(use)
	use 'akinsho/bufferline.nvim'
	use 'akinsho/toggleterm.nvim'
	use 'echasnovski/mini.nvim'
	use 'folke/todo-comments.nvim'
	use 'folke/trouble.nvim'
	use 'folke/which-key.nvim'
	use 'matbme/JABS.nvim'
	use 'numToStr/Comment.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/popup.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-treesitter/nvim-treesitter'
	use 'rktjmp/lush.nvim'
	use 'skywind3000/asyncrun.vim'
	use 'stevearc/overseer.nvim'
	use 'wbthomason/packer.nvim'
	use 'windwp/nvim-autopairs'
	use 'xuhdev/vim-latex-live-preview'
	use { 'nvim-telescope/telescope-file-browser.nvim', requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' } }

	-- LSP and completion
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-calc'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use 'liuchengxu/vista.vim'

	-- Colorscheme repositories
	use 'rakr/vim-two-firewatch'
	use 'atelierbram/Base2Tone-vim'
	use 'mcchrish/zenbones.nvim'
	use 'sainnhe/everforest'
	use 'shaunsingh/nord.nvim'
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use({ 'rose-pine/neovim', as = 'rose-pine' })
end)

-- Leader key
vim.g.mapleader = '`'

-- Colorscheme
vim.cmd [[ colorscheme nord ]]

-- Configure telescope
require('telescope').setup()

-- Configure nvim-tree and icons
require('nvim-tree').setup()
require('nvim-web-devicons').setup({})

-- Treesitter
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'c', 'cpp', 'python', 'cuda', 'lua', 'bash', 'latex' },
	highlight = {
		enable = true,
	},
})

-- Configure LSP
local lspconfig = require('lspconfig')
local servers = { 'clangd', 'pyright', 'texlab' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({})
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', 'grr', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', 'gca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', 'grca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
  end
})

-- Configure completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lua' },
		{ name = 'calc' },
		{ name = 'luasnip' },
	},

	window = {
		documentation = cmp.config.window.bordered()
	},

	formatting = {
		fields = {'menu', 'abbr', 'kind'},
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'λ',
				luasnip = '⋗',
				buffer = 'Ω',
				path = '🖫',
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},

	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),
	}
})

-- Showing keybindings
vim.o.timeout = true
vim.o.timeoutlen = 300
require('which-key').setup({})

-- Terminals
require('toggleterm').setup({
	size = 20,
	direction = 'horizontal'
})

-- Bufferline and airline
require('bufferline').setup()

-- -- Always italicize comments
-- vim.cmd('highlight Comment cterm=italic gui=italic')

-- Configure comment
require('Comment').setup({
	toggler = {
		line = 'cc',
		block = 'cb',
	},

	opleader = {
		line = 'cc',
		block = 'cb',
	},
})

-- Configure trouble
require('trouble').setup({})
require('todo-comments').setup({})

-- Configure mini modules
require('mini.trailspace').setup()

-- Buffer switching
require('jabs').setup({
	border = 'single',
	offset = {
		top = 2,
		bottom = 2,
		left = 2,
		right = 2,
	},
})

-- Configure LaTeX preview
vim.g.livepreview_previewer = 'zathura'
vim.g.livepreview_engine = 'xelatex'

-- Other modules
require('nvim-autopairs').setup()
require('overseer').setup()

-- Additional keybindings
vim.keymap.set({ 'n', 'i' },
	'<C-s>', ':w<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 't' },
	'<ESC>', '<C-\\><C-n>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n', 't' },
	'<A-t>', '<ESC>:ToggleTerm<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n' },
	'<C-e>', ':NvimTreeToggle<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n', 'v' },
	'<C-p>', ':Telescope find_files<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n', 'v' },
	'<C-g>', ':Telescope git_files<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n' },
	'tl', ':TroubleToggle<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n' },
	'tt', ':TodoQuickFix<CR>',
	{ noremap = true, silent = true })

vim.keymap.set({ 'n' },
	'bf', ':JABSOpen<CR>',
	{ noremap = true, silent = true })
