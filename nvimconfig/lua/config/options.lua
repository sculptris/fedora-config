-- ============================================
-- 行号设置
-- ============================================
vim.opt.number = true          -- 显示绝对行号
vim.opt.relativenumber = true  -- 显示相对行号（当前行显示绝对行号）
 
-- ============================================
-- Tab 和缩进设置
-- ============================================
vim.opt.tabstop = 2            -- Tab 键 = 2 个空格宽度
vim.opt.shiftwidth = 2         -- 自动缩进 = 2 个空格
vim.opt.expandtab = true       -- Tab 键自动转换为空格
vim.opt.smartindent = true     -- 智能缩进（新行自动继承上一行缩进）
vim.opt.autoindent = true      -- 自动缩进
 
-- ============================================
-- 其他常用设置
-- ============================================
vim.opt.wrap = false           -- 不换行
vim.opt.scrolloff = 8          -- 光标距离屏幕边缘至少 8 行
vim.opt.cursorline = true      -- 高亮当前行
vim.opt.signcolumn = "yes"     -- 始终显示符号列（防止 LSP 图标出现时跳动）
vim.opt.termguicolors = true   -- 启用真彩色\
 
-- ============================================
-- 搜索设置
-- ============================================
vim.opt.ignorecase = true      -- 搜索时忽略大小写
vim.opt.smartcase = true       -- 如果搜索词包含大写字母，则区分大小写
vim.opt.hlsearch = true        -- 高亮搜索结果
vim.opt.incsearch = true       -- 搜索时实时高亮
 
-- ============================================
-- 分割窗口设置
-- ============================================
vim.opt.splitright = true      -- 垂直分割窗口在右侧
vim.opt.splitbelow = true      -- 水平分割窗口在下方
 
-- ============================================
-- 剪贴板设置
-- ============================================
vim.opt.clipboard = "unnamedplus"  -- 使用系统剪贴板
 
-- ============================================
-- 备份和撤销
-- ============================================
vim.opt.backup = false         -- 不创建备份文件
vim.opt.writebackup = false    -- 不创建写入备份
vim.opt.undofile = true        -- 启用持久化撤销
vim.opt.undolevels = 10000     -- 撤销级别
 
-- ============================================
-- 性能设置
-- ============================================
vim.opt.updatetime = 200       -- 降低更新延迟（默认 4000ms）
vim.opt.timeoutlen = 500       -- 快捷键超时时间（毫秒）
vim.opt.ttimeoutlen = 10       -- 按键超时时间（毫秒）

-- ============================================
-- 代码错误显示配置
-- ============================================
vim.diagnostic.config({
  virtual_text = true,        -- 显示行尾错误提示（如 ❌ Unused variable）
  signs = true,               -- 在左侧显示图标（✔️/❌）
  underline = true,           -- 波浪线下划线标出错误
  update_in_insert = false,   -- 插入模式时不更新
  severity_sort = false,      -- 按严重性排序
})

-- ============================================
-- 额外配置
-- ============================================
vim.api.nvim_set_hl(0,'Normal',{bg='none'})
vim.api.nvim_set_hl(0,'NormalFloat',{bg='NONE'})
vim.api.nvim_set_hl(0,'BlinkCmpSignatureHelp',{bg='NONE'})


