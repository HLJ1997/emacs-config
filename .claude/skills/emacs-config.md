---
name: emacs-config
description: Manage the Emacs configuration project (~/emacs-config). Edit init.el, add keybindings, push to GitHub, and troubleshoot.
---

Work with the Emacs configuration project at `~/emacs-config`.

## Project Layout

```
~/emacs-config/
  .emacs              # 2-line loader
  .emacs.d/
    init.el           # Main config (~480 lines)
    plugins/          # External tools (verilog-mode, template, syn-keyword)
    elpa/             # MELPA packages
    themes/           # dracula, monokai, zenburn
    fireplace/        # fireplace.el
    emacs_plugins/    # cmake-mode
  .gitignore
  LICENSE
  README.md
```

Soft links:
- `~/.emacs` → `~/emacs-config/.emacs`
- `~/.emacs.d` → `~/emacs-config/.emacs.d`

Remote: `git@github.com:HLJ1997/emacs-config.git` (SSH)

## Common Operations

### Edit init.el

1. Read the relevant section first.
2. Make the edit.
3. Verify the change: `sed -n '<start>,<end>p' ~/emacs-config/.emacs.d/init.el`
4. Stage, commit, and push:
   ```bash
   cd ~/emacs-config
   git add .emacs.d/init.el
   git commit -m "<message>"
   git push origin main
   ```

### Add a New Keybinding

1. Define the function (if needed) in the **Custom Functions** section.
2. Bind it in the **Key Bindings** section using `global-set-key`.
3. Update `README.md` if the binding is user-facing.
4. Commit and push.

Example pattern:
```elisp
(defun my-new-command ()
  "Description."
  (interactive)
  ...)

(global-set-key (kbd "C-c x") 'my-new-command)
```

### Push to GitHub

```bash
cd ~/emacs-config
git status
git add -A
git commit -m "<message>"
git push origin main
```

If push fails with connection timeout, use SSH (port 22 is usually open):
```bash
git remote -v
# Should show: git@github.com:HLJ1997/emacs-config.git
```

### Backup Before Major Changes

```bash
cp -r ~/emacs-config ~/.emacs-config.bak.$(date +%Y%m%d_%H%M%S)
```

### Check Current Keybindings

```bash
grep -n "global-set-key" ~/emacs-config/.emacs.d/init.el
```

### Install a New Package

From within Emacs:
```
M-x package-refresh-contents
M-x package-install RET <package-name> RET
```

Then add the package setup to `init.el` and push.

## Troubleshooting

**Emacs fails to start:**
- Check `~/.emacs` is a valid symlink: `ls -la ~/.emacs`
- Start Emacs with debug: `emacs --debug-init`
- Check `*Messages*` buffer for errors

**Git push timeout (port 443 blocked):**
- Ensure remote is SSH: `git remote set-url origin git@github.com:HLJ1997/emacs-config.git`
- Verify SSH key: `ssh -T git@github.com`

**company-clang not working:**
- Check `gcc` is installed: `gcc --version`
- The config auto-detects GCC include paths. If detection fails, it falls back to Ubuntu 22.04 GCC 11 hardcoded paths.
- On a different Ubuntu/GCC version, install the matching `gcc` and `libclang-dev` packages.
