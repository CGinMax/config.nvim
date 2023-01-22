local M = {}

M.notifyError = function (msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.ends_with = function (str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

M.SaveAndExit = function ()
  vim.api.nvim_command(":wa")
  vim.api.nvim_command(":qa")
end

-- file exist?
M.exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

-- gtags
M.GtagsRefernce = function()
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find c " .. word)
  vim.api.nvim_command(":copen")
end

M.GtagsText = function()
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find t " .. word)
  vim.api.nvim_command(":copen")
end
return M

