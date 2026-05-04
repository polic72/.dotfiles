-- This is our color scheme.
-- By default we'll use the one that comes with kickstart because I think it looks nice.
-- This is respnsible for italicizing text too, it seems.


vim.pack.add({
    "https://github.com/folke/tokyonight.nvim"
})

require("tokyonight").setup(
    {
        on_colors = function(colors)
            --colors.bg_highlight = "#ff0000"
            --colors.border_highlight = "#ff0000"
        end,
        on_highlights = function(highlights)
            --highlights.Visual = { bg = "#283457" }    -- Default highlight color
            highlights.Visual = { bg = "#1e2a4c" }
            --highlights.Visual = { bg = "#261c1a" }    -- Nice red option (if desired)
        end
    })

vim.cmd.colorscheme("tokyonight-night")
vim.cmd.hi("Comment gui=none")
