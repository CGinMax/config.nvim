-- https://github.com/RRethy/vim-illuminate
return {
  -- vim-illuminate: 上下文高亮显示当前光标所在的内容
  "RRethy/vim-illuminate",
  config = function()
    -- 禁止高亮的文件类型
    vim.g.Illuminate_ftblacklist = {
      "NvimTree",
      "toggleterm",
    }
  end
}
