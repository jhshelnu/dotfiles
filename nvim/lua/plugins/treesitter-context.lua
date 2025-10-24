return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    enable = true,            -- enable this plugin
    max_lines = 1,            -- how many lines to show for context
    multiline_threshold = 1,  -- collapse long declarations
    trim_scope = "outer",     -- which context to remove when exceeded
    mode = "cursor",          -- calculate context from cursor (not top line)
    separator = nil,
  },
}
