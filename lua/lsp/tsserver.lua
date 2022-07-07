-- tsserver
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server"
return {
  cmd = {lsp_bin_path, "--stdio"},
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
