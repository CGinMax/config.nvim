-- clangd

local util = require ('lsp.util')
local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/clangd/clangd/bin/clangd")
return {
  cmd = {lua_lsp_bin, "--background-index", "--clang-tidy", "-j=4"},
  filetypes = {"c", "cpp", "cc", "objc", "objcpp"},
  root_dir = function(fname)
    local filename = util.path.is_absolute(fname) and fname
      or util.path.join(vim.loop.cwd(), fname)
    return root_pattern(filename) or util.path.dirname(filename)
  end,
  -- root_dir = function()
  --   return vim.fn.getcwd()
  -- end,
  log_level = 2,
  single_file_support = true,
}

