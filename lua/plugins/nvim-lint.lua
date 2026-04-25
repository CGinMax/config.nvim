-- https://github.com/mfussenegger/nvim-lint

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local frontend_lint = { "oxlint" }
		lint.linters_by_ft = {
			javascript = frontend_lint,
			typescript = frontend_lint,
			javascriptreact = frontend_lint,
			typescriptreact = frontend_lint,
			go = { "golangci-lint" },
			markdown = { "vale" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
		}
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
