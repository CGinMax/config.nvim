-- volar
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/volar/node_modules/@volar/vue-language-server/bin/vue-language-server.js")
return {
  cmd = {lua_lsp_bin},
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
