---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim

local fn = vim.fn
local install_path = fn.stdpath("data").. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print ("Installing packer close and reopen NeoVim...")
  vim.cmd [[packadd packer.nvim]]
end
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("wbthomason/packer.nvim load failed!")
  return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    profile = {
      enable = true,
      threshold = 1
    }
})

--  useage
-- use {
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

return packer.startup(function (use)
  use "wbthomason/packer.nvim"

  -- lsp
  use "neovim/nvim-lspconfig"
  -- 通知
  use "rcarriga/nvim-notify"

  use {
    "williamboman/mason.nvim",
    requires = {
      {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
    },
  }
  use "williamboman/mason-lspconfig"
  --[[
  use "williamboman/nvim-lsp-installer"
  ]]--
  use "tami5/lspsaga.nvim"
  -- lsp_signature:插入模式传参提示
  use "ray-x/lsp_signature.nvim"
  -- fidget:lsp进度提示
  use "j-hui/fidget.nvim"

  -- nvim-lightbulb:灯泡提示
  use {
    "kosayoda/nvim-lightbulb",
    requires = 'antoinemadec/FixCursorHold.nvim'
  }
  -- null-ls:前端代码格式
  use "jose-elias-alvarez/null-ls.nvim"
  -- prettier:前端代码美化
  use {
    "MunifTanjim/prettier.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    },
  }
  -- dap
  use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
  -- nvim-dap
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
  -- nvim-web-devicons
  use "kyazdani42/nvim-web-devicons"
  -- nvim-tree
  use "kyazdani42/nvim-tree.lua"

  -- gitsigns: git信息
  use "lewis6991/gitsigns.nvim"
  -- feline:状态栏美化
  use "feline-nvim/feline.nvim"

  -- nvim-autopairs:括号自动补全
  use "windwp/nvim-autopairs"
  -- nvim-surround: 自动前后插入括号
  use "kylechui/nvim-surround"
  -- comment.nvim: 注释
  use "numToStr/Comment.nvim"

  -- catppuccin.nvim:界面美化
  -- 其它plugin
  -- folke/tokyonight.nvim
  -- EdenEast/nightfox.nvim
  -- use {
  --   "catppuccin/nvim",
  --   -- 仓库命为nvim，有冲突，进行as做别名
  --   as = "catppuccin",
  --   config = function()
  --     require("plugin-config.catppuccin")
  --   end
  -- }
  use "folke/tokyonight.nvim"

  -- 支持 LSP 状态的 buffer 栏
  use {
    "akinsho/bufferline.nvim",
    requires = "famiu/bufdelete.nvim", -- 删除 buffer 时不影响现有布局
  }
  -- telescope:模糊搜索
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      -- required
      "nvim-lua/plenary.nvim", -- Lua开发模块
      -- options
      "BurntSushi/ripgrep", -- 文字查找
      "sharkdp/fd", -- 文本查找
      "nvim-telescope/telescope-live-grep-raw.nvim", -- 搜索预览
      "nvim-telescope/telescope-ui-select.nvim", -- ui-select
      "nvim-telescope/telescope-dap.nvim", -- dap
    },
  }

  -- 自动代码补全系列插件
  use {
    "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
    requires = {
      {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
      {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
      {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
      {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
      {"hrsh7th/cmp-path"}, -- 路径补全
      {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
      {"hrsh7th/cmp-cmdline"}, -- 命令补全
      {"f3fora/cmp-spell"}, -- 拼写建议
      {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
      {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
      -- {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
    }
  }

  -- aerial.nvim: 代码大纲和快速导航
  use "stevearc/aerial.nvim"

  -- winshift: 重排窗口
  use "sindrets/winshift.nvim"

  -- indent-blankline: 显示缩进线
  use "lukas-reineke/indent-blankline.nvim"

  -- 显示网页色
  use "norcalli/nvim-colorizer.lua"

  -- nvim-treesitter: 语法高亮
  use{
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects"
  }
  use "romgrk/nvim-treesitter-context" -- show class/function at the top

  -- toggleterm: 终端
  use "akinsho/toggleterm.nvim"

  -- project: 工程管理
  use "ahmedkhalf/project.nvim"

  -- litee: 调用查询
  use "ldelossa/litee.nvim"
  use "ldelossa/litee-calltree.nvim"
  -- trouble: 错误显示
  use "folke/trouble.nvim"

  -- which key
  use "folke/which-key.nvim"
  -- alpha-nvim:启动界面
  use "goolord/alpha-nvim"
  -- neoclip: neovim剪切板管理
  use "AckslD/nvim-neoclip.lua"
  use {
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  --[[
  -- windline
  use {
  "windwp/windline.nvim",
  config = function()
  require("plugin-config.windline")
  end
  }
  --]]

  if (PACKER_BOOTSTRAP) then
    require("packer").sync()
  end
end
)
