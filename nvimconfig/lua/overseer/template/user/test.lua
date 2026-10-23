-- 一个“强制”使用 toggleterm 的测试任务
return {
  name = "🔧 [测试] ToggleTerm强制弹窗",
  builder = function()
    return {
      -- 一个简单的交互式命令
      cmd = { "bash", "-c" },
      args = {
        [[
          echo "======================================="
          echo "✅ 如果配置正确，你现在应该在一个"
          echo "   ToggleTerm 浮动终端窗口中！"
          echo "======================================="
          echo ""
          read -p "👋 请输入任意内容测试输入: " input
          echo ""
          echo "🎉 你输入了: $input"
          echo ""
          echo "按任意键关闭这个窗口..."
          read -n 1
        ]]
      },
      -- ！！！关键：在这里显式指定策略，使用 toggleterm 浮动窗口！！！
      strategy = {
        "toggleterm",
        direction = "float",
      },
    }
  end
}
