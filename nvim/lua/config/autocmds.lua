-- Auto-save when you stop typing for 2 seconds
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.modified and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- Auto-format + organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.go", "*.rs", "*.js", "*.ts" },
  callback = function()
    -- Get the current window and cursor position so it can be restored after the formatting.
    local win = vim.api.nvim_get_current_win()
    local cursor_pos = vim.api.nvim_win_get_cursor(win)

    -- helper function to "apply all" for a particular kind of lsp action
    local function apply_by_kind(kind)
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { kind } }
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
          elseif r.command then
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end

    apply_by_kind("source.organizeImports")
    apply_by_kind("source.fixAll")
    vim.lsp.buf.format({ async = false })

    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(win, cursor_pos)
  end,
})

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      higroup = "Search",
    })
  end,
})
