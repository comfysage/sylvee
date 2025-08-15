return {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",

    -- lua lib
    "nvim-lua/plenary.nvim",
    -- ui lib
    "MunifTanjim/nui.nvim",
    -- async lib
    "nvim-neotest/nvim-nio",

    -- theme
    { "catppuccin/nvim", name = "catppuccin" },

    -- ui
    { "feline-nvim/feline.nvim", event = "UIEnter" },
    { "nvim-neo-tree/neo-tree.nvim", event = "UIEnter" },

    { "ibhagwan/fzf-lua", event = "VimEnter" },

    -- general
    "echasnovski/mini.icons",
    { "echasnovski/mini.pairs", event = "BufRead" },
    { "echasnovski/mini.surround", event = "BufRead" },
    { "echasnovski/mini.files", event = "BufRead" },

    { "comfysage/mossy.nvim", name = "mossy" },
    { "mfussenegger/nvim-lint", event = "BufReadPre" },

    { "SmiteshP/nvim-navic", event = "BufReadPre" },
    { "akinsho/toggleterm.nvim", event = "VimEnter" },
}
