vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

local utils = require('user.utils')
vim.keybinds = {
  gmap = vim.api.nvim_set_keymap,
  bmap = vim.api.nvim_buf_set_keymap,
  dgmap = vim.api.nvim_del_keymap,
  dbmap = vim.api.nvim_buf_del_keymap,
  opts = { noremap = true, silent = true }
}

-- 重新修改跳转到头和尾
utils.keymap({utils.mode_normal, utils.mode_visual}, 'H', '^', utils.opts)
utils.keymap({utils.mode_normal, utils.mode_visual}, 'L', '$', utils.opts)

-- Better window navigation
utils.keymap(utils.mode_normal, '<C-h>', '<C-w>h', utils.opts)
utils.keymap(utils.mode_normal, '<C-j>', '<C-w>j', utils.opts)
utils.keymap(utils.mode_normal, '<C-k>', '<C-w>k', utils.opts)
utils.keymap(utils.mode_normal, '<C-l>', '<C-w>l', utils.opts)

-- Resize with arrows
utils.keymap(utils.mode_normal, '<C-Up>', ':resize -2<CR>', utils.opts)
utils.keymap(utils.mode_normal, '<C-Down>', ':resize +2<CR>', utils.opts)
utils.keymap(utils.mode_normal, '<C-Left>', ':vertical resize -2<CR>', utils.opts)
utils.keymap(utils.mode_normal, '<C-Right>', ':vertical resize +2<CR>', utils.opts)

-- Move text up and down
-- BUG: unuse for mac
utils.keymap(utils.mode_normal, '<A-j>', '<Esc>:m .+1<CR>==gi', utils.opts)
utils.keymap(utils.mode_normal, '<A-k>', '<Esc>:m .-2<CR>==gi', utils.opts)
utils.keymap(utils.mode_visual, '<A-j>', ':m .+1<CR>==', opts)
utils.keymap(utils.mode_visual, '<A-k>', ':m .-2<CR>==', opts)
utils.keymap(utils.mode_visual_block, "<A-j>", ":move '>+1<CR>gv-gv", opts)
utils.keymap(utils.mode_visual_block, "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- paste selected block
utils.keymap(utils.mode_visual, "p", '"_dP', opts)

-- Toggle nvim-tree
utils.keymap(utils.mode_normal, "<leader>e", "<cmd>NvimTreeToggle<CR>", utils.opts)
-- 默认按键
-- o     ：打开目录或文件
-- a     ：新增目录或文件
-- r     ：重命名目录或文件
-- x     ：剪切目录或文件
-- c     ：复制目录或文件
-- d     ：删除目录或文件
-- y     ：复制目录或文件名称
-- Y     ：复制目录或文件相对路径
-- gy    ：复制目录或文件绝对路径
-- p     ：粘贴目录或文件
-- s     ：使用系统默认程序打开目录或文件
-- <Tab> ：将文件添加到缓冲区，但不移动光标
-- <C-v> ：垂直分屏打开文件
-- <C-x> ：水平分屏打开文件
-- <C-]> ：进入光标下的目录
-- <C-r> ：重命名目录或文件，删除已有目录名称
-- -     ：返回上层目录
-- I     ：切换隐藏文件/目录的可见性
-- H     ：切换点文件的可见性
-- R     ：刷新资源管理器
-- 另外，文件资源管理器操作和操作文档方式一致，可按 / ? 进行搜索

-- BufferLine
-- 关闭当前 buffer，由 bufdelete 插件所提供的方法
utils.keymap(utils.mode_normal, "<C-q>", "<cmd>Bdelete!<CR>", utils.opts)
-- 切换上一个缓冲区
utils.keymap(utils.mode_normal, "tl", "<cmd>BufferLineCycleNext<CR>", utils.opts)
-- 切换下一个缓冲区
utils.keymap(utils.mode_normal, "th", "<cmd>BufferLineCyclePrev<CR>", utils.opts)
-- 关闭左侧缓冲区
utils.keymap(utils.mode_normal, "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", utils.opts)
-- 关闭右侧缓冲区
utils.keymap(utils.mode_normal, "<leader>bl", "<cmd>BufferLineCloseRight<CR>", utils.opts)

