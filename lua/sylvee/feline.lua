local M = {}

local C = require("catppuccin.palettes").get_palette()
local lsp = require("feline.providers.lsp")

local assets = {
    left_separator = "",
    right_separator = "",
    mode_icon = "",
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
}

local sett = {
    text = C.mantle,
    bkg = C.crust,
    diffs = C.mauve,
    extras = C.overlay1,
    curr_file = C.maroon,
    curr_dir = C.flamingo,
    show_modified = false,
    show_lazy_updates = false,
}

if require("catppuccin").flavour == "latte" then
    local latte = require("catppuccin.palettes").get_palette("latte")
    sett.text = latte.base
    sett.bkg = latte.crust
end

if require("catppuccin").options.transparent_background then
    sett.bkg = "NONE"
end

local mode_colors = {
    ["n"] = { "NORMAL", C.lavender },
    ["no"] = { "N-PENDING", C.lavender },
    ["i"] = { "INSERT", C.green },
    ["ic"] = { "INSERT", C.green },
    ["t"] = { "TERMINAL", C.green },
    ["v"] = { "VISUAL", C.flamingo },
    ["V"] = { "V-LINE", C.flamingo },
    [""] = { "V-BLOCK", C.flamingo },
    ["R"] = { "REPLACE", C.maroon },
    ["Rv"] = { "V-REPLACE", C.maroon },
    ["s"] = { "SELECT", C.maroon },
    ["S"] = { "S-LINE", C.maroon },
    [""] = { "S-BLOCK", C.maroon },
    ["c"] = { "COMMAND", C.peach },
    ["cv"] = { "COMMAND", C.peach },
    ["ce"] = { "COMMAND", C.peach },
    ["r"] = { "PROMPT", C.teal },
    ["rm"] = { "MORE", C.teal },
    ["r?"] = { "CONFIRM", C.mauve },
    ["!"] = { "SHELL", C.green },
}

local view = {
    lsp = {
        progress = true,
        name = false,
        exclude_lsp_names = {},
        separator = "|",
    },
}

local function is_enabled(min_width)
    return function()
        return vim.api.nvim_win_get_width(0) > min_width
    end
end

local is_lsp_in_excluded_list = function(lsp_name)
    for _, excluded_lsp in ipairs(view.lsp.exclude_lsp_names) do
        if lsp_name == excluded_lsp then
            return true
        end
    end
    return false
end

-- helpers
local function any_git_changes()
    local gst = vim.b.gitsigns_status_dict -- git stats
    if gst then
        if
            gst["added"] and gst["added"] > 0
            or gst["removed"] and gst["removed"] > 0
            or gst["changed"] and gst["changed"] > 0
        then
            return true
        end
    end
    return false
end

local provider = {
    filetype = function()
        return " " .. string.upper(vim.bo.ft) .. " "
    end,
    filename = function()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local present, icons = pcall(require, "nvim-web-devicons")
        local icon = present and icons.get_icon(filename, extension) or assets.file
        return (sett.show_modified and "%m" or "") .. " " .. icon .. " " .. filename .. " "
    end,
    currentdir = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return " " .. assets.dir .. " " .. dir_name .. " "
    end,
}

function M.setup(opts)
    if opts then
        opts.assets = opts.assets or {}
        opts.sett = opts.sett or {}
        opts.mode_colors = opts.mode_colors or {}
        opts.view = opts.view or {}
    else
        opts = {
            assets = {},
            sett = {},
            mode_colors = {},
            view = {},
        }
    end
    assets = vim.tbl_deep_extend("force", assets, opts.assets)
    sett = vim.tbl_deep_extend("force", sett, opts.sett)
    mode_colors = vim.tbl_deep_extend("force", mode_colors, opts.mode_colors)
    view = vim.tbl_deep_extend("force", view, opts.view)
end

