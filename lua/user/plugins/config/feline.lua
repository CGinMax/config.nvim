-- https://github.com/feline-nvim/feline.nvim

local ok, feline = pcall(require, "feline")
if not ok then
  require("user.utils").notify_error("feline-nvim/feline.nvim load failed!")
  return
end
local ok, lsp = pcall(require, "feline.providers.lsp")
if not ok then
  require("user.utils").notify_error("feline.providers.lsp load failed!")
  return
end

local vi_mode_utils = require("feline.providers.vi_mode")
-- local position = require('feline.providers.position')
local cursor = require("feline.providers.cursor")

-- local colors = require 'theme.colors'
local colors = {
  bg = "#282c34",
  fg = "#abb2bf",
  yellow = "#e0af68",
  cyan = "#56b6c2",
  darkblue = "#081633",
  green = "#98c379",
  orange = "#d19a66",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#61afef",
  red = "#e86671",
}

local vi_mode_colors = {
  NORMAL = colors.green,
  INSERT = colors.red,
  VISUAL = colors.magenta,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.violet,
  ["V-REPLACE"] = colors.violet,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.green,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.yellow,
}

local icons = {
  linux = " ",
  macos = " ",
  windows = " ",

  errs = " ",
  warns = " ",
  infos = " ",
  hints = " ",

  lsp = " ",
  git = "",
}

local function file_osinfo()
  local os = vim.bo.fileformat:upper()
  local icon
  if os == "UNIX" then
    icon = icons.linux
  elseif os == "MAC" then
    icon = icons.macos
  else
    icon = icons.windows
  end
  return icon .. os
end

local function lsp_diagnostics_info()
  return {
    errs = lsp.get_diagnostics_count("Error"),
    warns = lsp.get_diagnostics_count("Warn"),
    infos = lsp.get_diagnostics_count("Info"),
    hints = lsp.get_diagnostics_count("Hint"),
  }
end

local function diag_enable(f, s)
  return function()
    local diag = f()[s]
    return diag and diag ~= 0
  end
end

local function diag_of(f, s)
  local icon = icons[s]
  return function()
    local diag = f()[s]
    return icon .. diag
  end
end

local function vimode_hl()
  return {
    name = vi_mode_utils.get_mode_highlight_name(),
    -- fg = vi_mode_utils.get_mode_color(),
    fg = colors.bg,
    bg = vi_mode_utils.get_mode_color(),
    style = "bold",
  }
end

-- LuaFormatter off
local comps = {
  vi_mode = {
    left = {
      provider = {
        name = "vi_mode",
        opts = {
          show_mode_name = true,
          padding = "center", -- Uncomment for extra padding.
        },
      },
      -- provider = '▊',
      hl = vimode_hl,
      left_sep = "block",
      right_sep = " ",
    },
    right = {
      -- provider = '▊',
      provider = "position",
      hl = vimode_hl,
      left_sep = "block",
      right_sep = "block",
    },
  },
  file = {
    info = {
      provider = "file_info",
      hl = {
        fg = colors.blue,
        style = "bold",
      },
    },
    encoding = {
      provider = "file_encoding",
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
    type = {
      provider = "file_type",
    },
    os = {
      provider = file_osinfo,
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
  },
  line_percentage = {
    provider = "line_percentage",
    left_sep = " ",
    hl = {
      style = "bold",
    },
  },
  scroll_bar = {
    provider = "scroll_bar",
    left_sep = " ",
    right_sep = " ",
    hl = {
      fg = colors.blue,
      style = "bold",
    },
  },
  diagnos = {
    err = {
      provider = diag_of(lsp_diagnostics_info, "errs"),
      left_sep = " ",
      enabled = diag_enable(lsp_diagnostics_info, "errs"),
      hl = {
        fg = colors.red,
      },
    },
    warn = {
      provider = diag_of(lsp_diagnostics_info, "warns"),
      left_sep = " ",
      enabled = diag_enable(lsp_diagnostics_info, "warns"),
      hl = {
        fg = colors.yellow,
      },
    },
    info = {
      provider = diag_of(lsp_diagnostics_info, "infos"),
      left_sep = " ",
      enabled = diag_enable(lsp_diagnostics_info, "infos"),
      hl = {
        fg = colors.blue,
      },
    },
    hint = {
      provider = diag_of(lsp_diagnostics_info, "hints"),
      left_sep = " ",
      enabled = diag_enable(lsp_diagnostics_info, "hints"),
      hl = {
        fg = colors.cyan,
      },
    },
  },
  lsp = {
    name = {
      provider = "lsp_client_names",
      left_sep = " ",
      icon = icons.lsp,
      hl = {
        fg = colors.yellow,
      },
    },
  },
  git = {
    branch = {
      provider = "git_branch",
      icon = icons.git,
      left_sep = " ",
      hl = {
        fg = colors.violet,
        style = "bold",
      },
    },
    add = {
      provider = "git_diff_added",
      hl = {
        fg = colors.green,
      },
    },
    change = {
      provider = "git_diff_changed",
      hl = {
        fg = colors.orange,
      },
    },
    remove = {
      provider = "git_diff_removed",
      hl = {
        fg = colors.red,
      },
    },
  },
}

local properties = {
  force_inactive = {
    filetypes = {
      "NvimTree",
      "packer",
      "^startify$",
      "^fugitive$",
      "^fugitiveblame$",
      "^qf$",
      "help",
    },
    buftypes = {
      "terminal",
    },
    bufnames = {},
  },
  disable = {
    filetypes = {
      "NvimTree",
      "help",
    },
    buftypes = {
      "terminal",
    },
    bufnames = {},
  },
}

-- LuaFormatter on
local components = {
  active = {
    {
      comps.vi_mode.left,
      comps.file.info,
      comps.lsp.name,
    },
    {},
    {
      comps.diagnos.err,
      comps.diagnos.warn,
      comps.diagnos.hint,
      comps.diagnos.info,
      comps.git.add,
      comps.git.change,
      comps.git.remove,
      comps.file.os,
      comps.file.encoding,
      comps.git.branch,
      comps.line_percentage,
      comps.scroll_bar,
      comps.vi_mode.right,
    },
  },
  inactive = {
    {
      comps.vi_mode.left,
      comps.file.info,
    },
    {},
    {},
  },
}

feline.setup({
  default_bg = colors.bg,
  default_fg = colors.fg,
  components = components,
  properties = properties,
  vi_mode_colors = vi_mode_colors,
})
