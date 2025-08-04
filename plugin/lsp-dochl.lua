vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sylvee:lsp-dochl", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client == nil then
            return
        end

        if client.server_capabilities.documentHighlightProvider then
            local group =
                vim.api.nvim_create_augroup(string.format("lsp:document_highlight:%d", ev.buf), { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = group,
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.lsp.buf.document_highlight()
                end,
                desc = "highlight lsp reference",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = group,
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
                desc = "clear lsp references",
            })
        end
    end,
})
