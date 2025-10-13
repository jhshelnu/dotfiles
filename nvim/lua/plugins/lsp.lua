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

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "K",         vim.lsp.buf.hover,          "LSP Hover")
        map("n", "gd",        vim.lsp.buf.definition,     "Go to Definition")
        map("n", "gD",        vim.lsp.buf.declaration,    "Go to Declaration")
        map("n", "gi",        vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gr",        vim.lsp.buf.references,     "References")
        map("n", "<leader>rn",vim.lsp.buf.rename,         "Rename Symbol")
        map("n", "<leader>ca",vim.lsp.buf.code_action,    "Code Action")
        map("n", "<leader>e", vim.diagnostic.open_float,  "Line Diagnostics")
        map("n", "[d",        vim.diagnostic.goto_prev,   "Prev Diagnostic")
        map("n", "]d",        vim.diagnostic.goto_next,   "Next Diagnostic")
      end

      mason_lsp.setup({
        ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "jsonls" },
        automatic_installation = true,
        handlers = {
          -- default for every server
          function(server)
            lspconfig[server].setup({
              capabilities = caps,
              on_attach = on_attach,
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
