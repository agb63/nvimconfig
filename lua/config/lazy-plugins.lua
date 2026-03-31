plugins = {
    require 'plugins.catppuccin',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.tokyonight',
}

opts = {}

require('lazy').setup(plugins, opts)
