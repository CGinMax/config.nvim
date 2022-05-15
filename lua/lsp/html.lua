-- html
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/html/node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server"
return {
  cmd = {lsp_bin_path},
  filetypes = {"html", "htm"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
