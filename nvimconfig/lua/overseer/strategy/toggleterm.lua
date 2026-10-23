-- 自定义 toggleterm 策略
-- 让 overseer 使用 toggleterm.nvim 作为终端后端
local log = require("overseer.log")
local util = require("overseer.util")

---@class overseer.ToggletermStrategy : overseer.Strategy
---@field bufnr nil|integer
---@field job_id nil|integer
---@field terminal nil|any
---@field opts table
local ToggletermStrategy = {}

---@class (exact) overseer.ToggletermStrategyOpts
---@field direction? string "horizontal" | "vertical" | "tab" | "float"
---@field size? number
---@field float_opts? table
---@field hidden? boolean

---使用 toggleterm 运行任务
---@param opts nil|overseer.ToggletermStrategyOpts
---@return overseer.Strategy
function ToggletermStrategy.new(opts)
  opts = opts or {}
  local strategy = {
    bufnr = nil,
    job_id = nil,
    terminal = nil,
    opts = opts,
  }
  setmetatable(strategy, { __index = ToggletermStrategy })
  ---@type overseer.ToggletermStrategy
  return strategy
end

function ToggletermStrategy:reset()
  if self.terminal then
    self.terminal:close()
    self.terminal = nil
  end
  self.bufnr = nil
  self.job_id = nil
end

function ToggletermStrategy:get_bufnr()
  return self.bufnr
end

---@param task overseer.Task
function ToggletermStrategy:start(task)
  local Terminal = require("toggleterm.terminal").Terminal

  -- 构建命令字符串
  local cmd_str
  if type(task.cmd) == "table" then
    cmd_str = table.concat(vim.tbl_map(function(arg)
      if arg:match("[%s]") then
        return '"' .. arg:gsub('"', '\\"') .. '"'
      end
      return arg
    end, task.cmd), " ")
  else
    cmd_str = task.cmd
  end

  local on_exit_called = false

  self.terminal = Terminal:new({
    cmd = cmd_str,
    direction = self.opts.direction or "float",
    size = self.opts.size,
    float_opts = self.opts.float_opts,
    on_exit = function(term, job, code)
      on_exit_called = true
      self.job_id = nil
      log.debug("Task %s exited with code %s", task.name, code)
      if vim.v.exiting == vim.NIL then
        task:on_exit(code)
      end
    end,
  })

  self.terminal:toggle()
  self.bufnr = self.terminal.bufnr
end

function ToggletermStrategy:stop()
  if self.terminal then
    self.terminal:close()
  end
end

function ToggletermStrategy:dispose()
  self:stop()
  self.terminal = nil
  util.soft_delete_buf(self.bufnr)
  self.bufnr = nil
end

return ToggletermStrategy
