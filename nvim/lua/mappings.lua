local map = vim.keymap.set

-- stylua: ignore start

map({ "i" }, "<c-b>", "<esc>^i", { desc = "move beginning of line" })
map({ "i" }, "<c-e>", "<end>",   { desc = "move end of line" })
map({ "i" }, "<c-h>", "<left>",  { desc = "move left" })
map({ "i" }, "<c-l>", "<right>", { desc = "move right" })
map({ "i" }, "<c-j>", "<down>",  { desc = "move down" })
map({ "i" }, "<c-k>", "<up>",    { desc = "move up" })

map({ "n" }, "<esc>", "<cmd>noh<cr>", { desc = "general clear highlights" })

map({ "n" }, "<c-h>", "<c-w>h", { desc = "switch window left" })
map({ "n" }, "<c-l>", "<c-w>l", { desc = "switch window right" })
map({ "n" }, "<c-j>", "<c-w>j", { desc = "switch window down" })
map({ "n" }, "<c-k>", "<c-w>k", { desc = "switch window up" })

map({ "n" }, "<c-s>", "<cmd>w<cr>",   { desc = "file save" })
map({ "n" }, "<c-c>", "<cmd>%y+<cr>", { desc = "file copy whole" })

map({ "n" }, "<leader>n",   "<cmd>set nu!<cr>",     { desc = "toggle line number" })
map({ "n" }, "<leader>rn",  "<cmd>set rnu!<cr>",    { desc = "toggle relative number" })

map({ "n" }, "<leader>fm", function() require("conform").format({ lsp_fallback = true }) end, { desc = "format files" })

-- global lsp mappings
map({ "n" }, "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- bufferline
map({ "n" }, "<leader>b",   "<cmd>enew<cr>",                    { desc = "buffer new" })
map({ "n" }, "<tab>",       "<cmd>BufferLineCycleNext<cr>",     { desc = "buffer goto next" })
map({ "n" }, "<s-tab>",     "<cmd>BufferLineCyclePrev<cr>",     { desc = "buffer goto prev" })
map({ "n" }, "<leader>x",   "<cmd>bd<cr><bar><cmd>bp<cr>",      { desc = "buffer close" })

-- comment
map({ "n" }, "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map({ "v" }, "<leader>/", "gc",  { desc = "comment toggle", remap = true })

-- nvimtree
map({ "n" }, "<c-n>",       "<cmd>NvimTreeToggle<cr>",  { desc = "nvimtree toggle window" })
map({ "n" }, "<leader>e",   "<cmd>NvimTreeFocus<cr>",   { desc = "nvimtree focus window" })

-- telescope
map({ "n" }, "<leader>fw", "<cmd>Telescope live_grep<cr>",                                         { desc = "telescope live grep" })
map({ "n" }, "<leader>fb", "<cmd>Telescope buffers<cr>",                                           { desc = "telescope find buffers" })
map({ "n" }, "<leader>fh", "<cmd>Telescope help_tags<cr>",                                         { desc = "telescope help page" })
map({ "n" }, "<leader>ma", "<cmd>Telescope marks<cr>",                                             { desc = "telescope find marks" })
map({ "n" }, "<leader>fo", "<cmd>Telescope oldfiles<cr>",                                          { desc = "telescope find oldfiles" })
map({ "n" }, "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                         { desc = "telescope find in current buffer" })
map({ "n" }, "<leader>cm", "<cmd>Telescope git_commits<cr>",                                       { desc = "telescope git commits" })
map({ "n" }, "<leader>gt", "<cmd>Telescope git_status<cr>",                                        { desc = "telescope git status" })
map({ "n" }, "<leader>pt", "<cmd>Telescope terms<cr>",                                             { desc = "telescope pick hidden term" })
map({ "n" }, "<leader>th", "<cmd>Telescope themes<cr>",                                            { desc = "telescope nvchad themes" })
map({ "n" }, "<leader>ff", "<cmd>Telescope find_files<cr>",                                        { desc = "telescope find files" })
map({ "n" }, "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", { desc = "telescope find all files" })

-- terminal
map({ "t" },      "<c-x>",     "<c-\\><c-n>",                              { desc = "terminal escape terminal mode" })
map({ "n" },      "<leader>h", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "terminal new horizontal term" })
map({ "n" },      "<leader>v", "<cmd>ToggleTerm direction=vertical<cr>",   { desc = "terminal new vertical window" })
map({ "n" },      "<leader>f", "<cmd>ToggleTerm direction=float<cr>",      { desc = "terminal new float window" })
map({ "n", "t" }, "<a-h>",     "<cmd>ToggleTermToggleAll<cr>",             { desc = "terminal toggle all" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function() vim.cmd("WhichKey " .. vim.fn.input("WhichKey: ")) end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- stylua: ignore end
