-- https://github.com/jay-babu/mason-null-ls.nvim
local status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if (not status_ok) then
  require('utils').notify_error("jay-babu/mason-null-ls.nvim")
  return
end

local status_ok, null_ls = pcall(require, "null-ls")
if (not status_ok) then
  require('utils').notify_error("jose-elias-alvarez/null-ls.nvim")
  return
end
mason_null_ls.setup_handlers {
    function(source_name, methods)
      -- all sources with no handler get passed here

      -- To keep the original functionality of `automatic_setup = true`,
      -- please add the below.
      require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    stylua = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
}
