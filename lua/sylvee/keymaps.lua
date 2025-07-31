vim.g.mapleader = " "
vim.g.maplocalleader = " m"
vim.keymap.set("n", "[<tab>", vim.cmd.tabprev)
vim.keymap.set("n", "]<tab>", vim.cmd.tabnext)
vim.keymap.set("n", "<C-w><tab>", vim.cmd.tabnew)

vim.keymap.set("n", "<leader>G", "<cmd>FloatermNew --autoclose=1 lazygit<CR>")

vim.keymap.set("n", "<leader>i", vim.cmd.Inspect)
vim.keymap.set("n", "<leader>I", vim.cmd.InspectTree)
