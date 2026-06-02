# Emacs Configuration

IC 设计开发环境（Verilog / Specman / Dcsh + C / C++），终端模式，多服务器 SSH 工作流。

## 适用环境

| 项目 | 要求 |
|---|---|
| 操作系统 | Ubuntu 22.04 / 24.04 |
| GCC | GCC 11（自动检测，WSL 也支持） |
| 连接方式 | SSH 终端（`emacs -nw`）或 WSL 本地 |
| Emacs 版本 | 29+（native comp 可选） |

## 快速开始

```bash
git clone https://github.com/HLJ1997/emacs-config.git ~/emacs-config-hlj
ln -sf ~/emacs-config-hlj/.emacs.d ~/.emacs.d
ln -sf ~/emacs-config-hlj/.emacs ~/.emacs
```

首次启动会自动从 MELPA 安装依赖包。

## 依赖

### 系统工具

```bash
sudo apt install gcc fonts-jetbrains-mono fonts-noto-cjk
```

### Emacs 包（MELPA 自动安装）

- `dracula-theme` — 主题
- `company` + `company-clang` — 代码补全
- `diredfl`（可选）— Dired 彩色显示
- `all-the-icons-dired`（可选）— Dired 图标

## 支持的语言/模式

| 语言 | 模式 | 自动识别后缀 |
|---|---|---|
| Verilog | `verilog-mode` | `.v` `.sv` `.svh` `.inc` |
| C / C++ | `c-mode` / `c++-mode` | `.c` `.cpp` `.h` `.cu` |
| CMake | `cmake-mode` | `CMakeLists.txt` `.cmake` |
| Protobuf | `protobuf-mode` | `.proto` |
| Specman | `specman-mode` | `.e` `.e3` `.load` `.ecom` `.etst` |
| Dcsh | `dcsh-mode` | `.scr` |
| Tcl | `tcl-mode` | `.pt` `.synopsys_*_setup` |
| Shell | `shell-script-mode` | `bashrc` `.bashrc` `.cfg` |

## WSL vs 远程服务器

配置文件通过 `/proc/version` 自动检测环境（`my/is-wsl`），行为差异：

| 功能 | WSL 本地 | 远程服务器 |
|---|---|---|
| 终端标题栏（xterm 逃逸码） | 跳过 | `Emacs@主机名 — IP` |
| 启动自动创建 shell | 1 个 `*shell*` | 3 个 `*shell-000*` ~ `*shell-002*` |
| 设备 shell 快捷创建 | 空列表 | `t41 t40 t33 t32 t23` |

## 快捷键

### 编辑

| 快捷键 | 功能 |
|---|---|
| `C-o` | 打开文件 |
| `C-s` | 保存 |
| `C-d` | 删整行 |
| `C-<backspace>` | 向前删词 |
| `C-<delete>` | 向后删词 |
| `M-s` | 保存并 tab→space |
| `C-c C-t` | 插入日期时间 |
| `C-=` / `C--` | 放大/缩小字体 |

### 窗口

| 快捷键 | 功能 |
|---|---|
| `f6` | 切换窗口 |
| `C-f6` | 切换 buffer |
| `S-f6` | buffer 列表 |
| `f11` | 最大化当前窗口 |
| `S-f11` | 关闭当前窗口 |
| `f12` / `S-f12` | 垂直/水平分屏 |
| `C-c ←/→` | undo/redo 窗口布局 |

### 搜索 & 替换

| 快捷键 | 功能 |
|---|---|
| `f3` / `S-f3` | 向前/向后搜索 |
| `f9` / `C-f9` | 查询替换 / 正则替换 |
| `f10` / `C-f10` | 字符串替换 / 正则替换 |
| `S-f9` / `S-f10` | 用寄存器的内容替换 |

### 代码

| 快捷键 | 功能 |
|---|---|
| `C-f8` | `.cpp` ↔ `.h` 切换 |
| `M-/` | 触发补全 |
| `f5` | 跳转到行 |

### Shell

| 快捷键 | 功能 |
|---|---|
| `S-f7` / `f7` | shell 历史向前/向后匹配 |
| `C-c s` | 新建 4 个 shell buffer |

## Shell 工作流

关于工作流的建议：当 SSH 连接到不同服务器时，可以在各 shell buffer 内手动执行 SSH 命令。例如：

- `*shell-000*` → `ssh t41`
- `*shell-001*` → `ssh t40`
- 依此类推

（在 WSL 本地使用时只有一个 `*shell*` buffer。）

## 目录结构

```
~/.emacs.d/ -> emacs-config-hlj/.emacs.d/
  init.el              # 主配置
  custom.el            # Customize 自动生成的变量
  plugins/             # 本地插件（verilog-mode, dcsh-mode 等）
  themes/              # 主题文件
  template/            # 新建文件模板
  elpa/                # MELPA 安装的包（自动生成）
```
