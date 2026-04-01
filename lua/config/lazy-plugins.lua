plugins = {
    require 'plugins.catppuccin',
    require 'plugins.lualine',
    require 'plugins.neo-tree',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.tokyonight',
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require'window-picker'.setup({
                hint = 'floating-big-letter',
                picker_config = {
                    handle_mouse_click = true,
                },
            })

            -- Jump to window
            vim.keymap.set(
                'n', '<leader>w',
                function()
                    winId = require('window-picker').pick_window()
                    if winId then
                        vim.api.nvim_set_current_win(winId)
                    end
                end
            )
        end,
    }
}

opts = {}

require('lazy').setup(plugins, opts)
