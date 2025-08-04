require("sylvee")

-- plugins --

vim.pack.add({
  { src = "https://github.com/comfysage/lynn.nvim", name = "lynn" }
})

local pack = require("lynn")
pack.setup("sylvee.plugins")

-- theme --
require("catppuccin").setup({
    flavour = "mocha",
    auto_integrations = true,
    integrations = {
        fzf = true,
    },
})

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("sylvee:message:enter", { clear = true }),
  once = true,
  callback = function()
    if vim.fn.argc() > 0 then
      return
    end
    require("sylvee.message")
  end,
})
