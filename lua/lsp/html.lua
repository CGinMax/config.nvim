-- html
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/html")
return {
  cmd = {lua_lsp_bin},
  filetypes = {"html", "htm"},
  root_dir = function()
    return vim.fn.getcwd()
  end
}