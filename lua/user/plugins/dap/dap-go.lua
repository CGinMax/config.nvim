local dap = require('dap')
dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}
dap.configurations.go = {
  {
    type = "go", -- Which adapter to use
    name = "Debug", -- Human readable name
    request = "launch", -- Whether to "launch" or "attach" to program
    program = "${file}", -- The buffer you are focused on when running nvim-dap
  },
}
