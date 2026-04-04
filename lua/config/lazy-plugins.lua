local plugins = {
    require 'plugins.colors.catppuccin',
    require 'plugins.colors.tokyonight',
    --
    require 'plugins.blink',
    require 'plugins.fugitive',
    require 'plugins.indent-blankline',
    require 'plugins.lualine',
    require 'plugins.mason-lspconfig',
    require 'plugins.neo-tree',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.treesitter-context',
    require 'plugins.which-key',
    require 'plugins.window-picker',
    require 'plugins.smartcolumn',
    require 'plugins.virt-column',
}

local opts = {}
require('lazy').setup(plugins, opts)
