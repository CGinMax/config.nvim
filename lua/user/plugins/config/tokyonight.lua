-- https://github.com/folke/tokyonight.nvim

local ok, tokyonight = pcall(require, 'tokyonight')
if (not ok) then
  require('user.utils').notify_error('folke/tokyonight.nvim load failed!')
  return
end

tokyonight.setup({
  style = 'storm',
  transparent = false,
  terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be 'dark', 'transparent' or 'normal'
    sidebars = 'dark', -- style for sidebars, see below
    floats = 'dark',   -- style for floating windows
  },
  colors = { hint = 'orange', error = '#FF0000' },
  sidebars = { 'qf', 'help' },      -- Set a darker background on sidebar-like windows. For example: `['qf', 'vista_kind', 'terminal', 'packer']`
  day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false,             -- dims inactive windows
  lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
})

-- 应用主题
vim.cmd.colorscheme('tokyonight-storm')
