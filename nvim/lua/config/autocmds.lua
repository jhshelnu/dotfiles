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
  pattern = { "*.go", "*.rs", "*.js", "*.ts" },
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
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
