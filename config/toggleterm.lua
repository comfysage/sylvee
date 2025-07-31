require("toggleterm").setup({
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "1",
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
        border = vim.o.winborder,
    },
})

vim.keymap.set("n", "<leader>gg", function()
    lazygit:toggle()
end, { noremap = true, silent = true })

local toggleterm = Terminal:new({
    direction = "float",
    on_open = function(t)
        vim.api.nvim_win_set_height(t.window, math.min(vim.o.lines, 16))
        vim.api.nvim_win_set_width(t.window, vim.o.columns)
        vim.api.nvim_win_set_config(t.window, {
            relative = "editor",
            col = 0,
            row = vim.o.lines - 16 - vim.o.cmdheight,
        })
    end,
    float_opts = {
        border = vim.o.winborder,
    },
})
vim.keymap.set("n", "<a-`>", function()
    toggleterm:toggle()
end, { noremap = true, silent = true })
