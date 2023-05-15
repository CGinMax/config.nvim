-- https://github.com/yamatsum/nvim-nonicons

local status_ok, nonicons = pcall(require, 'nvim-nonicons')
if not status_ok then
  require('user.utils').notify_error('yamatsum/nvim-nonicons load failed!')
  return
end

nonicons.setup()
