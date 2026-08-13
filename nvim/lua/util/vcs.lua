local M = {}

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

return M
