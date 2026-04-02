local baseOpts = {
    indent = {
        char = '╎',
        smart_indent_cap = true,
    },
    scope = {
        enabled = false
    }
}

local rainbowOpts = {
    indent = {
        highlight = {
            "RainbowRed",
            "RainbowOrange",
            "RainbowYellow",
            "RainbowGreen",
            "RainbowBlue",
            "RainbowViolet",
            "RainbowCyan",
        }
    }
}

local function doConfig(args)
    local opts = baseOpts
    opts.enabled = args.enabled

    if args.rainbow then
        -- Create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        opts = vim.tbl_deep_extend("force", opts, rainbowOpts)
    end

    require("ibl").setup(opts)
end

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        doConfig({ enabled = false, rainbow = true })
    end
}
