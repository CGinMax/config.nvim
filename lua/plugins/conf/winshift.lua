-- https://github.com/sindrets/winshift.nvim

local ok, winshift = pcall(require, 'winshift')
if (not ok) then
  require('utils').notifyError('sindrets/winshift load failed!')
  return
end

winshift.setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  },
  -- The window picker is used to select a window while swapping windows with
  -- ':WinShift swap'.
  window_picker = function()
    return require("winshift.lib").picker_window({

   -- A string of chars used as identifiers by the window picker.
    picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    filter_rules = {
      -- This table allows you to indicate to the window picker that a window
      -- should be ignored if its buffer matches any of the following criteria.
      cur_win = true,
      floats = true,
      filetype = {  -- List of ignored file types
        "NvimTree",
      },
      buftype = {   -- List of ignored buftypes
        "terminal",
        "quickfix",
      },
      bufname = {   -- List of regex patterns matching ignored buffer names
        [[.*foo/bar/baz\.qux]]
      },
    },
  })
  end
})
