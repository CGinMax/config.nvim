vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.keybinds = {
  gmap = vim.api.nvim_set_keymap,
  bmap = vim.api.nvim_buf_set_keymap,
  dgmap = vim.api.nvim_del_keymap,
  dbmap = vim.api.nvim_buf_del_keymap,
  opts = { noremap = true, silent = true }
}

-- 重新修改跳转到头和尾
vim.keybinds.gmap("n", "H", "^", vim.keybinds.opts)
vim.keybinds.gmap("n", "L", "$", vim.keybinds.opts)
vim.keybinds.gmap("v", "H", "^", vim.keybinds.opts)
vim.keybinds.gmap("v", "H", "^", vim.keybinds.opts)


vim.keybinds.gmap("n", "<C-h>", "<C-w>h", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-j>", "<C-w>j", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-k>", "<C-w>k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-l>", "<C-w>l", vim.keybinds.opts)

-- nvim-tree
-- 按 leader 1 打开文件树
vim.keybinds.gmap("n", "<leader>1", "<cmd>NvimTreeToggle<CR>", vim.keybinds.opts)

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
vim.keybinds.gmap("n", "<C-q>", "<cmd>Bdelete!<CR>", vim.keybinds.opts)
-- 切换上一个缓冲区
vim.keybinds.gmap("n", "tl", ":BufferLineCycleNext<CR>", vim.keybinds.opts)
-- 切换下一个缓冲区
vim.keybinds.gmap("n", "th", ":BufferLineCyclePrev<CR>", vim.keybinds.opts)
-- 关闭左侧缓冲区
vim.keybinds.gmap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", vim.keybinds.opts)
-- 关闭右侧缓冲区
vim.keybinds.gmap("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", vim.keybinds.opts)

vim.keybinds.gmap("n", "t1", ":BufferLineGoToBuffer 1<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t2", ":BufferLineGoToBuffer 2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t3", ":BufferLineGoToBuffer 3<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t4", ":BufferLineGoToBuffer 4<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t5", ":BufferLineGoToBuffer 5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t6", ":BufferLineGoToBuffer 6<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t7", ":BufferLineGoToBuffer 7<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t8", ":BufferLineGoToBuffer 8<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t9", ":BufferLineGoToBuffer 9<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t$", ":BufferLineGoToBuffer -1<CR>", vim.keybinds.opts)

-- notify
-- 使用案例：
-- 信息、级别、标题
-- 级别有：info、warn、error、debug、trace
-- 示例：
-- vim.notify("hello world", "info", {title = "info"})
-- 显示历史弹窗记录
vim.keybinds.gmap("n", "<leader>fn", "<cmd>lua require('telescope').extensions.notify.notify()<CR>", vim.keybinds.opts)

-- winshift
vim.keybinds.gmap("n", "<C-w>m", ":WinShift<CR>", vim.keybinds.opts)

-- aerial
vim.keybinds.gmap("n", "<F1>", ":AerialToggle<CR>", vim.keybinds.opts)

-- Resize with arrows
vim.keybinds.gmap("n", "<C-Up>", ":resize -2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Down>", ":resize +2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Left>", ":vertical resize -2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Right>", ":vertical resize +2<CR>", vim.keybinds.opts)

-- Move tetx up and down
-- BUG: unuse for mac
vim.keybinds.gmap("n", "<A-j>", "<Esc>:m .+1<CR>==gi<Esc>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-k>", "<Esc>:m .-2<CR>==gi<Esc>", vim.keybinds.opts)

-- Setup keymaps
vim.keybinds.gmap("n", "K", ':lua require("hover").hover()<CR>', vim.keybinds.opts)
vim.keybinds.gmap("n", "gK", ':lua require("hover").hover_select()<CR>', vim.keybinds.opts)

-- Telescope
-- 查找文件
vim.keybinds.gmap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", vim.keybinds.opts)
-- 查找文字
vim.keybinds.gmap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", vim.keybinds.opts)
-- 查找特殊符号
vim.keybinds.gmap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", vim.keybinds.opts)
-- 查找帮助文档
vim.keybinds.gmap("n", "<leader>fh", "<cmd>Telescope help_tags <CR>", vim.keybinds.opts)
-- 查找最近打开的文件
vim.keybinds.gmap("n", "<leader>fo", "<cmd>Telescope oldfiles <CR>", vim.keybinds.opts)
-- 查找 marks 标记
vim.keybinds.gmap("n", "<leader>fm", "<cmd>Telescope marks <CR>", vim.keybinds.opts)
-- 查看工程
vim.keybinds.gmap("n", "<leader>fp", "<cmd>Telescope projects <CR>", vim.keybinds.opts)

-- Trouble
vim.keybinds.gmap("n", "<leader>tt", "<cmd>TroubleToggle workspace_diagnostics<CR>", vim.keybinds.opts)

-- code action
-- vim.keybinds.bmap(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", vim.keybinds.opts)

-- hop
vim.keybinds.gmap("n", "<leader>hw", ":HopWord<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>hww", ":HopWordMW<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>hc", ":HopChar2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>hcc", ":HopChar2MW<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>hl", ":HopLine<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<leader>hls", ":HopLineStart<CR>", vim.keybinds.opts)

-- vim.keybinds.gmap("n", "<leader>k", ':lua require("lsp_signature").toggle_float_win()<CR>', vim.keybinds.opts)

vim.keybinds.gmap("n", "<leader>so", ":luafile %<CR>", vim.keybinds.opts)

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
