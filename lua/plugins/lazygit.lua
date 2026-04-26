--	https://www.github.com/kdheepak/lazygit.nvim
return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- window border thing
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
