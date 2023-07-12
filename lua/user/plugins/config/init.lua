local M = {}
local utils = require("user.utils")

M.setup = function()
  local config_path = vim.fn.stdpath("config") .. "/lua/user/plugins/config"
  -- plugins do not need to load, NOTE: no .lua suffix required
  local unload_plugins = {
    "init", -- we don't need to load init again
    -- "feline",
    "heirline",
  }

  local unload_plugins_map = {}
  for _, v in pairs(unload_plugins) do
    unload_plugins_map[v] = true
  end

  for _, filename in pairs(vim.fn.readdir(config_path)) do
    if utils.ends_with(filename, ".lua") then
      local plugin_name = filename:sub(1, #filename - #".lua")
      if unload_plugins_map[plugin_name] == nil then
        local file = "user.plugins.config." .. plugin_name
        local status_ok, result = pcall(require, file)
        if not status_ok then
          --?? plugins no load yet
          vim.notify("Failed Load " .. filename .. ", error:" .. result, vim.log.levels.ERROR)
          -- utils.notify_error('Failed Load ' .. filename .. ', error:' .. result)
        end
      end
    end
  end
end

M.setup()
