local M = {}

M.opts = {
  modules = {},
  ignore_install = {},
  auto_install = true,
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "haskell",
    "java",
    "json",
    "kotlin",
    "lua",
    "python",
    "rust",
    "bash",
    "sql",
    "vim",
    "yaml",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}

return M
