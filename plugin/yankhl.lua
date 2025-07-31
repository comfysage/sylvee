vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("editor:yank:highlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "CurSearch", timeout = 200 })
    end,
    desc = "Highlight yanked text",
})
