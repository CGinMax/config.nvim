-- https://github.com/loctvl842/monokai-pro.nvim

return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local monokai = require("monokai-pro")

		monokai.setup({
			filter = "octagon",
			background_clear = {
				"toggleterm",
				"telescope",
				"renamer",
				"notify",
			},
		})
	end,
}
