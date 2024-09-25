-- Setting leaders:
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Mindful group:
    -- Pasting:
    vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Delete and [P]aste without unnamed reg change" })
    vim.keymap.set("n", "<leader>p", '"_diwP', { desc = "Delete word and [P]aste without unnamed reg change" })
    vim.keymap.set("n", "<leader>P", '"_diWP', { desc = "Delete WORD and [P]aste without unnamed reg change" })

    -- Changing:
    vim.keymap.set("v", "<leader>c", '"_c', { desc = "[C]hange without unnamed reg change" })
    vim.keymap.set("n", "<leader>ciw", '"_ciw', { desc = "Change [w]ord without unnamed reg change" })
    vim.keymap.set("n", "<leader>ciW", '"_ciW', { desc = "Change [W]ORD without unnamed reg change" })

    -- Deleting:
    vim.keymap.set("v", "<leader>d", '"_d', { desc = "[D]elete without unnamed reg change"  })
    vim.keymap.set("n", "<leader>diw", '"_diw', { desc = "Delete [w]ord without unnamed reg change" })
    vim.keymap.set("n", "<leader>diW", '"_diW', { desc = "Delete [W]ORD without unnamed reg change" })

    -- Replacing
    vim.keymap.set("v", "<leader>r", '"_r', { desc = "[R]eplace without unnamed reg change" })
    vim.keymap.set("n", "<leader>r", '"_r', { desc = "[R]eplace without unnamed reg change" })


-- Movement:
vim.keymap.set("n", "<C-D>", "<C-D>zz", { desc = "Scroll down half page and recenter" })
vim.keymap.set("n", "<C-U>", "<C-U>zz", { desc = "Scroll up half page and recenter" })

vim.keymap.set("n", "<C-F>", "<C-F>zz", { desc = "Scroll up page and recenter" })
vim.keymap.set("n", "<C-B>", "<C-B>zz", { desc = "Scroll up page and recenter" })

vim.keymap.set("n", "*", "*zz", { desc = "Search down and recenter" })
vim.keymap.set("n", "#", "#zz", { desc = "Search up and recenter" })

vim.keymap.set("n", "n", "nzz", { desc = "Next and recenter" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous and recenter" })


-- Yank to clipboard:
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank to clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[Y]ank to clipboard" })


-- Clears hls:
vim.keymap.set("n", "<Esc>", "<Cmd>nohls<CR>")


-- Put diagnostics to the location list:
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Open diagnostic [Q]uickfix list" })


-- Move through quick fix list:
vim.keymap.set("n", "<C-J>", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<C-K>", "<Cmd>cprev<CR>")
