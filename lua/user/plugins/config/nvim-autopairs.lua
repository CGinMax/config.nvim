-- https://github.com/windwp/nvim-autopairs
local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
	require("user.utils").notify_error("windwp/nvim-autopairs load failed!")
	return
end
autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel", "dap-repl", "guihua", "guihua_rust", "clap_input" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%'%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
