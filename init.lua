vim.loader.enable()

-- Customizations
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.cmds')
require('config.modules')

-- Configure plugins
require('config.lazy-bootstrap')
require('config.lazy-plugins')

-- Needs to happen after colorscheme plugins load
vim.cmd.RandomColorScheme()
