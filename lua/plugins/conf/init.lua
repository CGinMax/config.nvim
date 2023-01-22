
local M = {}
local ends_with = require('utils').ends_with
local notifyError = require('utils').notifyError

M.setup = function ()
  local config_path = vim.fn.stdpath('config') .. '/lua/plugins/conf'
  -- plugins do not need to load, NOTE: no .lua suffix required
  local unload_plugins = {
    "init", -- we don't need to load init again
    "catppuccin",
    "neoformat",
    "nvim-lsp-installer",
    "prettier",
  }

  local unload_plugins_map = {}
  for _, v in pairs(unload_plugins) do
    unload_plugins_map[v] = true
  end

  for _, filename in pairs(vim.fn.readdir(config_path)) do
    if (ends_with(filename, ".lua")) then
      local cut_suffix_filename = filename:sub(1, #filename - #".lua")
      if (unload_plugins_map[cut_suffix_filename] == nil) then
        local file = "plugins.conf." .. cut_suffix_filename
        local status_ok, result = pcall(require, file)
        if (not status_ok) then
          notifyError("Failed Load " .. filename .. ", error:" .. result)
        end
      end
    end
  end
end

M.setup()
