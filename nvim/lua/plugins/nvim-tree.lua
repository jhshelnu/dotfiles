-- open tree when nvim starts on a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local is_dir = vim.fn.isdirectory(data.file) == 1
    if not is_dir then return end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})

-- Close NvimTree windows if they are the last ones *during quit*.
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local floating = 0
    local tree_wins = {}

    for _, win in ipairs(wins) do
      local cfg = vim.api.nvim_win_get_config(win)
      if cfg.relative ~= "" then
        floating = floating + 1
      else
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "NvimTree" then
          table.insert(tree_wins, win)
        end
      end
    end

    -- If all non-floating windows are NvimTree, close them so Neovim can quit cleanly
    if (#wins - floating) == #tree_wins then
      for _, win in ipairs(tree_wins) do
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end
    end
  end,
})

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  keys = {
    { "<leader>ft", "<cmd>NvimTreeToggle<CR>",     desc = "File tree" },
    { "<leader>fT", "<cmd>NvimTreeFindFile<CR>",   desc = "Reveal current file" },
  },
  opts = {
    view = { width = 32, side = "left" },
    renderer = { group_empty = true },
    update_focused_file = { enable = true, update_root = true },
    filters = { dotfiles = false, git_ignored = false },
    git = { enable = true },
    disable_netrw = true,
    hijack_netrw = true,
    actions = {
      open_file = {
        quit_on_open = true, -- close the tree after opening a file
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

  end
}
