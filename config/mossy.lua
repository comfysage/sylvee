local sources = require("mossy.sources")

sources:setup({
    "treefmt",
    "clang-format",
    "nixfmt",
    "shfmt",
    "stylua",
})

sources:add("prettier"):with({
    filetypes = { "html", "markdown", "astro", "vue" },
})

vim.keymap.set("n", "<localleader>f", "<Plug>(mossy-format)", {})
