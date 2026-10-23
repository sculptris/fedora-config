return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'xzbdmw/colorful-menu.nvim', opts = {} },
  },
  event = { 'BufReadPost', 'BufNewFile' },
  version = '1.*',
  opts = {
    completion = {
      menu = {
        winblend = 20,  -- 完全透明
        -- draw = {
        --   columns = {
        --     { "label", "label_description", gap = 1 },
        --     { "kind_icon", "kind" }
        --   },
        --   components = {
        --     label = {
        --       text = function(ctx)
        --         return require('colorful-menu').blink_components_text(ctx)
        --       end,
        --       highlight = function(ctx)
        --         return require('colorful-menu').blink_components_highlight(ctx)
        --       end
        --     }
        --   }
        -- }
      },
      documentation = {
        auto_show = true,
      },
    },
    signature = {
      enabled = false,
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = 'none',  -- 禁用边框测试
        winblend = 100,
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        scrollbar = false,
        direction_priority = { 'n', 's' },
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
    cmdline = {
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
    keymap = {
      preset = 'default',
      ['<C-enter>'] = { 'select_and_accept' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      -- disable a keymap from the preset
      ['<C-e>'] = false, -- or {}
    }
  },
}

