-- https://github.com/feline-nvim/feline.nvim

local ok, feline = pcall(require, "feline")
if not ok then
	require("user.utils").notify_error("feline-nvim/feline.nvim load failed!")
	return
end
local ok, lsp = pcall(require, "feline.providers.lsp")
if not ok then
	require("user.utils").notify_error("feline.providers.lsp load failed!")
	return
end

local vi_mode_utils = require("feline.providers.vi_mode")
-- local position = require('feline.providers.position')
local cursor = require("feline.providers.cursor")

local colors = require("user.colors")

local vi_mode_colors = {
	NORMAL = colors.statusline.green,
	INSERT = colors.statusline.red,
	VISUAL = colors.statusline.magenta,
	OP = colors.statusline.green,
	BLOCK = colors.statusline.blue,
	REPLACE = colors.statusline.violet,
	["V-REPLACE"] = colors.statusline.violet,
	ENTER = colors.statusline.cyan,
	MORE = colors.statusline.cyan,
	SELECT = colors.statusline.orange,
	COMMAND = colors.statusline.green,
	SHELL = colors.statusline.green,
	TERM = colors.statusline.green,
	NONE = colors.statusline.yellow,
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
	git = user_icons.git.BoldBranch,
	changed = user_icons.git.LineChanged,
}

local function file_osinfo()
	local os = vim.bo.fileformat:upper()
	local icon
	if os == "UNIX" then
		icon = icons.linux
	elseif os == "MAC" then
		icon = icons.macos
	else
		icon = icons.windows
	end
	return icon .. os
end

local function lsp_diagnostics_info()
	return {
		errs = lsp.get_diagnostics_count("Error"),
		warns = lsp.get_diagnostics_count("Warn"),
		infos = lsp.get_diagnostics_count("Info"),
		hints = lsp.get_diagnostics_count("Hint"),
	}
end

local function diag_enable(f, s)
	return function()
		local diag = f()[s]
		return diag and diag ~= 0
	end
end

local function diag_of(f, s)
	local icon = icons[s]
	return function()
		local diag = f()[s]
		return icon .. diag
	end
end

local function vimode_hl()
	return {
		name = vi_mode_utils.get_mode_highlight_name(),
		-- fg = vi_mode_utils.get_mode_color(),
		fg = colors.statusline.bg,
		bg = vi_mode_utils.get_mode_color(),
		style = "bold",
	}
end

-- LuaFormatter off
local comps = {
	vi_mode = {
		left = {
			provider = {
				name = "vi_mode",
				opts = {
					show_mode_name = true,
					padding = "center", -- Uncomment for extra padding.
				},
			},
			-- provider = '▊',
			hl = vimode_hl,
			left_sep = "block",
			right_sep = " ",
		},
		right = {
			-- provider = '▊',
			provider = "position",
			hl = vimode_hl,
			left_sep = "block",
			right_sep = "block",
		},
	},
	file = {
		info = {
			provider = "file_info",
			hl = {
				fg = colors.statusline.blue,
				style = "bold",
			},
		},
		encoding = {
			provider = "file_encoding",
			left_sep = " ",
			hl = {
				fg = colors.statusline.violet,
				style = "bold",
			},
		},
		type = {
			provider = "file_type",
		},
		os = {
			provider = file_osinfo,
			left_sep = " ",
			hl = {
				fg = colors.statusline.violet,
				style = "bold",
			},
		},
	},
	line_percentage = {
		provider = "line_percentage",
		left_sep = " ",
		hl = {
			style = "bold",
		},
	},
	scroll_bar = {
		provider = "scroll_bar",
		left_sep = " ",
		right_sep = " ",
		hl = {
			fg = colors.statusline.blue,
			style = "bold",
		},
	},
	diagnos = {
		err = {
			provider = diag_of(lsp_diagnostics_info, "errs"),
			left_sep = " ",
			enabled = diag_enable(lsp_diagnostics_info, "errs"),
			hl = {
				fg = colors.statusline.red,
			},
		},
		warn = {
			provider = diag_of(lsp_diagnostics_info, "warns"),
			left_sep = " ",
			enabled = diag_enable(lsp_diagnostics_info, "warns"),
			hl = {
				fg = colors.statusline.yellow,
			},
		},
		info = {
			provider = diag_of(lsp_diagnostics_info, "infos"),
			left_sep = " ",
			enabled = diag_enable(lsp_diagnostics_info, "infos"),
			hl = {
				fg = colors.statusline.blue,
			},
		},
		hint = {
			provider = diag_of(lsp_diagnostics_info, "hints"),
			left_sep = " ",
			enabled = diag_enable(lsp_diagnostics_info, "hints"),
			hl = {
				fg = colors.statusline.cyan,
			},
		},
	},
	lsp = {
		name = {
			provider = "lsp_client_names",
			left_sep = " ",
			icon = icons.lsp,
			hl = {
				fg = colors.statusline.yellow,
			},
		},
	},
	git = {
		branch = {
			provider = "git_branch",
			icon = icons.git,
			left_sep = " ",
			hl = {
				fg = colors.statusline.violet,
				style = "bold",
			},
		},
		add = {
			provider = "git_diff_added",
			hl = {
				fg = colors.statusline.green,
			},
		},
		change = {
			icon = icons.changed,
			provider = "git_diff_changed",
			hl = {
				fg = colors.statusline.orange,
			},
		},
		remove = {
			provider = "git_diff_removed",
			hl = {
				fg = colors.statusline.red,
			},
		},
	},
}

local properties = {
	force_inactive = {
		filetypes = {
			"NvimTree",
			"packer",
			"^startify$",
			"^fugitive$",
			"^fugitiveblame$",
			"^qf$",
			"help",
		},
		buftypes = {
			"terminal",
		},
		bufnames = {},
	},
	disable = {
		filetypes = {
			"NvimTree",
			"help",
		},
		buftypes = {
			"terminal",
		},
		bufnames = {},
	},
}

-- LuaFormatter on
local components = {
	active = {
		{
			comps.vi_mode.left,
			comps.file.info,
			comps.lsp.name,
		},
		{},
		{
			comps.diagnos.err,
			comps.diagnos.warn,
			comps.diagnos.hint,
			comps.diagnos.info,
			comps.git.add,
			comps.git.change,
			comps.git.remove,
			comps.file.os,
			comps.file.encoding,
			comps.git.branch,
			comps.line_percentage,
			comps.scroll_bar,
			comps.vi_mode.right,
		},
	},
	inactive = {
		{
			comps.vi_mode.left,
			comps.file.info,
		},
		{},
		{},
	},
}

feline.setup({
	default_bg = colors.statusline.bg,
	default_fg = colors.statusline.fg,
	components = components,
	properties = properties,
	vi_mode_colors = vi_mode_colors,
})
