-- https://github.com/folke/which-key.nvim
return {
	-- which key
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
	},
	config = function()
		local which_key = require("which-key")

		which_key.setup({

			delay = function(ctx)
				return ctx.plugin and 0 or 500
			end,

			defer = function(ctx)
				return ctx.mode == "V" or ctx.mode == "<C-V>"
			end,

			keys = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			show_help = true, -- show help message on the command line when the popup is visible
		})
	end,
}
