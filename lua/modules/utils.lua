M = {}

function M.writeTable(tbl, path)
    -- Ensure parent dir exists
    local parentPath = vim.fn.fnamemodify(path, ":h")
    vim.fn.mkdir(parentPath, "p")

    local encoded = vim.fn.json_encode(tbl)
    local file = io.open(path, "w")
    if not file then
        error("Could not open file for writing: " .. path)
    end
    file:write(encoded)
    file:close()
end


function M.readTable(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    if not content or #content == 0 then
        return {}
    end
    return vim.fn.json_decode(content)
end

function M.findAncestorPathContaining(filename, startPath)
    local path = startPath

    while true do
        local candidate = path .. "/" .. filename
        if vim.fn.filereadable(candidate) == 1 or
           vim.fn.isdirectory(candidate) == 1 then
            return path
        end

        local parentPath = vim.fn.fnamemodify(path, ":h")
        if parentPath == path then
            return nil  -- reached filesystem root
        end
        path = parentPath
    end
end

function M.toSet(tbl)
    local set = {}
    local result = {}
    for _, v in ipairs(tbl) do
        if set[v] == nil then
            table.insert(result, v)
        end
        set[v] = true
    end
    return result
end

function M.getSiteConfigPath()
    return vim.fn.stdpath('config') .. '/site-config.json'
end

function M.tableValid(t)
    return t ~= nil and next(t) ~= nil
end

function M.siteConfigLookup(key)
    local config = M.readTable(M.getSiteConfigPath())

    if not M.tableValid(config) then
        return nil
    end

    return config[key] or {}
end

function M.pathExists(path)
    return vim.uv.fs_stat(path) ~= nil
end

return M
