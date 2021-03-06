-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local lsp_bin_path = vim.fn.stdpath "data" .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
return {
  -- 比如这里修改成了中文提示信息，具体语言服务器是否支持中文提示还需要查看该语言服务器的配置项
  cmd = {lsp_bin_path, "--locale=zh-CN"},
  filetypes = {"lua"},
  log_level = 2,
  -- 再比如我将该服务器的工作域范围改成了当前所在目录的工作区，避免了重复运行多个同样的语言服务器的问题
  root_dir = function()
    return vim.fn.getcwd()
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      },
    },
  },
}
