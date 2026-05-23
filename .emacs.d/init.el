;;; init.el --- Emacs Configuration

;;; Commentary:
;; IC design (Verilog/Specman/Dcsh) + C/C++ development environment
;; Optimized for Ubuntu 22.04 with GCC 11

;;; Code:

;; =================================================================
;; Package Management
;; =================================================================
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; =================================================================
;; External Tools (from old config)
;; =================================================================
(defconst ENV_EMACS_DIR (expand-file-name "plugins/" user-emacs-directory))
(add-to-list 'load-path ENV_EMACS_DIR)

;; =================================================================
;; Basic Behavior
;; =================================================================

;; Startup
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq auto-save-mode nil)

;; Clipboard integration
(setq x-select-enable-clipboard t)
(setq mouse-yank-at-point t)

;; History
(setq history-length 500)
(setq comint-input-ignoredups t)
(setq comint-input-ring-size 500)
(setq comint-completion-fignore '("~" "#" "%" ".o"))
(setq shell-completion-fignore '("~" "#" "%" ".o"))
(setq comint-completion-autolist nil)

;; Line behavior
(setq next-line-add-newlines nil)
(setq kill-ring-max 200)
(setq line-number-display-limit 500000)

;; Font lock limits for large files
(setq font-lock-maximum-size
      '((c-mode . 256000)
        (c++-mode . 256000)
        (verilog-mode . 1024000)))

;; Other
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(auto-compression-mode)

;; Force English date/time format
(setq system-time-locale "C")

;; Auto-display images
(auto-image-file-mode t)

;; =================================================================
;; CUA Mode (Windows-style editing keys)
;; =================================================================
(cua-mode t)

;; =================================================================
;; Appearance
;; =================================================================

;; Time display
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-format "%m-%d  %A %H:%M")
(display-time)

;; UI elements
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode 1))
(column-number-mode t)
(global-display-line-numbers-mode t)
(temp-buffer-resize-mode 1)

;; Editing helpers
(show-paren-mode 1)
(electric-pair-mode t)
(global-auto-revert-mode t)

;; Cursor
(set-cursor-color "#00ff00")
(blink-cursor-mode 0)

