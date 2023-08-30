-- https://github.com/tami5/lspsaga.nvim

local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
	require("user.utils").notify_error("tami5/lspsaga.nvim load failed")
	return
end

local icons = require("user.icons")

lspsaga.setup({
	debug = false,
	use_saga_diagnostic_sign = true,
	-- 提示边框样式：round、single、double
	border_style = "round",
	error_sign = icons.diagnostics.BoldError,
	warn_sign = icons.diagnostics.BoldWarning,
	hint_sign = icons.diagnostics.BoldHint,
	infor_sign = icons.diagnostics.BoldInformation,
	diagnostic_header_icon = icons.diagnostics.BoldDebug,
	-- 正在写入的行提示
	code_action_icon = "",
	-- code_action_icon = icons.ui.BoldCheck,
	code_action_prompt = {
		-- 显示写入行提示
		-- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
		enable = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	finder_definition_icon = icons.ui.FindText,
	finder_reference_icon = icons.ui.FindText,
	max_preview_lines = 10,
	finder_action_keys = {
		open = "o",
		vsplit = "v",
		split = "s",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	-- 快捷键配置
	code_action_keys = {
		quit = "<Esc>",
		exec = "<CR>",
	},
	rename_action_keys = {
		quit = "<Esc>",
		exec = "<CR>",
	},
	definition_preview_icon = icons.kind.Preview,
	rename_prompt_prefix = icons.kind.Rename,
	rename_output_qflist = {
		enable = false,
		auto_open_qflist = false,
	},
	server_filetype_map = {},
	diagnostic_prefix_format = "%d. ",
	diagnostic_message_format = "%m %c",
	highlight_prefix = false,
})
