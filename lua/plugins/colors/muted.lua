return {
    {
        "pisgahk/muted.nvim",
        lazy = false,    -- load at startup, not on demand
        priority = 1000, -- load before all other plugins
        config = function()
            vim.cmd.colorscheme("muted")
        end,
    }
}
