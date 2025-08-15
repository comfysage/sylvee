vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sylvee:lsp-colorizer", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client == nil then
            return
        end

        if client.server_capabilities.colorProvider then
            vim.lsp.document_color.enable(true, ev.buf)
        end
    end,
})
