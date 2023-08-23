local ok, mason_nvim_dap = pcall(require, 'mason-nvim-dap')
if (not ok) then
  require('user.utils').notify_error('jay-babu/mason-nvim-dap.nvim load failed!')
  return
end

mason_nvim_dap.setup()
