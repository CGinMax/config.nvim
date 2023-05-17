require("plugins.dap.mason-nvim-dap")
require("plugins.dap.dap-config").setup()
require("plugins.dap.dap-ui")
require("plugins.dap.dap-virtual-text")

-- telescope-dap.nvim
require("telescope").load_extension('dap')
