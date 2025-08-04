vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sylvee:lsp-inlayhint", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client == nil then
            return
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end
    end,
})
