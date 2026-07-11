-- Telescope is a fuzzy finder for many aspects of neovim and development in general. Super handy.

return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",   -- Apparently the master branch is not recommended to run on. We're telescope guys, of course we develop in master!

    dependencies = {
        "nvim-lua/plenary.nvim",

        {
            -- Used to speed up the sorting of telescope dramatically.
            "nvim-telescope/telescope-fzf-native.nvim",

            -- Runs every time the plugin is installed/updated. Needed because this plugin is written in C.
            build = "make", -- This is the vim command, NOT the program make.

            -- Makes sure that make is an available command before trying to install.
            cond = function()
                return vim.fn.executable("make") == 1
            end
        },

        "nvim-telescope/telescope-ui-select.nvim",  -- Sets the vim.ui.select (handles drop-downs) to telescope.


    },


    -- Telescope is complicated enough to need extendend configuration, so here it is!
    config = function()
        local tele = require("telescope")

        tele.setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            }
        })

        -- Basically copied from the repos but using pcall to prevent errors.
        pcall(tele.load_extensions, "fzf")
        pcall(tele.load_extensions, "ui-select")

        -- Setting the remaps.
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = '[S]earch [C]ommands' })

        -- I don't open a lot of buffers all at once and this is too good of a remap to waste on it.
        -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    end
}
