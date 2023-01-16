-- https://github.com/feline-nvim/feline.nvim

local ok, feline = pcall(require, "feline")
if not ok then
  vim.notify("feline not found")
  return
end

feline.setup({

}
)
-- feline.winbar.setup({})