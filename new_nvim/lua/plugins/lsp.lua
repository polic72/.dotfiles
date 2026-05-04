-- This is the big boi, responsible for the main features one would expect from a true IDE.

-- If, for whatever reason, you're looking here for why marksman won't work,
-- just touch a .marksman.toml in the root of the notes folder and it'll work.

vim.pack.add({
    -- Contains a lot of sane defaults for configs of a lot of popular LSP servers.
    "https://github.com/neovim/nvim-lspconfig",

    -- Mason is a nice LSP installer helper so that I don't need to find and install the LSP servers
    -- with the system's package manager each time I move to another computer.
    "https://github.com/mason-org/mason.nvim",

    -- This is just a nice helper package that marries the previous 2 pacakages together.
    -- It'll automatically enable configs from lspconfig for installed LSP servers from Mason.
    "https://github.com/mason-org/mason-lspconfig.nvim"
})


require("mason").setup()
require("mason-lspconfig").setup({
    automatic_enable = {
        "lua-ls"
    }
})


-- lua-ls is one of the lspconfig built-in configs for Lua servers
vim.lsp.config("lua-ls", vim.lsp.config.lua_ls)

-- Need to do it in this order because calling vim.lsp.config directly just entirely overwrites lspconfig's config. Annoying.
vim.lsp.config("lua-ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
vim.lsp.enable("lua-ls")


--vim.api.nvim_create_autocmd("LspAttach", {
--
--})
