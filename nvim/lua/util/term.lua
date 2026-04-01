local Terminal = require("toggleterm.terminal").Terminal

local M = {}
local terms = {}

local function get_or_create(id)
    if not terms[id] then
        terms[id] = Terminal:new({
            direction = "float",
            hidden = true,
        })

        -- briefly open it in the background
        -- so it can run through zshrc stuff before it's first needed.
        local cur = vim.api.nvim_get_current_win()
        terms[id]:open()
        vim.api.nvim_set_current_win(cur)

        vim.defer_fn(function()
            terms[id]:close()
        end, 1000)
    end
    return terms[id]
end

function M.init()
    get_or_create("s")
    get_or_create("r")
    get_or_create("c")
end

function M.toggle(id)
    local term = get_or_create(id or "s")
    term:toggle()

    -- force insert mode every time
    if term:is_open() then
        vim.schedule(function()
            vim.cmd("startinsert")
        end)
    end
end

function M.run(cmd, id)
    local term = get_or_create(id or "s")
    term:open()
    term:send(cmd, false)

    -- force insert mode every time
    vim.schedule(function()
        vim.cmd("startinsert")
    end)
end

return M
