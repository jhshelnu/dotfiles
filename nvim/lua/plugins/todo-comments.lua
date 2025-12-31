return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      signs = false, -- disable gutter icons
      keywords = {
        TODO = {
          color = "warning",
          alt = { "todo", "FIXME", "fixme", "BUG", "bug", "ISSUE", "issue", "PERF", "perf" }
        },
      },
      highlight = {
        keyword = "fg",
        pattern = [[.*<(KEYWORDS)\s*:?]],
        multiline = false
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
      }
    })
  end
}
