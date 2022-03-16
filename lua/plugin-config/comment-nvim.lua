-- https://github.com/numToStr/Comment.nvim

require("Comment").setup(
{
  padding = true,
  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  -- 非VISUAL模式
  toggler = {
    -- 单行:gcc
    line = 'gcc',
    -- 块:gbc
    block = 'gbc',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  -- VISUAL模式
  opleader = {
    -- 单行:gc
    line = 'gc',
    -- 块:gb
    block = 'gb',
  },

  ---LHS of extra mappings
  ---@type table
  extra = {
    -- 在上一行插入注释gcO
    above = 'gcO',
    -- 在下一行插入注释gco
    below = 'gco',
    -- 在行尾插入注释gcA
    eol = 'gcA',
  },

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---@type table
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---Pre-hook, called before commenting the line
  ---@type fun(ctx: Ctx):string
  pre_hook = nil,

  ---Post-hook, called after commenting is done
  ---@type fun(ctx: Ctx)
  post_hook = nil,
}
)
