-- tsserver
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/tsserver/node_modules/typescript/bin/tsserver"
return {
  cmd = {lsp_bin_path},
  filetypes = {"ts", "tsx"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
