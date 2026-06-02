;;; init-tools.el --- Misc tools: dired, gdb, fireplace

;;; Commentary:
;; Dired enhancement, GDB, and fun stuff

;;; Code:

;; GDB
(setq gdb-many-windows t)
(setq gud-tooltip-mode t)

;; Dired Enhancement
(require 'dired-x)
(setq dired-use-ls-dired t)
(setq dired-listing-switches "-alh --group-directories-first --color=auto")
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; diredfl and all-the-icons-dired (install via M-x package-install if missing)
(when (require 'diredfl nil t)
  (diredfl-global-mode))

(when (fboundp 'all-the-icons-dired-mode)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; Fireplace (just for fun)
(load (expand-file-name "site-lisp/fireplace.el" user-emacs-directory) t)

(provide 'init-tools)
;;; init-tools.el ends here
