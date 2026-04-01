plugins = {
    require 'plugins.catppuccin',
    require 'plugins.lualine',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.tokyonight',
}

opts = {}

require('lazy').setup(plugins, opts)
