-- https://github.com/regen100/cmake-language-server

local util = require ('lsp.util')
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/cmake/venv/bin/cmake-language-server")
return {
  cmd = {lua_lsp_bin},
  filetypes = {"cmake", "txt"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}