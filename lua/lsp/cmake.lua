-- https://github.com/regen100/cmake-language-server

local util = require ('lsp.util')
local fn = vim.fn
local lsp_bin_path = fn.stdpath "data" .. "/lsp_servers/cmake/venv/bin/cmake-language-server"
return {
  cmd = {lsp_bin_path},
  filetypes = {"cmake", "txt"},
  log_level = 2,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
