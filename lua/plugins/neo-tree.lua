return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons', -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
        require('neo-tree').setup({
            close_if_last_window = true,
            window = {
                mappings = {
                    ['/'] = 'noop' -- pass-through to native search operator
                },
            },
        })

        -- Show/focus
        vim.keymap.set(
            'n', '<tab>',
            function()
                vim.cmd('Neotree left last')
            end
        )
        -- Close
        vim.keymap.set(
            'n', '<S-tab>',
            function()
                vim.cmd('Neotree close')
            end
        )
        -- Buffer quick-switch
        vim.keymap.set(
            'n', '<leader>e',
            function()
                vim.cmd('Neotree float source=buffers')
            end
        )
    end
}
