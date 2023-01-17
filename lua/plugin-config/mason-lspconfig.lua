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

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

function on_attach(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function() lsp.buf.format({bufnr = bufnr,}) end,
    })
  end
end

local data_path = vim.fn.stdpath("data")
local util = require("lsp.util")
local servers = {
  clangd = {
    cmd = {
      data_path .. "/mason/bin/clangd",
      "--background-index",
      "--clang-tidy",
      "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
      "--completion-style=detailed",
      "--cross-file-rename=true",
      "--pch-storage=memory",
      "--function-arg-placeholders=true",
      "--log=verbose",
      "--header-insertion-decorators",
      "-j=6",
      "--pretty",
    },
    filetypes = {"c", "cpp", "cc", "objc", "objcpp"},
    root_dir = function(fname)
      local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
      local filename = util.path.is_absolute(fname) and fname
      or util.path.join(vim.loop.cwd(), fname)
      return root_pattern(filename) or util.path.dirname(filename)
    end,
    log_level = 2,
    single_file_support = true,
  }

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
  -- zeta_note = require("lsp.zeta_note"),
  -- sqls = require("lsp.sqls"),
}

local ok, lspconfig = pcall(require, "lspconfig")
if (not ok) then
  vim.notify("lpsconfig load errror")
  return
end

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
    lspconfig[server_name].setup{}
  end,
  ["clangd"] = function()
    lspconfig.clangd.setup(servers["clangd"])
  end,
})
