return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPre",
  opts = {
    -- Always-visible indent guides
    indent = {
      char = "│",
      tab_char = "│",
      highlight = "IblIndent",
    },
    scope = { enabled = false },
  },
}
