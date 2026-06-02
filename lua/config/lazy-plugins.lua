local plugins = {
    -- colorschemes
    require 'plugins.colors.catppuccin',
    require 'plugins.colors.gruvbox',
    require 'plugins.colors.moonfly',
    require 'plugins.colors.olive-crt',
    require 'plugins.colors.primary',
    require 'plugins.colors.tokyonight',
    -- common plugins
    require 'plugins.blink',
    require 'plugins.fugitive',
    require 'plugins.indent-blankline',
    require 'plugins.lualine',
    require 'plugins.mason-lspconfig',
    require 'plugins.neo-tree',
    require 'plugins.nvim-treesitter',
    require 'plugins.ouroboros',
    require 'plugins.render-markdown',
    require 'plugins.smartcolumn',
    require 'plugins.telescope',
    require 'plugins.telescope-file-browser',
    require 'plugins.todo-comments',
    require 'plugins.treesitter-context',
    require 'plugins.virt-column',
    require 'plugins.which-key',
    require 'plugins.window-picker',
    require 'plugins.yazi'
}

-- site-local plugins
local ok, sitePlugins = pcall(require, 'plugins.site-plugins')
if ok then
  for _, p in ipairs(sitePlugins) do
    table.insert(plugins, p)
  end
end

local opts = {}
require('lazy').setup(plugins, opts)
