-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig
local ok, mason = pcall(require, "mason")
if (not ok) then
  require('utils').notify_error('williamboman/mason.nvim load failed!')
  return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not ok) then
  require('utils').notify_error('williamboman/mason-lspconfig load failed!')
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
  require('utils').notify_error('neovim/nvim-lspconfig load failed!')
  return
end

mason.setup({
  ui = {
    border = "rounded"
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 6,
})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = require("plugins.lsp.handlers").on_attach,
    }
  end,
  -- ["cmake"] = function()
  --   lspconfig.cmake.setup({
  --     on_attach = require("plugins.lsp.handlers").on_attach,
  --     capabilities = require("plugins.lsp.handlers").capabilities,
  --     filetypes = { "CMakeLists.txt", "cmake" }
  --   })
  -- end,
  ["clangd"] = function()
    lspconfig.clangd.setup({
      on_attach = require("plugins.lsp.handlers").on_attach,
      capabilities = require("plugins.lsp.handlers").clangd_capabilities,
    })
  end,
  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      on_attach = require("plugins.lsp.handlers").on_attach,
      capabilities = require("plugins.lsp.handlers").capabilities,
      filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" }
    })
  end,
})
