-- https://github.com/norcalli/nvim-colorizer.lua

local ok, colorizer = pcall(require, 'colorizer')
if (not ok) then
  require('utils').notifyError("norcalli/nvim-colorizer")
  return
end

colorizer.setup()
