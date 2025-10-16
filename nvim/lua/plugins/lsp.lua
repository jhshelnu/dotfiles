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
        require("mason-lspconfig").setup()
      end,
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    local go_settings = {
      gopls = {
        gofumpt = true,
        usePlaceholders = true,
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
