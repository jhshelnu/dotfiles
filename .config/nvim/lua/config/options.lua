-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- tab titles
opt.title = false
opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " (nvim)"

-- Line numbers
opt.number = true -- show line numbers
opt.relativenumber = true -- show relative line numbers

-- Indentation (LazyVim defaults to 2; personal preference is 4)
opt.autoindent = true -- keep indent of current line for the next
opt.copyindent = true -- copy existing indent structure
opt.preserveindent = true -- don't reflow existing indentation
opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
opt.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
opt.expandtab = true -- convert tabs to spaces
opt.smartindent = true -- autoindent new lines smartly

-- Search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- unless search has capital letters
opt.incsearch = true -- show matches as you type
opt.inccommand = "nosplit" -- live %s previews

-- Appearance
opt.termguicolors = true -- enable 24-bit RGB colors
opt.cursorline = true -- highlight current line
opt.signcolumn = "yes" -- always show sign column (for git/lsp symbols)
opt.scrolloff = 99999 -- keep cursor centered vertically
opt.wrap = false -- don't wrap long lines

-- Performance
opt.updatetime = 250 -- faster CursorHold events
opt.timeoutlen = 500 -- timeout after hitting the leader key

-- Reload files changed on disk (e.g. by jj new/edit/undo/rebase).
opt.autoread = true

-- Clipboard
opt.clipboard = "unnamedplus" -- use system clipboard

-- Splits
opt.splitbelow = true -- horizontal splits below current
opt.splitright = true -- vertical splits to the right
