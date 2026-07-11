require("polic72")


-- This needs to be here to make LuaSnip work with lockfiles. Check out lua/plugins/lsp-autocomplete for where this is used.
-- Taken direction from :h vim.pack
local hooks = function(ev)
    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
    end
    -- Use available |event-data|
    local name, kind = ev.data.spec.name, ev.data.kind

    -- Run build script after plugin's code has changed
    if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
        -- Append `:wait()` if you need synchronous execution
        vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
    end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

require("plugins")
