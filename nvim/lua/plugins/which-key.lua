-- hide the which key popup in visual mode
return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.triggers = { { "<auto>", mode = "no" } }
  end,
}
