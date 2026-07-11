-- Line numbers and relative numbers, the most important options:
vim.opt.number = true
vim.opt.relativenumber = true


-- Better searching:
vim.opt.incsearch = true
vim.opt.hlsearch = true


-- Virtual editting for visual block, allows for better selections around lines of different lengths.
vim.opt.virtualedit = "block"


-- Space supremacy (expanding tabs):
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true


-- Prevents drawing while macro/register is running, stops flashing of screen:
vim.opt.lazyredraw = true


-- Better indenting on wrapped lines:
vim.opt.breakindent = true


-- Undo savefile:
vim.opt.undofile = true


-- Better search casing handling:
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Keep the sign column on:
vim.opt.signcolumn = "yes"


-- Speed up neovim in general:
vim.opt.updatetime = 250    -- The swap file write timer.
vim.opt.timeoutlen = 300    -- The time waited for a sequence. Speeds up which-key if it's installed.


-- Set directions for splitting:
vim.opt.splitright = true
vim.opt.splitbelow = true


-- Set how whitespace is shown:
vim.opt.list = true
vim.opt.listchars = { tab = "»  ", trail = "·", nbsp = "␣" }


-- Preview substitutions (:s) live:
vim.opt.inccommand = "split"


-- Show cursor line:
vim.opt.cursorline = true


-- Enable mouse support:
vim.opt.mouse = "a"


-- Minimum characters kept on screen above and below cursor:
vim.opt.scrolloff = 10
