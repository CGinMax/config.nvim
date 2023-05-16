local M = {};

local utils = require('user.utils')

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      prefix = "●",
      -- always show prefix
      source = "always",
    },
    -- show signs
    signs = {
      active = signs,
    },
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
    underline = true,
    -- 在插入模式下是否显示诊断？不要
    update_in_insert = true,
    severity_sort = true,
  }
  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = utils.opts
  opts.buffer = bufnr
  utils.keymap(utils.mode_normal, 'gD', vim.lsp.buf.declaration, opts)
  utils.keymap(utils.mode_normal, 'gd', vim.lsp.buf.definition, opts)
  utils.keymap(utils.mode_normal, 'gh', vim.lsp.buf.hover, opts)
  utils.keymap(utils.mode_normal, 'gi', vim.lsp.buf.implementation, opts)
  -- use inc_rename
  -- utils.keymap(utils.mode_normal, '<leader>rn', vim.lsp.buf.rename, opts)
  utils.keymap(utils.mode_normal, '<leader>rf', vim.lsp.buf.references, opts)
  utils.keymap({utils.mode_normal, utils.mode_visual}, '<leader>ca', vim.lsp.buf.code_action, opts)
  utils.keymap(utils.mode_normal, "<C-k>", vim.lsp.buf.signature_help, opts)

  -- utils.bmap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", utils.opts)
  -- utils.bmap(bufnr, "n", "<leader>dj", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', utils.opts)
  -- utils.bmap(bufnr, "n", "<leader>dk", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', utils.opts)
  -- utils.bmap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', utils.opts)
  -- utils.bmap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", utils.opts)
end

M.on_attach = function(client, bufnr)
  -- if client.name == "tsserver" or client.name == "clangd" then
  -- client.resolved_capabilities.document_formatting = false
  -- end
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)  -- use RRethy/vim-illuminate instead

  -- add outline support for evey lanuage
  -- require("aerial").on_attach(client, bufnr)
  require("lsp_signature").on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

-- get rid of Multiple different client offset encodings detected for buffer
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
M.clangd_capabilities = M.capabilities
M.clangd_capabilities.textDocument.semanticHighlighting = true
M.clangd_capabilities.offsetEncoding = "utf-8"
return M;
