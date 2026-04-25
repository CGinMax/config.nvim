-- https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local frontend_config = { "oxfmt", "prettier", stop_after_first = true }
		conform.setup({
			formatters_by_ft = {
				javascript = frontend_config,
				typescript = frontend_config,
				javascriptreact = frontend_config,
				typescriptreact = frontend_config,
				vue = frontend_config,
				--vue-html = frontend_config,
				svelte = frontend_config,
				html = frontend_config,
				css = frontend_config,
				sass = frontend_config,
				scss = frontend_config,
				less = frontend_config,
				json = frontend_config,
				yaml = frontend_config,
				markdown = frontend_config,
				graphql = frontend_config,
				lua = { "stylua" },
				go = { "gofmt" },
				bash = { "shfmt", lsp_format = "fallback" },
				rust = { "rustfmt", lsp_format = "fallback" },
			},

			format_on_save = {
				async = false,
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		})
	end,
}
