vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- use a shorter alias for readability
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local telescope = require("telescope.builtin")
local gitsigns = require("gitsigns")

-- half-page scrolling
keymap({"n", "v"}, "<Down>", "<C-d>", opts)
keymap({"n", "v"}, "<Up>", "<C-u>", opts)

-- Keep cursor centered when scrolling or jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

-- Tab/Shift Tab behavior
keymap("i", "<S-Tab>", "<C-d>", opts)
keymap("v", "<Tab>",   ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)
keymap("n", "<Tab>",   ">>", opts)
keymap("n", "<S-Tab>", "<<", opts)

-- Easier saving
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Go to definition(s)
keymap("n", "<leader>jd", vim.lsp.buf.definition, { desc = "LSP: Go to definition(s)" })

-- Go to implementation(s)
keymap("n", "<leader>ji", function()
  telescope.lsp_implementations({ jump_type = "replace", initial_mode = "normal" })
end, { desc = "LSP: Go to implementation(s)" })

-- Go to usage(s) / references
keymap("n", "<leader>ju", function()
  telescope.lsp_references({
    include_declaration = false,
    jump_type = "replace",
    initial_mode = "normal"
  })
end, { desc = "LSP: Go to usage(s)" })

-- LSP
keymap("n", "<leader>lh", vim.lsp.buf.hover,         opts)
keymap("n", "<leader>lr", vim.lsp.buf.rename,        opts)
keymap("n", "<leader>la", vim.lsp.buf.code_action,   opts)
keymap("n", "<leader>ll", vim.diagnostic.open_float, opts)
keymap("n", "<leader>lp", vim.diagnostic.goto_prev,  opts)
keymap("n", "<leader>ln", vim.diagnostic.goto_next,  opts)
keymap("n", "<leader>lf", function()
  telescope.diagnostics({ bufnr = 0, initial_mode = "normal" })
end, opts)

-- helper to detect project root (via Git)
local function project_root_or_cwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 then
    return git_root
  else
    return vim.loop.cwd()
  end
end

-- navigation
-- (<leader>ft opens the file tree, configured in plugins/nvim-tree.lua)
keymap("n", "<leader>fr", function ()
  telescope.oldfiles({
    initial_mode = "normal",
    cwd = project_root_or_cwd(),
    cwd_only = true,
   })
end, { desc = "Find recent files" })

keymap("n", "<leader>ff", function()
  telescope.find_files({
    cwd = project_root_or_cwd(),
    cwd_only = true,
    hidden = true,
    no_ignore = false,
  })
end, { desc = "Find files from project root" })

keymap("n", "<leader>fg", function()
  telescope.live_grep({
    cwd = project_root_or_cwd(),
    cwd_only = true,
    hidden = true,
    no_ignore = false,
  })
end, { desc = "Search text from project root" })

keymap("n", "<leader>fi", telescope.current_buffer_fuzzy_find, { desc = "Search in current file" })

-- running tests
keymap("n", "<leader>tt", ":TestNearest<CR>", { desc = "Run nearest test" })
keymap("n", "<leader>tf", ":TestFile<CR>", { desc = "Run tests in file" })
keymap("n", "<leader>ta", ":TestSuite<CR>", { desc = "Run all tests" })
keymap("n", "<leader>tl", ":TestLast<CR>", { desc = "Re-run last test" })

-- diff mangement
keymap("n", "<leader>hn", gitsigns.next_hunk, { desc = "Next hunk" })
keymap("n", "<leader>hp", gitsigns.prev_hunk, { desc = "Prev hunk" })
keymap("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
keymap("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage" })
keymap("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
keymap("n", "<leader>hd", gitsigns.preview_hunk, { desc = "Preview hunk" })

-- commenting code
keymap("n", '<leader>/', '<Plug>(comment_toggle_linewise_current)', opts)
keymap('v', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', opts)

