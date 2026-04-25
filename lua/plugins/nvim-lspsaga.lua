-- https://github.com/nvimdev/lspsaga.nvim

return {
	"nvimdev/lspsaga.nvim",
	after = "nvim-lspconfig",
	config = function()
		local lspsaga = require("lspsaga")
		local icons = require("user.icons")
		lspsaga.setup({ ui = { code_action = icons.ui.Lightbulb }, Lightbulb = { virtual_text = false } })
	end,
}