function M.get()
    local components = {
        active = { {}, {}, {} }, -- left, center, right
        inactive = { {} },
    }

    -- global components
    local invi_sep = {
        str = " ",
        hl = {
            fg = sett.bkg,
            bg = sett.bkg,
        },
    }

    -- #################### STATUSLINE ->

    -- ######## Left

    -- Current vi mode ------>
    local vi_mode_hl = function()
        return {
            fg = sett.text,
            bg = mode_colors[vim.fn.mode()][2],
            style = "bold",
        }
    end

    table.insert(components.active[1], {
        provider = " " .. assets.mode_icon .. " ",
        hl = function()
            return {
                fg = sett.text,
                bg = mode_colors[vim.fn.mode()][2],
            }
        end,
    })

    table.insert(components.active[1], {
        provider = function()
            return mode_colors[vim.fn.mode()][1] .. " "
        end,
        hl = vi_mode_hl,
    })

    -- enable if git diffs are not available
    table.insert(components.active[1], {
        provider = assets.right_separator,
        hl = function()
            return {
                fg = mode_colors[vim.fn.mode()][2],
                bg = sett.bkg,
            }
        end,
        enabled = function()
            return not any_git_changes()
        end,
    })

    -- enable if git diffs are available
    table.insert(components.active[1], {
        provider = assets.right_separator,
        hl = function()
            return {
                fg = mode_colors[vim.fn.mode()][2],
                bg = sett.diffs,
            }
        end,
        enabled = function()
            return any_git_changes()
        end,
    })
    -- Current vi mode ------>

    -- Diffs ------>
    table.insert(components.active[1], {
        provider = "git_diff_added",
        hl = {
            fg = sett.text,
            bg = sett.diffs,
        },
        icon = " " .. assets.git.added .. " ",
    })

    table.insert(components.active[1], {
        provider = "git_diff_changed",
        hl = {
            fg = sett.text,
            bg = sett.diffs,
        },
        icon = " " .. assets.git.changed .. " ",
    })

    table.insert(components.active[1], {
        provider = "git_diff_removed",
        hl = {
            fg = sett.text,
            bg = sett.diffs,
        },
        icon = " " .. assets.git.removed .. " ",
    })

    table.insert(components.active[1], {
        provider = " ",
        hl = {
            fg = sett.bkg,
            bg = sett.diffs,
        },
        enabled = function()
            return any_git_changes()
        end,
    })

    table.insert(components.active[1], {
        provider = assets.right_separator,
        hl = {
            fg = sett.diffs,
            bg = sett.bkg,
        },
        enabled = function()
            return any_git_changes()
        end,
    })
    -- Diffs ------>

    -- Extras ------>

    -- file progress
    table.insert(components.active[1], {
        provider = function()
            local current_line = vim.fn.line(".")
            local total_line = vim.fn.line("$")

            if current_line == 1 then
                return "Top"
            elseif current_line == vim.fn.line("$") then
                return "Bot"
            end
            local result, _ = math.modf((current_line / total_line) * 100)
            return result .. "%%"
        end,
        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },
        left_sep = invi_sep,
    })

    -- position
    table.insert(components.active[1], {
        provider = "position",
        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },
        left_sep = invi_sep,
    })

    -- macro
    table.insert(components.active[1], {
        provider = "macro",
        enabled = function()
            return vim.api.nvim_get_option_value("cmdheight", { scope = "global" }) == 0
        end,
        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },
        left_sep = invi_sep,
    })

    -- search count
    table.insert(components.active[1], {
        provider = "search_count",
        enabled = function()
            return vim.api.nvim_get_option_value("cmdheight", { scope = "global" }) == 0
        end,
        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },
        left_sep = invi_sep,
    })

    -- Extras ------>

    -- ######## Left

    -- ######## Center

    -- Diagnostics ------>
    -- workspace loader
    table.insert(components.active[2], {
        provider = function()
            if vim.lsp.status then
                return ""
            end
            local Lsp = vim.lsp.util.get_progress_messages()[1]

            if Lsp then
                local msg = Lsp.message or ""
                local percentage = Lsp.percentage
                if not percentage then
                    return ""
                end
                local title = Lsp.title or ""
                local spinners = {
                    "",
                    "󰀚",
                    "",
                }
                local success_icon = {
                    "",
                    "",
                    "",
                }
                local ms = vim.loop.hrtime() / 1000000
                local frame = math.floor(ms / 120) % #spinners

                if percentage >= 70 then
                    return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
                end

                return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
            end

            return ""
        end,
        enabled = is_enabled(80) and view.lsp.progress == true,
        hl = {
            fg = C.rosewater,
            bg = sett.bkg,
        },
    })

    -- general diagnostics (errors, warnings. info and hints)
    table.insert(components.active[2], {
        provider = "diagnostic_errors",
        enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,

        hl = {
            fg = C.red,
            bg = sett.bkg,
        },
        icon = " " .. assets.lsp.error .. " ",
    })

    table.insert(components.active[2], {
        provider = "diagnostic_warnings",
        enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
        end,
        hl = {
            fg = C.yellow,
            bg = sett.bkg,
        },
        icon = " " .. assets.lsp.warning .. " ",
    })

    table.insert(components.active[2], {
        provider = "diagnostic_info",
        enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
        end,
        hl = {
            fg = C.sky,
            bg = sett.bkg,
        },
        icon = " " .. assets.lsp.info .. " ",
    })

    table.insert(components.active[2], {
        provider = "diagnostic_hints",
        enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
        end,
        hl = {
            fg = C.rosewater,
            bg = sett.bkg,
        },
        icon = " " .. assets.lsp.hint .. " ",
    })
    -- Diagnostics ------>

    -- ######## Center

    -- ######## Right

    table.insert(components.active[3], {
        provider = "git_branch",
        enabled = is_enabled(70),
        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },
        icon = assets.git.branch .. " ",
        right_sep = invi_sep,
    })

    table.insert(components.active[3], {
        provider = function()
            local active_clients = vim.lsp.get_clients({ bufnr = 0 })

            -- show an indicator that we have running lsps
            if view.lsp.name == false and next(active_clients) ~= nil then
                return assets.lsp.server .. " " .. "Lsp"
            end

            -- show the actual name of the running lsps
            local index = 0
            local lsp_names = ""
            for _, lsp_config in ipairs(active_clients) do
                if is_lsp_in_excluded_list(lsp_config.name) then
                    goto continue
                end

                index = index + 1
                if index == 1 then
                    lsp_names = assets.lsp.server .. " " .. lsp_config.name
                else
                    lsp_names = lsp_names .. view.lsp.separator .. lsp_config.name
                end

                ::continue::
            end

            return lsp_names
        end,

        hl = {
            fg = sett.extras,
            bg = sett.bkg,
        },

        right_sep = invi_sep,
    })

    table.insert(components.active[3], {
        provider = provider.filename,
        enabled = is_enabled(70),
        hl = {
            fg = sett.text,
            bg = sett.curr_file,
        },
        left_sep = {
            str = assets.left_separator,
            hl = {
                fg = sett.curr_file,
                bg = sett.bkg,
            },
        },
    })

    table.insert(components.active[3], {
        provider = provider.currentdir,
        enabled = is_enabled(80),
        hl = {
            fg = sett.text,
            bg = sett.curr_dir,
        },
        left_sep = {
            str = assets.left_separator,
            hl = {
                fg = sett.curr_dir,
                bg = sett.curr_file,
            },
        },
    })
    -- ######## Right

    -- Inanctive components
    table.insert(components.inactive[1], {
        provider = provider.filetype,
        hl = {
            fg = C.overlay2,
            bg = C.mantle,
        },
    })

    return components
