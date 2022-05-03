vim.g.mapleader=";"
vim.g.maplocalleader=";"

vim.keybinds={
  gmap = vim.api.nvim_set_keymap,
  bmap = vim.api.nvim_buf_set_keymap,
  dgmap = vim.api.nvim_del_keymap,
  dbmap = vim.api.nvim_buf_del_keymap,
  opts = {noremap=true, silent = true}
}

-- 重新修改跳转到头和尾
vim.keybinds.gmap("n", "H", "^", vim.keybinds.opts)
vim.keybinds.gmap("n", "L", "$", vim.keybinds.opts)
vim.keybinds.gmap("v", "H", "^", vim.keybinds.opts)
vim.keybinds.gmap("v", "H", "^", vim.keybinds.opts)


vim.keybinds.gmap("n", "<C-h>", "<C-w>h", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-j>", "<C-w>j", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-k>", "<C-w>k", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-l>", "<C-w>l", vim.keybinds.opts)

-- winshift
vim.keybinds.gmap("n", "<C-W>m", ":WinShift<CR>", vim.keybinds.opts)

-- Resize with arrows
vim.keybinds.gmap("n", "<C-Up>", ":resize -2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Down>", ":resize +2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Left>", ":vertical resize -2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<C-Right>", ":vertical resize +2<CR>", vim.keybinds.opts)

-- Move tetx up and down
vim.keybinds.gmap("n", "<A-j>", "<Esc>:m .+1<CR>==gi<Esc>", vim.keybinds.opts)
vim.keybinds.gmap("n", "<A-k>", "<Esc>:m .-2<CR>==gi<Esc>", vim.keybinds.opts)
