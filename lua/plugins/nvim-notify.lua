-- https://github.com/rcarriga/nvim-notify

return {
	-- notification
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		local icons = require("user.icons")

		notify.setup({
			-- animation:
			-- fade_in_slide_out
			-- fade
			-- slide
			-- static
			stages = "fade_in_slide_out",
			render = "default",
			-- 超时时间，默认 5s
			timeout = 5000,
			fps = 60,
			-- Icons for the different levels
			icons = {
				ERROR = icons.diagnostics.BoldError,
				WARN = icons.diagnostics.BoldWarning,
				INFO = icons.diagnostics.BoldInformation,
				DEBUG = icons.diagnostics.BoldDebug,
				TRACE = icons.diagnostics.Trace,
			},
		})

		-- 如果是透明背景，则需要设置背景色
		if vim.g.background_transparency then
			notify_opts.background_colour = "#ffffff"
		end

		vim.notify = notify
	end,
}
