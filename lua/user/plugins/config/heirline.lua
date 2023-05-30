-- https://github.com/rebelot/heirline.nvim

local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	require("user.utils").notify_error("rebelot/heirline load failed!")
	return
end

local function pattern_match(str, pattern_list)
	for _, pattern in ipairs(pattern_list) do
		if str:find(pattern) then
			return true
		end
	end
	return false
end
local buf_matchers = {
	filetype = function(pattern_list, bufnr)
		return pattern_match(vim.bo[bufnr or 0].filetype, pattern_list)
	end,
	buftype = function(pattern_list, bufnr)
		return pattern_match(vim.bo[bufnr or 0].buftype, pattern_list)
	end,
	bufname = function(pattern_list, bufnr)
		return pattern_match(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr or 0), ":t"), pattern_list)
	end,
}
function buffer_matches(patterns, bufnr)
	for kind, pattern_list in pairs(patterns) do
		if buf_matchers[kind](pattern_list, bufnr) then
			return true
		end
	end
	return false
end

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function extend_tbl(default, opts)
	opts = opts or {}
	return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- A function to build a set of children components for a mode section
---@param opts? table options for configuring mode_text, paste, spell, and the overall padding
---@return table # The Heirline component table
-- @usage local heirline_component = require("astronvim.utils.status").component.mode { mode_text = true }
function mode(opts)
	opts = extend_tbl({
		mode_text = false,
		paste = false,
		spell = false,
		surround = { separator = "left", color = M.hl.mode_bg },
		hl = M.hl.get_attributes("mode"),
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd.redrawstatus()
			end),
		},
	}, opts)
	if not opts["mode_text"] then
		opts.str = { str = " " }
	end
	return M.component.builder(M.utils.setup_providers(opts, { "mode_text", "str", "paste", "spell" }))
end

heirline.setup({
	opts = {
		disable_winbar_cb = function(args)
			return buffer_matches({
				buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
				filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
			}, args.buf)
		end,
	},
	statusline = {
		-- statusline
		hl = { fg = "fg", bg = "bg" },
		status.component.mode(),
		status.component.git_branch(),
		status.component.file_info({ filetype = {}, filename = false, file_modified = false }),
		status.component.git_diff(),
		status.component.diagnostics(),
		status.component.fill(),
		status.component.cmd_info(),
		status.component.fill(),
		status.component.lsp(),
		status.component.treesitter(),
		status.component.nav(),
		status.component.mode({ surround = { separator = "right" } }),
	},
})
