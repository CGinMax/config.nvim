-- https://github.com/p00f/clangd_extensions.nvim

local ok, clangd_ext = pcall(require, "clangd_extensions")
if not ok then
	require("user.utils").notify_error("p00f/clangd_extensions load failed!")
	return
end

clangd_ext.setup(

)
