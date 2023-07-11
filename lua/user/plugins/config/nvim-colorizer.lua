-- https://github.com/norcalli/nvim-colorizer.lua

local ok, colorizer = pcall(require, "colorizer")
if not ok then
	require("user.utils").notify_error("norcalli/nvim-colorizer load failed!")
	return
end

colorizer.setup()
