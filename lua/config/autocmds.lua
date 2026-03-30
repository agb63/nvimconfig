
-- Prevent collisions with custom group
local customAutos = vim.api.nvim_create_augroup("CustomAutos", { clear = true })

-- autocmd! Filetype c,cpp map<buffer> <C-e> :Ouroboros<CR>
vim.api.nvim_create_autocmd("FileType", {
    group = customAutos,
    buffer = 0, -- FIXME what does this do?
    desc = "Set up Ouroboros toggle hotkey",
    callback = function()
        vim.keymap.set('n', '<C-e>', ':Ouroboros<cr>', {
            desc = 'Toggle between header and implementation',
            buffer = 0 -- FIXME doesn't seem to work?
        })
    end
})
