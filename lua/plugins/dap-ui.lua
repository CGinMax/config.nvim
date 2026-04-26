-- https://github.com/rcarriga/nvim-dap-ui

return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		-- TODO: wait dap-ui for fixing temrinal layout
		-- the "30" of "30vsplit: doesn't work
		-- dap.defaults.fallback.terminal_win_cmd = '30vsplit new' -- this will be overrided by dapui
		dap.set_log_level("INFO")

		local user_icons = require("user.icons")

		local dap_breakpoint = {
			normal = {
				text = user_icons.debug.Breakpoint,
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			},
		}

		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.normal)

		dapui.setup({
			icons = {
				expanded = user_icons.debug.Expanded,
				collapsed = user_icons.debug.Collapsed,
				circular = user_icons.debug.Circular,
			},
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<2-LeftMouse>", "<CR>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			-- Use this to override mappings for specific elements
			element_mappings = {},
			expand_lines = true,
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.33 },
						{ id = "breakpoints", size = 0.17 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 0.33,
					position = "right",
				},
				{
					elements = {
						{ id = "repl", size = 0.45 },
						{ id = "console", size = 0.55 },
					},
					size = 0.27,
					position = "bottom",
				},
			},
			controls = {
				enabled = true,
				-- Display controls in this element
				element = "repl",
				icons = {
					pause = user_icons.debug.Pause,
					play = user_icons.debug.Start,
					step_into = user_icons.debug.StepInfo,
					step_over = user_icons.debug.StepOver,
					step_out = user_icons.debug.StepOut,
					step_back = user_icons.debug.StepBack,
					run_last = user_icons.debug.Restart,
					terminate = user_icons.debug.Stop,
				},
			},
			floating = {
				max_height = 0.9,
				max_width = 0.5, -- Floats will be treated as percentage of your screen.
				border = "rounded",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil, -- Can be integer or nil.
				max_value_lines = 100, -- Can be integer or nil.
			},
		})

		local debug_open = function()
			dapui.open()
			vim.api.nvim_command("DapVirtualTextEnable")
			vim.api.nvim_command("NvimTreeClose")
		end
		local debug_close = function()
			dap.repl.close()
			dapui.close()
			vim.api.nvim_command("DapVirtualTextDisable")
			-- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			debug_open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			debug_close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			debug_close()
		end
		dap.listeners.before.disconnect["dapui_config"] = function()
			debug_close()
		end
	end,
}
