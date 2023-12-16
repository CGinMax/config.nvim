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

local ok, lsp_zero = pcall(require, "lsp-zero")
if not ok then
  require("user.utils").notify_error("VonHeikemen/lsp-zero.nvim load failed!")
  return
end

local installed_servers = {
  "lua_ls",
  "clangd",
  "cmake",
  "gopls",
  "bashls",
  "rust_analyzer"
  -- "html",
  -- "cssls",
  -- "tsserver",
  -- "volar",
  -- "pyright",
  -- "jsonls",
  -- "dockerls",
}

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false,
  })
end)
lsp_zero.format_on_save({
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ["lua_ls"] = { "lua" },
    ["bashls"] = { "bash" },
    ["gopls"] = { "go" },
    ["cmake"] = { "cmake" },
    ["clangd"] = { "c", "cpp" },
    ["rust_analyzer"] = { "rust" },
  }
})

mason.setup({
  ui = {
    border = "rounded",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 6,
})
mason_lspconfig.setup({
  ensure_installed = installed_servers,
  handlers = {
    lsp_zero.default_setup,
  }
})

-- local handlers = require("user.plugins.lsp.handlers")

-- mason_lspconfig.setup({
-- 	ensure_installed = installed_servers,
-- })
-- mason_lspconfig.setup_handlers({
-- 	function(server_name)
-- 		lspconfig[server_name].setup({
-- 			on_attach = handlers.on_attach,
-- 			capabilities = handlers.capabilities,
-- 		})
-- 	end,
--   ['lua_ls'] = function ()
--     lspconfig.lua_ls.setup({
-- 			on_attach = handlers.on_attach,
-- 			capabilities = handlers.capabilities,
--       settings = {
--         Lua = {
--           diagnostics = {
--             globals = { "vim" },
--           },
--           workspace = {
--             library = {
--               [vim.fn.expand("$VIMRUNTIM/lua")] = true,
--               [vim.fn.stdpath("config") .. "/lua"] = true,
--             },
--           },
--         },
--       },
--
--     })
--   end,
-- })
