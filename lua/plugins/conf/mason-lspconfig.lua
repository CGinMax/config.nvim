-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig
local ok, mason = pcall(require, "mason")
if (not ok) then
  vim.notify("williamboman/mason.nvim require error")
  return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not ok) then
  print("williamboman/mason-lspconfig require error")
  return
end

local servers = {
  -- 语言服务器名称：配置选项
  -- sumneko_lua = require("lsp.sumneko_lua"),
  -- clangd = require("lsp.clangd"),
  -- gopls = require("lsp.gopls"),
  -- cmake = require("lsp.cmake"),
  -- html = require("lsp.html"),
  -- eslint = require("lsp.eslint"),
  -- volar = require("lsp.volar"),
  -- tsserver = require("lsp.tsserver"),
  -- pyright = require("lsp.pyright"),
  -- cssls = require("lsp.cssls"),
  -- jsonls = require("lsp.jsonls"),
  -- sqls = require("lsp.sqls"),
}

local ok, lspconfig = pcall(require, "lspconfig")
if (not ok) then
  vim.notify("neovim/nvim-lspconfig require errror")
  return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

-- get rid of Multiple different client offset encodings detected for buffer
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local clangd_capabilities = cmp_capabilities
clangd_capabilities.textDocument.semanticHighlighting = true
clangd_capabilities.offsetEncoding =  "utf-8" 

mason.setup({
  ui = {
    border = "rounded"
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {}
  end,
  ["clangd"] = function()
    lspconfig.clangd.setup({
      capabilities = clangd_capabilities,
    })
  end,
  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      capabilities = cmp_capabilities,
      filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" }
    })
  end
})
