return {
  "vim-test/vim-test",
  config = function()
    vim.g["test#strategy"] = "neovim" -- or "toggleterm" if you use that
  end,
}
