local theme = {
    { "default-title" },
    winopts = {
        row = 1,
        col = 0,
        width = 1,
        height = 0.4,
        backdrop = 100,
        title_pos = "left",
        border = { "", "─", "", "", "", "", "", "" },
        preview = {
            layout = "horizontal",
            title_pos = "right",
            border = function(_, m)
                if m.type == "fzf" then
                    return "single"
                else
                    assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
                    local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
                    if m.layout == "down" then
                        b[1] = "├" --top right
                        b[3] = "┤" -- top left
                    elseif m.layout == "up" then
                        b[7] = "├" -- bottom left
                        b[6] = "" -- remove bottom
                        b[5] = "┤" -- bottom right
                    elseif m.layout == "left" then
                        b[3] = "┬" -- top right
                        b[5] = "┴" -- bottom right
                        b[6] = "" -- remove bottom
                    else -- right
                        b[1] = "┬" -- top left
                        b[7] = "┴" -- bottom left
                        b[6] = "" -- remove bottom
                    end
                    return b
                end
            end,
        }
    },
}

local up      = {
    row = 1,
    col = 0,
    width = 1,
    height = 1,
    preview = {
        layout = "vertical",
        vertical = "up:60%",
        border = "none",
    },
}

theme.blines      = { winopts = up, previewer = { toggle_behavior = "extend" } }
theme.lines       = theme.blines
theme.grep        = theme.blines
theme.grep_curbuf = theme.blines
theme.git         = { blame = { winopts = up } }

local opts = {
    fzf_opts = {
        ["--layout"] = "reverse-list",
        ["--info"] = "inline-right",
        ["--no-separator"] = "",
    },
    file_icon_padding = " ",
    prompt = " ",
    previewer = "builtin",
    files = {
        cwd_prompt = false,
        previewer = false,
        git_icons = false,
    },
    grep_curbuf = {
        winopts = {
            treesitter = true,
        },
    },
    file_ignore_patterns = {
        "%.age",
        "%.cache",
        "%.class",
        "%.dart_tool/",
        "%.dll",
        "%.docx",
        "%.dylib",
        "%.exe",
        "%.git/",
        "%.gradle/",
        "%.ico",
        "%.idea/",
        "%.ipynb",
        "%.jar",
        "%.jpeg",
        "%.jpg",
        "%.lock",
        "%.luac",
        "%.met",
        "%.min.js",
        "%.npz",
        "%.otf",
        "%.pdb",
        "%.pdf",
        "%.png",
        "%.pyc",
        "%.settings/",
        "%.so",
        "%.sqlite3",
        "%.ttf",
        "%.vale/",
        "%.vscode/",
        "%.webp",
        ".direnv/",
        ".direnv/*",
        "__pycache__/",
        "__pycache__/*",
        "_sources/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "node_modules/*",
        "smalljre_*/*",
        "target/",
        "tmp/",
        "vendor/*",
    },
}

require("fzf-lua").setup(vim.tbl_deep_extend('force', theme, opts))

require("fzf-lua").register_ui_select()

local map = function(mode, shortcut, command, opt)
    opt = opt or { noremap = true, silent = true }
    vim.keymap.set(mode, shortcut, command, opt)
end

map("n", "<leader><leader>", "<cmd>FzfLua files<cr>") -- find files
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>") -- grep through all files
map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>") -- search help tags
map("n", "<leader>R", "<cmd>FzfLua lsp_definitions<cr>")
