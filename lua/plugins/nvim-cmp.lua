-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/hrsh7th/cmp-path
-- https://github.com/hrsh7th/cmp-buffer
-- https://github.com/hrsh7th/cmp-cmdline
-- https://github.com/f3fora/cmp-spell
-- https://github.com/L3MON4D3/LuaSnip
-- https://github.com/saadparwaiz1/cmp_luasnip
-- https://github.com/onsails/lspkind.nvim
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/lukas-reineke/cmp-under-comparator
-- https://github.com/mlaursen/vim-react-snippets

return {
	-- 自动代码补全系列插件
	"hrsh7th/nvim-cmp", -- 代码补全核心插件，下面都是增强补全的体验插件
	dependencies = {
		{ "neovim/nvim-lspconfig" }, -- lsp
		{ "onsails/lspkind.nvim" }, -- 为补全添加类似 vscode 的图标
		{ "hrsh7th/cmp-nvim-lsp" }, -- 替换内置 omnifunc，获得更多补全
		{ "hrsh7th/cmp-path" }, -- 路径补全
		{ "hrsh7th/cmp-buffer" }, -- 缓冲区补全
		{ "hrsh7th/cmp-cmdline" }, -- 命令补全
		{ "f3fora/cmp-spell" }, -- 拼写建议
		{ "L3MON4D3/LuaSnip" }, -- 功能最全，前端社区资源最多的补全
		{ "saadparwaiz1/cmp_luasnip" }, -- LuaSnip桥接
		{ "rafamadriz/friendly-snippets" }, -- 提供多种语言的代码片段
		{ "lukas-reineke/cmp-under-comparator" }, -- 让补全结果的排序更加智能
		{
			"mlaursen/vim-react-snippets",
			opts = {
				readonly_props = true, -- Set to `false` if all props should no longer be wrapped in `Readonly<T>`.
			},
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- 加载 friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- 可选：按文件类型延迟加载特定框架片段
		-- 这样不会在非前端项目里加载 React/Vue 片段
		luasnip.filetype_extend("javascript", { "javascriptreact" })
		luasnip.filetype_extend("typescript", { "typescriptreact" })

		local lspkind = require("lspkind")
		lspkind.init({
			-- defines how annotations are shown
			-- default: symbol
			-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			mode = "symbol_text",

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = "codicons",

			-- override preset symbols
			--
			-- default: {}
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		})

		local select_opts = { behavior = cmp.SelectBehavior.Insert }

		---@diagnostic disable-next-line: redundant-parameter
		cmp.setup({
			-- 指定补全引擎
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- 指定补全源（安装了补全源插件就在这里指定）
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippet 来源
				{ name = "nvim_lsp", priority = 1000, keyword_length = 1 },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "cmdline" },
				{ name = "emoji" },
				{ name = "nvim_lsp_signature_help", priority = 950 },
			}),
			-- 格式化补全菜单
			formatting = {
				fields = { "icon", "abbr", "kind", "menu" },
				format = lspkind.cmp_format({
					with_text = true,
					maxwidth = { abbr = 50, menu = 50 },
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					before = function(entry, item)
						-- item.menu = "[" .. string.upper(entry.source.name) .. "]"
						item.menu = entry:get_completion_item().detail
						return item
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
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			-- 绑定补全相关的按键
			mapping = {
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<Up>"] = cmp.mapping.select_prev_item(select_opts),
				["<Down>"] = cmp.mapping.select_next_item(select_opts),
				["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-n>"] = cmp.mapping.select_next_item(select_opts),
				-- 选择补全
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				--  出现或关闭补全
				-- FIXME: key mapping conflict with window move
				["<C-.>"] = cmp.mapping({
					i = function()
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end,
					c = function()
						if cmp.visible() then
							cmp.close()
						else
							cmp.complete()
						end
					end,
				}),
				-- NOTE: 类似于 IDEA 的功能，如果进入了选择框，tab 会确认当前选择，否则当做Tab缩进
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if entry then
							cmp.confirm()
						else
							fallback()
						end
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
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
