;;; init-shell.el --- Shell management

;;; Commentary:
;; Shell buffer creation and management

;;; Code:

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

(provide 'init-shell)
;;; init-shell.el ends here
