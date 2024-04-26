local M = {}

M.opts = {
  ensure_installed = {
    "black",
    "clang-format",
    "fourmolu",
    "google-java-format",
    "prettier",
    "stylua",
    "shfmt",
    "sqlfmt",
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 3000,
  debounce_hours = 5,
}

return M
