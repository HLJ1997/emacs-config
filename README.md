# Emacs Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IC design (Verilog / Specman / Dcsh) + C/C++ development environment for Emacs on Ubuntu 22.04.

---

## Features

- **IC Design Languages**: Verilog, Specman/e, DC Shell, Tcl
- **C/C++ Development**: `company-clang` with GCC 11 include paths, `.cpp` <-> `.h` toggle
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

| Key | Function |
|-----|----------|
| `F1` / `C-F1` | Jump to / set bookmark 1 |
| `F2` / `C-F2` | Jump to / set bookmark 2 |
| `F3` / `S-F3` | Forward / backward search |
| `C-F3` / `C-S-F3` | Forward / backward regexp search |
| `F4` / `S-F4` | Copy / paste via register `t` |
| `C-F4` | Kill buffer |
| `F5` | Goto line |
| `F6` / `C-F6` | Next window / switch buffer |
| `F7` / `S-F7` | Shell history previous / next |
| `C-F8` | Toggle `.cpp` <-> `.h` |
| `F9` / `C-F9` | Query replace / regexp |
| `F10` / `C-F10` | Replace string / regexp |
| `F11` / `S-F11` | Delete other windows / delete window |
| `F12` / `S-F12` | Split vertically / horizontally |
| `C-o` | Open file |
| `C-s` | Save buffer |
| `C-d` | Kill whole line |
| `M-s` | Save (untabify first) |
| `%` | Match paren (VI-style) |
| `C-c s` | Create numbered shells |
| `mouse-3` | Buffer menu |

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
| `M-x my-create-numbered-shells` | Create N numbered shell buffers |
| `M-x switch-source-file` | Toggle between `.cpp` and `.h` |
| `M-x save-buffer-no-tab` | Save file (replace tabs with spaces first) |
| `M-x insert-current-date-time` | Insert current timestamp |
| `M-x desktop-save` | Save current session |

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
