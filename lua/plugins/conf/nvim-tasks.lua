-- https://github.com/Shatur/neovim-tasks
local status_ok, tasks = pcall(require, "tasks")
if (not status_ok) then
  require('utils').notifyError('folke/which-key.nvim load failed!')
  return
end

local Path = require('plenary.path')
tasks.setup({
  -- Default module parameters with which `neovim.json` will be created.
  default_params = {
    cmake = {
      -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
      cmd = 'cmake',
      -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
      build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}/')),
      -- Build type, can be changed using `:Task set_module_param cmake build_type`.
      build_type = 'Debug',
      -- DAP configuration name from `require('dap').configurations`.
      dap_name = 'lldb',
      -- Task default arguments.
      args = {
        -- configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=ON', '-G', 'Ninja' },
        configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=ON', '-D', 'CMAKE_PREFIX_PATH=/Users/cginmax/Qt/Qt5.15.8/' },
      },
    },
  },
  -- If true, all files will be saved before executing a task.
  save_before_run = true,
  -- JSON file to store module and task parameters.
  params_file = 'neovim.json',
  quickfix = {
    -- Default quickfix position.
    pos = 'botright',
    -- Default height.
    height = 12,
  },
  -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open`
  dap_open_command = function() return require('dap').repl.open() end,
})
