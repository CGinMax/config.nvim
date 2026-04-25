-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/vim-vsnip
-- https://github.com/hrsh7th/cmp-vsnip
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/hrsh7th/cmp-path
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/hrsh7th/cmp-cmdline
-- https://github.com/f3fora/cmp-spell
-- https://github.com/onsails/lspkind-nvim
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/lukas-reineke/cmp-under-comparator

return {
	-- 自动代码补全系列插件
	"hrsh7th/nvim-cmp", -- 代码补全核心插件，下面都是增强补全的体验插件
	dependencies = {
		{ "neovim/nvim-lspconfig" }, -- lsp
		{ "onsails/lspkind-nvim" }, -- 为补全添加类似 vscode 的图标
		{ "hrsh7th/vim-vsnip" }, -- vsnip 引擎，用于获得代码片段支持
		{ "hrsh7th/cmp-vsnip" }, -- 适用于 vsnip 的代码片段源
		{ "hrsh7th/cmp-nvim-lsp" }, -- 替换内置 omnifunc，获得更多补全
		{ "hrsh7th/cmp-path" }, -- 路径补全
		{ "hrsh7th/cmp-buffer" }, -- 缓冲区补全
		{ "hrsh7th/cmp-cmdline" }, -- 命令补全
		{ "f3fora/cmp-spell" }, -- 拼写建议
		{ "rafamadriz/friendly-snippets" }, -- 提供多种语言的代码片段
		{ "lukas-reineke/cmp-under-comparator" }, -- 让补全结果的排序更加智能
	},
	config = function()
		local ok, cmp = pcall(require, "cmp")
		if not ok then
			require("user.utils").notify_error("Lazy Plugin", "hrsh7th/nvim-cmp load failed!")
			return
		end

		local lspkind = require("lspkind")

		---@diagnostic disable-next-line: redundant-parameter
		cmp.setup({
			-- 指定补全引擎
			snippet = {
				expand = function(args)
					-- 使用 vsnip 引擎
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			-- 指定补全源（安装了补全源插件就在这里指定）
			sources = cmp.config.sources({
				{ name = "vsnip" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "cmdline" },
				{ name = "emoji" },
			}),
			-- 格式化补全菜单
			formatting = {
				format = lspkind.cmp_format({
					with_text = true,
					maxwidth = 50,
					before = function(entry, vim_item)
						vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
						return vim_item
					end,
				}),
			},
			-- 对补全建议排序
			sorting = {
				priority_weight = 1.0,
				comparators = {
					cmp.config.compare.exact,
					cmp.config.compare.locality,
					cmp.config.compare.recently_used,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			-- 绑定补全相关的按键
			mapping = {
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- 上一个
				["<C-p>"] = cmp.mapping.select_prev_item(),
				-- 下一个
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- 选择补全
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- NOTE: 类似于 IDEA 的功能，如果进入了选择框，tab 会确认当前选择，否则当做Tab缩进
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if entry then
							cmp.confirm()
						else
							fallback()
						end
					else
						fallback()
					end
				end, { "i", "s", "c" }),
			},
		})

		-- 命令行 / 模式提示
		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
			},
		})

		-- 命令行 : 模式提示
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
