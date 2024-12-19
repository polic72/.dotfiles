-- Load my other settings:
require("polic72.remaps")
require("polic72.options")
require("polic72.functions")


-- Sync WSL clipboard with system clipboard if using WSL:
-- Thanks to Tushar Singh for the help on this one (https://stackoverflow.com/questions/75548458/copy-into-system-clipboard-from-neovim#answer-76388417)
if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("wl-copy") == 0 then
        print("install \"wl-copy\" to get the clipboard to work properly")
    else
        vim.g.clipboard = {
            name = "wl-clipboard (WSL)",
            copy = {
                ["+"] = 'wl-copy --foreground --type text/plain',
                ["*"] = 'wl-copy --foreground --primary --type text/plain',
            },
            paste = {
                ["+"] = (function ()
                    return vim.fn.systemlist('wl-paste|sed -e "s/\r$//"', {''}, 1)
                end),
                ["*"] = (function ()
                    return vim.fn.systemlist('wl-paste --primary|sed -e "s/\r$//"', {''}, 1)
                end),
            },
            cache_enabled = true
        }
    end
end


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
