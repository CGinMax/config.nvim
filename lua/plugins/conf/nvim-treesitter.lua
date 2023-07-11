--https://github.com/nvim-treesitter/nvim-treesitter
local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	require("utils").notifyError("nvim-treesitter.configs load failed!")
	return
end
treesitter_configs.setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"cpp",
		"cmake",
		"javascript",
		"typescript",
		"lua",
		"rust",
		"go",
		"java",
		"vim",
		"vimdoc",
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		enable = true,
	},
})
