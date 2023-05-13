-- https://github.com/folke/which-key.nvim
local ok, which_key = pcall(require, "which-key")
if (not ok) then
  require('user.utils').notify_error('folke/which-key.nvim load failed!')
  return
end

which_key.setup({
  plugins = {
    marks = false,      -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = false,            -- bindings for folds, spelling and others prefixed with z
      g = false,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<CR>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",      -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<Space>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  w = { "<cmd>wa<CR>", "Save" },
  q = { "<cmd>qa!<CR>", "Quit" },
  C = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
  o = { "<cmd>AerialToggle<CR>", "Toggle Code Navigation" },
  t = {
    name = "Telescope",
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    f = {
      "<cmd>lua require('telescope.builtin').find_files()<CR>",
      -- "<cmd>lua require('telescope').extensions.frecenncy.frecency(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
      "Find files",
    },
    F = {
      "<cmd>lua require('telescope').extensions.live_grep_raw.live_grep_raw(require('telescope.themes').get_ivy())<CR>",
      "Find Text",
    },
    s = {
      "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
      "Find Document Symbols",
    },
    S = {
      "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>",
      "Find Symobls",
    },
    p = { "<cmd>Telescope projects<CR>", "Projects" },
    -- ["P"] = { "<cmd>SessionManager load_session<CR>", "Projects" },
    v = {
      "<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_ivy())<CR>",
      "Clipboard Manager"
    },
  },
  c = {
    name = "CMake",
    g = { "<cmd>Task start cmake configure<CR>", "Configure" },
    t = { "<cmd>Task set_module_param cmake target<CR>", "SelectTarget" },
    T = { "<cmd>Task set_module_param cmake build_type<CR>", "SelectBuildType" },
    b = { "<cmd>Task start cmake build<CR>", "BuildTarget" },
    a = { "<cmd>Task start cmake build_all<CR>", "BuildAll" },
    r = { "<cmd>Task start cmake run<CR>", "Run" },
    d = { "<cmd>Task start cmake debug<CR>", "DebugTarget" },
    c = { "<cmd>Task cancel<CR>", "Cancel" },
    s = { "<cmd>Task set_task_param cmake run args<CR>", "SetArg" },
  },
  d = {
    name = "Debug",
    R = { "<cmd>lua require'dap'.run_to_cursor()<CR>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<CR>", "Evaluate Input" },
    X = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
    -- C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<CR>", "Conditional Breakpoint" },
    -- S = { "<cmd>lua require'dap.ui.widgets'.scopes()<CR>", "Scopes" },
    T = { "<cmd>lua require'dapui'.toggle('sidebar')<CR>", "Toggle Sidebar" },
    -- b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.toggle_breakpoint(); require'plugins.dap.dap-util'.store_breakpoints(true)<CR>",
      "Toggle Breakpoint" },
    e = { "<cmd>lua require'dapui'.eval()<CR>", "Evaluate" },
    p = { "<cmd>lua require'dap'.pause()<CR>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
    q = { "<cmd>lua require'dap'.close()<CR>", "Quit" },
    i = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
    c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<CR>", "Hover Variables" },
    -- b = { "<cmd>lua require'dap'.step_back()<CR>", "Step Back" },
    -- d = { "<cmd>lua require'dap'.disconnect()<CR>", "Disconnect" },
    -- g = { "<cmd>lua require'dap'.session()<CR>", "Get Session" },
  },
  p = {
    name = "Problem",
    t = { "<cmd>TroubleToggle<CR>", "ToggleTrouble" },
    d = { "<cmd>Trouble document_diagnostics<CR>", "Document Diagnostics" },
    w = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
    q = { "<cmd>Trouble quickfix<CR>", "Quick Fix" },
    u = { "<cmd>Trouble lsp_references<CR>", "Usage" },
    g = { "<cmd>Gitsigns setloclist<CR>", "Open changed hunk" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
    p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
    n = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    N = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<CR>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk", },
    U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk", },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<CR>",
      "Diff",
    },
  },
  -- R = {
  --   name = "Replace",
  --   f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
  --   p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
  --   s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search" },
  -- -- 全项目替换
  -- vim.keybinds.gmap("n", "<leader>rp", "", vim.keybinds.opts)
  -- -- 只替换当前文件
  -- vim.keybinds.gmap("n", "<leader>rf", , vim.keybinds.opts)
  -- -- 全项目中搜索当前单词
  -- vim.keybinds.gmap("n", "<leader>rw", , vim.keybinds.opts)
  -- },
  l = {
    name = "LSP",
    l = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics bufnr=0<CR>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<CR>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format" },
    i = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go deifinition" },
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      "Prev Diagnostic",
    },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
  },
  h = {
    name = "Help",
    -- b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    -- r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
  },
  -- t = {
  --   name = "Terminal",
  --   n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
  --   u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
  --   t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
  --   p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
  --   f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
  --   h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
  --   v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  -- },
}

which_key.register(mappings, opts)
