-- https://github.com/ray-x/lsp_signature.nvim

return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = function()
		local lsp_signature = require("lsp_signature")
		lsp_signature.setup({ always_trigger = true })
	end,
}
