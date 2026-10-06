return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      -- root at the outermost Cargo.toml so nested crates share one client
      root_dir = function(filename, default)
        local root
        for dir in vim.fs.parents(filename) do
          if vim.uv.fs_stat(dir .. "/Cargo.toml") then
            root = dir
          end
        end
        return root or default(filename)
      end,
    },
  },
}
