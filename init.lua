
-- nvim-tree configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基础配置
require('basic.plugins')
require('basic.settings')
require('basic.keybinds')
--插件
--require('plugins')
-- lsp
--require('lsp/setup')
--lua require('lspconfig').clangd.setup{}
