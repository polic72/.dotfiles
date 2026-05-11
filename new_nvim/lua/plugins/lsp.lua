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
    "https://github.com/mason-org/mason-lspconfig.nvim",

    -- This makes really nice-looking fuction overload pop-up windows that can be read and searched through.
    "https://github.com/Issafalcon/lsp-overloads.nvim"
})


require("mason").setup()
require("mason-lspconfig").setup({
    automatic_enable = {
        "lua-ls",
        "clangd",
        "omnisharp"
    }
})


-- lua-ls is one of the lspconfig built-in configs for Lua servers
vim.lsp.config("lua-ls", vim.lsp.config.lua_ls)

-- Need to do it in this order because calling vim.lsp.config directly just entirely overwrites lspconfig's config. Annoying.
vim.lsp.config("lua-ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' } -- Just adds "vim" to a list of globals because otherwise these configs all have warnings.
            }
        }
    }
})
vim.lsp.enable("lua-ls")


--require("lsp-overloads").setup({
--    override_native_handler = false,
--    display_automatically = true
--})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("polic72-lsp-attach", { clear = true }),
    desc = "The LSP attachment that adds all my keymappings, extra capabilities, and other stuff for LSP servers.",

    callback = function(lsp_attach_event)
        local client = vim.lsp.get_client_by_id(lsp_attach_event.data.client_id)

        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = lsp_attach_event.buf, desc = "LSP: " .. desc})
        end


        -- Could use 'vim.lsp.buf' for all of these, but I prefer how telescope looks over the quickfix list, so I'm using those.
        local tele = require("telescope.builtin")

        map("n", "gd", tele.lsp_definitions, "[G]oto [D]efinition")
        map("n", "gr", tele.lsp_references, "[G]oto [R]eferences")
        map("n", "gI", tele.lsp_implementations, "[G]oto [I]mplementations")
        map("n", "<leader>ds", tele.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("n", "<leader>ws", tele.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
        map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("n", "<leader>kk", vim.lsp.buf.code_action, "[K]ode [K]action") -- This is suggestions on what to do to fix an error.
        map("n", "<leader>kk", vim.lsp.buf.code_action, "[K]ode [K]action") -- This is suggestions on what to do to fix an error.

        --if client and client.server_capabilities.signatureHelperProvider then
        --    require("lsp-overloads").on_attach(client, lsp_attach_event.buf)
        --end
        --map("n", "L", "<cmd>LspOverloads signature<CR>", "[L] is now show signature")

        if client and client:supports_method("textDocument/documentHighlight", lsp_attach_event.buf) then
            local hl_group = vim.api.nvim_create_augroup("polic72-hl-group", { clear = false })

            vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                buf = lsp_attach_event.buf,
                group = hl_group,
                callback = vim.lsp.buf.document_highlight
            })

            vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
                buf = lsp_attach_event.buf,
                group = hl_group,
                callback = vim.lsp.buf.clear_references
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("polic72-lsp-detach", { clear = false }),
                callback = function(lsp_detach_event)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear({ buf = lsp_detach_event.buf, group = hl_group })
                end
            })
        end
    end
})
