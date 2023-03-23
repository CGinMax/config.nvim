-- https://github.com/nvim-tree/nvim-tree.lua
local ok, nvim_tree = pcall(require, "nvim-tree")
if (not ok) then
  require('utils').notifyError("nvim-tree/nvim-tree.lua load failed!")
  return
end

vim.opt.termguicolors = true
nvim_tree.setup({
  -- auto_close = false,
  view = {
    width = 25,
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
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  notify = {
    threshold = vim.log.levels.ERROR,
  },
  diagnostics = {
    -- enable file diagnostics information
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500
  }
}
)

-- default icon
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
