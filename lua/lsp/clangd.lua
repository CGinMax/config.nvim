-- clangd

local util = require ('lsp.util')
local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
local home_dir = os.getenv("HOME")
local lua_lsp_bin = string.format("%s/%s", home_dir, ".local/share/nvim/lsp_servers/clangd/clangd/bin/clangd")
return {
  cmd = {
    lua_lsp_bin,
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
    "--completion-style=detailed",
    "--cross-file-rename=true",
    "--pch-storage=memory",
    "--function-arg-placeholders=true",
    "--log=verbose",
    "--header-insertion-decorators",
    "-j=4",
    "--pretty",
  },
  filetypes = {"c", "cpp", "cc", "objc", "objcpp"},
  root_dir = function(fname)
    local filename = util.path.is_absolute(fname) and fname
    or util.path.join(vim.loop.cwd(), fname)
    return root_pattern(filename) or util.path.dirname(filename)
  end,
  log_level = 2,
  single_file_support = true,
}

