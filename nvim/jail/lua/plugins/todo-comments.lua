-- Makes NOTE[:]s pop out a little more.
-- NOTE: Not really the most useful thing in the world, but cute enough to stay.

return {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
}
