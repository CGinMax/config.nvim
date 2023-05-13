-- https://github.com/goolord/alpha-nvim
local ok, alpha = pcall(require, "alpha")
if (not ok) then
  require('utils').notify_error("goolord/alpha-nvim load failed!")
  return
end

alpha.setup(require("alpha.themes.dashboard").config)
