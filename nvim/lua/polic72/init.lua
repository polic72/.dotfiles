-- Load my other settings:
require("polic72.remaps")
require("polic72.options")


-- Go to last read position of a file after reopening (legit why is this not default behavior?):
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Return to last editted position.",
	pattern = { "*" },
	group = vim.api.nvim_create_augroup("polic72-return-last-editted", { clear = true }),
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})


-- Flash a highlight of what's being yanked (thanks kickstart):
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
   end,
})
