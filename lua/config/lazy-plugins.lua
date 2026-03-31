plugins = {
    require 'plugins.catppuccin',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.tokyonight',
}

opts = {}

require('lazy').setup(plugins, opts)
