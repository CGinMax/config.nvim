vim.g.mapleader=";"
vim.g.maplocalleader=";"

vim.keybinds={
  gmap = vim.api.nvim_set_keymap,
  bmap = vim.api.nvim_buf_set_keymap,    
  dgmap = vim.api.nvim_del_keymap,    
  dbmap = vim.api.nvim_buf_del_keymap,
  opts = {noremap=true, silent = true}
}

vim.keybinds.gmap("n", "<C-u>", "9k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-d>", "9j", vim.keybinds.opts)
vim.keybinds.gmap("n", "sv", ":vsp<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "sh", ":sp<CR>", vim.keybinds.opts)


