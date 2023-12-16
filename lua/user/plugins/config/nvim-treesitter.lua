--https://github.com/nvim-treesitter/nvim-treesitter
local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  require("user.utils").notify_error("nvim-treesitter load failed!")
  return
end

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or 'all' (the five listed parsers should always be installed)
  ensure_installed = {
    "c",
    "cpp",
    "java",
    "go",
    "python",
    "cmake",
    "rust",
    "lua",
    "javascript",
    "typescript",
    "html",
    "css",
    "vim",
    "vimdoc",
    "query",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = '/some/path/to/store/parsers', -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!

  highlight = {
    enable = true,
  },
})

local status_ok, cpp_tools = pcall(require, "nt-cpp-tools")
if not status_ok then
  require("user.utils").notify_error("nvim-treesitter-cpp-tools load failed!")
  return
end

cpp_tools.setup({
  preview = {
    quit = "q", -- optional keymapping for quit preview
    accept = "<tab>", -- optional keymapping for accept preview
  },
  header_extension = "h", -- optional
  source_extension = "cxx", -- optional
  custom_define_class_function_commands = {
    -- optional
    TSCppImplWrite = {
      output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
    },
    --[[
    <your impl function custom command name> = {
      output_handle = function (str, context)
        -- string contains the class implementation
        -- do whatever you want to do with it
      end
    }
    ]]
  },
})
