local Terminal = require("toggleterm.terminal").Terminal

local M = {}
local term

function M.init()
    -- create the terminal
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

function M.toggle()
    term:toggle()

    -- force insert mode every time
    if term:is_open() then
        vim.schedule(function()
            vim.cmd("startinsert")
        end)
    end
end

function M.run(cmd)
    term:open()
    term:send(cmd, false)

    -- force insert mode every time
    vim.schedule(function()
        vim.cmd("startinsert")
    end)
end

return M
