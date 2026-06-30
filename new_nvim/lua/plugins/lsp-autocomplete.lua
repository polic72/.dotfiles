-- This is en extension to the LSP that handles just autocomplete, because that's big enough to be its own thing.

vim.pack.add({
    "https://github.com/hrsh7th/nvim-cmp",

    -- I don't often use snippets (for now), but nvim-cmp requires a snipping engine, so I'll give it one.
    "https://github.com/L3MON4D3/LuaSnip",

    -- Sources:
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/saadparwaiz1/cmp_luasnip",  -- Required to get luasnip to actually show stuff.
})


local luasnip = require("luasnip")
luasnip.config.setup()


local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.expand(args.body)
        end
    },

    sources = {
        { name = "nvim_lsp"},
        { name = "luasnip"},
        { name = "path"},
    },

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


    completion = { completeopt = "menu,menuone,noinsert" },
})
