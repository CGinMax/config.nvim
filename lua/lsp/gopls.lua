-- go
local util = require ('lsp.util')
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/go/gopls")
return {
  cmd = {lua_lsp_bin},
  filetypes = {"go", "gomod", "gotmpl"},
  log_level = 2,
  root_dir = util.root_pattern("go.mod", ".git");
  single_file_support = true,
}
