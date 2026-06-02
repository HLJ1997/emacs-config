# Emacs 主题使用指南

## 快速开始

| 操作 | 快捷键 | 说明 |
|------|--------|------|
| 切换主题 | `C-c t` | 模糊搜索选主题，实时预览 |
| 增大字体 | `C-=` | 每次 +10pt |
| 缩小字体 | `C--` | 每次 -10pt |

---

## 主题目录（34 个精选）

> ★ = 个人推荐    ◆ = 经典流行    ☀ = 亮色主题

### Dracula 系列

| 主题名 | 标签 | 风格 |
|--------|------|------|
| **Dracula** | ★ | 紫/绿暗色，经典吸血鬼配色 |

### Doom 系列（来自 Doom Emacs）

#### 头牌推荐

| 主题名 | 标签 | 风格 |
|--------|------|------|
| **Doom One** | ★◆ | Doom Emacs 标志，深蓝背景 + 鲜艳高亮 |
| **Doom Tokyo Night** | ★ | 当前默认。VSCode Tokyo Night 移植，柔和蓝紫 |
| **Doom Monokai Pro** | ◆ | Sublime Text 经典，高对比暖色调 |

#### 暗色系

| 主题名 | 风格描述 |
|--------|----------|
| Doom Molokai | Vim 社区经典，绿/橙/粉 |
| Doom Nord | 北极蓝灰，极简冷静 |
| Doom Palenight | Material Palenight，紫蓝调 |
| Doom Snazzy | 霓虹色，艳丽大胆 |
| Doom Vibrant | 高饱和度，色彩丰富 |
| Doom Horizon | VSCode Horizon 移植，暖橙暗底 |
| Doom Oceanic Next | 海洋蓝绿，柔和护眼 |
| Doom Material | Material Design 风格 |
| Doom Solarized Dark | Ethan Schoonover 经典，低对比护眼 |
| Doom Spacegrey | 太空灰，简约现代 |
| Doom Outrun Electric | 赛博朋克/合成波，紫粉霓虹 |
| Doom Laserwave | 霓虹紫 + 粉，Retrowave |
| Doom Moonlight | 月光蓝，深色柔和 |
| Doom Challenger Deep | 深海蓝，低饱和度 |
| Doom Dark+ | VSCode 默认暗色 |
| Doom Henna | 印度红暖色调 |
| Doom Pine | Pine 配色方案 |
| Doom Dracula | Doom 版 Dracula |

#### 亮色系 ☀

| 主题名 | 风格描述 |
|--------|----------|
| Doom One Light | Doom One 亮色版 |
| Doom Flatwhite | 纯白简约 |
| Doom Solarized Light | Solarized 亮色版 |
| Doom Acario Light | 暖白柔和 |

### Nord 系列

| 主题名 | 标签 | 风格 |
|--------|------|------|
| **Nord** | ★ | 北极色系，蓝灰冰冷感，极简 |

### Gruvbox 系列

| 主题名 | 标签 | 风格 |
|--------|------|------|
| **Gruvbox Dark** | ◆ | Vim 社区神级主题，复古暖色（红/橙/黄/绿） |
| Gruvbox Light ☀ | | 亮色版 |

### Spacemacs 系列

| 主题名 | 风格 |
|--------|------|
| Spacemacs Dark | 现代简洁，紫/蓝强调 |
| Spacemacs Light ☀ | 亮色版 |

### 经典独立

| 主题名 | 标签 | 风格 |
|--------|------|------|
| **Zenburn** | ◆ | 低对比护眼，黄/绿暖色，20 年老牌 |
| **Solarized Dark** | ◆ | 精确色彩科学，16 色调色板 |
| Solarized Light ☀ | | 亮色版 |
| **Monokai** | ◆ | 最著名编程主题，高对比暖色 |

---

## 切换主题（3 种方式）

### 方式一：快捷键（推荐）

```
C-c t  →  输入主题名（模糊匹配）→ 回车
```

Emacs 会禁用当前主题，加载新主题，即时生效。

### 方式二：M-x 命令

```
M-x my-switch-theme
```

### 方式三：永久更改默认

编辑 `~/.emacs.d/lisp/init-ui.el`，找到末尾这行：

```elisp
;; Default theme
(my/load-theme 'doom-tokyo-night)
```

改成你想要的主题名（从上方表格中取 symbol 名），例如：

```elisp
(my/load-theme 'doom-one)        ; Doom One
(my/load-theme 'gruvbox)         ; Gruvbox Dark
(my/load-theme 'nord)            ; Nord
(my/load-theme 'zenburn)         ; Zenburn
```

然后重启 Emacs 或执行 `M-x eval-buffer`。

---

## 安装新主题

Emacs 已配置 MELPA 源。安装新主题只需：

```
M-x package-install RET 主题包名 RET
```

推荐一些还没装但值得一试的：

| 包名 | 描述 |
|------|------|
| `kaolin-themes` | 20+ 眼球糖系列（ocean, valley, light...） |
| `cyberpunk-theme` | 纯正赛博朋克 |
| `material-theme` | Material Design 原版 |
| `afternoon-theme` | 午后暖光 |
| `leuven-theme` | 学术论文风格，高可读性 |
| `ef-themes` | Emacs 28+ 内置，高对比无障碍 |

安装后，在 `init-ui.el` 的 `my/themes` 列表中加入对应条目即可使用。

---

## Grubvbox
```
sudo apt install fonts-firacode
```
### 主题自行配置目录位置

```
~/.doom.d/init-ui.el
```
---

## 故障排查

| 问题 | 解决 |
|------|------|
| 主题加载报错 | `M-x package-install RET 包名 RET` 确保已安装 |
| 两个主题叠加 | `M-x disable-theme` 手动禁用 |
| 终端 Emacs 颜色不对 | 终端只支持 256 色，部分主题效果打折扣 |
| 字体模糊 | `M-x customize-face RET default RET` 手动调整字体 |

---

*文档自动生成于 Emacs 配置重构，最后更新 2026-06-02*
