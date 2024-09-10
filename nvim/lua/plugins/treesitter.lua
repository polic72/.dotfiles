-- Tree-sitter is a program that creates robust ASTs for tons of different languages.
-- It's used in neovim primarily to give far better syntax-highlighting.

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "query",
            "regex",
            "vim",
            "vimdoc",
        },

        -- Autoinstall languages that are not installed:
        auto_install = true,
        highlight = {
            enable = true,

            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
