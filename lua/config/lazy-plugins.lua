local plugins = {
    require 'plugins.catppuccin',
    require 'plugins.fugitive',
    require 'plugins.lualine',
    require 'plugins.mason-lspconfig',
    require 'plugins.neo-tree',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.tokyonight',
    require 'plugins.treesitter-context',
    require 'plugins.window-picker',
}

local opts = {}
require('lazy').setup(plugins, opts)
