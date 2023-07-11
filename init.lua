
-- nvim-tree configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基础配置
require('core.settings')
require('core.plugins')
require('core.keymaps')

require('plugins.conf')
require('plugins.dap')
