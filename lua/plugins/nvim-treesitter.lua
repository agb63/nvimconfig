local langs = { 'c', 'cpp', 'lua', 'python', 'usd' }

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        lazy = false,
        -- Adapted from https://github.com/MeanderingProgrammer/treesitter-modules.nvim?tab=readme-ov-file#implementing-yourself
        config = function()
            -- Auto-install languages
            require('nvim-treesitter').install(langs)

            -- Trigger features for target langs
            vim.api.nvim_create_autocmd('FileType', {
                -- Auto-install target langs (no-op if already installed)
                group = vim.api.nvim_create_augroup('treesitter.setup', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match

                    -- you need some mechanism to avoid running on buffers that do not
                    -- correspond to a language (like oil.nvim buffers), this implementation
                    -- checks if a parser exists for the current language
                    local lang = vim.treesitter.language.get_lang(filetype) or filetype
                    if not vim.treesitter.language.add(lang) then
                        return
                    end

                    -- Enable folds
                    -- vim.wo.foldmethod = 'expr'
                    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                    -- Enable highlighting
                    vim.treesitter.start(buf, lang)

                    -- Enable indentation
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        -- Add back scope-based incremental selection which has been dropped
        -- from the main nvim-treesitter plugin. nvim 0.12 now has node-based
        -- incremental selection built-in. If it ever incorporates scope-based,
        -- remove this addendum.
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            incremental_selection = { enable = true },
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm', -- captures both node_incremental and scope_incremental
            },
        },
    }
}
