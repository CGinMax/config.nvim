-- https://github.com/simrat39/rust-tools.nvim
local ok, rust_tools = pcall(require, 'rust-tools')
if (not ok) then
  require('utils').notifyError('simrat39/rust-tools load failed!')
  return
end

rust_tools.setup()
