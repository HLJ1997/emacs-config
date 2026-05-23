# Emacs 配置

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

适用于 Ubuntu 22.04/24.04/26.04 的 Emacs 配置，面向 IC 设计（Verilog / Specman / Dcsh）和 C/C++ 开发环境。

---

## 功能特性

- **IC 设计语言**：Verilog、Specman/e、DC Shell、Tcl
- **C/C++ 开发**：`company-clang` 自动补全，支持 GCC 路径自动检测，`.cpp` ↔ `.h` 快速切换
- **自动补全**：Company 模式，输入即触发（延迟 0.2 秒）
- **主题**：Dracula（GUI），JetBrains Mono 16 号字体
- **CUA 模式**：类 Windows 快捷键 `C-x` 剪切、`C-c` 复制、`C-v` 粘贴
- **Shell 管理**：设备命名 shell 或编号 shell，支持快捷键批量创建
- **模板系统**：C/C++、Verilog、Python、Makefile 等文件模板

---

## 快速开始

```bash
git clone https://github.com/HLJ1997/emacs-config.git ~/emacs-config
ln -sf ~/emacs-config/.emacs ~/.emacs
ln -sf ~/emacs-config/.emacs.d ~/.emacs.d
```

然后启动 Emacs。

---

## 目录结构

```
.emacs                    # 入口文件，加载 .emacs.d/init.el
.emacs.d/
  init.el                 # 主配置文件（约 480 行）
  plugins/                # 外部工具
    verilog-mode.el       # Verilog 编辑模式
    template.el           # 模板系统
    syn-keyword.el        # Synopsys Tcl 关键字
    color-set-*.el        # 配色方案
  elpa/                   # MELPA 包（company、dracula-theme 等）
  themes/                 # 本地主题（dracula、monokai、zenburn）
  fireplace/              # fireplace 特效
  emacs_plugins/          # cmake-mode
```

---

## 快捷键说明

### 文件与缓冲区

| 快捷键 | 功能 |
|--------|------|
| `C-o` | 打开文件 |
| `C-s` | 保存文件 |
| `M-s` | 保存文件（先自动将 Tab 替换为空格） |
| `C-F4` | 关闭当前缓冲区 |
| `M-F4` | 保存所有缓冲区并退出 Emacs |
| `C-f6` | 切换到其他缓冲区 |
| `S-f6` | 打开缓冲区菜单 |
| `f6` | 切换到下一个窗口 |

### 编辑

| 快捷键 | 功能 |
|--------|------|
| `C-d` | 删除整行 |
| `C-<backspace>` | 向后删除一个单词 |
| `C-<delete>` | 向前删除一个单词 |
| `f4` | 将选区复制到寄存器 `t` |
| `S-f4` | 从寄存器 `t` 粘贴 |
| `C-c C-t` | 插入当前日期时间 |
| `%` | VI 风格：光标在括号上时跳转到匹配括号，否则插入 `%` |
| `鼠标右键` | 缓冲区菜单 |

> **CUA 模式** 已启用：`C-x` 剪切、`C-c` 复制、`C-v` 粘贴、`C-z` 撤销、`C-a` 全选。在无选区时，`C-c` / `C-x` / `C-v` 恢复为 Emacs 原生前缀键。

### 导航与搜索

| 快捷键 | 功能 |
|--------|------|
| `f3` | 向前搜索 |
| `S-f3` | 向后搜索 |
| `C-f3` | 向前正则搜索 |
| `C-S-f3` | 向后正则搜索 |
| `f5` | 跳转到指定行 |
| `C-f8` | C++ 源文件与头文件切换（`.cpp` ↔ `.h`） |

### 书签

| 快捷键 | 功能 |
|--------|------|
| `f1` | 跳转到默认书签 1 |
| `C-f1` | 在当前位置设置默认书签 1 |
| `f2` | 跳转到默认书签 2 |
| `C-f2` | 在当前位置设置默认书签 2 |
| `S-f2` | 跳转到任意书签 |
| `S-C-f2` | 设置任意书签 |

### 替换

| 快捷键 | 功能 |
|--------|------|
| `f9` | 交互式替换（逐个确认） |
| `C-f9` | 交互式正则替换 |
| `S-f9` | 用寄存器 `t` 的内容作为搜索词，交互式替换 |
| `f10` | 字符串替换（不确认） |
| `C-f10` | 正则字符串替换 |
| `S-f10` | 用寄存器 `t` 的内容作为搜索词，直接替换 |

### 窗口管理

| 快捷键 | 功能 |
|--------|------|
| `f11` | 关闭其他窗口，最大化当前窗口 |
| `S-f11` | 关闭当前窗口 |
| `f12` | 垂直分割窗口（上下分屏） |
| `S-f12` | 水平分割窗口（左右分屏） |
| `M-f12` | 水平分割窗口（左右分屏） |

### Shell

| 快捷键 | 功能 |
|--------|------|
| `C-c s` | 创建 4 个编号 Shell 缓冲区（`shell-000`、`shell-001`...） |
| `f7` | Shell 中上一条匹配的命令 |
| `S-f7` | Shell 中下一条匹配的命令 |

按一次 `C-c s` 创建 4 个新 shell，多次按压会继续追加（如第二次创建 `shell-004` ~ `shell-007`），自动切换到第一个新创建的 shell。

---

## 语言模式

| 文件扩展名 | 模式 |
|-----------|------|
| `.v` `.sv` `.vh` `.inc` | Verilog |
| `.scr` | DC Shell |
| `.e` `.e3` `.load` `.ecom` `.etst` | Specman |
| `.pt` `.synopsys_*.setup` | Tcl |
| `.cpp` `.h` `.cu` | C/C++ |
| `.ld` `vfl_*` `vflist` | C |
| `CMakeLists.txt` `.cmake` | CMake |
| `.proto` | Protobuf |

---

## 自定义命令

| 命令 | 说明 |
|------|------|
| `M-x my-create-device-shells` | 为设备创建 shell（t41、t40、t33、t32、t23） |
| `M-x my-create-numbered-shells` | 交互式输入数量，创建编号 shell |
| `M-x my-create-next-4-shells` | 基于已有 shell 继续创建 4 个 |
| `M-x switch-source-file` | `.cpp` 与 `.h` 文件切换 |
| `M-x save-buffer-no-tab` | 保存前先替换 Tab 为空格 |
| `M-x insert-current-date-time` | 插入当前日期时间 |
| `M-x desktop-save` | 保存当前会话 |
| `M-x global-font-lock-mode` | 切换语法高亮（打开大文件时可关闭提速） |

---

## 安装新插件

```elisp
M-x package-refresh-contents
M-x package-install RET <插件名> RET
```

或在终端执行：

```bash
emacs --batch --eval "(package-refresh-contents)" --eval "(package-install '<插件名>)"
```

---

## Claude Code Skill

本仓库包含 Claude Code skill，方便在 Claude Code 中快速管理配置：

```bash
ln -sf ~/emacs-config/.claude/skills/emacs-config.md ~/.claude/skills/emacs-config.md
```

在 Claude Code 中输入 `/emacs-config` 即可加载，支持：
- 查看项目结构和常用操作
- 快速编辑 `init.el` 的标准流程
- 添加新快捷键的模板
- 推送到 GitHub 的命令
- 故障排查（启动失败、push 超时、company-clang 问题）

---

## 许可证

[MIT](LICENSE)
