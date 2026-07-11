-- Copy the following settings into the Exec Flags of the Godot Editor > Editor Settings > Text Editor > External Editor.
-- Make sure to get the omnisharp LSP for the best experience.
-- --server 127.0.0.1:55432 --remote-send "<C-\><C-N>:lua vim.cmd.next(gd_helper.EscapeSpacedPath('{file}'))<CR>:call cursor({line}, {col})<CR>"

-- vim.api.nvim_create_user_command("EscapeSpacedPath",
--     function (opts)
--         print(opts.fargs[1])
--         return string.gsub(opts.fargs[1], " ", "\\ ")
--     end,
--     {
--         desc = "Takes a path that contains spaces and escapes them.",
--         nargs = 1,
--         complete = "file"
--     })


GD_helper = {}

function GD_helper.EscapeSpacedPath(name)
     return string.gsub(name, " ", "\\ ")
end
