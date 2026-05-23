# Emacs Configuration (Ubuntu 22.04)

IC design (Verilog/Specman/Dcsh) + C/C++ development environment.

## Structure

```
.emacs                    # Loader: delegates to .emacs.d/init.el
.emacs.d/
  init.el                 # Main configuration
  plugins/                # External tools (verilog-mode, template, syn-keyword)
  elpa/                   # Package manager (MELPA)
  themes/                 # Local themes (dracula, monokai, zenburn)
  fireplace/              # Fireplace effect
  emacs_plugins/          # cmake-mode
```

## Key Bindings

| Key | Function |
|-----|----------|
| `F1` / `C-F1` | Jump to / set bookmark 1 |
| `F2` / `C-F2` | Jump to / set bookmark 2 |
| `F3` | Forward search |
| `S-F3` | Backward search |
| `F4` / `S-F4` | Copy / paste via register `t` |
| `C-F4` | Kill buffer |
| `F5` | Goto line |
| `F6` / `C-F6` | Next window / switch buffer |
| `F7` / `S-F7` | Shell history prev / next |
| `C-F8` | Toggle .cpp <-> .h |
| `F9` / `C-F9` | Query replace / regexp |
| `F10` / `C-F10` | Replace string / regexp |
| `F11` / `S-F11` | Delete other windows / delete window |
| `F12` / `S-F12` | Split vertically / horizontally |
| `C-o` | Open file |
| `C-s` | Save buffer |
| `C-d` | Kill whole line |
| `M-s` | Save (untabify first) |
| `%` | Match paren (VI-style) |

## Language Modes

| Extension | Mode |
|-----------|------|
| `.v` `.sv` `.vh` `.inc` | Verilog |
| `.scr` | DC Shell |
| `.e` `.e3` `.load` | Specman |
| `.pt` `.synopsys_*.setup` | Tcl |
| `.cpp` `.h` `.cu` | C/C++ |
| `.ld` `vfl_*` | C |
| `CMakeLists.txt` `.cmake` | CMake |
| `.proto` | Protobuf |

## Theme

Default: `dracula` (via `load-theme` in `init.el`)

Font: JetBrains Mono 16 (GUI) / 10x20 (terminal)

## Shell Management

- `M-x my-create-device-shells` — Create shells for devices (t41, t40, ...)
- `M-x my-create-numbered-shells` — Create N numbered shells

## Install

```bash
ln -s ~/emacs-ubuntu22.04/.emacs ~/.emacs
ln -s ~/emacs-ubuntu22.04/.emacs.d ~/.emacs.d
```

## Install New Packages

```
M-x package-refresh-contents
M-x package-install RET <package> RET
```
