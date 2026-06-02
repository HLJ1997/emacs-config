;;; init-completion.el --- Company mode and auto-completion

;;; Commentary:
;; Company mode setup with clang backend for C/C++

;;; Code:

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

;; Auto-detect GCC default include paths
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

(provide 'init-completion)
;;; init-completion.el ends here
