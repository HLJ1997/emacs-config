;;; init-editing.el --- Editing behavior, indentation, helpers

;;; Commentary:
;; Tab/indent, custom editing functions

;;; Code:

;; Tab / Indent Configuration
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

;; Winner mode for window undo/redo
(winner-mode 1)

;; Custom Functions

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
  (copy-to-register ?t start end)
  (if transient-mark-mode (setq deactivate-mark t)))

(defun insert-register-t (pos)
  "Insert register t at POS."
  (interactive "d")
  (insert-register ?t 1))

;; Replace helpers
(defun query-replace-reg-t (to-string)
  "Query replace with register t content."
  (interactive
   (let ((to (read-from-minibuffer
              (format "Query-replace \"%s\" with: " (get-register ?t))
              nil nil nil query-replace-to-history-variable nil t)))
     (list to)))
  (perform-replace (get-register ?t) to-string t nil nil))

(defun replace-string-reg-t (to-string)
  "Replace string with register t content."
  (interactive
   (let ((to (read-from-minibuffer
              (format "Replace \"%s\" with: " (get-register ?t))
              nil nil nil query-replace-to-history-variable nil t)))
     (list to)))
  (perform-replace (get-register ?t) to-string nil nil nil))

;; Password prompt suppression
(defcustom comint-password-prompt-regexp
  "\\(\\([Oo]ld \\|[Nn]ew \\|Kerberos \\|'s \\|login \\|^CVS \\|^\\)[Pp]assword\\( (again)\\)?\\|pass phrase\\|Enter passphrase\\)\\( for [^@   \n]+@[^@        \n]+\\)?:\\s *\\'"
  "Regexp matching prompts for passwords in the inferior process."
  :type 'regexp
  :group 'comint)

(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(provide 'init-editing)
;;; init-editing.el ends here
