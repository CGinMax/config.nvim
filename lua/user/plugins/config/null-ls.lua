-- https://github.com/jose-elias-alvarez/null-ls.nvim
local ok, null_ls = pcall(require, 'null-ls')
if (not ok) then
  require('user.utils').notify_error('jose-elias-alvarez/null-ls.nvim')
  return
end

-- https://github.com/jay-babu/mason-null-ls.nvim
local status_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if (not status_ok) then
  require('user.utils').notify_error('jay-babu/mason-null-ls.nvim')
  return
end

mason_null_ls.setup({
  ensure_installed = { 'stylua', 'jq'},
  automatic_installation = false,
  handlers = {
    function(source_name, methods)
      -- all sources with no handler get passed here

      -- To keep the original functionality of `automatic_setup = true`,
      -- please add the below.
      require('mason-null-ls.automatic_setup')(source_name, methods)
    end,
    stylua = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
  },
})

local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local event = 'BufWritePre' -- or 'BufWritePost'
local async = event == 'BufWritePost'

null_ls.setup({
  sources = {
    -- format
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.cmake_format,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.buf, -- protobuf
    null_ls.builtins.formatting.shfmt,

    -- completion
    null_ls.builtins.completion.spell,
    
    -- code actions
    null_ls.builtins.code_actions.gomodifytags, -- go code_actions
    null_ls.builtins.code_actions.impl, -- go code_actions
    null_ls.builtins.code_actions.eslint,

    -- diagnostics
    null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.diagnostics.prettier,
    -- cpp
    null_ls.builtins.diagnostics.clang_check, 
    -- Qt-oriented static code analyzer based on the Clang framework
    -- null_ls.builtins.diagnostics.clazy,
    -- null_ls.builtins.diagnostics.cppcheck,
  },
  -- on_attach = function(client, bufnr)
  --   if client.supports_method('textDocument/formatting') then
  --     vim.keymap.set('n', '<Leader>f', function()
  --       vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --     end, { buffer = bufnr, desc = '[lsp] format' })
  --
  --     -- format on save
  --     vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
  --     vim.api.nvim_create_autocmd(event, {
  --       buffer = bufnr,
  --       group = group,
  --       callback = function()
  --         vim.lsp.buf.format({ bufnr = bufnr, async = async })
  --       end,
  --       desc = '[lsp] format on save',
  --     })
  --   end
  --
  --   if client.supports_method('textDocument/rangeFormatting') then
  --     vim.keymap.set('x', '<Leader>f', function()
  --       vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
  --     end, { buffer = bufnr, desc = '[lsp] format' })
  --   end
  -- end,
})
