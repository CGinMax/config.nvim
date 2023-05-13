local M = {
  keymap = vim.keymap.set,
  gmap = vim.api.nvim_set_keymap,
  bmap = vim.api.nvim_buf_set_keymap,
  dgmap = vim.api.nvim_del_keymap,
  dbmap = vim.api.nvim_buf_del_keymap,
  opts = { noremap = true, silent = true },
  mode_normal = 'n',
  mode_insert = 'i',
  mode_visual = 'v',
  mode_visual_block = 'x',
  mode_term = 't',
  mode_command = 'c',
}


M.notify_error = function (msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.ends_with = function (str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

M.save_and_exit = function ()
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

