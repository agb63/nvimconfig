plugins = {
    require 'plugins.catppuccin',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
}

opts = {}

require('lazy').setup(plugins, opts)
