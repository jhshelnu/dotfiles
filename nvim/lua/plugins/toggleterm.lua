return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      shade_terminals = false
    }
  end
}
