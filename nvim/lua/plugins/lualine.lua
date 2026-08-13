-- hide lualine extras like system time, filetype icon, etc.
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local s = opts.sections

    s.lualine_b = {}
    s.lualine_c = vim.tbl_filter(function(comp)
      return comp[1] ~= "filetype"
    end, s.lualine_c)
    s.lualine_x = {}
    s.lualine_z = {}
  end,
}
