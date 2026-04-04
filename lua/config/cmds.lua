local function tableDifference(a, b)
    local b_set = {}
    for _, v in ipairs(b) do b_set[v] = true end

    local result = {}
    for _, v in ipairs(a) do
        if not b_set[v] then
            table.insert(result, v)
        end
    end
    return result
end

vim.api.nvim_create_user_command(
    "RandomColorScheme",
    function()
        local exclude = { 'delek', 'murphy', 'pablo', 'ron', 'shine' }
        local schemes = tableDifference(
            vim.fn.getcompletion("", "color"),
            exclude)

        math.randomseed(os.time())
        vim.cmd.colorscheme(
            schemes[math.random(#schemes)])
        print('RandomColorScheme: ' .. vim.g.colors_name)
    end,
    {}
)
