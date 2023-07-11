-- https://github.com/akinsho/bufferline.nvim

local ok, bufferline = pcall(require, "bufferline")
if not ok then
	require("utils").notifyError("akinsho/bufferline load failed!")
	return
end

bufferline.setup({
	options = {
		-- 为每个 buffer 都配置一个序数
		numbers = "ordinal",
		-- 使用内置 LSP 进行诊断
		diagnostics = "nvim_lsp",
		-- 不建议更改图标
		indicator = {
			icon = "▎",
			style = "icon",
		},
		color_icons = true,
		get_element_icon = function(element)
			local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
			return icon, hl
		end,
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = true,
		--show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		-- 分割符样式："slant" | "thick" | "thin"
		-- 如果是透明背景，不推荐使用 slant
		separator_style = "thin",
		-- 左侧让出 nvim-tree 的位置
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
				separator = true,
			},
		},
		-- 显示 LSP 报错图标
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "" or (e == "warning" and "" or "")
				s = s .. n .. sym
			end
			return s
		end,
		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
				local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
				if error ~= 0 then
					table.insert(result, { text = "  " .. error, fg = "#EC5241" })
				end

				if warning ~= 0 then
					table.insert(result, { text = "  " .. error, fg = "#EFB839" })
				end

				if hint ~= 0 then
					table.insert(result, { text = "  " .. error, fg = "#A3BA5E" })
				end

				if info ~= 0 then
					table.insert(result, { text = "  " .. error, fg = "#7EA9A7" })
				end
				return result
			end,
		},
	},
})
