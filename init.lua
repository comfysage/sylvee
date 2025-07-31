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
})

vim.cmd.colorscheme("catppuccin")

require("sylvee.message")
