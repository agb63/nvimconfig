return {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
        require('treesitter-context').setup({
            enable = false,  -- we want to manually enable via hotkey
            max_lines = 2
        })

        -- Toggle
        vim.keymap.set(
            "n", "[t",
            function()
                require("treesitter-context").toggle()
            end,
            { silent = true }
        )

        -- Jump to context
        vim.keymap.set(
            "n", "[c",
            function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end,
            { silent = true }
        )
    end
}
