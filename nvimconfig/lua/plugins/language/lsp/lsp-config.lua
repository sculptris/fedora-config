return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      clangd = {
        root_markers = {
          "compile_commands.json",
          "CMakeLists.txt",
          "Makefile",
          ".git"
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--pch-storage=memory",
          "--suggest-missing-includes",
          "--enable-config"
        },
        -- 可选：自定义初始化选项
        init_options = {
          compilationDatabasePath = "build",
        },
        -- 可选：设置语言服务器的根目录
        -- root_dir = function(fname)
        --   return vim.fn.finddir("compile_commands.json", vim.fn.dirname(fname) .. "/;") or vim.fn.getcwd()
        -- end,
      },
      jdtls = {},
      ts_ls = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      -- 推荐绑定：使用 `K` 或 `gh`
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, opts)      -- 悬停查看
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)    -- 跳转到定义
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)   -- 跳转到声明
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- 跳转到实现
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)    -- 查找引用
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts) -- 签名帮助
      vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)      -- 重命名
      vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts) -- 代码操作
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- 代码操作（替代）
      vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, opts) -- 格式化

      -- 如果客户端支持文档符号
      if client.server_capabilities.documentSymbolProvider then
        vim.keymap.set('n', 'gS', vim.lsp.buf.document_symbol, opts)
      end

      -- 如果客户端支持工作区符号
      if client.server_capabilities.workspaceSymbolProvider then
        vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, opts)
      end
    end

    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      config.on_attach = on_attach
     -- 使用新方法设置 LSP 服务器
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    -- 自动格式化（可选，建议在保存时格式化）
    --vim.api.nvim_create_autocmd("BufWritePre", {
    --  group = vim.api.nvim_create_augroup("LspFormatting:",{clear=true}),
    --  callback = function()
        -- 检查当前缓冲区是否有 LSP 客户端支持格式化
        -- local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    --    local clients = vim.lsp.get_clients({ bufnr = 0 })

    --    for _, client in ipairs(clients) do
    --      if client.supports_method('textDocument/formatting') then
    --        vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
    --        break
    --      end
    --    end
    --  end,
    --})
  end
}

