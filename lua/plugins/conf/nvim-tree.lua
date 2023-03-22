-- https://github.com/kyazdani42/nvim-tree.lua
local ok, nvim_tree = pcall(require, "nvim-tree")
if (not ok) then
  require('utils').notifyError("kyazdani42/nvim-tree.lua load failed!")
  return
end

vim.opt.termguicolors = true
nvim_tree.setup({
  -- 自动关闭
  -- auto_close = false,
  -- 视图
  view = {
    width = 25,
    -- 隐藏顶部的根目录显示
    hide_root_folder = false,
    -- auto_resize = true
    adaptive_size = true,
    -- float = {
    --   enable = true,
    --   quit_on_focus_loss = true,
    --   open_win_config = {
    --     relative = "editor",
    --     border = "rounded",
    --     width = 30,
    --     height = 30,
    --     row = 1,
    --     col = 1,
    --   },
    -- },
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  notify = {
    threshold = vim.log.levels.ERROR,
  },
  diagnostics = {
    -- 是否启用文件诊断信息
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  git = {
    -- 是否启用 git 信息
    enable = true,
    ignore = true,
    timeout = 500
  }
}
)

-- 默认图标，可自行修改
vim.g.nvim_tree_icons = {
  default = " ",
  symlink = " ",
  git = {
    unstaged = "",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "",
    deleted = "",
    ignored = ""
  },
  folder = {
    -- arrow_open = "╰─▸",
    -- arrow_closed = "├─▸",
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = ""
  }
}
