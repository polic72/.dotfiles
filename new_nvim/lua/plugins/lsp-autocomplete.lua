-- This is en extension to the LSP that handles just autocomplete, because that's big enough to be its own thing.

vim.pack.add({
    "https://github.com/hrsh7th/nvim-cmp",

    -- I don't often use snippets (for now), but nvim-cmp requires a snipping engine, so I'll give it one.
    "https://github.com/L3MON4D3/LuaSnip"
})


--if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") ~= 0 then
      -- Run a quick ":h vim.pack-directory" and try to run make in the correct install directory.
--    vim.cmd("!make install_jsregexp")
--end

