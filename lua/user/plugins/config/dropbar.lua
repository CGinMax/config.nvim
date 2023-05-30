-- https://github.com/Bekaboo/dropbar.nvim

local status_ok, dropbar = pcall(require, "dropbar")
if not status_ok then
	require("user.utils").notify_error("Bekaboo/dropbar load failed! ")
	return
end

dropbar.setup()
