require("sylvee.disable")
require("sylvee.options")
require("sylvee.keymaps")

-- window --

vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("editor:window:autoresize", { clear = true }),
    pattern = "*",
    command = [[ wincmd = ]],
    desc = "automatically resize windows when the editor size changes",
})

-- editing --

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("editor:file:auto_create_parent_path", { clear = true }),
    desc = "create path to file",
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")

        if dir:find("%l+://") == 1 then
            return
        end

        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})
