-- options
require("options")

-- package manager
require("config.lazy")

-- lsp
require("config.java")
require("config.lspconfig")
require("config.mason")

-- mapppings
require "mappings"

-- colorscheme
vim.cmd("colorscheme rose-pine")

-- neovide
if vim.g.neovide then
    require("ginit")
end

