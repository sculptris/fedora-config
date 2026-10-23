return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = 80,
          height = 20,
        },
      })
      -- 快捷键：选择终端
      vim.keymap.set("n", "<Leader>ts", "<cmd>TermSelect<CR>", { desc = "Select ToggleTerm" })
    end,
  }
}
