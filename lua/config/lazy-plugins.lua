local plugins = {
    require 'plugins.catppuccin',
    require 'plugins.fugitive',
    require 'plugins.lualine',
    require 'plugins.neo-tree',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.tokyonight',
    require 'plugins.window-picker',
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "clangd", "lua_ls", "pyright", "vimls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig" },
        },
    }
}

local opts = {}
require('lazy').setup(plugins, opts)
