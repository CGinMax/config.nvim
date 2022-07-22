---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim

local fn = vim.fn
local install_path = fn.stdpath "data".. "/site/packer/start/packer.nvim"
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
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]


local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Load packer failed!")
  return
end

packer.init {
  display = {
    open_fn = function ()
      return require("packer.util").float({border = "rounded"})
    end,
  },
}
return packer.startup(function (use)
  use "wbthomason/packer.nvim"

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugin-config.nvim-lspconfig")
    end
  }
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("plugin-config.nvim-lsp-installer")
    end
  }
  use {
    "tami5/lspsaga.nvim",
    config = function()
      require("plugin-config.lspsaga")
    end
  }
  -- lsp_signature:插入模式传参提示
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugin-config.lsp_signature")
    end
  }
  -- fidget:lsp进度提示
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("plugin-config.fidget")
    end
  }
  -- nvim-lightbulb:灯泡提示
  use {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("plugin-config.nvim-lightbulb")
    end
  }
  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      -- 依赖一个图标插件
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      -- 插件加载完成后自动运行 lua/conf/nvim-tree.lua 文件中的代码
      require("plugin-config.nvim-tree")
    end
  }

  -- feline:状态栏美化
  use {
    "feline-nvim/feline.nvim",
    config = function()
      require("plugin-config.feline")
    end
  }
  -- nvim-autopairs:括号自动补全
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.nvim-autopairs")
    end
  }
  -- comment.nvim
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("plugin-config.comment-nvim")
    end
  }

  -- catppuccin.nvim:界面美化
  use {
    "catppuccin/nvim",
    -- 仓库命为nvim，有冲突，进行as做别名
    as = "catppuccin",
    config = function()
      require("plugin-config.catppuccin")
    end
  }

  -- 支持 LSP 状态的 buffer 栏
  use {
    "akinsho/bufferline.nvim",
    requires = {
      "famiu/bufdelete.nvim" -- 删除 buffer 时不影响现有布局
    },
    config = function()
      require("plugin-config.bufferline")
    end
  }

  -- winshift: 重排窗口
  use {
    "sindrets/winshift.nvim",
    config = function()
      require("plugin-config.winshift")
    end
  }

  -- 通知
  use {
    "rcarriga/nvim-notify",
    config = function()
      require("plugin-config.nvim-notify")
    end
  }

  -- 显示缩进线
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugin-config.indent-blankline")
    end
  }
  -- 显示网页色
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugin-config..nvim-colorizer")
    end
  }
  -- telescope:模糊搜索
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      -- required
      "nvim-lua/plenary.nvim", -- Lua开发模块
      "nvim-treesitter/nvim-treesitter",
      -- options
      "BurntSushi/ripgrep", -- 文字查找
      "sharkdp/fd", -- 文本查找
      "nvim-telescope/telescope-live-grep-raw.nvim", -- 搜索预览
      "nvim-telescope/telescope-ui-select.nvim", -- ui-select
    },
    config = function()
      require("plugin-config.telescope")
    end
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
    },
    config = function()
      require("plugin-config.nvim-cmp")
    end
  }

  -- toggleterm: 终端
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugin-config.toggleterm")
    end
  }

  -- project: 工程管理
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end
  }

  -- litee: 调用查询
  use {
    "ldelossa/litee.nvim",
    config = function ()
      require("plugin-config.litee")
    end
  }
  use {
    "ldelossa/litee-calltree.nvim",
    config = function ()
      require("plugin-config.litee-calltree")
    end
  }
  -- trouble: 错误显示
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      require("plugin-config.trouble")
    end
  }

  -- which key
  use {
    "folke/which-key.nvim",
    config = function ()
      require("plugin-config.which-key")
    end
  }
  -- alpha-nvim:启动界面
  use {
    "goolord/alpha-nvim",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      require("plugin-config.alpha-nvim")
    end
  }
  -- 代码格式化
  -- use {
  --   "sbdchd/neoformat",
  --   config = function()
  --       require("plugin-config.neoformat")
  --   end
  -- }
  -- windline
  --use {
  --  "windwp/windline.nvim",
  --  config = function()
  --    require("plugin-config.windline")
  --  end
  --}
end)
