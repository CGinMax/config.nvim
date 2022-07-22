-- https://github.com/goolord/alpha-nvim
local ok, alpha = pcall(require, "alpha")
if not ok then
  vim.notify("alpha-nvim not found")
  return
end

alpha.setup(require "alpha.themes.dashboard".config)