-- Cool little plugin for showing git changes in code.
-- It's starting to feel like and IDE already!

return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "?" },
        },
        attach_to_untracked = true
    }
}
