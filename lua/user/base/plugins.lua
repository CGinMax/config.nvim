---@diagnostic disable: undefined-global
-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
	print('folke/lazy.nvim load failed!')
	return
end

return lazy.setup({
	-- nvim-web-devicons
	'nvim-tree/nvim-web-devicons',

	-- telescope:模糊搜索
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			-- required
			'nvim-lua/plenary.nvim', -- Lua开发模块
			-- options
			'BurntSushi/ripgrep', -- 文字查找
			'sharkdp/fd', -- 文本查找
			'nvim-telescope/telescope-live-grep-raw.nvim', -- 搜索预览
			'nvim-telescope/telescope-ui-select.nvim', -- ui-select
			'nvim-telescope/telescope-dap.nvim', -- dap
		},
	},

	-- lsp
	'neovim/nvim-lspconfig',
	-- lsp manager
	{
		'williamboman/mason.nvim',
		dependencies = {
			{
				'hrsh7th/cmp-nvim-lsp', -- 替换内置 omnifunc，获得更多补全
				'williamboman/mason-lspconfig',
			}, 
		},
	},

	-- 自动代码补全系列插件
	{
		'hrsh7th/nvim-cmp', -- 代码补全核心插件，下面都是增强补全的体验插件
		dependencies = {
			{ 'onsails/lspkind-nvim' }, -- 为补全添加类似 vscode 的图标
			{ 'hrsh7th/vim-vsnip' }, -- vsnip 引擎，用于获得代码片段支持
			{ 'hrsh7th/cmp-vsnip' }, -- 适用于 vsnip 的代码片段源
			{ 'hrsh7th/cmp-nvim-lsp' }, -- 替换内置 omnifunc，获得更多补全
			{ 'hrsh7th/cmp-path' }, -- 路径补全
			{ 'hrsh7th/cmp-buffer' }, -- 缓冲区补全
			{ 'hrsh7th/cmp-cmdline' }, -- 命令补全
			{ 'f3fora/cmp-spell' }, -- 拼写建议
			{ 'rafamadriz/friendly-snippets' }, -- 提供多种语言的代码片段
			{ 'lukas-reineke/cmp-under-comparator' }, -- 让补全结果的排序更加智能
			-- {'tzachar/cmp-tabnine', run = './install.sh'} -- tabnine 源,提供基于 AI 的智能补全
		},
	},

	-- nvim-treesitter: 语法高亮
	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	},
	'nvim-treesitter/nvim-treesitter-textobjects',
	'romgrk/nvim-treesitter-context', -- show class/function at the top
	
	-- lspsaga:lsp ui美化
	-- 'tami5/lspsaga.nvim',
	-- lsp_signature:插入模式传参提示
	'ray-x/lsp_signature.nvim',
	-- fidget:lsp进度提示
	'j-hui/fidget.nvim',
	-- hover: lsp 显示当前光标所在的内容描述
	-- 'lewis6991/hover.nvim',

	-- nvim-lightbulb:灯泡提示
	{
		'kosayoda/nvim-lightbulb',
		dependencies = {
			{
				'antoinemadec/FixCursorHold.nvim',
			}
	},
	},
	-- null-ls:前端代码格式
	-- 'jose-elias-alvarez/null-ls.nvim',
	-- mason-null-ls
	-- {
	-- 	'jay-babu/mason-null-ls.nvim',
	-- 	event = { 'BufReadPre', 'BufNewFile' },
	-- 	dependencies = {
	-- 		'williamboman/mason.nvim',
	-- 		'jose-elias-alvarez/null-ls.nvim',
	-- 	},
	-- },
	-- prettier:前端代码美化
	-- {
	-- 	'MunifTanjim/prettier.nvim',
	-- 	dependencies = {
	-- 		'neovim/nvim-lspconfig',
	-- 		'jose-elias-alvarez/null-ls.nvim',
	-- 	},
	-- },
	-- dap
	-- 'ravenxrz/DAPInstall.nvim', -- help us install several debuggers
	-- nvim-dap
	-- 'mfussenegger/nvim-dap',
	-- 'theHamsta/nvim-dap-virtual-text',
	-- 'rcarriga/nvim-dap-ui',
	-- 'jay-babu/mason-nvim-dap.nvim',
	-- {
	-- 	'jbyuki/one-small-step-for-vimkind', module = 'osv', -- debug any Lua code running in a Neovim instance
	-- }

	-- feline:状态栏美化
	'feline-nvim/feline.nvim',

	-- notification
	'rcarriga/nvim-notify',

	-- nvim-tree
	'nvim-tree/nvim-tree.lua',

	-- gitsigns: git信息
	'lewis6991/gitsigns.nvim',

	-- nvim-autopairs:括号自动补全
	'windwp/nvim-autopairs',
	-- nvim-surround: 自动前后插入括号
	'kylechui/nvim-surround',
	-- comment.nvim: 注释
	'numToStr/Comment.nvim',

	-- colorscheme
	'folke/tokyonight.nvim',

	-- bufferline: 支持 LSP 状态的 buffer 栏
	{
		'akinsho/bufferline.nvim',
		dependencies = {
			{'famiu/bufdelete.nvim',  -- 删除 buffer 时不影响现有布局
		}
		},
	},

	-- aerial.nvim: 代码大纲和快速导航
	-- 'stevearc/aerial.nvim',

	-- winshift: 重排窗口
	-- 'sindrets/winshift.nvim',

	-- indent-blankline: 显示缩进线
	'lukas-reineke/indent-blankline.nvim',

	-- 显示网页色
	'norcalli/nvim-colorizer.lua',


	-- toggleterm: 终端
	-- 'akinsho/toggleterm.nvim',

	-- project: 工程管理
	-- 'ahmedkhalf/project.nvim',

	-- litee: 调用查询
	-- 'ldelossa/litee.nvim',
	-- 'ldelossa/litee-calltree.nvim',
	-- 'ldelossa/litee-symboltree.nvim',
	-- 'ldelossa/litee-filetree.nvim',
	-- trouble: 错误显示
	'folke/trouble.nvim',

	-- which key
	-- 'folke/which-key.nvim',
	-- alpha-nvim:启动界面
	-- 'goolord/alpha-nvim',
	-- neoclip: neovim剪切板管理
	-- 'AckslD/nvim-neoclip.lua',
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
		end,
	},
	-- vim-illuminate: 上下文高亮显示当前光标所在的内容
	-- 'RRethy/vim-illuminate',
	-- neovim-tasks: 构建任务(default cmake)
	-- 'Shatur/neovim-tasks',
})