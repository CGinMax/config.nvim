-- https://github.com/nvim-lualine/lualine.nvim

return {
	-- 状态栏美化
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local user_colors = require("user.colors")

		local colors = {

			FONT = user_colors.statusline.font,
			FRONTGROUND = user_colors.statusline.fg,
			BACKGROUND = user_colors.statusline.bg,
			DISABLE = user_colors.statusline.inactive,

			NORMAL = user_colors.statusline.green,
			INSERT = user_colors.statusline.red,
			VISUAL = user_colors.statusline.magenta,
			OP = user_colors.statusline.green,
			BLOCK = user_colors.statusline.blue,
			REPLACE = user_colors.statusline.violet,
			["V-REPLACE"] = user_colors.statusline.violet,
			ENTER = user_colors.statusline.cyan,
			MORE = user_colors.statusline.cyan,
			SELECT = user_colors.statusline.orange,
			COMMAND = user_colors.statusline.green,
			SHELL = user_colors.statusline.green,
			TERM = user_colors.statusline.green,
			NONE = user_colors.statusline.yellow,
		}

		local user_icons = require("user.icons")
		local icons = {
			linux = user_icons.misc.Linux,
			macos = user_icons.misc.MacOS,
			windows = user_icons.misc.Windows,
			errs = user_icons.diagnostics.BoldError,
			warns = user_icons.diagnostics.BoldWarning,
			infos = user_icons.diagnostics.BoldInformation,
			hints = user_icons.diagnostics.BoldHint,
			lsp = user_icons.diagnostics.Lsp,
			git = user_icons.git.Branch,
			changed = user_icons.git.LineChanged,
			added = user_icons.git.LineAdded,
			removed = user_icons.git.LineRemoved,
			prefix = " ",
			sep = "|",
		}

		local theme = {
			replace = {
				a = { fg = colors.FONT, bg = colors.REPLACE, gui = "bold" },
				b = { fg = colors.FRONTGROUND, bg = colors.BACKGROUND },
			},
			inactive = {
				a = { fg = colors.DISABLE, bg = colors.BACKGROUND, gui = "bold" },
				b = { fg = colors.DISABLE, bg = colors.BACKGROUND },
				c = { fg = colors.DISABLE, bg = colors.BACKGROUND },
			},
			normal = {
				a = { fg = colors.FONT, bg = colors.NORMAL, gui = "bold" },
				b = { fg = colors.FRONTGROUND, bg = colors.BACKGROUND },
				c = { fg = colors.FRONTGROUND, bg = colors.BACKGROUND },
			},
			visual = {
				a = { fg = colors.FONT, bg = colors.VISUAL, gui = "bold" },
				b = { fg = colors.FRONTGROUND, bg = colors.BACKGROUND },
			},
			insert = {
				a = { fg = colors.FONT, bg = colors.INSERT, gui = "bold" },
				b = { fg = colors.FRONTGROUND, bg = colors.BACKGROUND },
			},
		}

		local mode = {
			"mode",
			fmt = function(str)
				return icons.prefix .. str
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = icons.added, modified = icons.changed, removed = icons.removed },
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = icons.errs, warn = icons.warns, info = icons.infos, hint = icons.hints },
			colored = true,
			update_in_insert = false,
			always_visible = false,
			displayed = { error = true, warn = true, info = true, hint = true },
		}

		local filename_with_icon = {
			function()
				local name = vim.fn.expand("%:t")
				if name == "" then
					return "[No Name]"
				end
				local ext = vim.fn.expand("%:e")
				local icon, _ = require("nvim-web-devicons").get_icon_color(name, ext, { default = true })
				local modified = vim.bo.modified and " ●" or ""
				local readonly = vim.bo.readonly and " [RO]" or ""
				return icon .. " " .. name .. modified .. readonly
			end,
			color = function()
				local name = vim.fn.expand("%:t")
				local ext = vim.fn.expand("%:e")
				local _, color = require("nvim-web-devicons").get_icon_color(name, ext, { default = true })
				return { fg = color }
			end,
		}

		local branch = { "branch", icon = { icons.git }, "|" }

		local lsp = {
			function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					return ""
				end
				local names = {}
				for _, client in ipairs(clients) do
					table.insert(names, client.name)
				end
				return icons.lsp .. table.concat(names, ", ")
			end,
			color = { fg = user_colors.statusline.yellow },
		}

		lualine.setup({
			icons_enabled = true,
			disabled_filetypes = { "NvimTree" },
			options = {
				theme = theme,
				component_separators = { left = icons.sep, right = icons.sep },
				section_separators = { left = icons.sep, right = "" },
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { filename_with_icon, lsp, diagnostics },
				lualine_x = {
					-- { "encoding" },
					-- { "fileformat" },
					branch,
					diff,
				},
			},
		})
	end,
}
