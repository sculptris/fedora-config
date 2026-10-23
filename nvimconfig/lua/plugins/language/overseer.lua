return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  init = function()
    --vim.keymap.set("n", "<Leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Togger overseer task list" })
    --vim.keymap.set("n", "<Leader>tr", "<cmd>OverseerRun<cr>", { desc = "List overseer run templates" })
    vim.keymap.set("n", "<Leader>tg", "<cmd>OverseerToggle<cr>", { desc = "Togger overseer task list" })
    vim.keymap.set("n", "<Leader>rn", "<cmd>OverseerRun<cr>", { desc = "Togger overseer task list" })
  end,
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    local overseer = require('overseer')
    overseer.setup({
      dap = true,
      templates = { "make", "shell", "user.run_script" },
    })

    -- 为所有任务添加 toggleterm 策略
    overseer.add_template_hook(
      {},
      function(task_defn, util)
        task_defn.strategy = {
          "toggleterm",
          direction = "float",
        }
        util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
      end
    )
  end

}
