vim.api.nvim_exec_autocmds("ColorScheme", {
    data = {
        match = vim.g.colors_name
    },
})
