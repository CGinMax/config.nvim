-- https://github.com/ray-x/lsp_signature.nvim
local ok, lsp_signature = pcall(require, "lsp_signature")
if (not ok) then
  require('ray-x/lsp_signature load failed!')
  return
end

lsp_signature.setup({
  bind = true,
  -- 边框样式
  handler_opts = {
    -- double、rounded、single、shadow、none
    border = "rounded"
  },
  -- 自动触发
  floating_window = false,
  -- 绑定按键
  toggle_key = "<C-j>",
  select_signature_key = "<C-n>",
  -- 虚拟提示关闭
  hint_enable = true,
  -- 正在输入的参数将如何突出显示
  hi_parameter = "LspSignatureActiveParameter"
})
