-- https://github.com/akinsho/bufferline.nvim

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		{
			"famiu/bufdelete.nvim", -- 删除 buffer 时不影响现有布局
			"nvim-tree/nvim-web-devicons",
		},
	},
	config = function()
		local bufferline = require("bufferline")

		local icons = require("user.icons")

		bufferline.setup({
			options = {
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
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
				get_element_icon = function(element)
					return require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = true })
				end,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				buffer_close_icon = "󰖭",
				modified_icon = "● ",
				close_icon = "󰖭",
				left_trunc_marker = "",
				right_trunc_marker = "",
				-- 使用内置 LSP 进行诊断
				diagnostics = "nvim_lsp",
				-- 显示 LSP 报错图标
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and icons.diagnostics.BoldError
							or (e == "warning" and icons.diagnostics.BoldWarning or icons.diagnostics.BoldInformation)
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
							table.insert(result, { text = icons.diagnostics.Error .. error, fg = "#EC5241" })
						end

						if warning ~= 0 then
							table.insert(result, { text = icons.diagnostics.Warning .. error, fg = "#EFB839" })
						end

						if hint ~= 0 then
							table.insert(result, { text = icons.diagnostics.Hint .. error, fg = "#A3BA5E" })
						end

						if info ~= 0 then
							table.insert(result, { text = icons.diagnostics.Information .. error, fg = "#7EA9A7" })
						end
						return result
					end,
				},
			},
		})
	end,
}
