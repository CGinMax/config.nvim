-- https://github.com/smjonas/inc-rename.nvim

local status_ok, inc_rename = pcall(require, "inc_rename")
if not status_ok then
	require("user.utils").notify_error("smjonas/inc-rename.nvim load failed")
	return
end

inc_rename.setup()
