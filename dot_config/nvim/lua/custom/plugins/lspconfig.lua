local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- Clangd 
   lspconfig.clangd.setup {}
end

return M
