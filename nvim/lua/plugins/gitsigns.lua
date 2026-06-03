return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "+" }, -- new/untracked files show as added, not "┆"
      },
      current_line_blame = true, -- optional: show git blame inline
      attach_to_untracked = true, -- show brand-new (untracked) files as added
      -- Use the DEFAULT index base (no change_base). This is what shows new
      -- files in both worlds: untracked files via attach_to_untracked, and jj's
      -- intent-to-add new files via the staged-signs layer. (base=HEAD would
      -- hide all new files, since they don't exist in HEAD.)
      --
      -- Restyle the staged-signs layer to match `signs` so staged hunks render
      -- as +/~/_ instead of the default solid "┃" bar. In colocated jj this is
      -- also what draws intent-to-add new files as "+".
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })
  end,
}
