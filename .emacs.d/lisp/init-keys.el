;;; init-keys.el --- Key bindings

;;; Commentary:
;; Global key bindings for editing, navigation, search, windows

;;; Code:

;; Common editing
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-p") 'pwd)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "C-<delete>") 'kill-word)
(global-set-key (kbd "C-d") 'kill-whole-line)
(global-set-key (kbd "C-c C-t") 'insert-current-date-time)
(global-set-key (kbd "M-s") 'save-buffer-no-tab)

;; Graphical frame display controls.  MobaXterm may not support true
;; fullscreen, so keep maximization as a reliable fallback.
(global-set-key (kbd "C-c f") #'toggle-frame-fullscreen)
(global-set-key (kbd "C-c m") #'toggle-frame-maximized)

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
(global-set-key "\e[23~" 'delete-other-windows)  ; raw xterm F11 sequence
(global-set-key [S-f11] 'delete-window)
(global-set-key [f12] 'split-window-vertically)
(global-set-key [S-f12] 'split-window-horizontally)
(global-set-key [M-f12] 'split-window-horizontally)
(global-set-key [mouse-3] 'mouse-buffer-menu)
(global-set-key [delete] 'delete-char)
(global-set-key "%" 'match-paren)
(global-set-key [C-f8] 'switch-source-file)

(provide 'init-keys)
;;; init-keys.el ends here
