-- This handles the general debugger stuff.

return {
    "mfussenegger/nvim-dap",

    dependencies = {
        -- Nicer looknig UI:
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",

        -- Mason my BB, can you pleeaasseee install debuggers for meeee? tyty
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- Debuggers to add:
    },

    config = function ()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Remaps for debugging:
        vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: View Last Session" })
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>B", function ()
            dap.set_breakpoint(vim.fn.input "Breakpoint Condition: ")
        end, { desc = "Debug: Set Conditional Breakpoint" })


        -- Setting up adapters here:
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }


        -- Setting up configurations here:
        dap.configurations.c = {
            {
                type = "gdb",
                request = "launch",
                name = "Launch an executable",
                program = function ()
                    local input = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    return "\"" .. input .. "\""
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false
            },
            --{
            --    type = "gdb",
            --    request = "attach",
            --    name = "Launch current file",
            --    program = "${file}",
            --    cwd = "${workspaceFolder}"
            --}
        }


        require("mason-nvim-dap").setup {
            automatic_installation = true,

            handlers = {},

            ensure_installed = {
                "gdb"
            }
        }


        -- This is partially copied from kickstart; I like some of the icons.
        require("dapui").setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⤓',
                    step_over = '↷',
                    step_out = '↥',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',

                }
            }
        }


        -- Set some listeners to automatically open/close the debugger UI when the debugger is run/killed.
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end
}