utils.keymap(utils.mode_normal, "t1", "<cmd>BufferLineGoToBuffer 1<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t2", "<cmd>BufferLineGoToBuffer 2<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t3", "<cmd>BufferLineGoToBuffer 3<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t4", "<cmd>BufferLineGoToBuffer 4<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t5", "<cmd>BufferLineGoToBuffer 5<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t6", "<cmd>BufferLineGoToBuffer 6<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t7", "<cmd>BufferLineGoToBuffer 7<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t8", "<cmd>BufferLineGoToBuffer 8<CR>", utils.opts)
utils.keymap(utils.mode_normal, "t9", "<cmd>BufferLineGoToBuffer 9<CR>", utils.opts)
utils.keymap(utils.mode_normal, 't^', '<cmd>BufferLineGoToBuffer 1<CR>', utils.opts)
utils.keymap(utils.mode_normal, "t$", "<cmd>BufferLineGoToBuffer -1<CR>", utils.opts)

-- Telescope
local ok, telescope_builtin = pcall(require, 'telescope.builtin')
if ok then
utils.keymap(utils.mode_normal, '<leader>ff', telescope_builtin.find_files, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fg', telescope_builtin.live_grep, utils.opts)
-- grep string under your cursor
utils.keymap({utils.mode_normal, utils.mode_visual_block}, '<leader>fs', telescope_builtin.grep_string, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fb', telescope_builtin.buffers, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fh', telescope_builtin.help_tags, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fo', telescope_builtin.oldfiles, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fch', telescope_builtin.command_history, utils.opts)
utils.keymap(utils.mode_normal, '<leader>fk', telescope_builtin.keymaps, utils.opts)
end

local ok, telescope = pcall(require, 'telescope')
if ok then
-- 显示历史弹窗记录
utils.keymap(utils.mode_normal, '<leader>fn', telescope.extensions.notify.notify, utils.opts)
end

-- LSP
utils.keymap(utils.mode_normal, '<leader>do', vim.diagnostic.open_float, utils.opts)
utils.keymap(utils.mode_normal, '<leader>dl', vim.diagnostic.setloclist, utils.opts)
utils.keymap(utils.mode_normal, '[d', vim.diagnostic.goto_next, utils.opts)
utils.keymap(utils.mode_normal, ']d', vim.diagnostic.goto_prev, utils.opts)
  -- utils.keymap(utils.mode_normal, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", utils.opts)

-- winshift
-- utils.keymap(utils.mode_normal, "<C-w>m", "<cmd>WinShift<CR>", utils.opts)

-- aerial
-- utils.keymap(utils.mode_normal, "<F1>", "<cmd>AerialToggle<CR>", utils.opts)


-- utils.keymap(utils.mode_normal, "K", '<cmd>lua require("hover").hover()<CR>', utils.opts)
-- utils.keymap(utils.mode_normal, "gK", '<cmd>lua require("hover").hover_select()<CR>', utils.opts)

-- litee calltree
-- utils.keymap(utils.mode_normal, "<C-R>", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", utils.opts)
-- utils.keymap(utils.mode_normal, "<C-O>", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", utils.opts)



-- Trouble
utils.keymap(utils.mode_normal, "<leader>tt", "<cmd>TroubleToggle workspace_diagnostics<CR>", utils.opts)

-- code action
-- utils.keymap(utils.mode_normal, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", utils.opts)

-- hop
utils.keymap(utils.mode_normal, "<leader>hw", "<cmd>HopWord<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>hww", "<cmd>HopWordMW<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>hc", "<cmd>HopChar2<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>hcc", "<cmd>HopChar2MW<CR>", utils.opts)
-- utils.keymap(utils.mode_normal, "<leader>hl", "<cmd>HopLine<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>hls", "<cmd>HopLineStart<CR>", utils.opts)

-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
