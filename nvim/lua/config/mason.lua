require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "jdtls", "lua_ls", "rust_analyzer" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
})
