-- https://github.com/loctvl842/monokai-pro.nvim

return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local monokai = require("monokai-pro")

		monokai.setup({
			filter = "octagon",
			background_clear = {
				"toggleterm",
				"telescope",
				"renamer",
				"notify",
			},
			-- highlight
			override = function(scheme)
				local json_str = vim.json.encode(scheme.base)
				print(json_str)
				return {
					-- IndentBlanklineChar = { fg = scheme.base.dimmed4 },

					TelescopeTitle = { fg = scheme.base.yellow, fg = scheme.base.black, bold = true },
					TelescopePromptPrefix = { fg = scheme.base.cyan },
					TelescopePromptNormal = { bg = scheme.base.dimmed5 },
					TelescopePromptBorder = { fg = scheme.base.dimmed5, bg = scheme.base.dimmed5 },

					TelescopeResultsTitle = { bg = scheme.base.yellow, fg = scheme.base.black, bold = true },
					TelescopeResultsNormal = { bg = scheme.base.dimmed5 },
					TelescopeResultsBorder = { fg = scheme.base.dimmed1, bg = scheme.base.dimmed5 },

					TelescopePreviewTitle = { bg = scheme.base.yellow, fg = scheme.base.black, bold = true },
					TelescopePreviewNormal = { bg = scheme.base.dimmed5 },
					TelescopePreviewBorder = { fg = scheme.base.dimmed5, bg = scheme.base.dimmed5 },

					--   Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
					-- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					-- PmenuSbar = { bg = theme.ui.bg_m1 },
					-- PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
			-- palette
			override_palette = function(filter)
				return {
					dark2 = "#161821",
					dark1 = "#1e1f2b",
					background = "#282a3a",
					text = "#eaf2f1",
					accent1 = "#957FB8",
					accent2 = "#ff9b5e",
					accent3 = "#ffd76d",
					accent4 = "#bad761",
					accent5 = "#9cd1bb",
					accent6 = "#c39ac9",
					dimmed1 = "#b2b9bd",
					dimmed2 = "#888d94",
					dimmed3 = "#696d77",
					dimmed4 = "#535763",
					dimmed5 = "#3a3d4b",
				}
			end,
		})
	end,
}
