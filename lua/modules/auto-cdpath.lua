local M = {}

utils = require('modules.utils')

local function info(msg)
    print('AutoCdPath: ' .. msg)
end

local function getOwnerPath(markerPath)
    -- We want to set up path and cdpath to enable, e.g., `:find libname/file.cpp`.
    -- So for a given marker file path inside a lib, the path we want to add is
    -- the parent of the library, i.e., two parents up from the marker.
    local libPath = vim.fn.fnamemodify(markerPath, ":h")
    if libPath == markerPath then
        return nil
    else
        local ownerPath = vim.fn.fnamemodify(libPath, ":h")
        if ownerPath == libPath then
            return nil
        end
        return ownerPath
    end
end

local function load(rootPath, leafMarkerFilename, cacheFilePath)
    if not rootPath then
        error("Missing rootPath")
        return
    end

    local ownerPaths = {}

    if cacheFilePath and utils.pathExists(cacheFilePath) then
        -- Cache hit
        local cachedPaths = utils.readTable(cacheFilePath)
        if cachedPaths then
            ownerPaths = cachedPaths
        end
    end

    if #ownerPaths == 0 then
        -- FIXME add exclude dirs to site config
        -- FIXME this is too slow for ldap
        --
        -- Recompute from scratch
        local matches = vim.fn.globpath(
            rootPath, '**/' .. leafMarkerFilename, false, true)

        for _, markerPath in pairs(matches) do
            local ownerPath = getOwnerPath(markerPath)
            if ownerPath then
                table.insert(ownerPaths, ownerPath)
            end
        end

        -- Deduplicate and write cache
        ownerPaths = utils.toSet(ownerPaths)
        info('Computed cdpath for ' .. rootPath)

        if cacheFilePath then
            utils.writeTable(ownerPaths, cacheFilePath)
            info('Wrote cache at ' .. cacheFilePath)
        else
            info('No cache path provided')
        end
    end

    vim.opt.cdpath = ownerPaths
    vim.opt.path = ownerPaths
end

local treeRoot = nil

local installedOpts = {
    rootMarkerFilename = nil,
    leafMarkerFilename = nil,
    cacheDirTemplate = "{treeRoot}/.cache",
    enabled = true
}

local function getCacheDir()
    if installedOpts.cacheDirTemplate then
        return installedOpts.cacheDirTemplate:gsub(
            "{(%w+)}",
            { treeRoot = treeRoot })
    end
    return nil
end

local function mergeOpts(opts)
    installedOpts = vim.tbl_deep_extend("force", installedOpts, opts)
end

local function getSiteOpts()
    local siteOpts = utils.siteConfigLookup('autoCdPath')

    -- Explicitly disbale if config not found
    if not utils.tableValid(siteOpts) then
        siteOpts = { enabled = false }
    end

    return siteOpts
end

function M.getTreeRoot()
    return treeRoot
end

function M.getTreeName()
    -- FIXME replace other uses of fnamemodify()
    return vim.fs.basename(treeRoot)
end

function M.setup(startPath, opts)
    mergeOpts(getSiteOpts())

    if opts ~= nil then
        mergeOpts(opts)
    end

    if not installedOpts.enabled then
        return
    end

    if not installedOpts.rootMarkerFilename then
        info('No root marker filename provided')
        return
    end

    if not installedOpts.leafMarkerFilename then
        info('No leaf marker filename provided')
        return
    end

    startPath = startPath or vim.fn.getcwd()

    treeRoot = utils.findAncestorPathContaining(
        installedOpts.rootMarkerFilename,
        startPath)

    if not treeRoot then
        return
    end

    load(treeRoot,
         installedOpts.leafMarkerFilename,
         getCacheDir() .. '/nvim-cdpath.json')
end

return M
