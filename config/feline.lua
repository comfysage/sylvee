local function setup()
    -- feline bar settings
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    local clrs = require("catppuccin.palettes").get_palette()
    local ctp_feline = require('sylvee.feline')
    local U = require "catppuccin.utils.colors"

    ctp_feline.setup({
        assets = {
            left_separator = "",
            right_separator = "",
            mode_icon = "♥ ",
            dir = "󰉖",
            file = "󰈙",
            lsp = {
                server = "󰅡",
                error = "",
                warning = "",
                info = "",
                hint = "",
            },
            git = {
                branch = "",
                added = "",
                changed = "",
                removed = "",
            },
        },
        sett = {
            text = U.vary_color({ mocha = mocha.base }, clrs.surface0),
            bkg = U.vary_color({ mocha = mocha.crust }, clrs.surface0),
            diffs = clrs.mauve,
            extras = clrs.overlay1,
            curr_file = clrs.maroon,
            curr_dir = clrs.flamingo,
            show_modified = true -- show if the file has been modified
        },
        mode_colors = {
            ["n"] = { "NORMAL", clrs.pink },
            ["no"] = { "N-PENDING", clrs.pink },
            ["i"] = { "INSERT", clrs.rosewater },
            ["ic"] = { "INSERT", clrs.rosewater },
            ["t"] = { "TERMINAL", clrs.rosewater },
            ["v"] = { "VISUAL", clrs.flamingo },
            ["V"] = { "V-LINE", clrs.flamingo },
            ["�"] = { "V-BLOCK", clrs.flamingo },
            ["R"] = { "REPLACE", clrs.maroon },
            ["Rv"] = { "V-REPLACE", clrs.maroon },
            ["s"] = { "SELECT", clrs.maroon },
            ["S"] = { "S-LINE", clrs.maroon },
            ["�"] = { "S-BLOCK", clrs.maroon },
            ["c"] = { "COMMAND", clrs.peach },
            ["cv"] = { "COMMAND", clrs.peach },
            ["ce"] = { "COMMAND", clrs.peach },
            ["r"] = { "PROMPT", clrs.teal },
            ["rm"] = { "MORE", clrs.teal },
            ["r?"] = { "CONFIRM", clrs.mauve },
            ["!"] = { "SHELL", clrs.green },
            ["nt"] = { "NVIMTREE", clrs.peach },
        },
        view = {
            lsp = {
                progress = true,        -- if true the status bar will display an lsp progress indicator
                name = false,           -- if true the status bar will display the lsp servers name, otherwise it will display the text "Lsp"
                exclude_lsp_names = {}, -- lsp server names that should not be displayed when name is set to true
                separator = "|",        -- the separator used when there are multiple lsp servers
            },
        }
    })

    require('feline').setup({
        components = ctp_feline.get(),
    })

    require('feline').winbar.setup({
        disable = {
            filetypes = {
                '^neo[-]tree$',
                '^NvimTree$',
                '^packer$',
                '^startify$',
                '^fugitive$',
                '^fugitiveblame$',
                '^qf$',
                '^help$',
                '^toggleterm$',
            },
            buftype = {
                '^nofile$',
                '^terminal$',
            },
            bufnames = {},
        },
        components = ctp_feline.get_winbar(),
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("feline:colorscheme:reload", { clear = true }),
    callback = function()
        package.loaded["feline"] = nil
        package.loaded["catppuccin.groups.integrations.feline"] = nil
        setup()
    end,
})
