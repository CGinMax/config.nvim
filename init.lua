
-- nvim-tree configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基础配置
require('basic.plugins')
require('basic.settings')
require('basic.keybinds')

require('plugins.conf')
require('plugins.dap')
