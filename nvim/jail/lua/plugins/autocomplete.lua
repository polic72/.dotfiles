return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
        -- Snippet engine (All of this is copied from kickstart (I don't really care about snippets)):
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),

            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                -- {
                --   'rafamadriz/friendly-snippets',
                --   config = function()
                --     require('luasnip.loaders.from_vscode').lazy_load()
                --   end,
                -- },
            }
        },

        "saadparwaiz1/cmp_luasnip",

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path"
    },

    config = function()
        local luasnip = require("luasnip")
        luasnip.config.setup()

        local cmp = require("cmp")
        cmp.setup({
            -- The LSP sources to add autocomplete to:
            sources = {
                {
                    name = "lazydev",

                    group_index = 0 -- Lazydev recommends this to bypass LuaLS completions.
                },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
            },

            -- Set mappings:
            mapping = cmp.mapping.preset.insert({
                -- Force trigger autocompletion:
                ["<C-Space>"] = cmp.mapping.complete(),

                -- Confirms the current auto-complete slection:
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),

                -- Next/previous item:
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window:
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Navigate through arguments for snippets.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),

            -- Snippet engine:
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

            -- This is an option for the original vim autocomplete. Use ':h completeopt' to learn more.
            completion = { completeopt = "menu,menuone,noinsert" },
        })
    end
}
