-- https://github.com/nvimdev/lspsaga.nvim

return {
	"nvimdev/lspsaga.nvim",
	after = "nvim-lspconfig",
	config = function()
		local lspsaga = require("lspsaga")
		local icons = require("user.icons")
		lspsaga.setup({
			ui = { code_action = icons.ui.Lightbulb },
			rename = {
				in_select = true,
				auto_save = false,
				project_max_width = 0.5,
				project_max_height = 0.5,
				keys = {
					quit = "<C-k>",
					exec = "<CR>",
					select = "x",
				},
			},
			outline = {
				win_position = "right",
				win_width = 30,
				auto_preview = true,
				detail = true,
				auto_close = true,
				close_after_jump = false,
				layout = "normal",
				max_height = 0.5,
				left_width = 0.3,
				keys = {
					toggle_or_jump = "o",
					quit = "q",
					jump = "e",
				},
			},
			implement = {
				enable = true,
				sign = true,
				lang = {},
				virtual_text = true,
				priority = 100,
			},
			lightbulb = { virtual_text = false },
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
