-- eslint
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/vscode-eslint/node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server"
return {
  cmd = {lsp_bin_path},
  filetypes = {"ts", "tsx", "js", "jsx", "vue"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
