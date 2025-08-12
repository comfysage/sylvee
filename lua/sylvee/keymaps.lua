vim.g.mapleader = " "
vim.g.maplocalleader = " m"
vim.keymap.set("n", "[<tab>", vim.cmd.tabprev)
vim.keymap.set("n", "]<tab>", vim.cmd.tabnext)
vim.keymap.set("n", "<C-w><tab>", vim.cmd.tabnew)

vim.keymap.set("n", "<C-j>", "<C-^>")

vim.keymap.set("n", "<leader>i", vim.cmd.Inspect)
vim.keymap.set("n", "<leader>I", vim.cmd.InspectTree)

vim.keymap.set("i", "<c-space>", "<C-x><C-o>", {})
local function pummap(lhs, rhs)
    vim.keymap.set("i", lhs, function()
        if vim.fn.pumvisible() > 0 then
            return rhs
        end
        return lhs
    end, { expr = true })
end
pummap("<cr>", "<c-y>")
pummap("<tab>", "<c-n>")
pummap("<s-tab>", "<c-p>")
