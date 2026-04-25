-- https://github.com/karb94/neoscroll.nvim

return {
  "karb94/neoscroll.nvim",
  config = function()
    local ok, neoscroll = pcall(require, "neoscroll")
    if not ok then
      require("user.utils").notify_error("karb94/neoscroll load failed!")
      return
    end
    --neoscroll.setup()
  end
}
