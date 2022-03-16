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
			  "williamboman/nvim-lsp-installer"
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

      -- telescope.nvm:模糊搜索
      use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}},
        config = function()
          require("plugin-config.telescope-nvim")
        end
      }

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
