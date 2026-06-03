-- VCS detection helpers shared across the config.
-- Lets gitsigns and project-root logic adapt to jj (colocated or pure) vs git
-- automatically, with no manual toggling.

local M = {}

-- Resolve the project root: prefer git (works for colocated + pure-git repos),
-- fall back to `jj root` (pure-jj repos), then the cwd.
function M.repo_root()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 and git_root and git_root ~= "" then
    return git_root
  end

  local jj_root = vim.fn.systemlist("jj root")[1]
  if vim.v.shell_error == 0 and jj_root and jj_root ~= "" then
    return jj_root
  end

  return vim.loop.cwd()
end

-- Cache of root dir -> bool(is jj). Avoids repeated filesystem walks per buffer.
local jj_cache = {}

-- Walk up from `start` looking for a `.jj` directory. Returns true for both
-- colocated (.git + .jj) and pure-jj repos.
function M.is_jj(start)
  start = start and start ~= "" and start or vim.loop.cwd()
  -- Normalize a file path to its containing directory.
  local dir = vim.fn.isdirectory(start) == 1 and start or vim.fn.fnamemodify(start, ":h")

  if jj_cache[dir] ~= nil then
    return jj_cache[dir]
  end

  -- `vim.fs.find` walks upward toward the filesystem root.
  local found = vim.fs.find(".jj", { path = dir, upward = true, type = "directory" })[1]
  local result = found ~= nil
  jj_cache[dir] = result
  return result
end

return M
