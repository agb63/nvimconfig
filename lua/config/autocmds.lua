
-- Prevent collisions with custom group
local customAutos = vim.api.nvim_create_augroup("CustomAutos", { clear = true })

-- Jump between h and cpp
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "cxx", "h", "hpp" },
    group = customAutos,
    desc = "Set Ouroboros toggle hotkey",
    callback = function()
        vim.keymap.set('n', '<C-a>', ':Ouroboros<cr>', {
            desc = 'Toggle between header and implementation',
            silent = true,
            buffer = 0 -- FIXME doesn't seem to work?
        })
    end
})

-- Fix formatoptions (autocmd so it wins over ftplugins)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    group = customAutos,
    desc = "Disable auto comment leader in formatoptions",
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(
                true, client.id, args.buf, { autotrigger = true })
        end
    end,
})
