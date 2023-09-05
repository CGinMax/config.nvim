-- https://github.com/nvim-tree/nvim-tree.lua
local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	require("user.utils").notify_error("nvim-tree/nvim-tree.lua load failed!")
	return
end

local icons = require("user.icons")
local colors = require("user.colors")

nvim_tree.setup({
	-- auto_close = false,
	view = {
		width = 25,
		hide_root_folder = false,
		adaptive_size = true,
    signcolumn = "no",
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	notify = {
		threshold = vim.log.levels.ERROR,
	},
	diagnostics = {
		-- enable file diagnostics information
		enable = true,
		icons = {
			hint = icons.diagnostics.BoldHint,
			info = icons.diagnostics.BoldInformation,
			warning = icons.diagnostics.BoldWarning,
			error = icons.diagnostics.BoldError,
		},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
})

vim.g.nvim_tree_icons = {
	default = icons.ui.Text,
	symlink = icons.ui.FolderSymlink,
	git = {
		unstaged = icons.git.FileUnstaged,
		staged = icons.git.FileStaged,
		unmerged = icons.git.FileUnmerged,
		renamed = icons.git.FileRenamed,
		untracked = icons.git.FileUntracked,
		deleted = icons.git.FileDeleted,
		ignored = icons.git.FileIgnored,
	},
	folder = {
		arrow_open = icons.ui.ChevronShortDown,
		arrow_closed = icons.ui.ChevronShortRight,
		default = icons.ui.Folder,
		open = icons.ui.FolderOpen,
		empty = icons.ui.EmptyFolder,
		empty_open = icons.ui.EmptyFolderOpen,
		symlink = icons.ui.FileSymlink,
	},
}
vim.cmd[[
  hi NvimTreeStatusLine guibg=#1F1F2B guifg=#abb2bf
]]
