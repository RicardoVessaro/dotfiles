local M = {}

M.on_attach = require("nvchad.configs.lspconfig").on_attach
M.on_init = require("nvchad.configs.lspconfig").on_init
M.capabilities = require("nvchad.configs.lspconfig").capabilities
M.servers = { "clangd", "lua_ls", "rust_analyzer", "hls", "pylsp", "bashls" }

return M
