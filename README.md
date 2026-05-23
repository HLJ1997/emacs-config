# Emacs Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IC design (Verilog / Specman / Dcsh) + C/C++ development environment for Emacs on Ubuntu 22.04/24.04/26.04.

---

## Features

- **IC Design Languages**: Verilog, Specman/e, DC Shell, Tcl
- **C/C++ Development**: `company-clang` with auto-detected GCC include paths, `.cpp` <-> `.h` toggle
- **Auto-Complete**: Company mode with immediate trigger (`company-idle-delay: 0.2s`)
- **Theme**: Dracula (GUI), with JetBrains Mono 16 font
- **CUA Mode**: Windows-style `C-x` / `C-c` / `C-v` editing keys
- **Shell Management**: Named shells for devices (`t41`, `t40`...) or numbered shells
- **Template System**: File templates for C/C++, Verilog, Python, Makefile...

---

## Quick Start

```bash
git clone https://github.com/HLJ1997/emacs-config.git ~/emacs-config
ln -sf ~/emacs-config/.emacs ~/.emacs
ln -sf ~/emacs-config/.emacs.d ~/.emacs.d
```

Then launch Emacs.

---

## Directory Structure

```
.emacs                    # Loader (delegates to .emacs.d/init.el)
.emacs.d/
  init.el                 # Main configuration (~480 lines)
  plugins/                # External tools
    verilog-mode.el
    template.el + template/
    syn-keyword.el
    color-set-*.el
  elpa/                   # MELPA packages (company, dracula-theme, ...)
  themes/                 # Local themes (dracula, monokai, zenburn)
  fireplace/              # fireplace.el
  emacs_plugins/          # cmake-mode.el
```

---

## Key Bindings

### File & Buffer Operations

| Key | Function |
|-----|----------|
| `C-o` | Open file (`find-file`) |
| `C-s` | Save buffer |
| `M-s` | Save buffer (replace tabs with spaces first) |
| `C-F4` | Kill current buffer |
| `M-F4` | Save all buffers and exit Emacs |
| `C-f6` | Switch to another buffer |
| `S-f6` | Open buffer menu |
| `f6` | Switch to next window |

### Editing

| Key | Function |
|-----|----------|
| `C-d` | Kill whole line |
| `C-<backspace>` | Delete word backward |
| `C-<delete>` | Delete word forward |
| `f4` | Copy region to register `t` |
| `S-f4` | Paste from register `t` |
| `C-c C-t` | Insert current date & time |
| `%` | Jump to matching parenthesis (VI-style), or insert `%` |
| `mouse-3` | Buffer menu (right click) |

> **CUA Mode** is enabled: `C-x` cut, `C-c` copy, `C-v` paste, `C-z` undo, `C-a` select all. Outside a selection, `C-c` / `C-x` / `C-v` revert to standard Emacs prefix behavior.

### Navigation & Search

| Key | Function |
|-----|----------|
| `f3` | Forward search (`isearch-forward`) |
| `S-f3` | Backward search |
| `C-f3` | Forward regexp search |
| `C-S-f3` | Backward regexp search |
| `f5` | Goto line |
| `C-f8` | Toggle between `.cpp` and `.h` file |

### Bookmark

| Key | Function |
|-----|----------|
| `f1` | Jump to bookmark 1 (`default-bookmark1`) |
| `C-f1` | Set bookmark 1 at current position |
| `f2` | Jump to bookmark 2 (`default-bookmark2`) |
| `C-f2` | Set bookmark 2 at current position |
| `S-f2` | Jump to any bookmark |
| `S-C-f2` | Set any bookmark |

### Replace

| Key | Function |
|-----|----------|
| `f9` | Query replace |
| `C-f9` | Query replace with regexp |
| `S-f9` | Query replace using register `t` content |
| `f10` | Replace string |
| `C-f10` | Replace string with regexp |
| `S-f10` | Replace string using register `t` content |

### Window Management

| Key | Function |
|-----|----------|
| `f11` | Delete other windows (maximize current) |
| `S-f11` | Delete current window |
| `f12` | Split window vertically (top / bottom) |
| `S-f12` | Split window horizontally (left / right) |
| `M-f12` | Split window horizontally (left / right) |

### Shell

| Key | Function |
|-----|----------|
| `C-c s` | Create 4 new numbered shell buffers (`shell-000`, `shell-001`...) |
| `f7` | Previous matching shell command |
| `S-f7` | Next matching shell command |

Press `C-c s` multiple times to create more shells. Each press adds 4 new shells continuing from the highest existing number. Automatically switches to the first newly created shell.

---

## Language Modes

| Extension | Mode |
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

## Custom Commands

| Command | Description |
|---------|-------------|
| `M-x my-create-device-shells` | Create shells for devices (t41, t40, t33, t32, t23) |
| `M-x my-create-numbered-shells` | Create N numbered shell buffers (interactive) |
| `M-x my-create-next-4-shells` | Create 4 numbered shells continuing from existing ones |
| `M-x switch-source-file` | Toggle between `.cpp` and `.h` |
| `M-x save-buffer-no-tab` | Save file (replace tabs with spaces first) |
| `M-x insert-current-date-time` | Insert current timestamp |
| `M-x desktop-save` | Save current session |
| `M-x global-font-lock-mode` | Toggle syntax highlighting (useful for large files) |

---

## Installing New Packages

```elisp
M-x package-refresh-contents
M-x package-install RET <package> RET
```

Or from terminal:

```bash
emacs --batch --eval "(package-refresh-contents)" --eval "(package-install '<package-name>)"
```

---

## License

[MIT](LICENSE)
