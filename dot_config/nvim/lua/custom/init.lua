-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

-- MAPPINGS
local map = require("core.utils").map

-- Editor bindings
map("i", "<C-s>", "<ESC> :w <CR> i")

map("n", "<C-a>", ":tabn <CR>")
map("i", "<C-a>", "<ESC> :tabn <CR> i")

map("n", "<C-f>", ":Telescope find_files <CR>")
map("i", "<C-f>", "<ESC> :Telescope find_files <CR> i")

map("n", "<C-q>", ":Vista!! <CR>")
map("i", "<C-q>", "<ESC> :Vista!! <CR>")

-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins
local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
        use {
                "github/copilot.vim"
        }

        use {
                "nathom/filetype.nvim"
        }

        use {
                "liuchengxu/vista.vim"
        }

        use {
                "neoclide/coc.nvim", branch = "release"
        }

        use {
                "terrortylor/nvim-comment"
        }
end)

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough

-- Tab preferences
vim.cmd("set tabstop=8")
vim.cmd("set shiftwidth=8")
vim.cmd("set expandtab")

-- Commenting
require("nvim_commment").setup()

-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1
