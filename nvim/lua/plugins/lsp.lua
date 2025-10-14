return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local telescope = require("telescope.builtin")

      mason_lsp.setup({
        ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "jsonls" },
        automatic_installation = true,
        handlers = {
          -- default for every server
          function(server)
            lspconfig[server].setup({
              capabilities = caps,
            })
          end,

          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            }
          end,
        },
      })

      -- set go build tags
      vim.env.GOFLAGS = "-tags=integration"
    end,
  },
}
