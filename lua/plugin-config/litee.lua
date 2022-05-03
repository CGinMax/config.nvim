-- https://github.com/ldelossa/litee.nvim
local ok, litee_lib = pcall(require, "litee.lib")
if not ok then
  vim.notify("litee_lib not found")
  return
end

litee_lib.setup({
    tree = {
        icon_set = "codicons"
    },
    panel = {
        orientation = "right",
        panel_size  = 50
    }
})

