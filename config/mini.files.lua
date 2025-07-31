-- files
require("mini.files").setup({
    options = {
        use_as_default_explorer = false,
    },
    windows = {
        -- Maximum number of windows to show side by side
        max_number = 3,
        -- Whether to show preview of file/directory under cursor
        preview = false,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 25,
    },
})

vim.keymap.set("n", "<space>sp", require("mini.files").open, {})
vim.keymap.set("n", "-", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, {})
