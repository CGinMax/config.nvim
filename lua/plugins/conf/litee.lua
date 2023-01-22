-- https://github.com/ldelossa/litee.nvim
local ok, litee_lib = pcall(require, "litee.lib")
if (not ok) then
  require('ldelossa/litee.nim load failed!')
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

-- https://github.com/ldelossa/litee-calltree.nvim

local ok, litee_calltree = pcall(require, "litee.calltree")
if (not ok) then
  require('ldelossa/litee-calltree.nvim load failed!')
  return
end

-- configure litee-calltree.nvim
-- commands: LTOpenToCalltree to open calltree
litee_calltree.setup({
   -- NOTE: the plugin is in-progressing
  on_open = "pannel", -- pannel | popout
  hide_cursor = false,
  keymaps = {
    expand = "o",
    collapse = "zc",
    collapse_all = "zM",
    jump = "<CR>",
    jump_split = "s",
    jump_vsplit = "v",
    jump_tab = "t",
    hover = "i",
    details = "d",
    close = "X",
    close_panel_pop_out = "<C-c>",
    help = "?",
    hide = "H",
    switch = "S",
    focus = "f"
  },
})
