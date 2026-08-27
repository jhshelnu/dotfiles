return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = false, -- don't auto-open the tree on startup for a directory
    },
    picker = {
      sources = {
        explorer = {
          -- show dotfiles and gitignored files
          hidden = true,
          ignored = true,
          jump = { close = true }, -- hide the tree after selecting a file
          win = {
            list = {
              keys = {
                ["<Down>"] = "list_scroll_down",
                ["<Up>"] = "list_scroll_up",
              },
            },
          },
        },
      },
    },
  },
}
