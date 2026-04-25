local utils = require("user.utils")
vim.keybinds = {
	gmap = vim.api.nvim_set_keymap,
	bmap = vim.api.nvim_buf_set_keymap,
	dgmap = vim.api.nvim_del_keymap,
	dbmap = vim.api.nvim_buf_del_keymap,
	opts = { noremap = true, silent = true },
}

utils.keymap({ utils.mode_normal, utils.mode_visual }, "<space>w", ":wa<CR>", utils.opts)
utils.keymap({ utils.mode_normal, utils.mode_visual }, "<space>q", ":qa!<CR>", utils.opts)
utils.keymap({ utils.mode_normal, utils.mode_visual }, "<space>e", ":q!<CR>", utils.opts)

-- 重新修改跳转到头和尾
utils.keymap({ utils.mode_normal, utils.mode_visual }, "H", "^", utils.opts)
utils.keymap({ utils.mode_normal, utils.mode_visual }, "L", "$", utils.opts)

-- Better window navigation
utils.keymap(utils.mode_normal, "<C-h>", "<C-w>h", utils.opts)
utils.keymap(utils.mode_normal, "<C-j>", "<C-w>j", utils.opts)
utils.keymap(utils.mode_normal, "<C-k>", "<C-w>k", utils.opts)
utils.keymap(utils.mode_normal, "<C-l>", "<C-w>l", utils.opts)

-- Resize with arrows
utils.keymap(utils.mode_normal, "<A-Up>", ":resize -2<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<A-Down>", ":resize +2<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<A-Left>", ":vertical resize -2<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<A-Right>", ":vertical resize +2<CR>", utils.opts)

-- Move text up and down
utils.keymap(utils.mode_insert, "<A-j>", "<Esc>:m .+1<CR>==gi", utils.opts)
utils.keymap(utils.mode_insert, "<A-k>", "<Esc>:m .-2<CR>==gi", utils.opts)
utils.keymap(utils.mode_normal, "<A-j>", ":m .+1<CR>==", utils.opts)
utils.keymap(utils.mode_normal, "<A-k>", ":m .-2<CR>==", utils.opts)
utils.keymap(utils.mode_visual, "<A-j>", ":m '>+1<CR>gv=gv", utils.opts)
utils.keymap(utils.mode_visual, "<A-k>", ":m '<-2<CR>gv=gv", utils.opts)
utils.keymap(utils.mode_visual_block, "<A-j>", ":move '>+1<CR>gv-gv", utils.opts)
utils.keymap(utils.mode_visual_block, "<A-k>", ":move '<-2<CR>gv-gv", utils.opts)

-- paste selected block
utils.keymap(utils.mode_visual, "p", '"_dP', utils.opts)

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
utils.keymap(utils.mode_normal, "<leader>tch", "<cmd>BufferLineCloseLeft<CR>", utils.opts)
-- 关闭右侧缓冲区
utils.keymap(utils.mode_normal, "<leader>tcl", "<cmd>BufferLineCloseRight<CR>", utils.opts)

-- Telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
utils.keymap(utils.mode_normal, "<leader>ff", telescope_builtin.find_files, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fg", telescope_builtin.live_grep, utils.opts)
-- grep string under your cursor
utils.keymap({ utils.mode_normal, utils.mode_visual_block }, "<leader>fs", telescope_builtin.grep_string, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fb", telescope_builtin.buffers, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fh", telescope_builtin.help_tags, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fo", telescope_builtin.oldfiles, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fch", telescope_builtin.command_history, utils.opts)
utils.keymap(utils.mode_normal, "<leader>fk", telescope_builtin.keymaps, utils.opts)

-- 显示历史弹窗记录
utils.keymap(utils.mode_normal, "<leader>fn", telescope.extensions.notify.notify, utils.opts)

-- Claude Code:
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

-- LSP
-- utils.keymap(utils.mode_normal, '<leader>do', vim.diagnostic.open_float, utils.opts)
-- utils.keymap(utils.mode_normal, '<leader>dl', vim.diagnostic.setloclist, utils.opts)
-- utils.keymap(utils.mode_normal, '[d', vim.diagnostic.goto_next, utils.opts)
-- utils.keymap(utils.mode_normal, ']d', vim.diagnostic.goto_prev, utils.opts)
-- Lspsaga
-- utils.keymap(utils.mode_normal, "K", ":Lspsaga hover_doc<CR>", utils.opts) -- replace lsp hover
utils.keymap(utils.mode_normal, "gf", ":Lspsaga lsp_finder<CR>", utils.opts)
--utils.keymap(utils.mode_normal, "<M-CR>", ":Lspsaga code_action<CR>", utils.opts)
utils.keymap(utils.mode_normal, "gpd", ":Lspsaga preview_definition<CR>", utils.opts)
utils.keymap(utils.mode_normal, "[d", ":Lspsaga diagnostic_jump_next<CR>", utils.opts)
utils.keymap(utils.mode_normal, "]d", ":Lspsaga diagnostic_jump_prev<CR>", utils.opts)
-- utils.keymap(utils.mode_normal, '<leader>d', ':Lspsaga show_line_diagnostics<CR>', utils.opts)

-- lsp_signature
local lsp_signature = require("lsp_signature")
utils.keymap(utils.mode_normal, "K", lsp_signature.toggle_float_win, utils.opts) -- { silent = true, noremap = true, desc = 'toggle signature' }

-- inc-rename
utils.keymap(utils.mode_normal, "<leader>rn", ":IncRename ", utils.opts)

-- Trouble
utils.keymap(utils.mode_normal, "<leader>dt", "<cmd>Trouble diagnostics toggle follow=true<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>st", "<cmd>Trouble symbols toggle focus=false<CR>", utils.opts)
utils.keymap(utils.mode_normal, "<leader>lt", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", utils.opts)

-- icon picker
utils.keymap(utils.mode_normal, "<leader>ipn", "<cmd>IconPickerNormal<cr>", opts)
utils.keymap(utils.mode_normal, "<leader>ipy", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
utils.keymap(utils.mode_normal, "<leader>ipi", "<cmd>IconPickerInsert<cr>", opts)
