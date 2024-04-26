local M = {}

M.opts = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    haskell = { "fourmolu" },
    java = { "google-java-format" },
    json = { "prettier" },
    kotlin = { "klint" },
    lua = { "stylua" },
    python = { "black" },
    sh = { "shfmt" },
    sql = { "sqlfmt" },
    yaml = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  format_after_save = {
    lsp_fallback = true,
  },
  notify_on_error = true,
}

return M
