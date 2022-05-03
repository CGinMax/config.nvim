-- tsserver
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/tsserver/node_modules/typescript/bin/tsserver")
return {
  cmd = {lua_lsp_bin},
  filetypes = {"ts", "tsx"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
