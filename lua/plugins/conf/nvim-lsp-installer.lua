-- https://github.com/williamboman/nvim-lsp-installer

local lsp_installer_servers = require("nvim-lsp-installer.servers")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- WARN: 手动书写 LSP 配置文件
-- 名称：https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- 配置：https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = {
  -- 语言服务器名称：配置选项
  -- sumneko_lua = require("lsp.sumneko_lua"),
  -- clangd = require("lsp.clangd"),
  gopls = require("lsp.gopls"),
  cmake = require("lsp.cmake"),
  html = require("lsp.html"),
  eslint = require("lsp.eslint"),
  volar = require("lsp.volar"),
  tsserver = require("lsp.tsserver"),

  -- pyright = require("lsp.pyright"),
  -- cssls = require("lsp.cssls"),
  -- jsonls = require("lsp.jsonls"),
  -- zeta_note = require("lsp.zeta_note"),
  -- sqls = require("lsp.sqls"),
}

-- 这里是 LSP 服务启动后的按键加载
local function attach(_, bufnr)
  -- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
  vim.keybinds.bmap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>", vim.keybinds.opts)
  -- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
  vim.keybinds.bmap(bufnr, "n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", vim.keybinds.opts)
  -- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
  vim.keybinds.bmap(bufnr, "n", "go", "<cmd>Telescope diagnostics theme=dropdown<CR>", vim.keybinds.opts)
  -- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
  -- remove
  -- vim.keybinds.bmap(bufnr, "n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=dropdown<CR>", vim.keybinds.opts)
  -- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
  vim.keybinds.bmap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", vim.keybinds.opts)
  -- 预览
  vim.keybinds.bmap(bufnr, "n", "gp", "<cmd>Lspsaga preview_definition<CR>", vim.keybinds.opts)
  -- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
  vim.keybinds.bmap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", vim.keybinds.opts)
  -- 查看引用
  vim.keybinds.bmap(bufnr, "n", "gf", "<cmd>Lspsaga lsp_finder<CR>", vim.keybinds.opts)
  -- 查看错误
  vim.keybinds.bmap(bufnr, "n", "gsd", "<cmd>Lspsaga show_line_diagnostics<CR>", vim.keybinds.opts)
  -- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
  vim.keybinds.bmap(bufnr, "n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.keybinds.opts)
  -- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
  vim.keybinds.bmap(bufnr, "n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.keybinds.opts)
  -- 悬浮窗口上翻页，由 Lspsaga 提供
  vim.keybinds.bmap(
  bufnr,
  "n",
  "<C-p>",
  "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
  vim.keybinds.opts
  )
  -- 悬浮窗口下翻页，由 Lspsaga 提供
  vim.keybinds.bmap(
  bufnr,
  "n",
  "<C-n>",
  "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
  vim.keybinds.opts
  )
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved","InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      -- vim.diagnostic.open_float(nil, opts)
    end
  })
end

-- 自动安装或启动 LanguageServers
for server_name, server_options in pairs(servers) do
  local server_available, server = lsp_installer_servers.get_server(server_name)
  -- 判断服务是否可用
  if server_available then
    -- 判断服务是否准备就绪，若就绪则启动服务
    server:on_ready(
    function()
      -- keybind
      server_options.on_attach = attach
      -- options config
      server_options.flags = {
        debounce_text_changes = 150
      }
      -- 代替内置 omnifunc
      server_options.capabilities = capabilities
      -- 启动服务
      server:setup(server_options)
    end
    )
    -- 如果服务器没有下载，则通过 notify 插件弹出下载提示
    if not server:is_installed() then
      vim.notify("Install Language Server : " .. server_name, "WARN", {title = "Language Servers"})
      server:install()
    end
  end
end