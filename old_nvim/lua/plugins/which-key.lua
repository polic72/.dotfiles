-- Probably the most scrub plugin ever, but should help with learning the rops for now.
-- Should consider turning this off when more comfortale in the edittor in general.

return {
    "folke/which-key.nvim",
    event = "VimEnter", -- This makes the plugin load before UI elements are drawn.
    config = function()
        require("which-key").setup()

        require("which-key").add({
            { "<leader>c", group = "[C]ode and [C]hange" }, 
            { "<leader>ci", group = "Change [I]nner" }, 
            { "<leader>d", group = "[D]ocument and [D]elete" }, 
            { "<leader>di", group = "Delete [I]nner" }, 
            { "<leader>r", group = "[R]ename or [R]eplace" }, 
            { "<leader>s", group = "[S]earch" }, 
            { "<leader>w", group = "[W]orkspace" }, 
            { "<leader>t", group = "[T]oggle" }, 
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }
        })
    end
}
