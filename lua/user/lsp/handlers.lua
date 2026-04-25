local M = {}

local lspconfig = require("lspconfig")

-- Default handlers for LSP
local default_handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.semanticHighlighting = true
local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_client, buffer_number)
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
		vim.lsp.buf.format({})
	end, { desc = "LSP: Format current buffer with LSP" })

	if _client.server_capabilities.codeLensProvider then
		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
			buffer = buffer_number,
			callback = vim.lsp.codelens.refresh,
			desc = "LSP: Refresh code lens",
			group = vim.api.nvim_create_augroup("codelens", { clear = true }),
		})
	end
end

M.handlers = {}

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = { checkThirdParty = false },
				telemetry = { enabled = false },
				diagnostics = { globals = { "vim" } },
			},
		},
	},
}
-- Iterate over our servers and set them up
for name, config in pairs(servers) do
	M.handlers[name] = function()
		lspconfig[name].setup({
			capabilities = default_capabilities,
			filetypes = config.filetypes,
			handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
			on_attach = on_attach,
			settings = config.settings,
		})
	end
end
return M
