
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
-- vim.keybinds.gmap("n", "<C-Tab>", ":bnext", vim.keybinds.opts)

-- bufferline
vim.keybinds.gmap("n", "tn", ":BufferLineCycleNext<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "tp", ":BufferLineCyclePrev<CR>", vim.keybinds.opts)
-- vim.keybinds.gmap("n", "tc", ":BufferLinePickClose<CR>", vim.keybinds.opts)

vim.keybinds.gmap("n", "t1", ":BufferLineGoToBuffer 1<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t2", ":BufferLineGoToBuffer 2<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t3", ":BufferLineGoToBuffer 3<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t4", ":BufferLineGoToBuffer 4<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t5", ":BufferLineGoToBuffer 5<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t6", ":BufferLineGoToBuffer 6<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t7", ":BufferLineGoToBuffer 7<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t8", ":BufferLineGoToBuffer 8<CR>", vim.keybinds.opts)
vim.keybinds.gmap("n", "t9", ":BufferLineGoToBuffer 9<CR>", vim.keybinds.opts)


