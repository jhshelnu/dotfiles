-- git signs: +/~/- symbols with vivid, high-contrast colors
local colors = {
  GitSignsAdd = "#00e676", -- vivid green
  GitSignsChange = "#ffa031", -- vivid orange
  GitSignsDelete = "#ff4040", -- vivid red
  GitSignsChangedelete = "#ffa031",
  GitSignsTopdelete = "#ff4040",
  GitSignsUntracked = "#00e676",
}

local function set_hl()
  for group, fg in pairs(colors) do
    vim.api.nvim_set_hl(0, group, { fg = fg })
  end
end

-- re-apply after any colorscheme load, and once for the current one
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
vim.schedule(set_hl)

local signs = {
  add = { text = "+" },
  change = { text = "~" },
  delete = { text = "-" },
  topdelete = { text = "-" },
  changedelete = { text = "~" },
  untracked = { text = "+" },
}

return {
  "lewis6991/gitsigns.nvim",
  opts = { signs = signs, signs_staged = signs },
}
