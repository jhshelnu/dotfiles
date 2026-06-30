local Terminal = require("toggleterm.terminal").Terminal

local M = {}
local term

local function get_or_create()
    if not term then
        term = Terminal:new({
            direction = "float",
            hidden = true,
        })

        -- briefly open it in the background
        -- so it can run through zshrc stuff before it's first needed.
        local cur = vim.api.nvim_get_current_win()
        term:open()
        vim.api.nvim_set_current_win(cur)

        vim.defer_fn(function()
            term:close()
        end, 1000)
    end
    return term
end

function M.init()
    get_or_create()
end

function M.run(cmd)
    local t = get_or_create()
    t:open()
    t:send(cmd, false)

    -- force insert mode every time
    vim.schedule(function()
        vim.cmd("startinsert")
    end)
end

return M
