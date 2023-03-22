-- https://github.com/rcarriga/nvim-notify

local ok, notify = pcall(require, "notify")
if (not ok) then
  require('rcarriga/nvim-notify load failed!')
  return
end

notify.setup({
  -- 动画样式
  -- fade_in_slide_out
  -- fade
  -- slide
  -- static
  stages = "fade_in_slide_out",
  -- 超时时间，默认 5s
  timeout = 2000,
  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})

-- 如果是透明背景，则需要设置背景色
if vim.g.background_transparency then
  notify_opts.background_colour = "#ffffff"
end

vim.notify = notify

