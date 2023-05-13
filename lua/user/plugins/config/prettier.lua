-- https://github.com/MunifTanjim/prettier.nvim

local ok, prettier = pcall(require, 'prettier')
if (not ok) then
  require('user.utils').notify_error('MunifTanjim/prettier.nvim load failed!')
  return
end

-- local bin_path = vim.fn.stdpath('data') .. '/mason/bin/prettier'  -- or `'prettierd'` (v0.22+)
-- prettier.setup({
--   bin = 'prettier',
--   filetypes = {
--     'css',
--     'graphql',
--     'html',
--     'javascript',
--     'javascriptreact',
--     'json',
--     'less',
--     'markdown',
--     'scss',
--     'typescript',
--     'typescriptreact',
--     'yaml',
--   },
-- })
