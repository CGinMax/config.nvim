require("user.plugins.dap.mason-nvim-dap")
require("user.plugins.dap.dap-config").setup()
require("user.plugins.dap.dap-ui")
require("user.plugins.dap.dap-virtual-text")

-- telescope-dap.nvim
require("telescope").load_extension('dap')
