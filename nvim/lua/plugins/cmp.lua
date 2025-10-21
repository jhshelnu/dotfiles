return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
      },

      -- completion behavior & UX
      completion = {
        completeopt = "menu,menuone,noinsert",
        -- keep default keyword pattern
        -- keyword_pattern = [[\k\+]],
      },
      preselect = cmp.PreselectMode.Item,
      experimental = { ghost_text = true },
    })

    -- Extend trigger characters for the LSP source (so '.' ':' '>' open completion)
    local cfg = cmp.get_config()
    for _, src in ipairs(cfg.sources) do
      if src.name == "nvim_lsp" then
        src.trigger_characters = { ".", ":", ">" }
      end
    end

    -- Disable completion in comments or strings
    cfg.enabled = function()
      local context = require("cmp.config.context")

      -- Disable in command mode
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      end

      -- Use Treesitter or syntax groups to detect context
      return not (
        context.in_treesitter_capture("comment")
        or context.in_syntax_group("Comment")
        or context.in_treesitter_capture("string")
        or context.in_syntax_group("String")
      )
    end

    cmp.setup(cfg)

    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )

  end,
}
