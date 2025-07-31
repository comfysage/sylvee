-- surround
require("mini.surround").setup({
    mappings = {
        add = "S",             -- Add surrounding in Normal and Visual modes
        delete = "ds",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "cs",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
        suffix_last = "",      -- Suffix to search with "prev" method
        suffix_next = "",      -- Suffix to search with "next" method
    },
})
