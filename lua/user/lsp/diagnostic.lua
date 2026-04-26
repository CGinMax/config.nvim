local M = {}

M.setup_ui = function()
	local icons = require("user.icons")
	local signs = {
		[vim.diagnostic.severity.ERROR] = icons.diagnostics.BoldError,
		[vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
		[vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
		[vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local diagnostic_config = {
		virtual_text = true,
		underline = true,
		-- show signs
		signs = {
			text = signs,
		},
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = true,
			header = "",
			prefix = "",
		},
		update_in_insert = true,
		severity_sort = true,
	}
	vim.diagnostic.config(diagnostic_config)
end
return M
