;;; init-basic.el --- Basic behavior and settings

;;; Commentary:
;; Startup, clipboard, history, line behavior

;;; Code:

;; Startup
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq auto-save-mode nil)

;; Clipboard integration
(setq x-select-enable-clipboard t)
(setq mouse-yank-at-point t)

;; Use bash as default shell
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "/bin/bash")

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

;; Load built-in Info reader and MSB enhancements
(load "info" nil t)
(load "msb" nil t)

;; Yes/No simplification
(fset 'yes-or-no-p 'y-or-n-p)

;; Frame position (GUI only)
(when (display-graphic-p)
  (set-frame-position (selected-frame) 0 0))

(provide 'init-basic)
;;; init-basic.el ends here
