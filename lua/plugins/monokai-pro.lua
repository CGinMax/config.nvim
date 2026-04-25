-- https://github.com/loctvl842/monokai-pro.nvim

return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("monokai-pro").setup({
			disabled_plugins = { "bufferline", "nvim-tree" },
			filter = "octagon",
		})
	end,
}