;; Font
(when (display-graphic-p)
  (condition-case nil
      (set-face-attribute 'default nil :font "JetBrains Mono-16")
    (error (message "Failed to set JetBrains Mono font, using default."))))

;; Color theme
(setq ansi-color-names-vector
      ["black" "tomato" "PaleGreen2" "gold1"
       "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])
(load-theme 'dracula t)

;; =================================================================
;; Desktop Session
;; =================================================================
(require 'desktop)
(desktop-read)

;; =================================================================
;; Tab / Indent Configuration
;; =================================================================
(setq default-tab-width 4)
(setq tab-width 4)
(setq indent-tabs-mode t)

;; C/C++ style
(setq c-basic-offset 4)
(setq c-indent-level 4)

(defvar my-c-style
  '((c-backslash-column . 7)
    (innamespace . 0)
    (namespace-close . 0)))

(defconst my-cobbcpp-style
  '("linux"
    (c-basic-offset . 4)
    (c-offsets-alist . ((innamespace . [0])))))

(c-add-style "cobbcpp" my-cobbcpp-style)

(defun my-c-cpp-hook ()
  "Custom hook for C/C++ modes."
  (c-set-style "cobbcpp")
  (setq indent-tabs-mode nil)
  (setq default-tab-width 4)
  (setq tab-width 4)
  (global-hl-line-mode t))

(add-hook 'c++-mode-hook 'my-c-cpp-hook)
(add-hook 'c-mode-hook 'my-c-cpp-hook)

;; =================================================================
;; Language Modes
;; =================================================================

;; CMake
(autoload 'cmake-mode "cmake-mode" "CMake mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;; Protobuf
(autoload 'protobuf-mode "protobuf-mode" "protobuf mode" t)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;; Verilog
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
(add-to-list 'auto-mode-alist '("\\.v\\'" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.s?vh?\\'" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . verilog-mode))
(setq verilog-auto-newline nil
      verilog-tab-always-indent nil)

;; Template system
(require 'template)
(template-initialize)
(setq template-default-directories
      (cons (concat ENV_EMACS_DIR "template/") template-default-directories))

;; Synopsys keyword support for tcl-mode
(load (concat ENV_EMACS_DIR "syn-keyword.el") t nil t)

;; Dcsh (Synopsys DC Shell)
(autoload 'dcsh-mode "dcsh-mode" "Dcsh Mode" t)
(add-to-list 'auto-mode-alist '("\\.scr\\'" . dcsh-mode))

;; Specman
(autoload 'specman-mode "specman-mode" "Specman code editing mode" t)
(add-to-list 'auto-mode-alist '("\\.e\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.e3\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.load\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.ecom\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.etst\\'" . specman-mode))

;; Shell script
(add-to-list 'auto-mode-alist '("bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.cfg" . shell-script-mode))

;; Tcl
(when (< max-specpdl-size 1000)
  (setq max-specpdl-size 2000))
(add-to-list 'auto-mode-alist '(".*\\.pt$" . tcl-mode))
(add-to-list 'auto-mode-alist '(".*\\.synopsys_..\\.setup$" . tcl-mode))

;; C files
(add-to-list 'auto-mode-alist '("vfl_.+" . c-mode))
(add-to-list 'auto-mode-alist '("vflist$" . c-mode))
(add-to-list 'auto-mode-alist '(".*\\.ld$" . c-mode))

;; CUDA
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))

;; =================================================================
;; Company Mode (Auto-Complete Replacement)
;; =================================================================
(require 'company)
(global-company-mode t)

;; Trigger immediately after typing
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.2)
(setq company-tooltip-limit 10)
(setq company-show-quick-access t)

;; Use M-/ to trigger completion manually
(define-key company-mode-map (kbd "M-/") 'company-complete)

;; Navigation keys in completion popup
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)

;; Auto-detect GCC default include paths for company-clang
;; Falls back to Ubuntu 22.04 GCC 11 paths if gcc is not available
(defun my-gcc-include-paths ()
  "Return GCC default C++ include paths."
  (let ((gcc-output (shell-command-to-string "gcc -xc++ -E -v /dev/null 2>&1")))
    (if (string-match "#include <\\.\\.\\.> search starts here:\\([\\s\\S]*?\\)End of search list." gcc-output)
        (delq nil
              (mapcar (lambda (line)
                        (let ((trimmed (string-trim line)))
                          (when (and (> (length trimmed) 0)
                                     (file-directory-p trimmed))
                            trimmed)))
                      (split-string (match-string 1 gcc-output) "\n")))
      ;; Fallback: Ubuntu 22.04 GCC 11 hardcoded paths
      '("/usr/include/c++/11"
        "/usr/include/x86_64-linux-gnu/c++/11"
        "/usr/include/c++/11/backward"
        "/usr/lib/gcc/x86_64-linux-gnu/11/include"
        "/usr/local/include"
        "/usr/lib/gcc/x86_64-linux-gnu/11/include-fixed"
        "/usr/include/x86_64-linux-gnu"
        "/usr/include"))))

(setq company-clang-arguments
      (mapcar (lambda (path) (concat "-I" path)) (my-gcc-include-paths)))

;; Add clang backend for C/C++ modes
(defun my-company-cc-mode-setup ()
  "Setup company backends for C/C++ mode."
  (setq-local company-backends
              '((company-clang company-dabbrev-code company-keywords)
                company-dabbrev
                company-files)))

(add-hook 'c-mode-hook 'my-company-cc-mode-setup)
(add-hook 'c++-mode-hook 'my-company-cc-mode-setup)

;; =================================================================
;; Key Bindings
;; =================================================================

;; Common editing
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-p") 'pwd)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "C-<delete>") 'kill-word)
(global-set-key (kbd "C-d") 'kill-whole-line)
(global-set-key (kbd "C-c C-t") 'insert-current-date-time)
(global-set-key (kbd "M-s") 'save-buffer-no-tab)

;; F-keys
(global-set-key [f1] 'bookmark-jump-default1)
(global-set-key [C-f1] 'bookmark-set-default1)
(global-set-key [f2] 'bookmark-jump-default2)
(global-set-key [C-f2] 'bookmark-set-default2)
(global-set-key [S-f2] 'bookmark-jump)
(global-set-key [S-C-f2] 'bookmark-set)
(global-set-key [f3] 'isearch-forward)
(define-key isearch-mode-map [f3] 'isearch-repeat-forward)
(global-set-key [C-f3] 'isearch-forward-regexp)
(global-set-key [S-f3] 'isearch-backward)
(define-key isearch-mode-map [S-f3] 'isearch-repeat-backward)
(global-set-key [C-S-f3] 'isearch-backward-regexp)
(global-set-key [C-f4] 'kill-this-buffer)
(global-set-key [M-f4] 'save-buffers-kill-emacs)
(global-set-key [f4] 'copy-to-register-t)
(global-set-key [S-f4] 'insert-register-t)
(global-set-key [f5] 'goto-line)
(global-set-key [f6] 'other-window)
(global-set-key [C-f6] 'switch-to-buffer)
(global-set-key [S-f6] 'buffer-menu)
(global-set-key [S-f7] 'comint-next-matching-input-from-input)
(global-set-key [f7] 'comint-previous-matching-input-from-input)
(global-set-key [f9] 'query-replace)
(global-set-key [C-f9] 'query-replace-regexp)
(global-set-key [S-f9] 'query-replace-reg-t)
(global-set-key [f10] 'replace-string)
(global-set-key [C-f10] 'replace-string-regexp)
(global-set-key [S-f10] 'replace-string-reg-t)
(global-set-key [f11] 'delete-other-windows)
(global-set-key [S-f11] 'delete-window)
(global-set-key [f12] 'split-window-vertically)
(global-set-key [S-f12] 'split-window-horizontally)
(global-set-key [M-f12] 'split-window-horizontally)
(global-set-key [mouse-3] 'mouse-buffer-menu)
(global-set-key [delete] 'delete-char)
(global-set-key "%" 'match-paren)
(global-set-key [C-f8] 'switch-source-file)

;; =================================================================
;; Custom Functions
;; =================================================================

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun switch-source-file ()
  "Switch between .cpp and .h file."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (cond ((string-match "\\.cpp$" file-name)
           (find-file (replace-regexp-in-string "\\.cpp$" ".h" file-name)))
          ((string-match "\\.h$" file-name)
           (find-file (replace-regexp-in-string "\\.h$" ".cpp" file-name))))))

(defun kill-whole-line ()
  "Kill the whole line at cursor."
  (interactive)
  (beginning-of-line nil)
  (kill-line nil)
  (kill-line nil))

(defun insert-current-date-time ()
  "Insert current date and time."
  (interactive)
  (insert "==========\n")
  (insert (format-time-string "%a %b %d %H:%M:%S %Z %Y" (current-time)))
  (insert "\n"))

(defun save-buffer-no-tab ()
  "Replace tabs with spaces then save."
  (interactive)
  (untabify (point-min) (point-max))
  (save-buffer))

;; Bookmark helpers
(defun bookmark-jump-default1 (pos)
  "Jump to default bookmark 1, creating it at POS if needed."
  (interactive "d")
  (bookmark-jump "default-bookmark1")
  (bookmark-set "default-bookmark1"))

(defun bookmark-set-default1 (pos)
  "Set default bookmark 1 at POS."
  (interactive "d")
  (bookmark-set "default-bookmark1"))

(defun bookmark-jump-default2 (pos)
  "Jump to default bookmark 2, creating it at POS if needed."
  (interactive "d")
  (bookmark-jump "default-bookmark2")
  (bookmark-set "default-bookmark2"))

(defun bookmark-set-default2 (pos)
  "Set default bookmark 2 at POS."
  (interactive "d")
  (bookmark-set "default-bookmark2"))

;; Register helpers
(defun copy-to-register-t (start end)
  "Copy region to register t."
  (interactive "r")
  (copy-to-register t start end)
  (if transient-mark-mode (setq deactivate-mark t)))

(defun insert-register-t (pos)
  "Insert register t at POS."
  (interactive "d")
  (insert-register t 1))

;; Replace helpers
(defun query-replace-reg-t (to-string)
  "Query replace with register t content."
  (interactive
   (let ((to (read-from-minibuffer
              (format "Query-replace \"%s\" with: " (get-register t))
              nil nil nil query-replace-to-history-variable nil t)))
     (list to)))
  (perform-replace (get-register t) to-string t nil nil))

(defun replace-string-reg-t (to-string)
  "Replace string with register t content."
  (interactive
   (let ((to (read-from-minibuffer
              (format "Replace \"%s\" with: " (get-register t))
              nil nil nil query-replace-to-history-variable nil t)))
     (list to)))
  (perform-replace (get-register t) to-string nil nil nil))

;; Password prompt suppression
(defcustom comint-password-prompt-regexp
  "\\(\\([Oo]ld \\|[Nn]ew \\|Kerberos \\|'s \\|login \\|^CVS \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|Enter passphrase\\)\\( for [^@   \n]+@[^@        \n]+\\)?:\\s *\\'"
  "Regexp matching prompts for passwords in the inferior process."
  :type 'regexp
  :group 'comint)

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; =================================================================
;; Shell Management (On-demand instead of auto-create)
;; =================================================================

(defvar my-shell-devices '("t41" "t40" "t33" "t32" "t23")
  "List of device names for shell buffers.")

(defun my-create-device-shells ()
  "Create shell buffers for all device names."
  (interactive)
  (dolist (device my-shell-devices)
    (shell)
    (rename-buffer (format "shell-%s" device))))

(defun my-create-numbered-shells (count)
  "Create COUNT numbered shell buffers (e.g. shell-000 to shell-009)."
  (interactive "nNumber of shells: ")
  (dotimes (n count)
    (shell)
    (rename-buffer (format "shell-%03d" (- count n 1)))))

(defun my-create-next-4-shells ()
  "Create 4 new numbered shell buffers, continuing from the highest existing number."
  (interactive)
  (let ((max-num -1))
    ;; Find the highest existing shell number
    (dolist (buf (buffer-list))
      (let ((name (buffer-name buf)))
        (when (string-match "^shell-\\([0-9]+\\)$" name)
          (let ((num (string-to-number (match-string 1 name))))
            (when (> num max-num)
              (setq max-num num))))))
    ;; Create 4 new shells starting from max-num + 1
    (dotimes (n 4)
      (shell)
      (rename-buffer (format "shell-%03d" (+ max-num 1 n))))
    ;; Switch to the first of the newly created shells
    (switch-to-buffer (format "shell-%03d" (+ max-num 1)))))

;; Bind C-c s to create 4 shells at a time
(global-set-key (kbd "C-c s") 'my-create-next-4-shells)

;; =================================================================
;; GDB
;; =================================================================
(setq gdb-many-windows t)
(setq gud-tooltip-mode t)

;; =================================================================
;; Frame Position (GUI only)
;; =================================================================
(when (display-graphic-p)
  (set-frame-position (selected-frame) 0 0))

;; =================================================================
;; Yes/No simplification
;; =================================================================
(fset 'yes-or-no-p 'y-or-n-p)

;; =================================================================
;; Dired Enhancement
;; =================================================================
(require 'dired-x)
(setq dired-use-ls-dired t)
(setq dired-listing-switches "-alh --group-directories-first")

;; diredfl and all-the-icons-dired (install via M-x package-install if missing)
(when (require 'diredfl nil t)
  (diredfl-global-mode))

(when (fboundp 'all-the-icons-dired-mode)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; =================================================================
;; Fireplace (just for fun)
;; =================================================================
(load (expand-file-name "fireplace/fireplace" user-emacs-directory) t)

;; =================================================================
;; Global Font Lock
;; =================================================================
(global-font-lock-mode t)

(provide 'init)
;;; init.el ends here
