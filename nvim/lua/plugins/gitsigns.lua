-- Cool little plugin for showing git changes in code.
-- It's starting to feel like and IDE already!

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim"
})


require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
    },
    attach_to_untracked = true
})
