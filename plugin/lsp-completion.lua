vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sylvee:lsp-completion", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client == nil then
            return
        end

        if client.server_capabilities.completionProvider then
            -- enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
    end,
})
