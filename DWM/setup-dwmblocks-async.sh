#!/bin/bash
# dwmblocks-async 安装和配置脚本

set -e

DWMBLOCKS_DIR="$HOME/.config/DWM/dwmblocks"
BACKUP_DIR="$DWMBLOCKS_DIR/backup-$(date +%Y%m%d-%H%M%S)"

echo "=== dwmblocks-async 安装脚本 ==="

# 1. 备份当前配置
echo "[1/6] 备份当前配置..."
mkdir -p "$BACKUP_DIR"
cp -r "$DWMBLOCKS_DIR"/* "$BACKUP_DIR/" 2>/dev/null || true
echo "      备份到：$BACKUP_DIR"

# 2. 下载 dwmblocks-async
echo "[2/6] 下载 dwmblocks-async..."
if [ -d /tmp/dwmblocks-async ]; then
    rm -rf /tmp/dwmblocks-async
fi
git clone --depth 1 https://github.com/UtkarshVerma/dwmblocks-async.git /tmp/dwmblocks-async

# 3. 替换源码
echo "[3/6] 替换源码..."
cp /tmp/dwmblocks-async/dwmblocks.c "$DWMBLOCKS_DIR/"
cp /tmp/dwmblocks-async/config.h "$DWMBLOCKS_DIR/"
cp /tmp/dwmblocks-async/Makefile "$DWMBLOCKS_DIR/"

# 4. 生成 config.h
echo "[4/6] 生成 config.h..."
cat > "$DWMBLOCKS_DIR/config.h" << 'EOF'
#ifndef CONFIG_H
#define CONFIG_H

// dwmblocks-async 配置
// 格式：X(图标，命令，更新间隔，信号)
// 更新间隔：0 = 不自动更新（仅信号触发）

#define BLOCKS(X)             \
    X(" ", "sb-volume", 0, 1)      \
    X(" ", "sb-ram-usage -p", 2, 2) \
    X(" ", "sb-cpu-usage 2", 2, 3)  \
    X(" ", "sb-battery-status", 60, 4) \
    X(" ", "sb-wifi", 10, 5)        \
    X(" ", "sb-datetime", 5, 6)

// 分隔符
static const char *delim = " | ";

// 最大输出长度
#define MAX_BLOCK_OUTPUT_LENGTH 128

// 是否启用点击（需要 dwm statuscmd 补丁）
#define CLICKABLE_BLOCKS 0

// 前导/尾随分隔符
#define LEADING_DELIMITER 0
#define TRAILING_DELIMITER 0

#endif  // CONFIG_H
EOF

# 5. 编译安装
echo "[5/6] 编译安装..."
cd "$DWMBLOCKS_DIR"
make clean
make
sudo make install

# 6. 重启 dwmblocks
echo "[6/6] 重启 dwmblocks..."
killall dwmblocks 2>/dev/null || true
sleep 1
dwmblocks &

echo ""
echo "=== 安装完成 ==="
echo "备份位置：$BACKUP_DIR"
echo ""
echo "如需恢复原版，运行："
echo "  cd $BACKUP_DIR && sudo make install && killall dwmblocks && dwmblocks &"
