-- This is the big boi, responsible for the main features one would expect from a true IDE.

-- If, for whatever reason, you're looking here for why marksman won't work,
-- just touch a .marksman.toml in the root of the notes folder and it'll work.

return {
    "neovim/nvim-lspconfig",

    dependencies = {
        -- Useful little plugin to better show off notifications.
        { "j-hui/fidget.nvim", opts = {} },


        { "williamboman/mason.nvim" },

        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",


        -- Adds extra LSP functionality. We will need to tells neovim and the LSPs that this is a thing later...
        "hrsh7th/cmp-nvim-lsp",


        -- Adds even more functionality, specifically for method overloads.
        "Issafalcon/lsp-overloads.nvim",
    },

    config = function()
        -- Right here. This is what I was talking about...4 lines ago... we're adding new LSP capabilities!
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- All of this can be found in greater detail in autocomplete.lua


        local servers = {
            -- C/C++:
            clangd = {},

            -- Python:
            pyright = {},

            -- Lua (configured from here https://luals.github.io/wiki/settings/):
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },

                        -- Gets rid of the annoying 'missing-fields' warning.
                        diagnostics = { disable = { 'missing-fields' } },
                    }
                }
            }
        }


        require("mason").setup()

        require("mason-lspconfig").setup({
            handlers = {
                function (server_name)
                    local server = servers[server_name] or {}

                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

                    -- This is what ACTUALLY starts the LSP for all of our servers.
                    -- This is just convenience so we don't have to inject new capabilities ourselves.
                    require("lspconfig")[server_name].setup(server)
                end
            }
        })


        -- This will run every time an LSP attaches to a buffer:
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("polic72-lsp-attach", { clear = true }),

            -- This is the function that runs on the event call.
            callback = function(lsp_attach_event)
                -- The LSP client to configure as we go along.
                local client = vim.lsp.get_client_by_id(lsp_attach_event.data.client_id)


                -- Creating a helper function to map keymaps for only the buffers that get called by this event.
                local map = function(mode, keys, func, desc)
                    vim.keymap.set(mode, keys, func, { buffer = lsp_attach_event.buf, desc = "LSP: " .. desc })
                end


                -- Goto definition. To jump back, press <C-t>.
                map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Find References for the word under the cursor.
                map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under the cursor.
                map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Goto type definition of the word under the cursor.
                map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in the current document.
                map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in the current workspace (project).
                map("n",
                    "<leader>ws",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[W]orkspace [S]ymbols"
                )

                -- Rename the variable under the cursor.
                map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                -- Offers nice parity with my vsvim, but slows down the QF list.
                --map("n", "<C-k>r", vim.lsp.buf.rename, "Rename")

                -- Execute a code action.
                -- Usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
                map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")


                -- Show the signatureHelpProvider window.
                map("n", "L", ":LspOverloadsSignature<CR>", "Show Signature Help")


                -- Adding better overload handling.
                if client and client.server_capabilities.signatureHelpProvider then
                    require("lsp-overloads").setup(client, {
                        -- Changing up some keymaps.
                        --keymaps = {
                        --    -- Actually don't do this, it makes editting more annoying.
                        --    --close_signature = "<Esc>"
                        --},

                        display_automatically = true
                    })
                end


                -- Recreate the highlight effect when hovering over a symbol.
                if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup("polic72-lsp-highlight", { clear = false })

                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = lsp_attach_event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {

                        buffer = lsp_attach_event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("polic72-lsp-detach", { clear = true }),
                        callback = function(lsp_detach_event)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "polic72-lsp-highlight", buffer = lsp_detach_event.buf })
                        end,
                    })
                end
            end
        })
    end
}
