-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig
local ok, mason = pcall(require, "mason")
if not ok then
	require("user.utils").notify_error("williamboman/mason.nvim load failed!")
	return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	require("user.utils").notify_error("williamboman/mason-lspconfig load failed!")
	return
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	require("user.utils").notify_error("neovim/nvim-lspconfig load failed!")
	return
end

mason.setup({
	ui = {
		border = "rounded",
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 6,
})

local handlers = require("user.plugins.lsp.handlers")
local installed_servers = {
	"lua_ls",
	"clangd",
	"cmake",
	"gopls",
	"bashls",
	-- "html",
	-- "cssls",
	-- "tsserver",
	-- "volar",
	-- "pyright",
	-- "jsonls",
	-- "dockerls",
}

mason_lspconfig.setup({
	ensure_installed = installed_servers,
})
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
		})
	end,
  ['lua_ls'] = function ()
    lspconfig.lua_ls.setup({
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
      settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      }},

    })
  end,
	-- ["tsserver"] = function()
	-- 	lspconfig.tsserver.setup({
	-- 		on_attach = handlers.on_attach,
	-- 		capabilities = handlers.capabilities,
	-- 		filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	-- 	})
	-- end,
})

local ok, rt = pcall(require, "rust-tools")
if not ok then
	require("user.utils").notify_error("rust-tools load failed!")
	return
end

rt.setup({
  server = {
    on_attach = handlers.on_attach,
  },
})
