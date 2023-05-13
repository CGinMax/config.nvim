local options = {
  backup = false, -- 是否开启备份文件
  clipboard = "unnamedplus", -- 是否启用系统剪切板
  showcmd = true, -- 是否在屏幕最后一行显示命令
  cmdheight = 2, -- 命令行显示信息行数
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- 设定各种文本的字符编码
  hlsearch = true, -- 是否开启高亮搜索
  ignorecase = true, -- 是否在搜索时忽略大小写
  mouse = "a",
  pumheight = 10, -- popup menu height
  showmode = true, -- 显示当前工作模式
  smartcase = true, -- 是否开启在搜索时如果有大写字母，则关闭忽略大小写的选项
  smartindent = false, -- use format plugin
  splitbelow = true,
  splitright = true,
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors
  timeoutlen = 400, -- 设定等待按键时长的毫秒数
  undofile = true, -- enable persistent undo
  updatetime = 500, -- 设定在无操作时，交换文件刷写到磁盘的等待毫秒数（默认为 4000）
  -- writebackup = false,
  expandtab = true, -- 是否将 tab 替换为 space
  shiftwidth = 2, -- 换行或 >> << 缩进时的 space 数量
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 4, -- set number column width to 4
  signcolumn = "yes",
  wrap = true,
  linebreak = true,
  scrolloff = 10,
  sidescrolloff = 10,
  hidden = true, -- 是否允许缓冲区未保存时就切换
  syntax = "enable", -- 是否开启语法高亮
  list = true, -- 是否特殊显示空格等字符
  showmatch = true, -- 是否在插入括号时短暂跳转到另一半括号上
  wildmenu = true, -- 是否开启命令行补全
  foldenable = true, -- 是否开启代码折叠
  foldmethod = "indent", -- 指定代码折叠的策略是按照缩进进行的
  foldlevel = 100, -- 指定代码折叠的最高层级为 100
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- 取消自动注释，当前行是 -- 注释时，按下 CR 或者 o 默认会自动注释下一行，所以这里取消了
-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.listchars:append "space:⋅" -- space char 
vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use


