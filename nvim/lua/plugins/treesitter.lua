return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,           -- load at startup so it's available immediately
  -- priority = 1000,     -- optional: force earlier load if you still had init-time requires
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "markdown", "markdown_inline", "go", "rust",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    })
  end,
}