end

function M.get_winbar()
    local components = {
        active = { {}, {}, {} }, -- left, center, right
        inactive = { {} },
    }

    -- left

    table.insert(components.active[1], {
        provider = provider.filename,
        enabled = is_enabled(40),
        hl = {
            fg = sett.text,
            bg = C.lavender,
        },
        right_sep = {
            str = assets.right_separator,
            hl = {
                fg = C.lavender,
                bg = C.mantle,
            },
        },
    })

    table.insert(components.active[1], {
        provider = function()
            local ok, navic = pcall(require, "nvim-navic")
            if not ok then
                return
            end
            return " " .. navic.get_location() .. " "
        end,
        enabled = function()
            local ok, navic = pcall(require, "nvim-navic")
            if not ok then
                return false
            end
            return is_enabled(40)() and navic.is_available()
        end,
        hl = {
            fg = C.lavender,
            bg = C.mantle,
        },
        right_sep = {
            str = assets.right_separator,
            hl = {
                fg = C.mantle,
                bg = sett.bkg,
            },
        },
    })

    table.insert(components.active[1], {
        provider = function()
            return " "
        end,
        enabled = function()
            local ok, navic = pcall(require, "nvim-navic")
            if not ok then
                return false
            end
            return not is_enabled(40)() or not navic.is_available()
        end,
        hl = {
            fg = C.text,
            bg = C.mantle,
        },
        right_sep = {
            str = assets.right_separator,
            hl = {
                fg = C.mantle,
                bg = sett.bkg,
            },
        },
    })

    -- inactive

    table.insert(components.inactive[1], components.active[1][1])

    return components
end

return M
