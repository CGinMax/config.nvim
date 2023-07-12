-- https://github.com/simrat39/symbols-outline.nvim

local status_ok, symbols_outline = pcall(require, "symbols-outline")
if not status_ok then
  require("user.utils").notify_error("simrat39/symbols-outline.nvim load failed!")
  return
end

local icons = require("user.icons")
symbols_outline.setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = "right",
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = "Pmenu",
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { "", "" },
  wrap = false,
  keymaps = {
    -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = icons.kind.File, hl = "@text.uri" },
    Module = { icon = icons.kind.Module, hl = "@namespace" },
    Namespace = { icon = icons.kind.Namespace, hl = "@namespace" },
    Package = { icon = icons.kind.Package, hl = "@namespace" },
    Class = { icon = icons.kind.Class, hl = "@type" },
    Method = { icon = icons.kind.Method, hl = "@method" },
    Property = { icon = icons.kind.Property, hl = "@method" },
    Field = { icon = icons.kind.Field, hl = "@field" },
    Constructor = { icon = icons.kind.Constructor, hl = "@constructor" },
    Enum = { icon = icons.kind.Enum, hl = "@type" },
    Interface = { icon = icons.kind.Interface, hl = "@type" },
    Function = { icon = icons.kind.Function, hl = "@function" },
    Variable = { icon = icons.kind.Variable, hl = "@constant" },
    Constant = { icon = icons.kind.Constant, hl = "@constant" },
    String = { icon = icons.kind.String, hl = "@string" },
    Number = { icon = icons.kind.Number, hl = "@number" },
    Boolean = { icon = icons.kind.Boolean, hl = "@boolean" },
    Array = { icon = icons.kind.Array, hl = "@constant" },
    Object = { icon = icons.kind.Object, hl = "@type" },
    Key = { icon = icons.kind.Key, hl = "@type" },
    Null = { icon = icons.kind.Null, hl = "@type" },
    EnumMember = { icon = icons.kind.EnumMember, hl = "@field" },
    Struct = { icon = icons.kind.Struct, hl = "@type" },
    Event = { icon = icons.kind.Event, hl = "@type" },
    Operator = { icon = icons.kind.Operator, hl = "@operator" },
    TypeParameter = { icon = icons.kind.TypeParameter, hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
})
