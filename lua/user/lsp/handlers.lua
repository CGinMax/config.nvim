local M = {}

local lspconfig = require("lspconfig")
local utils = require("user.utils")
-- Default handlers for LSP
local default_handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.semanticHighlighting = true
local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function lsp_keymaps(bufnr)
	local opts = utils.opts
	opts.buffer = bufnr
	utils.keymap(utils.mode_normal, "gD", vim.lsp.buf.declaration, opts)
	utils.keymap(utils.mode_normal, "gd", vim.lsp.buf.definition, opts)
	utils.keymap(utils.mode_normal, "gh", vim.lsp.buf.hover, opts)
	utils.keymap(utils.mode_normal, "gi", vim.lsp.buf.implementation, opts)
	-- NOTE: use inc_rename
	-- utils.keymap(utils.mode_normal, '<leader>rn', vim.lsp.buf.rename, opts)
	utils.keymap(utils.mode_normal, "<leader>rf", vim.lsp.buf.references, opts)
	utils.keymap({ utils.mode_normal, utils.mode_visual }, "<leader>ca", vim.lsp.buf.code_action, opts)
	-- FIXME: key mapping conflict
	-- utils.keymap(utils.mode_normal, "<C-k>", vim.lsp.buf.signature_help, opts)

	-- utils.bmap(bufnr, "n", "<leader>dj", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', utils.opts)
	-- utils.bmap(bufnr, "n", "<leader>dk", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', utils.opts)
	-- utils.bmap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', utils.opts)
	-- utils.bmap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", utils.opts)
end

local on_attach = function(_client, buffer_number)
	-- Pass the current buffer to map lsp keybinds
	lsp_keymaps(buffer_number)

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
		vim.lsp.buf.format({
			filter = function(format_client)
				-- Use Prettier to format TS/JS if it's available
				-- return format_client.name ~= "tsserver" or not null_ls.is_registered("prettier")
			end,
		})
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
	bashls = {},
	lua_ls = {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enabled = false },
				diagnostics = { globals = { "vim" } },
			},
		},
	},
	neocmake = {},
	gopls = {},
	cssls = {},
	html = {},
	-- Vue 3
	volar = {},
	-- TypeScript
	ts_ls = {
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
