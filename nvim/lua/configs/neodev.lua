local M = {}

M.opts = {
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
  setup_jsonls = true,
  override = function(_, _) end,
  lspconfig = true,
  pathStrict = true,
}

return M
