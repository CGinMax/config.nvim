-- go
local util = require ('lsp.util')
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/go/gopls"
return {
  cmd = {lsp_bin_path},
  filetypes = {"go", "gomod", "gotmpl"},
  log_level = 2,
  root_dir = util.root_pattern("go.mod", ".git");
  single_file_support = true,
}
