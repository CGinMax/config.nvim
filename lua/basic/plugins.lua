---@diagnostic disable: undefined-global
-- https://github.com/wbthomason/packer.nvim

local packer = require("packer")
packer.startup(
	{
		function()
			use {
			  "wbthomason/packer.nvim"
			}
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
      -- use {
      --   "numToStr/Comment.nvim",
      --   config = function()
      --     -- require("plugin-config.comment-nvim")
      --     require("Comment").setup()
      --   end
      -- }

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

      -- telescope.nvm:模糊搜索
      -- use {
      --   "nvim-telescope/telescope.nvim",
      --   requires = {{"nvim-lua/plenary.nvim"}},
      --   config = function()
      --     require("plugin-config.telescope-nvim")
      --   end
      -- }

      -- windline
      --use {
      --  "windwp/windline.nvim",
      --  config = function()
      --    require("plugin-config.windline")
      --  end
      --}
		end,
	}
)

vim.cmd(
  [[
    augroup packer_user_config
	  autocmd!
	  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
  ]]
)
