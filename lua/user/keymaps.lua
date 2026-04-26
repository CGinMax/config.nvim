local utils = require("user.utils")
vim.keybinds = {
	gmap = vim.api.nvim_set_keymap,
	bmap = vim.api.nvim_buf_set_keymap,
	dgmap = vim.api.nvim_del_keymap,
	dbmap = vim.api.nvim_buf_del_keymap,
	opts = { noremap = true, silent = true },
}

utils.set_keymap(
	{ utils.mode_normal, utils.mode_visual },
	"<leader>rs",
	"<cmd>restart<CR>",
	utils.opts,
	{ desc = "Reboot neovim" }
)

utils.set_keymap({ utils.mode_normal, utils.mode_visual }, "<space>w", ":wa<CR>", utils.opts, { desc = "wa" })
utils.set_keymap({ utils.mode_normal, utils.mode_visual }, "<space>q", ":qa!<CR>", utils.opts, { desc = "qa!" })
utils.set_keymap({ utils.mode_normal, utils.mode_visual }, "<space>e", ":q!<CR>", utils.opts, { desc = "q!" })

-- 重新修改跳转到头和尾
utils.set_keymap({ utils.mode_normal, utils.mode_visual }, "H", "^", utils.opts, { desc = "Move to start of line" })
utils.set_keymap({ utils.mode_normal, utils.mode_visual }, "L", "$", utils.opts, { desc = "Move to end of line" })

-- Better window navigation
utils.set_keymap(utils.mode_normal, "<C-h>", "<C-w>h", utils.opts, { desc = "Move left to window" })
utils.set_keymap(utils.mode_normal, "<C-j>", "<C-w>j", utils.opts, { desc = "Move down to window" })
utils.set_keymap(utils.mode_normal, "<C-k>", "<C-w>k", utils.opts, { desc = "Move up to window" })
utils.set_keymap(utils.mode_normal, "<C-l>", "<C-w>l", utils.opts, { desc = "Move right to window" })

-- Resize with arrows
utils.set_keymap(utils.mode_normal, "<A-Up>", ":resize -2<CR>", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_normal, "<A-Down>", ":resize +2<CR>", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_normal, "<A-Left>", ":vertical resize -2<CR>", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_normal, "<A-Right>", ":vertical resize +2<CR>", utils.opts, { desc = "" })

-- Move text up and down
utils.set_keymap(utils.mode_insert, "<A-j>", "<Esc>:m .+1<CR>==gi", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_insert, "<A-k>", "<Esc>:m .-2<CR>==gi", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_normal, "<A-j>", ":m .+1<CR>==", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_normal, "<A-k>", ":m .-2<CR>==", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_visual, "<A-j>", ":m '>+1<CR>gv=gv", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_visual, "<A-k>", ":m '<-2<CR>gv=gv", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_visual_block, "<A-j>", ":move '>+1<CR>gv-gv", utils.opts, { desc = "" })
utils.set_keymap(utils.mode_visual_block, "<A-k>", ":move '<-2<CR>gv-gv", utils.opts, { desc = "" })

-- paste selected block
utils.set_keymap(utils.mode_visual, "p", '"_dP', utils.opts, { desc = "Paste with keep buffer" })

-- Toggle nvim-tree
utils.set_keymap(utils.mode_normal, "<leader>e", "<cmd>NvimTreeToggle<CR>", utils.opts, { desc = "Toggle NvimTree" })
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
utils.set_keymap(utils.mode_normal, "<C-q>", "<cmd>Bdelete!<CR>", utils.opts, { desc = "Buffer Delete" })
-- 切换上一个缓冲区
utils.set_keymap(utils.mode_normal, "tl", "<cmd>BufferLineCycleNext<CR>", utils.opts, { desc = "BufferLineCycleNext" })
-- 切换下一个缓冲区
utils.set_keymap(utils.mode_normal, "th", "<cmd>BufferLineCyclePrev<CR>", utils.opts, { desc = "BufferLineCyclePrev" })
-- 关闭左侧缓冲区
utils.set_keymap(
	utils.mode_normal,
	"<leader>bch",
	"<cmd>BufferLineCloseLeft<CR>",
	utils.opts,
	{ desc = "BufferLineCloseLeft" }
)
-- 关闭右侧缓冲区
utils.set_keymap(
	utils.mode_normal,
	"<leader>bcl",
	"<cmd>BufferLineCloseRight<CR>",
	utils.opts,
	{ desc = "BufferLineCloseRight" }
)

-- Telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
utils.set_keymap(utils.mode_normal, "<leader>ff", telescope_builtin.find_files, utils.opts, { desc = "Find files" })
utils.set_keymap(utils.mode_normal, "<leader>fg", telescope_builtin.live_grep, utils.opts, { desc = "Live grep" })
utils.set_keymap(
	{ utils.mode_normal, utils.mode_visual_block },
	"<leader>fs",
	telescope_builtin.grep_string,
	utils.opts,
	{ desc = "Grep string under cursor" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>fb",
	telescope_builtin.buffers,
	utils.opts,
	{ desc = "Lookup buffer files" }
)
utils.set_keymap(utils.mode_normal, "<leader>fh", telescope_builtin.help_tags, utils.opts, { desc = "Lookup help" })
utils.set_keymap(utils.mode_normal, "<leader>fo", telescope_builtin.oldfiles, utils.opts, { desc = "Lookup old files" })
utils.set_keymap(
	utils.mode_normal,
	"<leader>fch",
	telescope_builtin.command_history,
	utils.opts,
	{ desc = "Lookup command history" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>fjl",
	telescope_builtin.jumplist,
	utils.opts,
	{ desc = "Lookup jump list" }
)
utils.set_keymap(utils.mode_normal, "<leader>fk", telescope_builtin.keymaps, utils.opts, { desc = "Lookup keymaps" })
-- 显示历史弹窗记录
utils.set_keymap(
	utils.mode_normal,
	"<leader>fn",
	telescope.extensions.notify.notify,
	utils.opts,
	{ desc = "Lookup notification" }
)

utils.set_keymap(
	utils.mode_normal,
	"<leader>ld",
	telescope_builtin.lsp_definitions,
	utils.opts,
	{ desc = "Lsp definitions" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>lr",
	telescope_builtin.lsp_references,
	utils.opts,
	{ desc = "Lsp references" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>lws",
	telescope_builtin.lsp_dynamic_workspace_symbols,
	utils.opts,
	{ desc = "Lsp dynamic workspace symbols" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>li",
	telescope_builtin.lsp_implementations,
	utils.opts,
	{ desc = "Lsp Implementations" }
)

-- git

utils.set_keymap(utils.mode_normal, "<leader>lzg", "<cmd>LazyGit<CR>", utils.opts, { desc = "Open LazyGit" })
utils.set_keymap(utils.mode_normal, "<leader>dvo", "<cmd>DiffviewOpen<CR>", utils.opts, { desc = "Open Diffview" })
utils.set_keymap(utils.mode_normal, "<leader>dvc", "<cmd>DiffviewClose<CR>", utils.opts, { desc = "Close Diffview" })
utils.set_keymap(
	utils.mode_normal,
	"<leader>dvfh",
	"<cmd>DiffviewFileHistory<CR>",
	utils.opts,
	{ desc = "Diffview File History" }
)

-- Claude Code:
utils.set_keymap(utils.mode_normal, "<leader>cc", "<cmd>ClaudeCode<CR>", utils.opts, { desc = "Toggle Claude Code" })

-- Lspsaga
-- replace lsp hover-
utils.set_keymap(utils.mode_normal, "<leader>lh", ":Lspsaga hover_doc<CR>", utils.opts, { desc = "Hover" })
utils.set_keymap(utils.mode_normal, "<leader>lf", ":Lspsaga finder<CR>", utils.opts, { desc = "Finder" })
utils.set_keymap(utils.mode_normal, "<leader>lca", ":Lspsaga code_action<CR>", utils.opts, { desc = "Code Action" })
utils.set_keymap(
	utils.mode_normal,
	"<leader>lwd",
	":Lspsaga show_workspace_diagnostics<CR>",
	utils.opts,
	{ desc = "Show workspace diagnostics" }
)
utils.set_keymap(
	utils.mode_normal,
	"[d",
	":Lspsaga diagnostic_jump_next<CR>",
	utils.opts,
	{ desc = "Jump next diagnostics" }
)
utils.set_keymap(
	utils.mode_normal,
	"]d",
	":Lspsaga diagnostic_jump_prev<CR>",
	utils.opts,
	{ desc = "Jump prev diagnostics" }
)

-- inc-rename
utils.set_keymap(utils.mode_normal, "<leader>rn", ":IncRename ", utils.opts, { desc = "Rename" })

-- Trouble
utils.set_keymap(
	utils.mode_normal,
	"<leader>td",
	"<cmd>Trouble diagnostics toggle follow=true<CR>",
	utils.opts,
	{ desc = "Toggle Trouble diagnostics" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>ts",
	"<cmd>Trouble symbols toggle focus=false<CR>",
	utils.opts,
	{ desc = "Toggle Trouble symbols" }
)

-- icon picker
utils.set_keymap(
	utils.mode_normal,
	"<leader>ipn",
	"<cmd>IconPickerNormal<cr>",
	utils.opts,
	{ desc = "Insert the selected icon into register" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>ipy",
	"<cmd>IconPickerYank<cr>",
	utils.opts,
	{ desc = "Yank the selected icon into register" }
)
utils.set_keymap(
	utils.mode_normal,
	"<leader>ipi",
	"<cmd>IconPickerInsert<cr>",
	utils.opts,
	{ desc = "Insert the selected icon" }
)
