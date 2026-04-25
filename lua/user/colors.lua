local M = {}
M.monokai = {
	dark2 = "#161821",
	dark1 = "#1e1f2b",
	background = "#282a3a",
	text = "#eaf2f1",
	accent1 = "#ff657a",
	accent2 = "#ff9b5e",
	accent3 = "#ffd76d",
	accent4 = "#bad761",
	accent5 = "#9cd1bb",
	accent6 = "#c39ac9",
	dimmed1 = "#b2b9bd",
	dimmed2 = "#888d94",
	dimmed3 = "#696d77",
	dimmed4 = "#535763",
	dimmed5 = "#3a3d4b",
}

M.diagnostics = {
	fg = {
		Error = "#EC5241",
		Warning = "#EFB839",
		Hint = "#A4BA5E",
		Info = "#7EA9A7",
	},
}

M.statusline = {
	bg = M.monokai.background,
	fg = M.monokai.text,
	font = "#092236",
	inactive = "#a1aab8",
	yellow = "#e0af68",
	cyan = "#56b6c2",
	darkblue = "#081633",
	green = "#98c379",
	orange = "#d19a66",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#61afef",
	red = "#e86671",
}
M.global = {
	bg = M.monokai.background,
	fg = M.monokai.text,
}
return M
