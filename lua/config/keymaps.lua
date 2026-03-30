vim.keymap.set('n', '-', 'o<esc>', { desc = 'Add line below' })
vim.keymap.set('n', '_', 'O<esc>', { desc = 'Add line above' })
vim.keymap.set('n', '<s-k>', '"_dd', { desc = 'Kill line (no yank)' })
vim.keymap.set('n', '<c-s>', ':w<cr>', { desc = 'QuickSave' })
vim.keymap.set('i', '<c-s>', '<esc>:w<cr>a', { desc = 'QuickSave' })

-- Highlight word under cursor without searching
vim.keymap.set(
    'n', '<leader>f',
    function()
        vim.opt.hlsearch = true
        vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
    end,
    {
        desc = 'Highlight current word (exclusive)',
        silent = true,
        noremap = true
    }
)

vim.keymap.set(
    'n', '<leader>g',
    function()
        vim.opt.hlsearch = true
        vim.fn.setreg('/', vim.fn.expand('<cword>'))
    end,
    {
        desc = 'Highlight current word (non-exclusive)',
        silent = true,
        noremap = true
    }
)

vim.keymap.set(
    'n', '<leader>c',
    function()
        vim.opt.hlsearch = false
    end,
    {
        desc = 'Clear highlighting',
        silent = true,
        noremap = true
    }
)
