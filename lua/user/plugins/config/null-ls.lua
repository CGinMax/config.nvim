-- https://github.com/jose-elias-alvarez/null-ls.nvim
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	require("user.utils").notify_error("jose-elias-alvarez/null-ls.nvim")
	return
end

-- https://github.com/jay-babu/mason-null-ls.nvim
local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	require("user.utils").notify_error("jay-babu/mason-null-ls.nvim")
	return
end

mason_null_ls.setup({
	ensure_installed = { "stylua", "jq" },
	automatic_installation = false,
})

local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

null_ls.setup({
	sources = {
		-- format
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		-- null_ls.builtins.formatting.eslint,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.shfmt,

		-- completion
		null_ls.builtins.completion.spell,

		-- code actions
		null_ls.builtins.code_actions.gomodifytags, -- go code_actions
		null_ls.builtins.code_actions.impl, -- go code_actions
		-- null_ls.builtins.code_actions.eslint,
		null_ls.builtins.code_actions.shellcheck,

		-- diagnostics
		-- null_ls.builtins.diagnostics.eslint,

		-- cpp
		-- diagnostics on save
		-- null_ls.builtins.diagnostics.clang_check,
		-- Qt-oriented static code analyzer based on the Clang framework
		-- null_ls.builtins.diagnostics.clazy,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
				desc = "[lsp] format on save",
			})
		end
	end,
})
