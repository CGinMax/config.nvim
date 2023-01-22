-- https://github.com/MunifTanjim/prettier.nvim

local ok, prettier = pcall(require, "prettier")
if (not ok) then
  require('MunifTanjim/prettier.nvim load failed!')
  return
end

local bin_path = vim.fn.stdpath("data") .. "/mason/bin"
prettier.setup({
  bin = bin_path .. "/prettier", -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
