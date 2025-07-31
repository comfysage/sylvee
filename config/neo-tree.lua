-- neo-tree settings
require("neo-tree").setup({
    popup_border_style = "", -- use 'winborder'
    filesystem = {
        use_libuv_file_watcher = true,
    },
    default_component_configs = {
        icon = {
            provider = function(icon, node) -- setup a custom icon provider
                local text, hl
                local mini_icons = require("mini.icons")
                if node.type == "file" then          -- if it's a file, set the text/hl
                    text, hl = mini_icons.get("file", node.name)
                elseif node.type == "directory" then -- get directory icons
                    text, hl = mini_icons.get("directory", node.name)
                    -- only set the icon text if it is not expanded
                    if node:is_expanded() then
                        text = nil
                    end
                end

                -- set the icon text/highlight only if it exists
                if text then
                    icon.text = text
                end
                if hl then
                    icon.highlight = hl
                end
            end,
        },
        kind_icon = {
            provider = function(icon, node)
                local mini_icons = require("mini.icons")
                icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
            end,
        },
    },
})

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "neo-tree *",
    group = vim.api.nvim_create_augroup("filetype:neo-tree:options", { clear = true }),
    callback = function(ev)
        vim.api.nvim_set_option_value("sidescrolloff", 0, { win = ev.win })
    end,
})

vim.keymap.set("n", "<leader>x", function()
    vim.cmd [[ Neotree toggle action=show position=left ]]
end)
