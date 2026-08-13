-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function root()
  return require("util.vcs").repo_root()
end

-- half-page scrolling
keymap({ "n", "v" }, "<Down>", "<C-d>", opts)
keymap({ "n", "v" }, "<Up>", "<C-u>", opts)

-- Keep cursor centered when scrolling or jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

-- Tab / Shift-Tab indent behavior (visual + normal).
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("n", "<S-Tab>", "<<", opts)

-- Easier saving / quitting.
-- NOTE: these shadow LazyVim's <leader>w (+windows) and <leader>q (+quit) groups.
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file", noremap = true, silent = true })
keymap("n", "<leader>q", ":quitall<CR>", { desc = "Quit window", noremap = true, silent = true })

-- Copy relative path
keymap(
  "n",
  "<leader>yp",
  [[<cmd>let @+ = expand("%")<CR>]],
  { desc = "Yank relative path", noremap = true, silent = true }
)

-- LSP navigation (telescope -> snacks.picker) -----------------------------

keymap("n", "<leader>jd", function()
  Snacks.picker.lsp_definitions({ focus = "list" })
end, { desc = "LSP: Go to definition(s)" })

keymap("n", "<leader>ji", function()
  Snacks.picker.lsp_implementations({ focus = "list" })
end, { desc = "LSP: Go to implementation(s)" })

keymap("n", "<leader>ju", function()
  Snacks.picker.lsp_references({ focus = "list" })
end, { desc = "LSP: Go to usage(s)" })

keymap("n", "<leader>jr", function()
  Snacks.picker.jumps({ focus = "list" })
end, { desc = "Jump list" })

-- LSP actions -------------------------------------------------------------
pcall(vim.keymap.del, "n", "<leader>l")
keymap("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP: Hover", silent = true })
keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: Rename", silent = true })
keymap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code action", silent = true })
keymap("n", "<leader>ll", vim.diagnostic.open_float, { desc = "LSP: Line diagnostics", silent = true })
keymap("n", "<leader>lp", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "LSP: Prev diagnostic", silent = true })
keymap("n", "<leader>ln", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "LSP: Next diagnostic", silent = true })
keymap("n", "<leader>lf", function()
  Snacks.picker.diagnostics_buffer({ focus = "list" })
end, { desc = "LSP: Buffer diagnostics" })

-- File tree (nvim-tree -> snacks.explorer) --------------------------------
keymap("n", "<leader>ft", function()
  Snacks.explorer({ cwd = root() })
end, { desc = "File tree (root)" })
keymap("n", "<leader>fT", function()
  Snacks.explorer.reveal()
end, { desc = "Reveal current file" })

-- Finders (telescope -> snacks.picker), scoped to project root ------------
keymap("n", "<leader>fr", function()
  Snacks.picker.recent({ filter = { cwd = root() }, focus = "list" })
end, { desc = "Find recent files" })

keymap("n", "<leader>ff", function()
  Snacks.picker.files({ cwd = root(), hidden = true })
end, { desc = "Find files from project root" })

keymap("n", "<leader>fg", function()
  Snacks.picker.grep({ cwd = root(), hidden = true })
end, { desc = "Search text from project root" })

keymap("n", "<leader>fi", function()
  Snacks.picker.lines()
end, { desc = "Search in current file" })

-- Git hunks (gitsigns) ----------------------------------------------------
keymap("n", "<leader>hn", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next hunk" })
keymap("n", "<leader>hp", function()
  require("gitsigns").nav_hunk("prev")
end, { desc = "Prev hunk" })
keymap("n", "<leader>hs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
keymap("n", "<leader>hu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Undo stage" })
keymap("n", "<leader>hr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
keymap("n", "<leader>hd", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

-- Commenting (Comment.nvim -> built-in gc/gcc) ----------------------------
keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
keymap("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
