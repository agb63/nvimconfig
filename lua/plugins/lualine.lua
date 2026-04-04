-- local function buffFileName()
--     local path = vim.api.nvim_buf_get_name(0)
--     return vim.fn.fnamemodify(path, ":t")
-- end
--
-- local function buffShortPath()
--     return buffDirName() .. "/" .. buffFileName()
-- end

-- FIXME this could maybe give the relative path to the nearest ancestor dir
-- that contains a SConscript
local function buffDirName()
    local path = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(path, ":h:t")
end

local function getTreeName()
    return require('modules.auto-cdpath').getTreeName() or ''
end

return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                }
            },
            sections = {
                -- FIXME tweak this some more
                lualine_a = {'mode'},
                lualine_b = { getTreeName, buffDirName },
                lualine_c = { '%t %r%m' }, -- filename, read-only, modified
                lualine_x = {'branch', 'diff', 'diagnostics'},
                lualine_y = {'filetype'},
                lualine_z = {'progress', '%l:%c / %L'} -- % thru the file, line:char, total lines
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { buffDirName },
                lualine_c = {'filename'},
                lualine_x = {'progress'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    }
}
