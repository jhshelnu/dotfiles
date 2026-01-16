return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "gopls", "rust_analyzer", "lua_ls" },
          automatic_installation = true,
        })
      end,
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local go_settings = {
      gopls = {
        gofumpt = true,
        usePlaceholders = false,
        completeUnimported = true,
        staticcheck = true,
        buildFlags = { "-tags=integration" },
      },
    }

    local ok, prefixTable = pcall(require, "local.go_import_prefixes")
    if ok then
      local prefixes = table.concat(prefixTable, ",")
      go_settings.gopls["formatting.local"] = prefixes
    end

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = go_settings,
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            allTargets = true,  
          },
          checkOnSave = true,
          check = {
            command = "check",
            allTargets = true,
          },
          cfg = {
            setTest = true,
          },
          imports = {
            granularity = { group = "crate", enforce = true },
            prefix = "crate",
          },
          completion = {
            callable = {
              snippets = "add_parentheses"
            },
          },
          rustfmt = {
            extraArgs = {
              "--config",
              "imports_granularity=Crate",
            },
          },
        },
      },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}
