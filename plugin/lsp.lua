-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sylvee:lsp:keymaps", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client == nil then
            return
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("i", "<C-s>", function()
            vim.lsp.buf.signature_help({
                silent = true,
                height = 2,
                focusable = false,
            })
        end, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, opts)
    end,
})

vim.lsp.config("*", {
    on_attach = function(client, bufnr)
        do
            local ok, navic = pcall(require, "nvim-navic")
            if not ok then
                return
            end
            navic.attach(client, bufnr)
        end
    end,
})

local servers = {
    lua_ls = {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath("config")
                    and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                then
                    return
                end
            end
            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                    },
                },
            })
        end,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = {
                        "lua/?.lua",
                        "lua/?/init.lua",
                    },
                },
                diagnostics = {
                    globals = { "vim", "package", "table" },
                },
                hint = {
                    enable = true,
                    arrayIndex = "Disable",
                },
            },
        },
    },
}

vim.iter(pairs(servers)):each(function(name, cfg)
    vim.lsp.config(name, cfg)
end)
local server_names = vim.iter(pairs(servers))
    :map(function(name, _)
        return name
    end)
    :totable()
vim.lsp.enable(server_names)
