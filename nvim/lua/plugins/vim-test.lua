return {
  "vim-test/vim-test",
  config = function()
    local function run_in_term(cmd)
      require("util.term").run(vim.fn.expandcmd(cmd))
    end

    vim.g["test#custom_strategies"] = { termfloat = run_in_term }
    vim.g["test#strategy"] = "termfloat"

    -- when running Go tests, use verbose mode and turn on the data race detector
    vim.g["test#go#gotest#options"] = "-v -tags=integration -race -parallel=2"
  end,
}
