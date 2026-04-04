-- General shortcuts
vim.keymap.set('n', '-', 'o<esc>', { desc = 'Add line below' })
vim.keymap.set('n', '_', 'O<esc>', { desc = 'Add line above' })
-- FIXME conflicts with default lsp mapping
-- vim.keymap.set('n', '<s-k>', '"_dd', { desc = 'Kill line (no yank)' })
vim.keymap.set('n', '<C-s>', ':w<cr>', { desc = 'QuickSave' })
vim.keymap.set('i', '<C-s>', '<esc>:w<cr>a', { desc = 'QuickSave' })

vim.keymap.set(
    'n', '<leader>cd',
    function()
        local buffDir = vim.fn.expand('%:p:h')
        vim.fn.chdir(buffDir)
    end,
    { desc = 'Change directory to current buffer'}
)

-- Emacs-style nav/editing
vim.keymap.set('i', '<C-b>', '<left>')
vim.keymap.set('i', '<C-f>', '<right>')
vim.keymap.set('i', '<C-p>', '<up>')
vim.keymap.set('i', '<C-n>', '<down>')
vim.keymap.set('i', '<C-a>', '<home>')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-d>', '<del>')
vim.keymap.set('i', '<C-k>', '<C-o>C')

vim.keymap.set('c', '<C-b>', '<left>')
vim.keymap.set('c', '<C-f>', '<right>')
vim.keymap.set('c', '<C-a>', '<home>')
vim.keymap.set('c', '<C-e>', '<end>')
vim.keymap.set('c', '<C-d>', '<del>')
vim.keymap.set(
    'c', '<C-k>',
    '<C-\\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to window at left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate to window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate to window at right' })

-- FIXME vim.lsp.buf.rename() ?
vim.keymap.set('n', '<leader>r', ':%s/<C-R><C-W>/',
               { desc = 'Search and replace word under cursor' })

-- Highlight without searching
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
        vim.cmd.nohlsearch()
    end,
    {
        desc = 'Clear highlight',
        silent = true,
        noremap = true
    }
)

vim.keymap.set(
    'n', '<leader>t',
    function()
        vim.opt.hlsearch = not vim.opt.hlsearch:get()
    end,
    {
        desc = 'Toggle search highlight'
    }
)

-- Inlay hints
vim.keymap.set(
    'n', '<leader>i',
    function()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end,
    {
        desc = 'Toggle inlay hints',
        silent = true,
        noremap = true
    }
)

-- Telescope plugin
vim.keymap.set(
    'n', '<leader>ff',
    function()
        -- Explicitly pass cwd in case autochdir is set
        require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() })
    end,
    { desc = 'Telescope find files' }
)

vim.keymap.set(
    'n', '<leader>fp',
    function()
        -- Explicitly pass cwd in case autochdir is set
        require('telescope').extensions.file_browser.file_browser({ path = vim.fn.getcwd() })
    end,
    { desc = 'Telescope browse files' }
)

vim.keymap.set(
    'n', '<leader>fb',
    function()
        require('telescope.builtin').buffers()
    end,
    { desc = 'Telescope buffers' }
)

vim.keymap.set(
    'n', '<leader>fg',
    function()
        require('telescope.builtin').live_grep()
    end,
    { desc = 'Telescope live grep' }
)

vim.keymap.set(
    'n', '<leader>fh',
    function()
        require('telescope.builtin').help_tags()
    end,
    { desc = 'Telescope help tags' }
)

-- TodoComments plugin
vim.keymap.set(
    'n', '<leader>fc',
    function()
        -- Explicitly pass cwd in case autochdir is set
        --require('todo-comments').todo_telescope({ cwd = vim.fn.getcwd() })
        vim.cmd('TodoTelescope cwd=' .. vim.fn.getcwd())
        --require("todo-comments").jump_prev()
    end,
    { desc = 'Telescope TODO/FIXME comments' }
)
