-- https://github.com/karb94/neoscroll.nvim

local ok, neoscroll = pcall(require, "neoscroll")
if not ok then
	require("user.utils").notify_error("karb94/neoscroll load failed!")
	return
end
neoscroll.setup()
