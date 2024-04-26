return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("configs.conform").opts,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("configs.lspconfig")

      require("nvchad.configs.lspconfig").defaults()

      require("mason").setup(require("configs.mason").opts)
      require("mason-lspconfig").setup(require("configs.mason-lspconfig").opts)
      require("mason-tool-installer").setup(require("configs.mason-installer").opts)

      require("neodev").setup(require("configs.neodev").opts)
      require("configs.inlayhints").setup()

      for _, lsp in ipairs(lspconfig.servers) do
        require("lspconfig")[lsp].setup({
          on_attach = lspconfig.on_attach,
          on_init = lspconfig.on_init,
          capabilities = lspconfig.capabilities,
        })
      end
    end,
    dependencies = {
      {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "lvimuser/lsp-inlayhints.nvim",
      },
    },
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("configs.treesitter").opts,
  },
  {
    "folke/trouble.nvim",
    branch = "dev", -- IMPORTANT!
    keys = require("configs.trouble").keys,
    opts = require("configs.trouble").opts,
  },
}
