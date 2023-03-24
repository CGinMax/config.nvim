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
  lsp = {},
  panel = {
    orientation = "left",
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

-- https://github.com/ldelossa/litee-symboltree.nvim
local ok, litee_symboltree = pcall(require, "litee.symboltree")
if (not ok) then
  require('ldelossa/litee-symboltree.nvim load failed!')
  return
end

litee_symboltree.setup({})

-- https://github.com/ldelossa/litee-filetree.nvim
local ok, litee_filetree = pcall(require, "litee.filetree")
if (not ok) then
  require('ldelossa/litee-filetree.nvim load failed!')
  return
end
litee_filetree.setup({})

-- vim.lsp.handlers['callHierarchy/incomingCalls'] = vim.lsp.with(
--   require('litee.lsp.handlers').ch_lsp_handler("from"), {}
-- )
-- vim.lsp.handlers['callHierarchy/outgoingCalls'] = vim.lsp.with(
--   require('litee.lsp.handlers').ch_lsp_handler("to"), {}
-- )
-- vim.lsp.handlers['textDocument/documentSymbol'] = vim.lsp.with(
--   require('litee.lsp.handlers').ws_lsp_handler(), {}
-- )
