-- https://github.com/lewis6991/hover.nvim

local ok, hover = pcall(require, 'hover')
if (not ok) then
  require('utils').notifyError("lewis6991/hover.nvim load failed!!")
  return
end

hover.setup({
  init = function ()
    require('hover.providers.lsp')
  end,
  preview_opts = {
    border = nil
  },
  preview_window = true,
  title = true,
})
-- Setup keymaps
vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
