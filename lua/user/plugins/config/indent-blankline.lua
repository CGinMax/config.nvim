-- https://github.com/lukas-reineke/indent-blankline.nvim

local ok, ibl = pcall(require, "ibl")
if not ok then
  require("user.utils").notify_error("lukas-reineke/indent-blankline load failed!")
  return
end

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

ibl.setup({
  -- 显示当前所在区域
  -- show_current_context = true,
  -- 显示当前所在区域的开始位置
  -- show_current_context_start = true,
  -- 显示行尾符
  -- show_end_of_line = true,
  -- show_trailing_blankline_indent = true,
  -- space_char_blankline = " ",
  -- colorful
  -- char_highlight_list = {
  -- 	"IndentBlanklineIndent1",
  -- 	"IndentBlanklineIndent2",
  -- 	"IndentBlanklineIndent3",
  -- 	"IndentBlanklineIndent4",
  -- 	"IndentBlanklineIndent5",
  -- 	"IndentBlanklineIndent6",
  -- },
  -- filetype_exclude = {
  --   "help",
  --   "startify",
  --   "dashboard",
  --   "packer",
  --   "neogitstatus",
  --   "NvimTree",
  --   "Trouble",
  -- },
})
