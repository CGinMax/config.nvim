-- https://github.com/windwp/nvim-autopairs

return {
	-- nvim-autopairs:括号自动补全
	"windwp/nvim-autopairs",
	config = function()
		local autopairs = require("nvim-autopairs")
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
		local ok, cmp = pcall(require, "cmp")
		if not ok then
			return
		end
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
