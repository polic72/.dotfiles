-- This is our color scheme.
-- By default we'll use the one that comes with kickstart because I think it looks nice.
-- THis is respnsible for italicizing text too, it seems.

return {
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("tokyonight-night")
        vim.cmd.hi("Comment gui=none")
    end
}
