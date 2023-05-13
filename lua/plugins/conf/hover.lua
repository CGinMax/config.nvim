-- https://github.com/lewis6991/hover.nvim

local ok, hover = pcall(require, 'hover')
if (not ok) then
  require('utils').notify_error("lewis6991/hover.nvim load failed!!")
  return
end

hover.setup({
  init = function()
    require('hover.providers.lsp')
    -- require('hover.providers.gh')
    -- require('hover.providers.gh_user')
    -- require('hover.providers.jira')
    -- require('hover.providers.man')
    -- require('hover.providers.dictionary')
  end,
  preview_opts = {
    border = nil
  },
  preview_window = true,
  title = true,
})
